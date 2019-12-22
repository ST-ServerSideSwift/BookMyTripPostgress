//
// Created by subash on 12/21/19.
//

import Foundation
import FluentPostgreSQL
import Vapor

class AddingDescriptionToTrip: Migration {

    typealias Database = PostgreSQLDatabase

    class func prepare(on conn: Database.Connection) -> Future<Void> {
        return Database.update(Trip.self, on: conn) { builder in
            builder.field(for: \.description)
        }
    }

    class func revert(on conn: Database.Connection) -> Future<Void> {
        return Database.update(Trip.self, on: conn) { builder in
            builder.deleteField(for: \.description)
        }
    }
}
