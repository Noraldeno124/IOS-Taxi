//
//  VerifyingExitAVI.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct VerifyingExitAvi {
  let stateName = "verifyingExitAvi"
  static let sharedInstance = VerifyingExitAvi()
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      postNotification(SfoNotification.State.waitForExitAvi, value: nil)
      
      self.poller = Poller.init(timeout: 60, action: { _ in

        DriverManager.sharedInstance.getCurrentVehicle() { vehicle in
          if let vehicle = vehicle {
            ApiClient.requestAntenna(vehicle.transponderId) { antenna in
              // TODO: make sure antenna is the right one
              if let antenna = antenna where antenna.device() == .TaxiStagingExit {
                LatestAviReadAtTaxiLoop.sharedInstance.fire()
                TripManager.sharedInstance.setStartTime(antenna.aviDate)
              }
//            else {
//              ExitAviReadFailed.sharedInstance.fire()
//              StateManager.sharedInstance.addWarning(.ExitAviFailed)
//            }
            }
          }
        }
      })
    }
    
    state.setDidExitStateBlock { _, _ in
      self.poller?.stop()
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
