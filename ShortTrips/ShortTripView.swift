//
//  ShortTripView.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

enum StatePrompt {
  case GoToSfo
  case Pay
  case Ready
  case InProgress
  
  func toString() -> String {
    switch self {
    case .GoToSfo:
      return NSLocalizedString("Go to SFO holding lot to start your next trip", comment: "").uppercaseString
    case .Pay:
      return NSLocalizedString("Pay and go to terminal curbside to start your next trip", comment: "").uppercaseString
    case .Ready:
      return NSLocalizedString("Your trip will start when you exit the airport", comment: "").uppercaseString
    case .InProgress:
      return NSLocalizedString("Your short trip is in progress", comment: "").uppercaseString
    }
  }
  
  func image() -> UIImage {
    switch self {
    case .GoToSfo:
      return Image.exclamationPoint.image()
    case .Pay:
      return Image.exclamationPoint.image()
    case .Ready:
      return Image.mapPin.image()
    case .InProgress:
      return Image.car.image()
    }
  }
}

class ShortTripView: UIView {
  let countdown = CountdownView()
  private let promptLabel = UILabel()
  private let promptImageView = UIImageView()
  private let notificationView = NotificationView()
  private var currentPrompt: StatePrompt?
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
    addSubview(countdown)
    addSubview(promptLabel)
    addSubview(promptImageView)
    
    countdown.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
      make.height.equalTo(self).dividedBy(4)
    }
    
    let horizontalDivider = UIView()
    horizontalDivider.backgroundColor = Color.Trip.divider
    addSubview(horizontalDivider)
    horizontalDivider.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.height.equalTo(1)
      make.width.equalTo(self).dividedBy(2)
      make.top.equalTo(promptLabel.snp_bottom).offset(UiConstants.Trip.dividerMargin)
    }
    
    promptLabel.font = Font.OpenSansSemibold.size(25)
    promptLabel.textAlignment = .Center
    promptLabel.numberOfLines = 0
    promptLabel.textColor = Color.Trip.title
    promptLabel.snp_makeConstraints { make in
      make.leading.equalTo(self).offset(25)
      make.trailing.equalTo(self).offset(-25)
      make.top.equalTo(self).offset(UiConstants.Trip.topMargin)
    }
    
    promptImageView.contentMode = .ScaleAspectFit
    promptImageView.snp_makeConstraints { make in
      make.centerX.equalTo(self)
      make.top.equalTo(horizontalDivider.snp_bottom).offset(UiConstants.Trip.dividerMargin)
      make.bottom.equalTo(countdown.snp_top).offset(-UiConstants.Trip.dividerMargin)
      make.width.equalTo(self).dividedBy(2)
    }
    
    addSubview(notificationView)
    notificationView.hidden = true
  }
  
  func updatePrompt(prompt: StatePrompt) {
    if prompt != currentPrompt {
      promptLabel.text = prompt.toString()
      promptImageView.image = prompt.image()
      Speaker.sharedInstance.speak(prompt.toString())
  
      currentPrompt = prompt
    }
  }
  
  func notifySuccess() {
    
    notificationView.snp_remakeConstraints { make in
      make.height.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
    notificationView.setNeedsUpdateConstraints()
    layoutIfNeeded()
    
    notificationView.notifySuccess()
    notificationView.hidden = false
  }
  
  func notifyFail(validationStep: ValidationStep) {
    
    notificationView.snp_remakeConstraints { make in
      make.height.equalTo(self).multipliedBy(0.75)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
    notificationView.setNeedsUpdateConstraints()
    layoutIfNeeded()
    
    let duration: NSTimeInterval = 0.5
    let delay: NSTimeInterval = 5
    
    notificationView.notifyFail(validationStep, delay: delay, duration: duration)
    
    notificationView.snp_remakeConstraints { make in
      make.height.equalTo(self).dividedBy(4)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
    
    notificationView.setNeedsUpdateConstraints()
    notificationView.hidden = false
    UIView.animateWithDuration(duration,
      delay: delay,
      options: UIViewAnimationOptions.CurveEaseInOut,
      animations: {
        self.layoutIfNeeded()
      },
      completion: nil)
  }
  
  func hideNotification() {
    notificationView.hidden = true
  }
  
  func updateCountdown(elapsedTime: NSTimeInterval?) {
    countdown.updateCountdown(elapsedTime)
  }
}
