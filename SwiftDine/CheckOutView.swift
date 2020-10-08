//
//  CheckOutView.swift
//  SwiftDine
//
//  Created by JTM on 08/10/2020.
//

import SwiftUI

struct CheckOutView: View {
	@EnvironmentObject var order: Order
	
	
	
	static let paymentTypes = ["Cash", "Credit Card", "SwiftDine Points"]
	
	@State private var paymentType = 0
	
	@State private var addLoyaltyDetails = false
	@State private var loyaltyNumber = ""
	
	@State private var showingPaymentAlert = false
	
	static let tipAmounts = [0,10,15,20,25]
	@State private var tipAmount = 1
	
	var totalPrice: Double{
		let total = Double(order.total)
		let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
		return total + tipValue
	}
	
	static let pickupOptions = ["Now", "Tonight", "Tomorrow Morning"]
	@State private var pickupOption = 0
	
    var body: some View {
		Form {
			Section{
				Toggle(isOn: $addLoyaltyDetails.animation(), label: {
					Text("Add SwiftDine loyalty card")
				})
				
				if addLoyaltyDetails{TextField("Enter your SwiftDine ID", text:$loyaltyNumber).padding(2)}
				
				Picker("How do you wish to pay?", selection:$paymentType){
					ForEach(0..<Self.paymentTypes.count){
						Text(Self.paymentTypes[$0])
					}
				}.pickerStyle(SegmentedPickerStyle())
				
			}
			
			Section(header: Text("Add a tip?")){
				Picker("Percentage:", selection: $tipAmount){
					ForEach(0..<Self.tipAmounts.count){
						Text("\(Self.tipAmounts[$0])%")
					}
				}.pickerStyle(SegmentedPickerStyle())
			}
			
			Section(header: Text("Pickup")) {
				Picker("Pickup Options:", selection: $pickupOption){
					ForEach(0..<Self.pickupOptions.count){
						Text(Self.pickupOptions[$0])
					}
				}
			}
			
			Section(header: Text("TOTAL: $\(totalPrice, specifier: "%.2f")").font(.largeTitle)){
				Button("Confirm Order"){
					self.showingPaymentAlert.toggle()
					
				}
			}
		}
		.navigationBarTitle(Text("Payment"), displayMode: .inline)
		.alert(isPresented: $showingPaymentAlert, content: {
			Alert(title: Text("Order Confirmed"), message: Text("Your total was $\(totalPrice,specifier: "%.2f") - thank you"), dismissButton: .default(Text("OK")))
		})
    }
}

struct CheckOutView_Previews: PreviewProvider {
	static let order = Order()
	
    static var previews: some View {
		Group {
			CheckOutView().environmentObject(order)
			CheckOutView().environmentObject(order)
		}
    }
}
