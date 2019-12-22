
import Foundation
import Vapor
import FluentPostgreSQL

final class Trip: Content {

    var id: Int?
    var destination: String
    var price: Double
    var description: String

    init(destination: String, price: Double, desc: String) {
        self.destination = destination
        self.price = price
        self.description = desc
    }

}

extension Trip: PostgreSQLModel {
    static var entity: String = "Trips"
}


extension Trip: Migration {}

extension Trip: Parameter {}
