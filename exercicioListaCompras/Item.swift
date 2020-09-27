//
//  Item.swift
//  exercicioListaCompras
//
//  Created by Cesar A. Tavares on 9/16/20.
//  Copyright © 2020 Cesar A. Tavares. All rights reserved.
//

import Foundation

class Item {
    var product: String
    var quantity: Int
    
    init(product: String, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
}
