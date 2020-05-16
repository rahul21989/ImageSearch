//
//  HomeRootView.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeRootView: UIView, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var lastSearchTableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    
    var viewController : HomeController?
    var disposableBag = DisposeBag()
    private var numberOfColumns: CGFloat = 3
    var items:[PhotoItem]?
    var lastSearchString:[String]?

    func bind(controller : HomeController) {
        viewController = controller
        configureUI()
        observeData()
        self.viewController = controller
        
        self.lastSearchTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        
        self.searchBar.rx.searchButtonClicked
            .subscribe(onNext: { () in
                self.viewController?.fetchData(self.searchBar.text ?? "")
            }) .disposed(by: disposableBag)

        self.searchBar.rx.text
        .subscribe(onNext: { (text) in
            if text!.isEmpty {
                self.showRecentSearches()

            }
        })
        .disposed(by: disposableBag)


//        self.searchBar.rx.textDidBeginEditing
//            .subscribe(onNext: { () in
//                self.showRecentSearches()
//            })
//            .disposed(by: disposableBag)
    }
    
    private func showRecentSearches() {
        viewController?.getViewData().getRecentSearch()
    }
    
    private func observeData() {
        viewController?.getViewData().obserePublishData()
            .map{[weak self] (result) -> Bool in
                self?.items = result.hits
                if result.hits?.count ?? 0 > 0 {
                    self?.collectionView.isHidden = false
                    self?.lastSearchTableView.isHidden = true
                    self?.persistSearchString(self?.searchBar.text ?? "")
                    self?.collectionView.reloadData()
                } else {
                    self?.collectionView.isHidden = true
                    self?.lastSearchTableView.isHidden = true
                    self?.viewController?.noResultFound()
                }
                return true
        }.subscribe()
            .disposed(by: disposableBag)
        
        
        viewController?.getViewData().observePublishLastSearchData()
            .map{[weak self] (result) -> Bool in
                if result.count > 0 {
                    self?.lastSearchString = result
                    self?.collectionView.isHidden = true
                    self?.lastSearchTableView.isHidden = false
                    self?.persistSearchString(self?.searchBar.text ?? "")
                }
                self?.lastSearchTableView.reloadData()
                return true
        }.subscribe()
            .disposed(by: disposableBag)
        
    }
    
    fileprivate func configureUI() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets.zero
        collectionView.register(UINib(nibName: ImageCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.nibName)
    }
    
    private func persistSearchString(_ text:String) {
        self.viewController?.persistData(text)
    }
}

extension HomeRootView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lastSearchString?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.bind((self.lastSearchString?[indexPath.row])!, controller:self.viewController!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.text = self.lastSearchString?[indexPath.row]
        self.viewController?.fetchData((self.lastSearchString?[indexPath.row])!)
    }
}

extension HomeRootView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewController?.tap((self.items?[indexPath.row])!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.nibName, for: indexPath) as! ImageCollectionViewCell
        cell.bind((self.items?[indexPath.row])!, controller:self.viewController!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width)/numberOfColumns, height: (collectionView.bounds.size.width)/numberOfColumns)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageCollectionViewCell else {
            return
        }

        cell.bind((self.items?[indexPath.row])!, controller:self.viewController!)
    }
}

