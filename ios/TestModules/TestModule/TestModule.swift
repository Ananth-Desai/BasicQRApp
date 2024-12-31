//
//  TestModule.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 30/12/24.
//

import Foundation

@objc(TestModule)
class TestModule: NSObject {
  private var isError: Bool = false;
  
  @objc
  func constantsToExport() -> [String: Any]? {
    ["parameter": "Hello World"]
  }
  
  @objc
  func getValue(_ callback: RCTResponseSenderBlock) {
    callback(["This is the returned value"])
  }
  
  @objc
  func getValueAsync(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) {
    if (isError) {
      reject("CUSTOM_ERROR_CODE", "This is a custom error", nil)
    } else {
      resolve("Resolved with a test string")
    }
    isError = !isError
  }
}
