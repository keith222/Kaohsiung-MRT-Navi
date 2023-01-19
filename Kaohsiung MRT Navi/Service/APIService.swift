//
//  APIService.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/28.
//

import Foundation

final class APIService{
    
    typealias Parameters = [String: Any]
    typealias HTTPHeaders = [String: String]
    
    static let MRTMapURL: String = (Bundle.main.object(forInfoDictionaryKey: "API Service") as! Dictionary<String, String>)["MRTMapURL"]!
    static let tokenURL: String = (Bundle.main.object(forInfoDictionaryKey: "API Service") as! Dictionary<String, String>)["TokenURL"]!
    static let timeURL: String = (Bundle.main.object(forInfoDictionaryKey: "API Service") as! Dictionary<String, String>)["TDXTimeURL"]!    
    static let clientID: String =
    (Bundle.main.object(forInfoDictionaryKey: "API Service") as! Dictionary<String, String>)["ClientID"]!
    static let clientSecret: String = (Bundle.main.object(forInfoDictionaryKey: "API Service") as! Dictionary<String, String>)["ClientSecret"]!
    
    
    static func request<T: Decodable>(_ url: String, method: HttpMethod = .get, parameters: Parameters = [:], requestData: Data? = nil, headers: HTTPHeaders = [:], responseModel: T.Type) async -> Result<T, NetworkError> {
        guard let validURL = URL(string: url) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: validURL)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        let urlSession = URLSession(configuration: configuration)
        
        do {
            if !headers.isEmpty {
                for (key, value) in headers {
                    request.setValue(value, forHTTPHeaderField: key)
                }                
            }
            
            if let data = requestData {
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
                request.httpBody = data
            }
            
            if !parameters.isEmpty {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            }
                        
            let (data, response) = try await urlSession.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            print(response.statusCode)
            switch response.statusCode {
            case 200...299:
                do {
                    let decordResponose = try JSONDecoder().decode(responseModel, from: data)
                    return .success(decordResponose)
                    
                } catch (let error) {
                    print(error.localizedDescription)
                    return .failure(.invalidData)
                }
                
            case 404: return  .failure(.pageNotFound)
            default: return .failure(.unexpectedStatusCode)
            }
            
        } catch (let error) {
            return .failure(.requestFailed(error))
        }
    }
    
    static func checkToken() async -> Result<Bool, NetworkError> {
        let now = Date().timeIntervalSince1970
        guard let token = UserDefaults().token, let time = UserDefaults().tokenTime, (!token.isEmpty && (now - time) < 86400) else {
            let result = await fetchToken()
            
            switch result {
            case .success(_): return .success(true)
            case .failure(let error): return .failure(error)
            }
        }
        
        return .success(true)
    }
    
    static private func fetchToken() async -> Result<Bool, NetworkError> {
        let parameters = [
            "grant_type":"client_credentials",
            "client_id": clientID,
            "client_secret": clientSecret
        ]

        let parameterData = "grant_type=client_credentials&client_id=\(clientID)&client_secret=\(clientSecret)".data(using: .utf8)
        let tokenResponse = await request(tokenURL, method: .post, requestData: parameterData, responseModel: Token.self)
        switch tokenResponse {
        case .success(let token):
            let timeInterval = Date().timeIntervalSince1970
            UserDefaults().save(data: token.accessToken, key: "token")
            UserDefaults().save(data: timeInterval, key: "tokenTime")
            
            return .success(true)
            
        case .failure(let error):
            return .failure(error)
        }
    }
}


