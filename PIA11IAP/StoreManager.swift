//
//  StoreManager.swift
//  PIA11IAP
//
//  Created by Bill Martensson on 2022-11-24.
//

import Foundation
import StoreKit

class StoreManager : NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    
    
    //@Published var myProducts = [SKProduct]()
    
    @Published var coinproduct : SKProduct?
    @Published var premiumproduct : SKProduct?

    @Published var transactionState: SKPaymentTransactionState?
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        print("Products didReceive")
        
        for prod in response.products {
            print(prod.localizedTitle)
            
            if(prod.productIdentifier == "pia11coin")
            {
                DispatchQueue.main.async {
                    self.coinproduct = prod
                }
            }
            if(prod.productIdentifier == "pia11premium")
            {
                DispatchQueue.main.async {
                    self.premiumproduct = prod
                }
            }
        }
        
        /*
        DispatchQueue.main.async {
            self.myProducts = response.products
        }
        */
        
    }
    
    func getProducts(productIDs: [String]) {
        print("Start requesting products ...")
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            print(transaction.payment.productIdentifier)
            
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                queue.finishTransaction(transaction)
                transactionState = .purchased
                // KÖP OK KLART
                print("Köp ok")
            case .restored:
                queue.finishTransaction(transaction)
                transactionState = .restored
                // KÖP OK RESTORE
                print("restore ok")
            case .failed, .deferred:
                print("Payment Queue Error: \(String(describing: transaction.error))")
                queue.finishTransaction(transaction)
                transactionState = .failed
            default:
            queue.finishTransaction(transaction)
            }
        }
        
    }
    
    func purchaseProduct(product: SKProduct) {
        
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            print("User can't make payment.")
        }
            
    }
    
    
    func restoreProducts() {
        print("Restoring products ...")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}
