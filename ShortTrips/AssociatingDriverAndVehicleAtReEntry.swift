//
//  AssociatingDriverAndVehicleAtReEntry.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct AssociatingDriverAndVehicleAtReEntry {
  let stateName = "associatingDriverAndVehicleAtReEntry"
  static let sharedInstance = AssociatingDriverAndVehicleAtReEntry()
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      postNotification(SfoNotification.State.update, value: self.getState())
      
      self.poller = Poller.init(failure: { TimedOutReEntryCheck.sharedInstance.fire() }) {
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.getVehicle(driver.cardId) { vehicle in
            
            if let vehicle = vehicle {
              DriverManager.sharedInstance.setCurrentVehicle(vehicle)
            }
          }
        }
      }
    }
    
    state.setDidExitStateBlock { _, _ in
      self.poller?.stop()
    }
  }
  
  func getState() -> TKState {
    return state
  }
}