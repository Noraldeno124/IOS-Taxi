//
//  ShortTripView.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class ShortTripView: UIView {
  let countdownLabel = UILabel()
  let currentStateLabel = UILabel()
  let notificationImageView = UIImageView()
  let topImageView = UIImageView()
  private let notificationLabel = UILabel()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
    addSubview(countdownLabel)
    addSubview(currentStateLabel)
    addSubview(notificationImageView)
    addSubview(notificationLabel)
    addSubview(topImageView)
    
    countdownLabel.backgroundColor = Color.Auth.fadedWhite
    countdownLabel.font = Font.MyriadPro.size(14)
    countdownLabel.textAlignment = .Left
    countdownLabel.textColor = UIColor.whiteColor()
    countdownLabel.snp_makeConstraints { make in
      make.leading.equalTo(notificationLabel)
      make.trailing.equalTo(notificationLabel)
      make.bottom.equalTo(notificationLabel.snp_top)
      make.height.equalTo(40)
    }
    
    currentStateLabel.font = Font.MyriadPro.size(28)
    currentStateLabel.textAlignment = .Center
    currentStateLabel.numberOfLines = 0
    currentStateLabel.textColor = UIColor.whiteColor()
    currentStateLabel.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(self).offset(10)
      make.height.equalTo(75)
    }
    
    notificationImageView.contentMode = .ScaleAspectFit
    notificationImageView.snp_makeConstraints { make in
      make.centerX.equalTo(self)
      make.width.equalTo(200)
      make.height.equalTo(200)
      make.bottom.equalTo(countdownLabel.snp_top)
    }
    
    notificationLabel.backgroundColor = Color.Auth.fadedWhite
    notificationLabel.font = Font.MyriadPro.size(14)
    notificationLabel.numberOfLines = 0
    notificationLabel.textAlignment = .Center
    notificationLabel.textColor = UIColor.whiteColor()
    notificationLabel.snp_makeConstraints { make in
      make.leading.equalTo(self).offset(30)
      make.trailing.equalTo(self).offset(-30)
      make.bottom.equalTo(self).offset(-30)
      make.height.equalTo(75)
    }
    
    topImageView.contentMode = .Center
    topImageView.clipsToBounds = true
    topImageView.image = Image.tripHorizontalDivider.image()
    topImageView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.width.equalTo(notificationImageView)
      make.top.equalTo(currentStateLabel.snp_bottom)
      make.bottom.equalTo(notificationImageView.snp_top)
    }
  }
  
  func notify(notification: String) {
    notificationLabel.text = notification
    AVSpeechSynthesizer().speakUtterance(AVSpeechUtterance(string: notification))
  }
}
