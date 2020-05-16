//
//  HomePresenter.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import Foundation
import RxSwift

class HomePresenter {
    
    let viewData : HomeViewData
    let navigation : HomeNavigation?

    init(viewData :HomeViewData,
         homeNavigation : HomeNavigation) {
        self.viewData = viewData
        self.navigation = homeNavigation
    }

    
    func subscribeLoadDataResponse(responseObservable : Observable<DataResponse<PhotoItems>>) -> Disposable {
        return responseObservable.observeOn(MainScheduler.instance)
            .map{ (response) -> Bool in
                if(response.responseStatus == .SUCCESS) {
                    self.viewData.showSuccess(response.data!)
                }
                else {
//                    self.viewData.showFailure(errorMessage: "Offline")
                }
                return true
        }.subscribe()
    }
}
    
