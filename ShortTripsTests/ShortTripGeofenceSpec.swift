//
//  ShortTripGeofenceSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import CoreLocation
import ObjectMapper

class ShortTripGeofenceSpec: QuickSpec {
  
  var localGeofence: LocalGeofence!

  override func spec() {
    
    describe("the entry gate geofence") {
      beforeEach {

        self.localGeofence = Mapper<LocalGeofence>().map(EntryGateString)!
      }

      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude: 37.610560, longitude: -122.393328)
        
        expect(GeofenceArbiter.checkLocation(badPoint, againstFeatures: self.localGeofence.features)).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
        let goodPoint = CLLocationCoordinate2D(latitude: 37.615699660000075, longitude: -122.3883)
        
        expect(GeofenceArbiter.checkLocation(goodPoint, againstFeatures: self.localGeofence.features)).to(beTrue())
      }
    }
  }
}
