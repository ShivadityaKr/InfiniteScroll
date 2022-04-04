import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImageCacheWithUrlString(urlString: String) {
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                self.image = UIImage(systemName: "photo.artframe")
            }
            
        } else {
            // Fallback on earlier versions
        }
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            }
            }.resume()
    }
}
