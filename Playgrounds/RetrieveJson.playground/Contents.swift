import UIKit

struct Ref: Codable {
    var quote: String
}

let website = "https://api.kanye.rest/"
let url = URL(string: website)!
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let response = response as? HTTPURLResponse,
       let data = data,
       (200..<300).contains(response.statusCode)
    {
        let ref = try? JSONDecoder().decode(Ref.self, from: data)
        let jsonDic = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: String]
        print(jsonDic["quote"]!)
    }
}
task.resume()
