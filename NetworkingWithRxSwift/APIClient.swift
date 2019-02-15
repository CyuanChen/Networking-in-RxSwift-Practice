//
//  APIClient.swift
//  NetworkingWithRxSwift
//
//  Created by PeterChen on 2019/2/15.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import Foundation
import RxSwift

class APIClient {
    private let baseURL = URL(string: "http://universities.hipolabs.com/")!

    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { [unowned self] observer in
            let request = apiRequest.request(with: self.baseURL)
            let task = URLSession.shared.dataTask(with: request)
                {   (data, response, error) in
                    do {
                        let model: T = try JSONDecoder().decode(T.self
                            , from: data ?? Data()) // 根據你的T是誰去做decode
                        observer.onNext(model)
                    } catch let error {
                        observer.onError(error)
                    }
                    observer.onCompleted()
                }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}






