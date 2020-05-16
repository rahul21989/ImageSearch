//
//  PhotoItems.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

public struct PhotoItems     : Codable {
    public var total : Int?
    public var hits : [PhotoItem]?
}
