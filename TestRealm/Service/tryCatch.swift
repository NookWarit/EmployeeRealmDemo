//
//  tryCatch.swift
//  TestRealm
//
//  Created by Foodstory on 29/4/2564 BE.
//

import Foundation
public func doCatch<T>(block: () throws -> T) -> T? {
    do {
        return try block()
    } catch let error {
        print(error)
    }
    return nil
}
