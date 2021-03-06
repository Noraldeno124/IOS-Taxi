//
//  UIFont+SFO.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/20/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

enum Font: String {
  case OpenSans = "OpenSans"
  case OpenSansBold = "OpenSans-Bold"
  case OpenSansSemibold = "OpenSans-Semibold"
  // TODO all the other fonts
  
  func size(_ size: CGFloat) -> UIFont {
    return UIFont(name: self.rawValue, size: scaledSize(size))!
  }
  
  func scaledSize(_ sizeOnIPhone6: CGFloat) -> CGFloat {
    return sizeOnIPhone6 * (UIScreen.main.bounds.size.height / 667)
  }
}
