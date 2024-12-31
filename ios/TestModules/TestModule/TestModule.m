//
//  TestModule.m
//  BasicQRApp
//
//  Created by Ananth Desai on 30/12/24.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(TestModule, NSObject)
  RCT_EXTERN_METHOD(getValue: (RCTResponseSenderBlock)callback)
  RCT_EXTERN_METHOD(getValueAsync: (RCTPromiseResolveBlock)resolve rejecter: (RCTPromiseRejectBlock)reject)
@end
