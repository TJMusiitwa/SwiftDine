//
//  SwiftDineApp.swift
//  SwiftDine
//
//  Created by JTM on 07/10/2020.
//

import SwiftUI

@main
struct SwiftDineApp: App {
	var order = Order()
    var body: some Scene {
        WindowGroup {
			TabView {
				ContentView().environmentObject(order)
					.tabItem {
						Image(systemName: "list.dash")
						Text("Menu")
					}
				OrderView().environmentObject(order)
					.tabItem { Image(systemName: "square.and.pencil")
						Text("Order")
					}
			}
        }
    }
}
