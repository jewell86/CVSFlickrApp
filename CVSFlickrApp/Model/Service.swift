import UIKit

protocol ServiceProtocol {
    func searchImages(_ searchTerm: String) async throws -> [ImageInfo]
}

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

internal class Service: ServiceProtocol {
    private struct Endpoints {
        static let searchImages = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=%@"
    }
    
    private let session: URLSessionProtocol
        
    init(session: URLSessionProtocol) {
        self.session = session
    }
        
    internal func searchImages(_ searchTerm: String) async throws -> [ImageInfo] {
        let endpointURLString = String(format: Endpoints.searchImages, searchTerm)
        
        guard let endpointURL = URL(string: endpointURLString) else {
            throw URLError(.badURL)
        }
                
        do {
            let (serviceResponse, _) = try await session.data(from: endpointURL)
            
            return try JSONDecoder().decode(ImageResponse.self, from: serviceResponse).items
        }
        catch {
            throw error
        }
    }
}
