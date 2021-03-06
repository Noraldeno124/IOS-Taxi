//
//  TripInvalidated.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct TripInvalidated {
  let eventNames = ["tripInvalidated"]
  static let sharedInstance = TripInvalidated()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [ValidatingTrip.sharedInstance.getState()],
      to: NotReady.sharedInstance.getState())]
  }
}

extension TripInvalidated: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension TripInvalidated: Observable {
  func eventIsFiring(_ info: Any?) {
    if let info = info as? [ValidationStepWrapper]? {
      if let info = info {
        NotificationCenter.default.post(name: .tripInvalidated, object: nil, userInfo: [InfoKey.validationSteps: info])
      } else {
        NotificationCenter.default.post(name: .tripInvalidated, object: nil) 
      }
      TripManager.sharedInstance.reset(false)
    }
  }
}
