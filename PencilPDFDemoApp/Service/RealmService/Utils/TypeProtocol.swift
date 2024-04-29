//
//  TypeProtocol.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: LocalConvertibleType
    
    func asRealm() -> RealmType
}

protocol LocalConvertibleType {
    associatedtype LocalType: RealmRepresentable
    
    func asLocal() -> LocalType
}
