//
//  HomeController.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import Foundation
import RxSwift

let kSaveDataString = "SavedStringArray"
class HomeController {
    
    private let interactor : HomeInteractor
    private let presenter : HomePresenter
    private let disposeBag : DisposeBag = DisposeBag()
    
    init(homeInteractor : HomeInteractor, presenter : HomePresenter) {
        self.interactor = homeInteractor
        self.presenter = presenter
    }
    
    func fetchData(_ text: String) {
        let url = String(format: "https://pixabay.com/api/?key=16552350-efc5ea0886b76edad964ca05e&q=%@", text)
        return presenter.subscribeLoadDataResponse(
            responseObservable: self.interactor.fetchData(url: url)
        ).disposed(by: disposeBag)
    }
    
    
    func getViewData() -> HomeViewData {
        return presenter.viewData
    }
    
    func persistData(_ text:String) {
        if !text.isEmpty {
            let defaults = UserDefaults.standard
            var result = [String]()
            if let data = defaults.value(forKey: kSaveDataString) {
                result = data as! [String]
            }
            if !result.contains(text) {
                result.append(text)
            }
            defaults.set(result, forKey: kSaveDataString)
        }
    }
    
    func tap(_ item:PhotoItem) {
        self.presenter.navigation?.routeToDetail(item)
    }
    
    
    func noResultFound() {
        self.presenter.navigation?.showAlert()
    }    
}
