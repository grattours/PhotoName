//
//  Image.swift
//  PhotoName
//
//  Created by Luc Derosne on 10/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation

struct ImageModel: Identifiable , Comparable {
    static func == (lhs: ImageModel, rhs: ImageModel) -> Bool {
        return lhs.id == rhs.id
    }
    enum codingKeys: CodingKey{
        case id , image , name
    }
    static func < (lhs: ImageModel, rhs: ImageModel) -> Bool {
        return lhs.name < rhs.name
    }
    
    let id = UUID()
    var image: Image
    var name: String
    var location: CLLocationCoordinate2D?
    
}

class Images: ObservableObject{
    @Published var images = [ImageModel]()
}

