import Fluent
import Vapor

/// Registers all HTTP routes for the application.
/// - Parameter app: The running Vapor application instance.
func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.post("auth", "register", use: registerUser)
}

/// Request payload for user registration.
private struct RegisterUserRequest: Content {
    /// User email address.
    let email: String

    /// Plain-text password sent by the client.
    let password: String
}

/// Creates a new user model from registration input.
/// - Parameter req: Incoming request containing registration data.
/// - Returns: A `User` model with a hashed password.
private func registerUser(req: Request) async throws -> User {
    let input = try req.content.decode(RegisterUserRequest.self)
    let hash = try Bcrypt.hash(input.password)

    return User(email: input.email, passwordHash: hash)
}
