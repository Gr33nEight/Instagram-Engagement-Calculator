//
//  StoreManager.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 02/01/2022.
//

import Foundation

import Foundation
import StoreKit
import SwiftUI

class StoreManager : NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @Published var transactionState: SKPaymentTransactionState?
    @Published var myProducts = [SKProduct]()
    var request: SKProductsRequest!
    
    var product = SKProduct()
    
    init(authViewModel: AuthViewModel){
        self.authViewModel = authViewModel
        super.init()
        SKPaymentQueue.default().add(self)
        
    }

    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Did receive response")
        
        if !response.products.isEmpty {
            for fetchedProduct in response.products {
                    DispatchQueue.main.async {
                        self.myProducts.append(fetchedProduct)
                }
            }
            for invalidIdentifier in response.invalidProductIdentifiers {
                print("Invalid identifiers found: \(invalidIdentifier)")
            }
        }else{
            print("it's empty")
        }
    }
    
    func getProducts(productIDs: [String]) {
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
                break
            case .purchased:
                authViewModel.addPoint(product: product)
                
                print(authViewModel.currentUser!.points)
                queue.finishTransaction(transaction)
                transactionState = .purchased
                break
            case .restored:
                print("restored")
                transactionState = .restored
                queue.finishTransaction(transaction)
                break
            case .failed, .deferred:
                    queue.finishTransaction(transaction)
                    transactionState = .failed
                break
                    default:
                    queue.finishTransaction(transaction)
                break
            }
        }
    }
    
    func purchaseProduct(product: SKProduct) {
        
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)

            self.product = product
            
        } else {
            print("User can't make payment.")
        }
    }
    
    func restoreProducts() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

