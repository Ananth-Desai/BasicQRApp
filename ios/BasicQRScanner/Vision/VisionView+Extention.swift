//
//  VisionView+Extention.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 02/01/25.
//

import Foundation
import CoreMedia

extension VisionView {
  func imageFromSampleBuffer(sampleBuffer : CMSampleBuffer) -> CGImage
   {
     // Get a CMSampleBuffer's Core Video image buffer for the media data
     let  imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
     // Lock the base address of the pixel buffer
     CVPixelBufferLockBaseAddress(imageBuffer!, CVPixelBufferLockFlags.readOnly);


     // Get the number of bytes per row for the pixel buffer
     let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer!);

     // Get the number of bytes per row for the pixel buffer
     let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer!);
     // Get the pixel buffer width and height
     let width = CVPixelBufferGetWidth(imageBuffer!);
     let height = CVPixelBufferGetHeight(imageBuffer!);

     // Create a device-dependent RGB color space
     let colorSpace = CGColorSpaceCreateDeviceRGB();

     // Create a bitmap graphics context with the sample buffer data
     var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Little.rawValue
     bitmapInfo |= CGImageAlphaInfo.premultipliedFirst.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
     //let bitmapInfo: UInt32 = CGBitmapInfo.alphaInfoMask.rawValue
     let context = CGContext.init(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
     // Create a Quartz image from the pixel data in the bitmap graphics context
     let quartzImage = context?.makeImage();
     // Unlock the pixel buffer
     CVPixelBufferUnlockBaseAddress(imageBuffer!, CVPixelBufferLockFlags.readOnly);

     return (quartzImage!);
   }
}
