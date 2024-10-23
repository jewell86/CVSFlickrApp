import SwiftUI

struct ImageGridItem: View {
    var url: URL
    let borderWidth: CGFloat = 2
    
    enum Strings {
        static let accessibilityLabel = "ImageGridItem"
        static let imageLoadError = "Error loading the image: %@"
    }
    
    var body: some View {
        AsyncImage(url: url) { status in
            if let image = status.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(4)
                    .shadow(radius: 5)
            } else if status.error != nil {
                let _ = print(status.error?.localizedDescription ?? (Strings.imageLoadError, url))
            } else {
                ProgressView()
                    .frame(width: 100, height: 100)
                    .cornerRadius(4)
                    .shadow(radius: 5)
            }
        }
        .padding(.vertical, 15)
        .accessibilityLabel(Strings.accessibilityLabel)
    }
}

struct ImageGridItem_Previews: PreviewProvider {
    static var previews: some View {
        if let url = URL(string: "https://tinyurl.com/5pntcptk") {
            ImageGridItem(url: url)
        }
    }
}
