import SwiftUI
import UniformTypeIdentifiers

struct ImageGridView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @State private var searchText = ""
    
    enum Strings {
        static let imageHint = "Double tap to view image details"
        static let imageLabelPrefix = "Image with URL: "
        static let noImagesText = "No images to display :("
        static let searchBarHint = "Enter a search term to find images"
        static let searchBarLabel = "Search"
        static let searchBarPlaceholder = "Search for images"
        static let URLError = "Invalid image URL string: %@"
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    if viewModel.images.isEmpty {
                        Text(Strings.noImagesText)
                            .accessibilityLabel(Strings.noImagesText)
                            .font(.title2)
                    } else {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3), spacing: 0) {
                            ForEach(viewModel.images, id: \.self) { image in
                                if let url = URL(string: image.media.url) {
                                    NavigationLink(destination: ImageDetailsView(image: image)
                                        .environmentObject(viewModel))
                                    {
                                        ImageGridItem(url: url)
                                            .accessibilityLabel("\(Strings.imageLabelPrefix) \(image.media.url)")
                                            .accessibilityHint(Strings.imageHint)
                                    }
                                }
                                else {
                                    let _ = print(Strings.URLError, image.media.url)
                                }
                            }
                        }
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: Strings.searchBarPlaceholder)
        .onChange(of: viewModel.searchText) { searchTerm in
            viewModel.receive(event: .searchImages(searchTerm))
        }
    }
    
    private func searchImages(_ searchTerm: String) {
        if !searchTerm.isEmpty {
            viewModel.receive(event: .searchImages(searchTerm))
        } 
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        let mockService = MockService()
        let viewModel = ViewModel(service: mockService)
        
        return ImageGridView()
            .environmentObject(viewModel)
    }
}
