//
//  APICaller.swift
//  AlamofireVersusURLSession
//
//  Created by Cüneyt Erçel on 20.10.2022.
//

import Foundation
import Alamofire

struct Constants {
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    static let baseUrl = "https://api.themoviedb.org"
    static let YoutubeAPI_Key = "AIzaSyBQgbMvoYGSgtCBDqwxOy_Sp_DfHHN9CKI"
    static let YoutubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
}

class APICaller {
    
    static let shared = APICaller()
    
    

    func getDatasWithURLSession(completion: @escaping (Result< [Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in // completion error olunca başka yerlerde de kullanbiliyoruz.
            
            guard let data = data, error == nil else {return}
            
            do { // sonuclar tv değil hepsini sonuclar versemde olur ama anlayayım diye :)
                let sonuclar = try  JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(sonuclar.results))
                
            }catch{
                completion(.failure(error.localizedDescription as! Error))
            }
        
        }
        
        task.resume()
        
    }
    
    
    
    func getDatasWithAlamofire(onSuccesAndError: @escaping ([Title], Error) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        AF.request(url).responseDecodable(of: TrendingTitleResponse.self) {  sonuclar in
            guard let value = sonuclar.value else {return}
            onSuccesAndError(value.results,Error.self as! Error)

        }
        
    }
    
    
}



