//
//  HomeViewData.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewData {
        
    private let publishData = PublishSubject<PhotoItems>()
    private let publishLastSearchData = PublishSubject<[String]>()

    
    init() {
        
    }
    
    public func obserePublishData() -> Observable<PhotoItems> {
        return self.publishData
    }
    
    func showSuccess(_ items:PhotoItems) {
        self.publishData.onNext(items)
    }
    
    public func observePublishLastSearchData() -> Observable<[String]> {
        return self.publishLastSearchData
    }
    
    func getRecentSearch() {
        if let data = UserDefaults.standard.value(forKey: kSaveDataString){
            self.publishLastSearchData.onNext(data as! [String])
        }
    }
    
}
