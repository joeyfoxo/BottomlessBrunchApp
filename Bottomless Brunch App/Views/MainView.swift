//
//  ContentView.swift
//  Bottomless Brunch App
//
//  Created by Joey on 22/08/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        NavigationStack {
        
        HeaderView()
        
        
            VStack {
                
                Text("Made by James Lawrence").foregroundStyle(.gray).font(.system(size: 15))
                
                NavigationLink(destination: PlayerView(),
                               label: {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.red)
                        
                        Text("Go!").foregroundStyle(.white).font(.system(size: 30))
                    }.frame(width: UIScreen.main.bounds.width / 3, height: 50)
                    
                })
            }
            
        }
    }
}

#Preview {
    MainView()
}
