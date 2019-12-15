//
//  ImagePicker.swift
//  PhotoName
//
//  Created by Luc Derosne on 10/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//
import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: Image?
    
    //Crée une classe coordinator afin d'agir comme délégué pour la structure du sélecteur d'images
    class Coordinator: NSObject , UINavigationControllerDelegate , UIImagePickerControllerDelegate{
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else{ return}
            parent.selectedImage = Image(uiImage: selectedImage)
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(self)
    }
  
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .camera
        return imagePicker
    }
    
    
    
    
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
  
}
