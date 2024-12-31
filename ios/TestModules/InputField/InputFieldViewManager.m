//
//  InputFieldViewManager.m
//  BasicQRApp
//
//  Created by Ananth Desai on 29/12/24.
//

#import "React/RCTBridgeModule.h"
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(InputFieldViewManager, RCTViewManager)
  RCT_EXTERN_METHOD(getValue: (RCTResponseSenderBlock)callback)
  RCT_EXPORT_VIEW_PROPERTY(initialValue, NSString)
  RCT_EXPORT_VIEW_PROPERTY(onReturn, RCTDirectEventBlock)
@end
