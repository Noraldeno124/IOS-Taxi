//
//  GeofenceArbiter.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

import CoreLocation
import MapKit

struct GeofenceArbiter {
  
  static let buffer: Double = 0
  
  static func location(location: CLLocationCoordinate2D, satisfiesPolygonInfo polygonInfos:[PolygonInfo]) -> Bool {

    for polygonInfo in polygonInfos {
      if polygonInfo.additive != self.location(location, isInsideRegion: polygonInfo.polygon) {
        return false
      }
    }
    
    return true
  }
  
  static func location(location: CLLocationCoordinate2D, isInsideRegion region: MKPolygon) -> Bool {
    
    let mutablePathRef = CGPathCreateMutable()
    
    let polygonPoints = region.points()
    
    for var index = 0; index < region.pointCount; index++ {
      
      let mapPoint = polygonPoints[index]
      
      if index == 0 {
        CGPathMoveToPoint(mutablePathRef, nil, CGFloat(mapPoint.x), CGFloat(mapPoint.y))
      } else {
        CGPathAddLineToPoint(mutablePathRef, nil, CGFloat(mapPoint.x), CGFloat(mapPoint.y))
      }
    }
    
    let mapPoint = MKMapPointForCoordinate(location)
    let pointasCGP = CGPointMake(CGFloat(mapPoint.x), CGFloat(mapPoint.y))

    return CGPathContainsPoint(mutablePathRef, nil, pointasCGP, false)
  }
}
