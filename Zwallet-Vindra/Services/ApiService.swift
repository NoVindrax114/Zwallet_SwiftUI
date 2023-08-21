//
//  ApiService.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 18/08/23.
//

import Foundation
import Moya
import RxSwift

class ApiService {
    let configuration = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
    private lazy var apiProvider: MoyaProvider<Api> = {
        return MoyaProvider<Api>(
            plugins: [NetworkLoggerPlugin(configuration: configuration)]
        )
    }()
    
    private let disposeBag = DisposeBag()
    
    func login(email: String, password: String, completion: @escaping (DataLoginResponse?, Error?) -> ()) {
        let provider = MoyaProvider<Api>(
            plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        provider.request(.login(email: email, password: password), completion: { result in
            switch result {
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let loginResponse = try decoder.decode(LoginResponse.self, from: result.data)
                    completion(loginResponse.data, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        })
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping (SignUpResponse?, Error?) -> ()) {
        let provider = MoyaProvider<Api>(
            plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        provider.request(.signUp(username: username, email: email, password: password), completion: { result in
            switch result {
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let signUpResponse = try decoder.decode(SignUpResponse.self, from: result.data)
                    completion(signUpResponse, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        })
    }
    
    func resetPassword(email: String, newPassword: String, completion: @escaping (ResetPassResponse?, Error?) -> ()) {
        let provider = MoyaProvider<Api>(
            plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        provider.request(.resetPassword(email: email, password: newPassword), completion: { result in
            switch result {
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let resetPassResponse = try decoder.decode(ResetPassResponse.self, from: result.data)
                    completion(resetPassResponse, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        })
    }
    
    func loadProfile(completion: @escaping (DataProfileResponse?, Error?) -> ()) {
        let provider = MoyaProvider<Api>(
            plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        provider.request(.profile, completion: { result in
            switch result {
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let profileResponse = try decoder.decode(ProfileResponse.self, from: result.data)
                    completion(profileResponse.data, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        })
    }
    
    func logout(token: String, completion: @escaping (LogoutResponse?) -> ()) {
        let provider = MoyaProvider<Api>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        
        provider.request(.logout(token: token), completion: { response in
            switch response{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let logoutResponse = try decoder.decode(LogoutResponse.self, from: result.data)
                    completion(logoutResponse)
                } catch _ {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        })
    }
    
//    func loadProfile(completion: @escaping (Profile?) -> Void) {
//        apiProvider.rx.request(.profile)
//            .subscribe { (event) in
//                switch event {
//                case .success(let response):
//                    if (200...299).contains(response.statusCode),
//                       let profile = try? JSONDecoder().decode(Profile.self, from: response.data) {
//                        completion(profile)
//                    } else {
//                        let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Wrong email or password"])
//                        completion(nil)
//                    }
//                case .failure(let error):
//                    completion(nil)
//                }
//            }
//            .disposed(by: disposeBag)
//    }
}
