//
//  DataGatewayImpl.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import Foundation
import RxSwift

class DataGatewayImpl: DataGateway {
    
    init() {
        
    }
    
    func loadUrlContent(_ url: String) -> Observable<DataResponse<PhotoItems>> {
        return Observable.create({ emitter in
            self.fetchSectionListData(url) { (sectionListData, error) in
                emitter.onNext(DataResponse.success(data: sectionListData!))
                emitter.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    private func fetchSectionListData(_ urlString : String, _ completionHandler: @escaping (PhotoItems?, _ error: Error?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let serverItems = try? JSONDecoder().decode(PhotoItems.self, from: data) {
                    completionHandler(serverItems, nil)
                }
            } else {
                completionHandler(nil, error)
            }
        }.resume()
    }
}
