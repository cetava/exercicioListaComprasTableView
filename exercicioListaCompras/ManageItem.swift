//
//  ManageItem.swift
//  exercicioListaCompras
//
//  Created by Cesar A. Tavares on 9/26/20.
//  Copyright © 2020 Cesar A. Tavares. All rights reserved.
//

import Foundation

class ManageItem {
    var arrayProdutcs = [Item]()

    init(arrayProducts: [Item]) {
        self.arrayProdutcs = arrayProducts
    }
    
    func setAddItem(product: String, quantity: Int) {
        let addItem = Item(product: product, quantity: quantity)
        arrayProdutcs.append(addItem)
    }
    
    func itemExist(product: String) -> Bool{
        for item in arrayProdutcs {
            if product.folding(options: .diacriticInsensitive, locale: .current).lowercased() == item.product.folding(options: .diacriticInsensitive, locale: .current).lowercased() {
                return true
            }
        }
        return false
    }
    
    func getQuantity(product: String) -> Int {
        for item in arrayProdutcs {
            if product.folding(options: .diacriticInsensitive, locale: .current).lowercased() == item.product.folding(options: .diacriticInsensitive, locale: .current).lowercased() {
                return item.quantity
            }
        }
        return 0
    }
    
    func setQuantity(product: String, quantity: Int) {
        for item in arrayProdutcs {
            if product.folding(options: .diacriticInsensitive, locale: .current).lowercased() == item.product.folding(options: .diacriticInsensitive, locale: .current).lowercased() {
                item.quantity = quantity
            }
        }
    }
    
    func deleteItem(product: String) {
        arrayProdutcs = arrayProdutcs.filter { $0.product.folding(options: .diacriticInsensitive, locale: .current).lowercased() != product.folding(options: .diacriticInsensitive, locale: .current).lowercased() }
    }
}
