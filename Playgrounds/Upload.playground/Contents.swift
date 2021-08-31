import UIKit

let json = """
    {
        "name": "Netowrking with URLSession",
        "language": "Swift",
        "version": 5.2
    }
    """
// MARK: Create the destination url
guard let uploadUrl = URL(string: "http://localhost:8080/upload") else { fatalError() }
// MARK: Create the url request
var request = URLRequest(url: uploadUrl)
// MARK: Pack your json data to be uploaded
let jsonData = json.data(using: .utf8)
// MARK: Indicate the http method and what type of data you are going to upload
request.httpMethod = "Post"
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
// MARK: Create the url session and get ready for uploading
let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
// MARK: Create the upload task and resume it
let task = urlSession.uploadTask(with: request, from: jsonData){ data, response, error in
    print(response ?? "no response")
}
task.resume()
