//
//  InputFieldViewManager.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 29/12/24.
//

import Foundation

@objc(InputFieldViewManager)
class InputFieldViewManager: RCTViewManager {
  
  override class func requiresMainQueueSetup() -> Bool {
    true
  }
  
  override func view() -> UIView! {
    return InputFieldView()
  }
}
