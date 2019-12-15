//
//  ContentView.swift
//  PhotoName
//
//  Created by Luc Derosne on 09/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var images = Images()
    @State private var showingAddImageView = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(images.images) { image in
                    NavigationLink(destination: ImageDetailsView(image: image)) {
                        HStack{
                            image.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44 , height: 44)
                                .clipShape(Rectangle())
                                .overlay(Circle().stroke(Color.black , lineWidth: 0.5))
                            
                            Text(image.name)
                                .font(.system(size: 18))
                        }
                    }
                }
                .onDelete { (offsets) in
                    self.deleteRow(offsets: offsets)
                }
            }
            .navigationBarTitle("Bibliothèque Photo")
            .navigationBarItems(leading: EditButton() ,trailing: Button(action:{
                self.showingAddImageView = true
            }){
                Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddImageView) {
                    AddImageView(images: self.images)
            }
        }
    }

    func deleteRow(offsets: IndexSet){
        self.images.images.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
