//
//  Object+Extension.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import Foundation
import RealmSwift

extension Object {
    static func build<O: Object>(_ builder: (O) -> ()) -> O {
        let object = O()
        builder(object)
        return object
    }
}
