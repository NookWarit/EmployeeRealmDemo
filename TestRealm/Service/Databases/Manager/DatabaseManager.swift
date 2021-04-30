//
//  DatabaseManager.swift
//  FoodStory_Owner
//
//  Created by Khwan Siricharoenporn on 11/9/2562 BE.
//  Copyright © 2562 LivingMobile. All rights reserved.
//

import Foundation
import RealmSwift

fileprivate let kSchemaVersion: UInt64 = 1

@objc class DatabaseManager: NSObject {
    static let `default`: DatabaseManager = DatabaseManager()
    
    private override init() {
        super.init()
        
        defaultMigration()
    }
    
    @discardableResult
    @objc static func sharedInstance() -> DatabaseManager {
        return DatabaseManager.default
    }
    
    func configure(configuration: RealmConfigurationType = .general(url: nil)) throws -> Realm? {
        var realmConfig = Realm.Configuration()
        realmConfig.readOnly = true
        
        switch configuration {
        case .general:
            realmConfig = Realm.Configuration.defaultConfiguration
            if let url = configuration.associated {
                realmConfig.fileURL = URL(string: url)
            }
            else {
                throw RealmErrorType.configurationFailure
            }
        case .inMemory:
            realmConfig = Realm.Configuration()
            if let identifier = configuration.associated {
                realmConfig.inMemoryIdentifier = identifier
            }
            else {
                throw RealmErrorType.configurationFailure
            }
        }
        
        //Migration
        migrationBy(realmConfig: &realmConfig)
        
        return try? Realm(configuration: realmConfig)
    }
}

//MARK: Migration
extension DatabaseManager {
    private func migrationBy(realmConfig: inout Realm.Configuration) {
        realmConfig.schemaVersion = kSchemaVersion
        
        implementMigration(migrationBlock: &realmConfig.migrationBlock)
    }
    
    private func defaultMigration() {
        var realmConfig = Realm.Configuration()
        
        realmConfig.schemaVersion = kSchemaVersion
        
        implementMigration(migrationBlock: &realmConfig.migrationBlock)
        
        Realm.Configuration.defaultConfiguration = realmConfig
    }
}

//MARK: Migration Implement
extension DatabaseManager {
    private func implementMigration(migrationBlock: inout MigrationBlock?) {
        migrationBlock = { (migration, oldSchemaVersion) in
            if oldSchemaVersion < 1 {}
            
        }
    }
}
