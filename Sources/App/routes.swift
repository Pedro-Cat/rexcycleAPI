import Vapor

func routes(_ app: Application) throws {
    
    app.routes.get { req -> String in
        let routes = req.application.routes.all
        return routes.map(\.description).joined(separator: "\n")
    }
    
    app.routes.get("documentation") { req in
        req.view.render(app.directory.publicDirectory + "documentation/index.html")
    }
    
    try app.register(collection: UserController())
    try app.register(collection: VoucherController())
    try app.register(collection: LikeVoucherController())
    try app.register(collection: LikeEnterpriseController())
    try app.register(collection: ReportController())
    
}
