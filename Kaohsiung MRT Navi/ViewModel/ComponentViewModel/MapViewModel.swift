//
//  MapViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/10.
//

import Foundation
import MapKit

struct MapViewModel {
        
    private(set) var region: MKCoordinateRegion
    private (set) var annotations: [MKPointAnnotation]?
    private(set) var polylines: [MKPolyline]?
        
    init(region: MKCoordinateRegion, lineCoordinates: [[CLLocationCoordinate2D]], stations: [Station]) {
        self.region = region
        self.polylines = createPolylines(of: lineCoordinates)
        self.annotations = createAnnotations(of: stations)
    }
    
    func createAnnotations(of stations: [Station]) -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        let newStations = stations.filter({ $0.num != "O5" })
        for station in newStations {
            annotations.append(createAnnotation(with: station))
        }
        return annotations
    }
    
    func createPolylines(of lineCoordinates: [[CLLocationCoordinate2D]]) -> [MKPolyline] {
        var lines = [MKPolyline]()
        for (index, linePoints) in lineCoordinates.enumerated() {
            lines.append(createPolyline(with: linePoints, and: index))
        }
        return lines
    }
        
    private func createPolyline(with points: [CLLocationCoordinate2D], and index: Int) -> MKPolyline {
        let polyline = MKPolyline(coordinates: points, count: points.count)
        polyline.title = getLineName(by: index)
        return polyline
    }
    
    private func createAnnotation(with station: Station) -> MKPointAnnotation {
        let annotation = Annotation()
        annotation.coordinate = CLLocationCoordinate2D(geohash: station.geoHash)
        annotation.id = station.num
        return annotation
    }
    
    private func getLineName(by index: Int) -> String {
        switch index {
        case 0: return StringConstant.circle
        case 1: return StringConstant.orange
        case 2: return StringConstant.red
        default: return StringConstant.red
        }
    }
}
