//
//  MLKitViewManger.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 31/12/24.
//

import Foundation

@objc(MLKitViewManager)
class MLKitViewManager: RCTViewManager {
  private weak var scannerRef: MLKitView? = nil
  override class func requiresMainQueueSetup() -> Bool {
    false
  }
  
  override func view() -> UIView! {
    let ref = MLKitView()
    scannerRef = ref
    return ref
  }
}
