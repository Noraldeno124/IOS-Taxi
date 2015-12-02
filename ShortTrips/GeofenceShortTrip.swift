//
//  GeofenceShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension ShortTripVC {
  
  func setupGeofenceObservers() {
    
    sfoObservers.exitingTerminalsObserver = NotificationObserver(notification: SfoNotification.Geofence.exitingTerminals) { _, _ in
      self.shortTripView().notificationLabel.text = "Exiting Terminals Event!"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.foundInsideGeofencesObserver = NotificationObserver(notification: SfoNotification.Geofence.foundInside) { geofences, _ in
      self.shortTripView().notificationLabel.text = ""
      for geofence in geofences {
        self.shortTripView().notificationLabel.text! += "In Geofence: \(geofence.name) "
      }
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.insideSfoObserver = NotificationObserver(notification: SfoNotification.Geofence.insideSfo) { _, _ in
      self.shortTripView().notificationLabel.text = "Inside SFO Event!"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.outsideShortTripObserver = NotificationObserver(notification: SfoNotification.Geofence.outsideShortTrip) { _, _ in
      self.shortTripView().notificationLabel.text = "Trip Went Outside Short Trip Geofence"
      self.shortTripView().notificationImageView.image = UIImage(named: "notInGeofence.png")
    }
  }
}
