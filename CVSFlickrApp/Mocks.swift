import Foundation

// MARK: Service Mock

final class MockService: ServiceProtocol {
    var images: [ImageInfo]?
    
    func searchImages(_ searchTerm: String) async throws -> [ImageInfo] {
        return images ?? []
    }
}

// MARK: URLSession Mock

class MockURLSession: URLSessionProtocol {
    var data: Data?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        guard let data = data else {
            throw URLError(.badServerResponse)
        }
        return (data, URLResponse())
    }
}

// MARK: ImagesResponse Mock

internal func mockImagesResponse() -> Data? {
    let mockResponse = """
    {
            "title": "Recent Uploads tagged porcupine",
            "link": "https://www.flickr.com/photos/tags/porcupine/",
            "description": "",
            "modified": "2024-10-19T21:05:07Z",
            "generator": "https://www.flickr.com",
            "items": [
           {
                "title": "06 African Crested Porcupine",
                "link": "https://www.flickr.com/photos/megatti/54077728957/",
                "media": {"m":"https://live.staticflickr.com/65535/54077728957_d407c00486_m.jpg"},
                "date_taken": "2023-08-26T09:45:56-08:00",
                "description": " ",
                "published": "2024-10-19T21:05:07Z",
                "author": "nobody@flickr.com",
                "author_id": "19697039@N00",
                "tags": "cohanzickzoo nj zoo porcupine animals newjersey bridgeton"
           },
           {
                "title": "ZOOM Erlebniswelt Gelsenkirchen - ZOO",
                "link": "https://www.flickr.com/photos/magdeburg/54075652943/",
                "media": {"m":"https://live.staticflickr.com/65535/54075652943_86d2b848a0_m.jpg"},
                "date_taken": "2024-08-26T10:06:18-08:00",
                "description": " ",
                "published": "2024-10-18T11:33:00Z",
                "author": "nobody@flickr.com",
                "author_id": "55276930@N04",
                "tags": "stachelschweine old world porcupine stachel oldworldporcupine zoom erlebniswelt gelsenkirchen zoo zoomerlebnisweltgelsenkirchen gelsenkirchenzoo erlebnisweltgelsenkirchen"
           },
           {
                "title": "Nanyuki-Masai Mara-42.jpg",
                "link": "https://www.flickr.com/photos/73377102@N00/54074337490/",
                "media": {"m":"https://live.staticflickr.com/65535/54074337490_a9f4377609_m.jpg"},
                "date_taken": "2024-09-02T15:34:21-08:00",
                "description": " ",
                "published": "2024-10-17T17:35:46Z",
                "author": "nobody@flickr.com",
                "author_id": "73377102@N00",
                "tags": "africa porcupine kenya safari tauck mtkenyasafariclub animalorphanage"
           }
            ]
    }
    """
    
    return mockResponse.data(using: .utf8)
}

// MARK: ImageResponse Failure Mock

internal func mockImagesResponseFailure() -> Data? {
    let mockResponse = """
    {
            "title": "Recent Uploads tagged porcupine",
            "link": ,
            "description": "",
            "modified": "2024-10-19T21:05:07Z",
            "generator": "https://www.flickr.com",
            "items": [
           {
                "title": "06 African Crested Porcupine",
                "link": "https://www.flickr.com/photos/megatti/54077728957/",
                "media": {},
                "date_taken": "2023-08-26T09:45:56-08:00",
                "description": " <p><a href="https://www.flickr.com/people/megatti/">megatti</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/megatti/54077728957/" title="06 African Crested Porcupine"><img src="https://live.staticflickr.com/65535/54077728957_d407c00486_m.jpg" width="240" height="160" alt="06 African Crested Porcupine" /></a></p> <p>African crested porcupine</p> ",
                "published": "2024-10-19T21:05:07Z",
                "author": "nobody@flickr.com ("megatti")",
                "author_id": "19697039@N00",
                "tags": "cohanzickzoo nj zoo porcupine animals newjersey bridgeton"
           },
           {
                "title": "ZOOM Erlebniswelt Gelsenkirchen - ZOO",
                "link": "https://www.flickr.com/photos/magdeburg/54075652943/",
                "media": {"m":"https://live.staticflickr.com/65535/54075652943_86d2b848a0_m.jpg"},
                "date_taken": "2024-08-26T10:06:18-08:00",
                "description": " <p><a href="https://www.flickr.com/people/magdeburg/">Magdeburg</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/magdeburg/54075652943/" title="ZOOM Erlebniswelt Gelsenkirchen - ZOO"><img src="https://live.staticflickr.com/65535/54075652943_86d2b848a0_m.jpg" width="240" height="160" alt="ZOOM Erlebniswelt Gelsenkirchen - ZOO" /></a></p> <p>Stachelschweine - Old World porcupine</p> ",
                "published": "2024-10-18T11:33:00Z",
                "author": "nobody@flickr.com ("Magdeburg")",
                "author_id": "55276930@N04",
                "tags":
           },
           {
                "title": "Nanyuki-Masai Mara-42.jpg",
                "link": "https://www.flickr.com/photos/73377102@N00/54074337490/",
                "media": {"m":"https://live.staticflickr.com/65535/54074337490_a9f4377609_m.jpg"},
                "description": " <p><a href="https://www.flickr.com/people/73377102@N00/">arlenesenser</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/73377102@N00/54074337490/" title="Nanyuki-Masai Mara-42.jpg"><img src="https://live.staticflickr.com/65535/54074337490_a9f4377609_m.jpg" width="240" height="160" alt="Nanyuki-Masai Mara-42.jpg" /></a></p> ",
                "published": "2024-10-17T17:35:46Z",
                "author": "nobody@flickr.com ("arlenesenser")",
                "author_id": "73377102@N00",
                "tags": "africa porcupine kenya safari tauck mtkenyasafariclub animalorphanage"
           }
            ]
    }
    """
    
    return mockResponse.data(using: .utf8)
}

// MARK: ImageInfo Mock

extension ImageInfo {
    static func testMake(
        title: String = "Test Image",
        link: String = "https://itsAnImage.com",
        media: Media = .testMake(),
        date_taken: String = "2023-04-20T12:34:56Z",
        description: String = "Its a test image",
        published: String = "2023-04-20T12:34:56Z",
        author: String = "Cooper Pupp",
        author_id: String = "coopcupp",
        tags: String = "cat, dog, blue"
    ) -> ImageInfo {
        ImageInfo(
            title: title,
            link: link,
            media: media,
            date_taken: date_taken,
            description: description,
            published: published,
            author: author,
            author_id: author_id,
            tags: tags
        )
    }
}

extension Media {
    static func testMake(
        url: String = "https://tinyurl.com/5pntcptk"
    ) -> Media {
        Media(url: url)
    }
}
