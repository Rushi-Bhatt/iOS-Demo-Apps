import Vapor

struct VideoCourse: Content {
    let name: String
    let author: String
    let version: Double
}

func routes(_ app: Application) throws {
    app.post("upload") { req -> HTTPResponseStatus in
        let course = try req.content.decode(VideoCourse.self)
        print("course name: \(course.name)")
        print("author name: \(course.author)")
        print("version name: \(course.version)")
        return .ok
    }
}
