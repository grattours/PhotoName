//
//  MapView.swift
//  PhotoName
//
//  Created by Luc Derosne on 11/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable{
    @State var location: CLLocationCoordinate2D
    
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject , MKMapViewDelegate {
        let parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "PlaceMark"
            var annotationview = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            // si pas reutilisable
            if annotationview == nil {
                
                annotationview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                annotationview?.canShowCallout = true
                
            }else {
                
                annotationview?.annotation = annotation
            }
            
            return annotationview
            
        }
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        let newLocation = MKPointAnnotation()
        newLocation.coordinate = location
        newLocation.title = "ici"
        if uiView.annotations.count == 0 {
            uiView.addAnnotation(newLocation)
        }
        
        print(newLocation.coordinate)
    }
    
    
    
}

    
