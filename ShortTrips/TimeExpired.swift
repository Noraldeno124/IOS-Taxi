//
//  TimeExpired.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct TimeExpired {
  let eventNames = ["timeExpired"]
  static let sharedInstance = TimeExpired()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      to: NotReady.sharedInstance.getState())]
  }
}

extension TimeExpired: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension TimeExpired: Observable {
  func eventIsFiring(_ info: Any?) {
    postNotification(SfoNotification.Trip.timeExpired, value: nil)

    if let tripId = TripManager.sharedInstance.getTripId(),
      let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId {

      ApiClient.invalidate(tripId, invalidation: .duration, sessionId: sessionId)
      TripManager.sharedInstance.reset(false)
    }
  }
}
