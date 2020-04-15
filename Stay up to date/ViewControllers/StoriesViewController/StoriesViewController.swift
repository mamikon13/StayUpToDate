//
//  StoriesViewController.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 08.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit
import SafariServices


final class StoriesViewController: UIViewController, BaseViewController {
    
    private var activityIndicator: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .medium)
        } else {
            return UIActivityIndicatorView(style: .gray)
        }
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    @IBAction private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        reloadStoryIDs(by: sender.selectedSegmentIndex)
    }
    
    // MARK: - Model
    
    private var dataSource: DataSource<Story, StoryTableViewCell>!
    
    private var currentIDs = [Int]()
    
    // store task (calling API) of getting each story
    private var dataTasks = [URLSessionDataTask]()
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        reloadStoryIDs(by: 0)
        
        setupNavigationBar()
        setupActivityIndicator()
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}


// MARK: - UI activities and other...

private extension StoriesViewController {
    
    func reloadStoryIDs(by index: Int) {
        guard let type = SourceType(by: index) else { return }
        
        NewsAPI.shared.storyIDs(from: type) { [weak self] ids, error in
            guard let self = self else { return }
            guard
                let newIDs = ids,
                self.currentIDs.count == 0 || newIDs.first != self.currentIDs.first
                else {
                    self.stopRefreshingUI()
                    self.didReceive(error: error)
                    return
            }
            
            DispatchQueue.main.async {
                self.currentIDs = newIDs
                self.dataTasks.forEach { $0.cancel() }
                self.dataTasks = []
                
                if let dataSource = self.dataSource {
                    dataSource.objects = [Story?](repeating: nil, count: newIDs.count)
                    self.stopRefreshingUI()
                    self.tableView.reloadData()
                } else {
                    self.stopRefreshingUI()
                    self.setupTableView()
                }
            }
        }
    }
    
    func setupTableView() {
        dataSource = .init(objects: [Story?](repeating: nil, count: currentIDs.count), fetchDelegate: self, alertDelegate: self)
        tableView.register(StoryTableViewCell.nib, forCellReuseIdentifier: StoryTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = dataSource
        tableView.prefetchDataSource = dataSource
        tableView.delegate = self
    }
    
    func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Hacker News"
        if #available(iOS 13.0, *) {
            titleLabel.textColor = .label
        } else {
            titleLabel.textColor = .black
        }
        titleLabel.font = UIFont(name: "Helvetica", size: 25.0)
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
    }
    
    func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        activityIndicator.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(handleRefresh),
                                            for: .valueChanged)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        reloadStoryIDs(by: segmentedControl.selectedSegmentIndex)
    }
    
    func stopRefreshingUI() {
        DispatchQueue.main.async {
            if let _ = self.tableView.refreshControl?.isRefreshing {
                self.tableView.refreshControl?.endRefreshing()
            }
            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func showWarningAlert(for indexPath: IndexPath) {
        let message = dataSource.objects[indexPath.row] != nil ? "Invalid URL" : "The object hasn't been loaded yet"
        
        let alert = UIAlertController(title: "Ooops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}


// MARK: - AlertDelegate

extension StoriesViewController: AlertDelegate {
    
    func didReceive(error: Error?) {
        guard
            let description = error?.localizedDescription.debugDescription,
            let firstIndex = description.firstIndex(of: "\""),
            let lastIndex = description.lastIndex(of: "\"")
            else { return }
        
        let startIndex = description.index(firstIndex, offsetBy: 1)
        let message = String(description[startIndex..<lastIndex])
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        DispatchQueue.main.async {
            self.present(errorAlert, animated: true, completion: { self.stopRefreshingUI() })
        }
    }
    
}


// MARK: - UITableViewDelegate

extension StoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = dataSource.objects[indexPath.row]?.url else {
            showWarningAlert(for: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
    
}


// MARK: - FetchableDelegate

extension StoriesViewController: Fetchable {
    
    func executeFetch(by index: Int, handler: @escaping (Error?) -> ()) {
        guard let index = currentIDs.indices.first(where: { $0 == index }) else { return }
        let storyID = currentIDs[index]
        
        // if there is already an existing data task for that specific story url,
        // it means we already loaded it previously / currently loading it and we have to stop it
        guard !dataTasks.contains(where: { $0.originalRequest?.url == Request(type: .story(storyID)).absolutURL }) else { return }
        
        let dataTask: URLSessionDataTask = NewsAPI.shared.story(id: storyID) { [weak self] story, error in
            
            handler(error)
            guard
                let self = self,
                let story = story
                else { return }
            
            self.dataSource.objects[index] = story
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: index, section: 0)
                if self.tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
        }
        
        // run the task of fetching story, and append it to the dataTasks array
        dataTask.resume()
        dataTasks.append(dataTask)
    }
    
    func cancelFetch(by index: Int) {
        guard let index = currentIDs.indices.first(where: { $0 == index }) else { return }
        let storyID = currentIDs[index]
        
        // get the index of the dataTask which load this specific story
        // if there is no existing data task for the specific news, no need to cancel it
        let url = Request(type: .story(storyID)).absolutURL
        if let dataTask = dataTasks.first(where: { $0.originalRequest?.url == url }) {
            // cancel and remove the dataTask from the dataTasks array
            // so that a new datatask will be created and used to load story next time
            // since we already cancelled it before it has finished loading
            dataTask.cancel()
            dataTasks.removeAll(where: { $0.originalRequest?.url == url })
        }
    }
    
}


// MARK: - SFSafariViewControllerDelegate

extension StoriesViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }
    
}
