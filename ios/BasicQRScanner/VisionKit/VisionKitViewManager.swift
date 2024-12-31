//
//  VisionKitViewManager.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 31/12/24.
//

import Foundation

@available(iOS 16.0, *)
@objc(VisionKitViewManager)
class VisionKitViewManager: RCTViewManager {
  private weak var scannerRef: VisionKitView? = nil
  
  override class func requiresMainQueueSetup() -> Bool {
    false
  }
  
  override func view() -> UIView! {
    let scannerRef = VisionKitView()
    self.scannerRef = scannerRef
    return scannerRef
  }
}
