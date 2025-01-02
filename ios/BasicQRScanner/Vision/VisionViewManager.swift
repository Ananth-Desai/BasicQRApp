//
//  VisionViewManager.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 02/01/25.
//

import Foundation

@objc(VisionViewManager)
class VisionViewManager: RCTViewManager {
  private var scannerRef: VisionView? = nil
  
  override class func requiresMainQueueSetup() -> Bool {
    false
  }
  
  override func view() -> UIView! {
    let ref = VisionView()
    scannerRef = ref
    return ref
  }
}
