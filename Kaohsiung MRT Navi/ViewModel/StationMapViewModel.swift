//
//  StationMapViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/7.
//

import Foundation
import Geohash
import CoreLocation
import MapKit

@MainActor class StationMapViewModel: ObservableObject {

    @Published private(set) var annotationViewModels: [PlaceAnnotationViewModel] = []
    @Published private(set) var places: [Place] = []
    @Published var region: MKCoordinateRegion
    
    init(stationNum: String, geoHash: String, exitGeoHash: [String]?) {
        let stationLocation = CLLocationCoordinate2D(geohash: geoHash)
        region = MKCoordinateRegion(center: stationLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        
        var locations = [stationLocation]
        if let exits = exitGeoHash {
            locations.append(contentsOf: exits.map({ CLLocationCoordinate2D(geohash: $0) }))
        }
        loadPlaces(with: stationNum, and: locations)
    }
    
    private func loadPlaces(with stationNum: String, and locations: [CLLocationCoordinate2D]) {
        for (index, location) in locations.enumerated() {
            places.append(createPlace(with: index, stationNum: stationNum, coordinate: location))
        }
    }
    
    private func createPlace(with index: Int, stationNum: String, coordinate: CLLocationCoordinate2D) -> Place {
        return Place(stationNum: stationNum, coordinate: coordinate, exit: index)
    }
    
    func createPlaceAnnotationViewModel(of place: Place) -> PlaceAnnotationViewModel {
        return PlaceAnnotationViewModel(stationNum: place.stationNum, exit: place.exit)
    }
}
