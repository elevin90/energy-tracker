import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        configuration: .init(
            hostname: "localhost",
            username: "yauheni",
            password: "",
            database: "energy_tracker"
        )
    ), as: .psql)
    
    app.views.use(.leaf)
    
    app.migrations.add(CreateUser())
    
    // register routes
    try routes(app)
}
