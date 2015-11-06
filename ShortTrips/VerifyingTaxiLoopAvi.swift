//
//  VerifyingTaxiLoopAVI.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct VerifyingTaxiLoopAvi {
  let stateName = "verifyingTaxiLoopAvi"
  static let sharedInstance = VerifyingTaxiLoopAvi()
  private let expectedAvi: GtmsLocation = .HoldingLotExit
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
    
      postNotification(SfoNotification.State.waitForTaxiLoopAvi, value: nil)
      
      self.poller = Poller.init(timeout: 60, action: { _ in
        DriverManager.sharedInstance.getCurrentVehicle() { vehicle in
          if let vehicle = vehicle {
            ApiClient.requestAntenna(vehicle.transponderId) { antenna in
              if let antenna = antenna, let device = antenna.device() {
                if device == self.expectedAvi {
                  LatestAviReadAtTaxiLoop.sharedInstance.fire(antenna)
                } else {
                  postNotification(SfoNotification.Avi.unexpected, value: (expected: self.expectedAvi, found: device))
                }
              }
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