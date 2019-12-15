//
//  AddImageView.swift
//  PhotoName
//
//  Created by Luc Derosne on 10/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI
import CoreLocation

struct AddImageView: View {
    @State private var selectedImage: Image?
    @State private var showingImagePicker = false
    @State private var imageCaption = ""
    @Environment(\.presentationMode) var presentationMode
    let locationFetcher = LocationFetcher()
    
    var images: Images
    var formValidation: Bool{
        return imageCaption.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && selectedImage == nil
    }
    
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                VStack(alignment: .center){
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: geometry.size.width * 0.9 , height: geometry.size.height * 0.5)
                            .padding()
                        
                        if self.selectedImage != nil{
                            self.selectedImage?
                                .resizable()
                                .scaledToFit()
                                .clipShape(Rectangle())
                            
                        }else{
                            Text("Taper pour prendre une photo")
                                .foregroundColor(.blue)
                        }
                    }
                    .onTapGesture {
                        self.showingImagePicker = true
                        self.locationFetcher.start()
                    }
                    
                    Section(header: Text("Légende")){
                        TextField("légende", text: self.$imageCaption)
                            .padding()
                            .overlay(Rectangle().stroke(Color.gray , lineWidth: 0.5))
                    }
                    .padding()
                    
                    
                    Button(action:{
                        //Perform saving function
                        self.saveImage()
                    }){
                        Text("Enregistrer dans la bibliothéque")
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .padding()
                            .background(Color.blue)
                        
                    }
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.black , lineWidth: 1))
                    .disabled(self.formValidation)
                    
                    
                    Spacer()
                }
                .sheet(isPresented: self.$showingImagePicker) {
                    ImagePicker(selectedImage: self.$selectedImage)
                }
                
            }
            .navigationBarTitle("Ajouter Photo")
            .navigationBarItems(trailing: Button("annuler"){
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func saveImage(){
        guard !self.imageCaption.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {return}
        
        //Vérifier saisie un texte significatif pour la légende
        let textChecker = UITextChecker()
        let range = NSRange(location: 0, length: self.imageCaption.utf16.count)
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: self.imageCaption, range: range, startingAt: 0, wrap: false, language: "fr")
        
        guard misspelledRange.location == NSNotFound else {return}
        
        // déballage image sélectionnée
        guard let image = self.selectedImage else {return}
        
        let createdImage = ImageModel(image: image, name: imageCaption , location: locationFetcher.lastLocation)
        
        self.images.images.append(createdImage)
        self.images.images.sort()
        self.presentationMode.wrappedValue.dismiss()
    }
}

