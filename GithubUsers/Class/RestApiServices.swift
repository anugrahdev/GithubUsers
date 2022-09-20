//
//  RestApiServices.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//

import Foundation
import Alamofire

class RestApiServices {
    
    static let shared = {
        RestApiServices()
    }()
    
    func request<T: Codable>(url: String, success: @escaping (T) -> Void, failure: @escaping (NSError) -> Void) {
        
        AF.request(url)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: T.self){ response in
                debugPrint(response)
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                do {
                    let decoder = JSONDecoder()
                    let errorData = try decoder.decode(GithubErrorModel.self, from: response.data ?? Data())
                    let customError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorData.message ?? error.localizedDescription])
                    failure(customError)
                } catch {
                    failure(error as NSError)
                }
            }
        }
    }
    
}
