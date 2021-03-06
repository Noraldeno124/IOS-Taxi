//
//  PingSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import CoreLocation
import Quick
import Nimble
import Foundation
import ObjectMapper

class PingSpec: QuickSpec {
  var ping: Ping!
  
  override func spec() {
    describe("the Ping") {
      beforeEach {
        self.ping = Ping(location: CLLocation(latitude: 37.615716, longitude: -122.388321),
          tripId: 123,
          vehicleId: 123,
          sessionId: 456,
          medallion: "789")
      }
      
      it("is non-nil") {
        expect(self.ping).toNot(beNil())
      }
      
      it("can map") {
        expect(self.ping.toJSON()).toNot(beNil())
      }
    }
  }
}
