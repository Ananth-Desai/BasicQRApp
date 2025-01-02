//
//  VisionViewManager.m
//  BasicQRApp
//
//  Created by Ananth Desai on 02/01/25.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(VisionViewManager, RCTViewManager)
  RCT_EXPORT_VIEW_PROPERTY(onSuccessfulScan, RCTDirectEventBlock)
@end
