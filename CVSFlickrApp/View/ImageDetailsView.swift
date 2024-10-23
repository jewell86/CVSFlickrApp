import SwiftUI

struct ImageDetailsView: View {
    @EnvironmentObject private var viewModel: ViewModel
    var image: ImageInfo
    
    enum Strings {
        static let authorLabel = "Author"
        static let authorTitle = "Author:"
        static let datePublishedLabel = "Date published"
        static let imageInfoViewLabel = "ImageInfoView"
        static let imageLoadError = "Error loading the image: %@"
        static let imageTitleLabel = "Image title"
        static let URLError = "Invalid image URL string: %@"
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if let url = URL(string: image.media.url) {
                    AsyncImage(url: url) { status in
                        if let image = status.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else if status.error != nil {
                            let _ = print(status.error?.localizedDescription ?? (Strings.imageLoadError, image.media.url))
                            Color.gray
                        } else {
                            ProgressView()
                        }
                    }
                } else {
                    let _ = print(Strings.URLError, image.media.url)
                    Color.gray
                }
                
                VStack(alignment: .center, spacing: 10) {
                    Text(image.getFormattedDescription())
                        .font(.body)
                    Text(image.title)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .accessibilityLabel(Strings.imageTitleLabel)
                    Text(Strings.authorTitle)
                        .font(.title2)
                        .bold()
                    Text(image.author)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .accessibilityLabel(Strings.authorLabel)
                    Text(image.getFormattedDate())
                        .font(.subheadline)
                        .accessibilityLabel(Strings.datePublishedLabel)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
            .accessibilityLabel(Strings.imageInfoViewLabel)
        }
    }
}

struct ImageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailsView(image: ImageInfo.testMake())
    }
}
