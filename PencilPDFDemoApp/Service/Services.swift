//
//  Services.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import Foundation

protocol ServiceType {
    var realmService: RealmServiceType { get set }
    var fileManagingService: FileManagingServiceType { get set }
}

class Services: ServiceType {
    var realmService: RealmServiceType
    var fileManagingService: FileManagingServiceType
    
    init() {
        self.realmService = RealmService()
        self.fileManagingService = FileManagingService()
    }
}

class StubServices: ServiceType {
    var realmService: RealmServiceType = StubRealmService()
    var fileManagingService: FileManagingServiceType = StubFileManagingService()
}
