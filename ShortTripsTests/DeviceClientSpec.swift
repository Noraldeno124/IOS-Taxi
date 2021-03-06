//
//  DeviceClientSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class DeviceClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the device client") {
      
      beforeEach {
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
      }
      
      xit("can post mobile state changes") {
//        self.stub(uri(Url.Device.mobileStateUpdate(MobileState.Ready.rawValue)), builder: json(AllGeofenceMock))
        
        let mobileState = MobileStateInfo(longitude: 10.0, latitude: 10.0, sessionId: 1, tripId: 1)
        ApiClient.updateMobileState(MobileState.ready, mobileStateInfo: mobileState)
      }
      
      xit("can request automatic vehicle ids") {
        let transponderId = 2005887;
//        self.stub(uri(Url.Device.Avi.transponder(transponderId)), builder: json(RequestAntennaMock))
        ApiClient.requestAntenna(transponderId) { response in
          expect(response).toNot(beNil())
        }
      }
      
      xit("can request automatic vehicle ids") {
        let driverId = 5;
//        self.stub(uri(Url.Device.Cid.driver(driverId)), builder: json(RequestCidForSmartCardMock))
        ApiClient.requestCid(driverId) { response in
          expect(response).toNot(beNil())
        }
      }
    }
  }
}
