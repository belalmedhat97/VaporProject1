import Fluent
import Vapor

func routes(_ app: Application) throws {
    //return only text
    app.get { req in
        return "It works!"
    }

    // double routes hello/vapor/
    app.get("hello","vapor") { req -> String in
        
        return "Vapor"
    }
    // get json return to ios or android POST Request
    app.post("infoReturnJson") { req -> InfoResponse in
      let data = try req.content.decode(InfoData.self)
      // 2
        return InfoResponse(request: data)
    }
    // another example :: get json return to ios or android GET Resquest
    app.get("infoReturnInfo") { req -> InfoData in
        
      let data = try req.content.decode(InfoData.self)
      // 2
        return data
    }
    
    app.get("dic") { req in
        
        return ["belal":"mohamed"]
    }
    // redirect to custom url
    app.get("infoReturnJson") { req in
//      let data = try req.content.decode(InfoData.self)
      // 2
        return req.redirect(to: "www.google.com")
    }
    // post data in body using content like codable
    // 1
    app.post("info") { req -> String in
      // 2
      let data = try req.content.decode(InfoData.self)
      // 3
      return "Hello \(data.name)!"
    }
    
    //send paramter in url
    app.get("hello", ":name") { req -> String in
        let name = req.parameters.get("name")!
        return "Hello, \(name)!"
    }

    try app.register(collection: TodoController())
}
// string value send to body
struct InfoData: Content {
 let name: String
}
struct InfoResponse: Content {
  let request: InfoData
}
