//
//  LocationFetcher.swift
//  PeopleCollection
//
//  Created by Dexter  on 7/28/24.
//

import CoreLocation
import AddressBookUI

protocol LocationFetcherProgressDelegate: Any {
    
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    enum FetchError: Swift.Error {
        case nullLocation
    }
    let manager = CLLocationManager()
    
    typealias Progress = (_ value: Double, _ total: Double) -> Void
    typealias Success = (_ location: CLLocation?, _ address: String?) -> Void
    typealias Failure = (Error) -> Void
    
    private var progress: Progress?
    private var success: Success?
    private var failure: Failure?
    
    private let progressTotal = 5.0
    
    override init() {
        super.init()
        manager.delegate = self
        
    }
    
    func getLocation() async throws -> (location: CLLocation, address: String?) {
//        manager.requestWhenInUseAuthorization()
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self = self else {
                return
            }
            self.manager.requestWhenInUseAuthorization()
            
            self.setSuccess({ location, address in
                self.progress?(5, self.progressTotal)
                if let location {
                    continuation.resume(returning: (location, address))
                } else {
                    continuation.resume(throwing: FetchError.nullLocation)
                }
        
                self.success = nil
            })
            self.setFailure({ error in
                continuation.resume(throwing: error)
                self.failure = nil
            })
            self.manager.requestLocation()

        }
        
    }
    
    func setProgress(_ progress: @escaping Progress) {
        self.progress = progress
    }
    
    private func setSuccess(_ success: @escaping Success) {
        self.success = success
    }
    
    private func setFailure(_ failure: @escaping Failure) {
        self.failure = failure
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
//            self.manager.requestLocation()
            progress?(1, progressTotal)
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        progress?(2, progressTotal)
        if let location = locations.first {
            
            progress?(2.5, progressTotal)
            print("\(location)")
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location, preferredLocale: .autoupdatingCurrent) { [weak self] placemarks, error in
                guard let self = self else {
                    return
                }
                self.progress?(3, progressTotal)
                if let error {
                    self.failure?(error)
                    return
                }
                self.progress?(3.1, progressTotal)
                if let placemarks, let placemark = placemarks.first {
                    let subStreet = placemark.subThoroughfare
                    let street = placemark.thoroughfare
                    
                    let subLocality = placemark.subLocality
                    let locality = placemark.locality
                    
                    let subAdministrativeArea = placemark.subAdministrativeArea
                    let aministrativeArea = placemark.administrativeArea
                    
                    let postalCode = placemark.postalCode
                    let country = placemark.country
                    
                    var address = ""
                    self.addInfo(to: &address, info: subStreet)
                    self.addInfo(to: &address, info: street)
//                    self.addInfo(to: &address, info: subLocality)
                    self.addInfo(to: &address, info: locality)
//                    self.addInfo(to: &address, info: subAdministrativeArea)
                    self.addInfo(to: &address, info: aministrativeArea)
                    self.addInfo(to: &address, info: country)
                    self.addInfo(to: &address, info: postalCode)
                    self.progress?(3.5, progressTotal)
                    self.success?(locations.first, address)
                } else {
                    
                    self.progress?(3.7, progressTotal)
                    self.success?(locations.first, nil)
                }
            }
        } else {
            self.success?(nil, nil)
        }
  
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        failure?(error)
    }
    
    private func addInfo(to address: inout String, info: String?) {
        guard let info else {
            return
        }
        
        let prefixChars = address.isEmpty ? "" : ", "
        
        address += prefixChars + info
        
        
    }
}
