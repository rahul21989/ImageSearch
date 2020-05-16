//
//  DataGateway.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import Foundation
import RxSwift

protocol DataGateway {
    func loadUrlContent(_ url : String) -> Observable<DataResponse<PhotoItems>>
}
