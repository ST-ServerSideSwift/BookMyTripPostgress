import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    router.post(Trip.self, at: "/trips") { (request, trip) -> Future<Trip> in
        return trip.save(on: request)
    }
    
    router.get("/trips") { request -> Future<[Trip]> in
        return Trip.query(on: request).all()
    }
    
    router.get("/trips",Trip.parameter) { (request) -> Future<Trip> in
        return try request.parameters.next(Trip.self)
    }
    
    router.delete("/trips",Trip.parameter) { (request) -> Future<Trip> in
        return try request.parameters.next(Trip.self).delete(on: request)
    }
    
    router.put(Trip.self, at: "/trips") { (request, trip) -> Future<Trip> in
        return trip.update(on: request)
    }

}
