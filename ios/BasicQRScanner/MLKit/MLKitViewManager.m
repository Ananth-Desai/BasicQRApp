//
//  VisionKitViewManager.m
//  BasicQRApp
//
//  Created by Ananth Desai on 31/12/24.
//

#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(MLKitViewManager, RCTViewManager)
  RCT_EXPORT_VIEW_PROPERTY(onSuccessfulScan, RCTDirectEventBlock)
@end
