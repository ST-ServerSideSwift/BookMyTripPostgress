import FluentSQLite
import Vapor
import FluentPostgreSQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)



    // Register the configured psql database
    var databases = DatabasesConfig()
    let postgreDatabaseConfig = PostgreSQLDatabaseConfig(hostname: "localhost",
                                                         username: "postgres",
                                                         database: "BookMyTripPSQLStorage")
    let postGredatabase = PostgreSQLDatabase(config: postgreDatabaseConfig)
    databases.add(database: postGredatabase, as: .psql)
    
    services.register(databases)

    
    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Trip.self, database: .psql)
    migrations.add(migration: AddingDescriptionToTrip.self, database: .psql)
    services.register(migrations)
}
