//
//  ReferenceConfigResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct ReferenceConfigResponse: Mappable {
  var referenceConfig: ReferenceConfig!
  
  static func newInstance(map: Map) -> Mappable? {
    return ReferenceConfigResponse()
  }
  
  mutating func mapping(map: Map) {
    referenceConfig <- map["response"]
  }
}