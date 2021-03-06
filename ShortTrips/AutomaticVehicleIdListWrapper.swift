//
//  AutomaticVehicleIdListWrapper.swift
//  ShortTrips
//
//  Created by Joshua Adams and 🐈 on 9/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct AutomaticVehicleIdListWrapper: Mappable {
  var automaticVehicleIds: [AutomaticVehicleId]!
  
  init?(map: Map){}
  
  mutating func mapping(map: Map) {
    automaticVehicleIds <- map["response.list"]
  }
}
