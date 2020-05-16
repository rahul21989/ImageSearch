//
//  DataResponse.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import Foundation


enum ResponseState {
    case SUCCESS
    case SERVER_FAILURE
    case OFFLINE
}

struct DataResponse<T>  {
    
    let responseStatus: ResponseState
    let data : T?
    
    init(_ status: ResponseState, _  data : T?) {
        self.responseStatus = status
        self.data = data
    }
    
    public static func success(data : T) -> DataResponse<T> {
        return DataResponse<T>(.SUCCESS,data)
    }

    public static func error() -> DataResponse<T> {
        return DataResponse<T>(.SERVER_FAILURE,nil)
    }
}
