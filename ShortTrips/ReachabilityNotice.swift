//
//  ReachabilityNotice.swift
//  ShortTrips
//
//  Created by Matt Luedke on 8/26/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit

class ReachabilityNotice: UILabel {
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.redColor()
    textAlignment = .Center
    textColor = UIColor.whiteColor()
    text = "network unreachable"
  }
}