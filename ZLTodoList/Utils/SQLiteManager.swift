//
//  SQLiteManager.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/8/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import FMDB

class SQLiteManager: NSObject {
    private static let manager: SQLiteManager = SQLiteManager()
    
    class func shareManager() -> SQLiteManager {
        return manager
    }
    
    private let dbName = "test.db"
    
    lazy var dbURL: URL = {
        let fileURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(dbName)
        print(fileURL)
        return fileURL
    }()
    
    lazy var db: FMDatabase = {
        let database = FMDatabase()
        return database
    }()
    
    lazy var bdQuery: FMDatabaseQueue? = {
        let databaseQuery = FMDatabaseQueue(url: dbURL)
        return databaseQuery
    }()
}
