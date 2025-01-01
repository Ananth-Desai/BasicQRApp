//
//  VisionKitView.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 31/12/24.
//

import Foundation
import AVFoundation
import VisionKit

@available(iOS 16.0, *)
class VisionKitView: UIView {
  static let queueLabel = "com.basicQRApp.visionKit"
  private let session = AVCaptureSession()
  private var imageAnalyser: ImageAnalyzer? = nil
  private var imageInteraction: ImageAnalysisInteraction? = nil
  private let configuration = ImageAnalyzer.Configuration(.machineReadableCode)
  
//  private let viewController = DataScannerViewController(
//    recognizedDataTypes: [.barcode(symbologies: [.qr])],
//    qualityLevel: .accurate,
//    recognizesMultipleItems: false,
//    isHighFrameRateTrackingEnabled: false,
//    isGuidanceEnabled: true,
//    isHighlightingEnabled: true)
  
  @objc var onSuccessfulScan: RCTDirectEventBlock?
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCamera()
//    viewController.delegate = self
    if ImageAnalyzer.isSupported {
      imageAnalyser = ImageAnalyzer()
      imageInteraction = ImageAnalysisInteraction()
      imageInteraction?.preferredInteractionTypes = .automatic
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupCamera() {
    guard let device = AVCaptureDevice.default(for: .video) else { return }
    
    do {
      let input = try AVCaptureDeviceInput(device: device)
      
      let output = AVCaptureVideoDataOutput()

      output.setSampleBufferDelegate(self, queue: DispatchQueue(label: VisionKitView.queueLabel))
      output.alwaysDiscardsLateVideoFrames = true
      output.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String) : NSNumber(value: kCVPixelFormatType_32BGRA)]
      
      session.beginConfiguration()
      session.addInput(input)
      session.addOutput(output)
      session.commitConfiguration()
      
      let previewLayer = AVCaptureVideoPreviewLayer(session: session)
      previewLayer.videoGravity = .resizeAspectFill
      previewLayer.frame = UIScreen.main.bounds
        
      self.layer.addSublayer(previewLayer)
      DispatchQueue.global(qos: .userInitiated).async { [weak self] in
        self?.session.startRunning()
      }
    } catch {
        print(error)
    }
//    let rootViewController = UIApplication.shared.delegate?.window??.rootViewController
//    if (rootViewController) != nil {
//      print("Root View Controller exists")
//      rootViewController?.present(viewController, animated: true)
//    }
//    try? viewController.startScanning()
  }
}

@available(iOS 16.0, *)
extension VisionKitView: AVCaptureVideoDataOutputSampleBufferDelegate {
//  func metadataOutput(_ output: AVCaptureMetadataOutput,
//                          didOutput metadataObjects: [AVMetadataObject],
//                          from connection: AVCaptureConnection) {
//    
//    guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
//              metadataObject.type == .qr,
//        let stringValue = metadataObject.stringValue else { return }
//    onSuccessfulScan?(["result" : stringValue])
//  }
  
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    let image = imageFromSampleBuffer(sampleBuffer: sampleBuffer)
    Task {
      await analyzeImage(image: image)
    }
  }
  
  func analyzeImage(image: UIImage) async {
    let analysis = try? await imageAnalyser?.analyze(image, configuration: configuration)
    print("Has machine readable code: ", analysis?.hasResults(for: .machineReadableCode))
    print("Transcript: \(analysis?.transcript)")
  }
}

@available(iOS 16.0, *)
extension VisionKitView: ImageAnalysisInteractionDelegate {
//  func contentsRect(for interaction: ImageAnalysisInteraction) -> CGRect {
//    UIScreen.main.bounds
//  }
}

@available(iOS 16.0, *)
extension VisionKitView: DataScannerViewControllerDelegate {
  
}
