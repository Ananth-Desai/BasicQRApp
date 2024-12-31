//
//  AVFoundationViewManager.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 30/12/24.
//

import Foundation

@objc(AVFoundationViewManager)
class AVFoundationViewManager: RCTViewManager {
  private weak var scannerRef: AVFoundationView? = nil
  override class func requiresMainQueueSetup() -> Bool {
    false
  }
  
  override func view() -> UIView! {
    let ref = AVFoundationView()
    scannerRef = ref
    return ref
  }
}
