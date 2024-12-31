//
//  AVFoundationViewManager.m
//  BasicQRApp
//
//  Created by Ananth Desai on 30/12/24.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(AVFoundationViewManager, RCTViewManager)
  RCT_EXPORT_VIEW_PROPERTY(onSuccessfulScan, RCTDirectEventBlock)
@end
