//
//  ViewController.swift
//  exercicioListaCompras
//
//  Created by Cesar A. Tavares on 9/16/20.
//  Copyright © 2020 Cesar A. Tavares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldProduto: UITextField!
    @IBOutlet weak var textFieldQuantidade: UITextField!
    @IBOutlet weak var actionButtonSaveManagement: UIButton!
    @IBOutlet weak var actionButtonClearManagement: UIButton!
    @IBOutlet weak var actionButtonDeleteManagement: UIButton!
    @IBOutlet weak var tableViewList: UITableView!
    
    var tempItem = ManageItem(arrayProducts: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldProduto.delegate = self
        textFieldQuantidade.delegate = self
        tableViewList.delegate = self
        tableViewList.dataSource = self
        textFieldQuantidade.isEnabled = false
        actionButtonSaveManagement.isEnabled = false
        actionButtonClearManagement.isEnabled = false
        actionButtonDeleteManagement.isHidden = true
        textFieldProduto.becomeFirstResponder()
    }
    
    @IBAction func actionButtonSave(_ sender: UIButton) {
        if actionButtonSaveManagement.currentTitle == "Alterar" {
            if let product = textFieldProduto.text, let quantity = Int(textFieldQuantidade.text!) ?? 0 {
                tempItem.setQuantity(product: product, quantity: quantity)
                actionButtonSaveManagement.setTitle("Salvar", for: .normal)
                clearFields()
                updateTableView()
            }
        } else {
            if let product = textFieldProduto.text, let quantity = Int(textFieldQuantidade.text!) ?? 0 {
                tempItem.setAddItem(product: product, quantity: quantity)
                clearFields()
                updateTableView()
            }
        }
    }
    
    
    @IBAction func actionButtoClear(_ sender: UIButton) {
        clearFields()
        textFieldProduto.becomeFirstResponder()
        actionButtonDeleteManagement.isHidden = true
        actionButtonClearManagement.isEnabled = false
        updateTableView()
    }
    

    
    @IBAction func actionButtoDelete(_ sender: UIButton) {
        tempItem.deleteItem(product: textFieldProduto.text!)
        clearFields()
        updateTableView()
    }

    
    func updateTableView() {
        tableViewList.reloadData()
    }
    
    func clearFields() {
        textFieldProduto.text = ""
        textFieldQuantidade.text = ""
        actionButtonSaveManagement.setTitle("Salvar", for: .normal)
        actionButtonDeleteManagement.isHidden = true
        actionButtonClearManagement.isEnabled = false
        actionButtonSaveManagement.isEnabled = false
        textFieldQuantidade.isEnabled = false
        textFieldProduto.becomeFirstResponder()
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldProduto {
            if textField.text == nil || textField.text!.isEmpty  {
                print("ALERT")
                textFieldProduto.becomeFirstResponder()
            } else {
                actionButtonClearManagement.isEnabled = true
                textFieldQuantidade.isEnabled = true
                textFieldQuantidade.becomeFirstResponder()
                if tempItem.itemExist(product: textFieldProduto.text!) {
                    textFieldQuantidade.text = String(tempItem.getQuantity(product: textFieldProduto.text!))
                    actionButtonSaveManagement.setTitle("Alterar", for: .normal)
                    actionButtonSaveManagement.isEnabled = true
                    actionButtonDeleteManagement.isHidden = false
                } else {
                    textFieldQuantidade.isEnabled = true
                    actionButtonSaveManagement.isEnabled = true
                }
            }
        }
        return true
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textFieldProduto.text = tempItem.arrayProdutcs[indexPath.row].product
        textFieldQuantidade.text = String(tempItem.arrayProdutcs[indexPath.row].quantity)
        updateTableView()
        actionButtonSaveManagement.setTitle("Alterar", for: .normal)
        actionButtonClearManagement.isEnabled = true
        actionButtonDeleteManagement.isHidden = false
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempItem.arrayProdutcs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(tempItem.arrayProdutcs[indexPath.row].product) - \(tempItem.arrayProdutcs[indexPath.row].quantity)"
        return cell
    }
    
    
}
