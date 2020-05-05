//
//  DataSource.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 08.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


final class DataSource<Entity: Decodable & ManagedObjectConvertible, Existing: ManagedObjectExistable, P: BaseTableViewCell>: NSObject, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
//    var objects = [T?]()
    
    private weak var fetchDelegate: Fetchable?
    private weak var alertDelegate: AlertDelegate?

    init(fetchDelegate: Fetchable, alertDelegate: AlertDelegate) {
//        self.objects = objects
        self.fetchDelegate = fetchDelegate
        self.alertDelegate = alertDelegate
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsDAL.get(EntityID.self).count
//        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: P.identifier, for: indexPath) as? P else { return UITableViewCell() }
        
        if
            let objectDAO = Existing.getSingle(ordinal: Int16(indexPath.row)) as? AnyEntityConvertible<Entity>,
            let object = objectDAO.toEntity() as? P.Element
        {
            
//        }
//        
//        if let object = objects[indexPath.row] as? P.Element {
            cell.setupCell(with: object)
        } else {
            cell.resetCell()
            fetchDelegate?.executeFetch(by: indexPath.row) { [alertDelegate] error in
                if let error = error, !error.localizedDescription.contains("cancelled") {
                    alertDelegate?.didReceive(error: error)
                }
            }
        }
        
        return cell
    }
    
    
    // MARK: - UITableViewDataSourcePrefetching
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if
                let objectDAO = Existing.getSingle(ordinal: Int16(indexPath.row)) as? AnyEntityConvertible<Entity>,
                let _ = objectDAO.toEntity() as? P.Element
            { continue }
//            if let _ = objects[indexPath.row] as? P.Element { continue }
            fetchDelegate?.executeFetch(by: indexPath.row) { [alertDelegate] error in
                if let error = error, !error.localizedDescription.contains("cancelled") {
                    alertDelegate?.didReceive(error: error)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            fetchDelegate?.cancelFetch(by: indexPath.row)
        }
    }
    
}
