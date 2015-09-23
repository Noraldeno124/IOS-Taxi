//
//  LotStatusResponseSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class LotStatusResponseSpec: QuickSpec {
  var lotStatus: LotStatus!
  var lotStatusResponse: LotStatusResponse!
  var map: Map!

  override func spec() {
    describe("the LotStatusResponse") {
      beforeEach {
        self.lotStatus = LotStatus(color: LotStatusEnum.Red, timestamp: NSDate())
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.lotStatusResponse = LotStatusResponse(self.map)
        self.lotStatusResponse.lotStatus = self.lotStatus
      }

      it("is non-nil") {
        expect(self.lotStatusResponse).toNot(beNil())
      }

      it("has a lot status") {
        expect(self.lotStatus).toNot(beNil())
      }

      it("can map") {
        expect(self.lotStatusResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
