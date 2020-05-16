//
//  HomeInteractor.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import UIKit
import RxSwift

class HomeInteractor {
    
    private let dataGateway : DataGateway
    private let connection : ConnectionGateway
    
    init(dataGateway : DataGateway, connectionGateway : ConnectionGateway) {
        self.dataGateway = dataGateway
        self.connection = connectionGateway
    }
    
    func fetchData(url: String) -> Observable<DataResponse<PhotoItems>> {
        
        if(!self.connection.isConnected()) {
            let dataResponse = DataResponse<PhotoItems>(.OFFLINE, nil)
            return Observable<DataResponse>.just(dataResponse)
        }
        
        return self.dataGateway
            .loadUrlContent(url).map {
                return $0
        }
    }
    
}


