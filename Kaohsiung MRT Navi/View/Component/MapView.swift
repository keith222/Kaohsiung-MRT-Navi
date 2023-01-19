//
//  MapView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/10.
//

import UIKit
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    let viewModel: MapViewModel
    
    @Binding var selectedAnnotation: Annotation?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = viewModel.region
        
        if let polylines = viewModel.polylines {
            mapView.addOverlays(polylines)
        }
        
        if let annotations = viewModel.annotations {
            mapView.addAnnotations(annotations)
        }
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: NSObject, MKMapViewDelegate {
    
    private let parent: MapView
    private var selectedAnnotation: Annotation?
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = getPolyLineColor(of: routePolyline.title ?? "")
            renderer.lineWidth = 7
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Annotation {
            let reuseId = "station-pin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                annotationView?.canShowCallout = true
            }else {
                annotationView?.annotation = annotation
            }
            
            if let stataionNum = (annotation.id == "R10") ? "r10o5" : annotation.id?.lowercased() {
                if let image = UIImage(named: "\(ImageConstant.station)\(stataionNum)")?.preparingThumbnail(of: CGSize(width: 25, height: 25))?.imageWithColor(backgroundColor: UIColor(Color.backgroundColor)) {
                    annotationView?.image = image
                }
            }
        
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? Annotation, !annotation.isEqual(selectedAnnotation) {
            let region = MKCoordinateRegion(center: annotation.coordinate, span: mapView.region.span)
            mapView.setRegion(region, animated: true)
            parent.selectedAnnotation = annotation
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        parent.selectedAnnotation = nil
    }
    
    private func getPolyLineColor(of line: String) -> UIColor {
        switch line {
        case RouteLine.red.rawValue: return UIColor(Color.redLineColor)
        case RouteLine.orange.rawValue: return UIColor(Color.orangeLineColor)
        case RouteLine.circle.rawValue: return UIColor(Color.circleLineColor)
        default: return UIColor(Color.redLineColor)
        }
    }
}
