//
//  ContentView.swift
//  SwiftDine
//
//  Created by JTM on 07/10/2020.
//

import SwiftUI

struct ContentView: View {
	
	let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    var body: some View {
		NavigationView{
			List{
				ForEach(menu){
					section in Section(header: Text(section.name))
					
					{
						ForEach(section.items){
						item in ItemRow(item: item)
					}}
					
			}
			}
			.navigationTitle("Menu")
			.listStyle(GroupedListStyle())
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			ContentView()
				.preferredColorScheme(.dark)
			ContentView()
				.preferredColorScheme(.dark)
		}
    }
}
