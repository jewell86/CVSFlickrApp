import SwiftUI

@main
struct CVSFlickrAppApp: App {
    var body: some Scene {
        WindowGroup {
            let session = URLSession.shared
            let service = Service(session: session)
            let viewModel = ViewModel(service: service)
            
            ImageGridView()
                .environmentObject(viewModel)
        }
    }
}
