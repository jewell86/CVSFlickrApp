import Foundation

internal enum ViewEvent {
    case searchImages(_ serchTerm: String)
}

internal class ViewModel: ObservableObject {
    var service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    @Published var images: [ImageInfo] = []
    @Published var searchText: String = ""
    
    @MainActor
    internal func receive(event: ViewEvent) {
        switch event {
        case .searchImages(let searchTerm):
            searchImages(searchTerm)
        }
    }
    
    @MainActor
    private func searchImages(_ searchTerm: String) {
        Task {
            do {
                let images = try await service.searchImages(searchTerm)
                self.images = images
            } catch {
                print(error)
            }
        }
    }
}
