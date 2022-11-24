//
//  ContentView.swift
//  PIA11IAP
//
//  Created by Bill Martensson on 2022-11-24.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    
    @StateObject var storeManager : StoreManager
    
    var body: some View {
        VStack {
            Text("Köpa saker").padding()
            
            if(storeManager.coinproduct != nil) {
                Text(storeManager.coinproduct!.localizedTitle)
                Text(storeManager.coinproduct!.localizedDescription)
                Button(action: {
                    storeManager.purchaseProduct(product: storeManager.coinproduct!)
                }) {
                    Text("Köp för " + String(Double(storeManager.coinproduct!.price)))
                }
            }
            if(storeManager.premiumproduct != nil) {
                Text(storeManager.premiumproduct!.localizedTitle)
                Text(storeManager.premiumproduct!.localizedDescription)
                Button(action: {
                    storeManager.purchaseProduct(product: storeManager.premiumproduct!)
                }) {
                    Text("Köp för " + String(Double(storeManager.premiumproduct!.price)))
                }
            }

            Button(action: {
                storeManager.restoreProducts()
            }) {
                Text("Återställ köp")
            }
        }
        .padding()
        .onAppear() {
            SKPaymentQueue.default().add(storeManager)
            
            storeManager.getProducts(productIDs: ["pia11coin", "pia11premium"])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(storeManager: StoreManager())
    }
}
