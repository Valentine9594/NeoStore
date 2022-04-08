//
//  RealmDBProvider.swift
//  NeoStore
//
//  Created by neosoft on 08/04/22.
//

import Foundation
import RealmSwift

final class RealmDBProvider {
    private var realmQueue: DispatchQueue!
    
    static var realmConfiguration: Realm.Configuration {
        return Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    }
    
    var realm: Realm {
        return try! Realm()
    }
    
    init() {
        realmQueue = DispatchQueue(label: "RealmQueue", qos: .background)
        Realm.Configuration.defaultConfiguration = RealmDBProvider.realmConfiguration
    }
    
    func save<T: Object>(_ objects: [T]) {
        debugPrint("Before Saving Realm")
        realmQueue.async {
            try! self.realm.write {
                self.realm.add(objects, update: .all)
            }
        }
        debugPrint("After Saving Realm")
    }
    
    func fetch<T: Object>() -> [T] {
        var arrayResult = [T]()
        realmQueue.async {
            let result = self.realm.objects(T.self)
            arrayResult = Array(result)
        }
        return arrayResult
        
//        let result = realm.objects(T.self)
//        return Array(result)
    }
    
    func deleteAll() {
        realmQueue.async { [weak self] in
            try! self?.realm.write {
                self?.realm.deleteAll()
            }
        }
    }
        
}
