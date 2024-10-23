import Foundation

internal struct ImageResponse: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [ImageInfo]
}

internal struct ImageInfo: Codable, Hashable {
    let title: String
    let link: String
    let media: Media
    let date_taken: String
    let description: String
    let published: String
    let author: String
    let author_id: String
    let tags: String
    
    func getFormattedDate() -> String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime]
        
        if let date = inputFormatter.date(from: self.published) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = outputFormatter.string(from: date)
            return "Posted on " + dateString
        }
        
        return ""
    }
    
    func getFormattedDescription() -> String {
        let pattern = "<a[^>]*>([^<]+)</a> ([^<]+)</p>.*title=\"([^\"]+)\""
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let nsString = self.description as NSString
        let results = regex.matches(in: self.description, options: [], range: NSRange(location: 0, length: nsString.length))
        
        if let match = results.first {
            var formattedDescription = ""
            
            for index in 1..<3 {
                let range = match.range(at: index)
                if range.location != NSNotFound {
                    let string = nsString.substring(with: range)
                    formattedDescription.append("\(string) ")
                }
            }
            
            return formattedDescription
        }
        
        return ""
    }
}

struct Media: Codable, Hashable, Equatable {
    var url: String

    enum CodingKeys: String, CodingKey {
        case url = "m"
    }
}
