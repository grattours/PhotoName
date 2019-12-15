//
//  ImageDetailsView.swift
//  PhotoName
//
//  Created by Luc Derosne on 10/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI

struct ImageDetailsView: View {
    @State var image: ImageModel
    @State var viewDisplayed = 0
    var segments = ["Photo", "Carte"]
    
    var body: some View {
        GeometryReader{ geometry in
            if self.viewDisplayed == 0{
                VStack{
                    Text(self.image.name.uppercased())
                        .font(.largeTitle)
                        .padding()
                    
                    Divider()
                    
                    self.image.image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width)
                  
                    Spacer()
                }
            }else {
                MapView(location: self.image.location!)
                    .edgesIgnoringSafeArea(.all)
            }
        }
            
        .navigationBarItems(trailing: Picker(selection: $viewDisplayed.animation(Animation.easeInOut), label: Text("view"), content: {
            ForEach(0..<segments.count){
                Text(self.segments[$0])
            }
        })
            .shadow(radius: 2)
            .pickerStyle(SegmentedPickerStyle()))
            .navigationBarBackButtonHidden(self.viewDisplayed == 1)
    }
    
}
