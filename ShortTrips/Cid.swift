//
//  Cid.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct Cid: Mappable {
  var cidId: String!
  var cidLocation: String!
  var cidTimeRead: Date?
  
  static let transform = SfoDateTransform(dateFormat: "yyyy-MM-dd HH:mm:ss.SS") // "2015-09-03 09:19:20.99"

  init(cidId: String, cidLocation: String, cidTimeRead: Date) {
    self.cidId = cidId
    self.cidLocation = cidLocation
    self.cidTimeRead = cidTimeRead
  }
  
  init?(map: Map){}
  
  mutating func mapping(map: Map) {
    cidId <- map["response.device_id"]
    cidLocation <- map["response.device_location"]
    cidTimeRead <- (map["response.time_read"], Cid.transform)
  }
  
  func device() -> GtmsLocation? {
    return GtmsLocation.from(cidId: cidId)
  }
}
