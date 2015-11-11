//
//  GeofenceClientSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/19/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Mockingjay

class GeofenceClientSpec: QuickSpec {
    override func spec() {
    describe("the geofence client") {
      it("can request geofences for a given location that should be in SFO geofence") {
        self.stub(uri(Url.Geofence.locations), builder: json(MultipleGeofenceMock))
        ApiClient.requestGeofencesForLocation(37.621313,
          longitude: -122.378955,
          buffer: GeofenceArbiter.buffer)
          { geofences in
              
            expect(geofences).toNot(beNil())
        }
      }
    }
  }
}
