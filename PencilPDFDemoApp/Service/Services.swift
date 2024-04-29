//
//  Services.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import Foundation

protocol ServiceType {
    var realmService: RealmServiceType { get set }
}

class Services: ServiceType {
    var realmService: RealmServiceType
    
    init() {
        self.realmService = RealmService()
    }
}

class StubServices: ServiceType {
    var realmService: RealmServiceType = StubRealmService()
}
