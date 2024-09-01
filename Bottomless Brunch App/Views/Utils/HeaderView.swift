//
//  HeaderView.swift
//  Bottomless Brunch App
//
//  Created by Joey on 23/08/2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.red)
                    .rotationEffect(Angle(degrees: -15))
            
            VStack {
                Text("Bottomless Brunch")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                    .bold()
                
                Text("Player Tracker")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                
            }
                
            }
            .frame(width: UIScreen.main.bounds.width * 2, height:350)
            
            Spacer()
        }
        .offset(y:-130)
        
    }
    
}

#Preview {
    HeaderView()
}

