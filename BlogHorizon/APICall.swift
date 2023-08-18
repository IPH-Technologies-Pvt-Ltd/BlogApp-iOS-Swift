//
//  APICall.swift
//  BlogHorizon
//
//  Created by IPH Technologies Pvt. Ltd. on 07/06/23.
//

import Foundation
import UIKit
class APICall{
    
    static let shared = APICall()
    var imageUrl = " "
    var imgArr = [UIImage]()
    //var arrimg
    //for displaying content fetched from API to UI we need to use completionhandler
    func fetchDataFromApi(onCompletion: @escaping([BlogDetailModel]) -> ()){
        let urlString = "https://blog.iphtechnologies.org/wp-json/blog/get_blog"
        let url = URL(string: urlString)!
        //MARK: ORIGINAL
        let task = URLSession.shared.dataTask(with: url) { data, reponse, error in
            guard let data = data else{
                print("Data was nil")
                return
            }
            guard let blogList = try? JSONDecoder().decode(BlogModel.self, from: data) else{
                print("Couldn't decode the JSON data.")
                return
            }
          onCompletion(blogList.blogs!)
         }
         task.resume()
         }
}

extension UIImageView{
    func loadImage(from url: URL){ //load image from the url that get passed over here
        image = nil
        //make url session
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //creating image from the data that we received and that image is now stored in newImage
            guard let data = data, let imageDownloaded = UIImage(data: data) else{
                print("couldn't load image from url: \(url)")
               
                return
            }
            DispatchQueue.main.async {
                self.image = imageDownloaded
                
                APICall.shared.imgArr.append(imageDownloaded)
            }
        }
        task.resume()
    }
}
