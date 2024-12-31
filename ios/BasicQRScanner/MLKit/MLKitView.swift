//
//  MLKitView.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 31/12/24.
//

import Foundation
import AVFoundation
import MLKitBarcodeScanning
import MLKitVision

class MLKitView: UIView {
  private let session = AVCaptureSession()
  
  @objc var onSuccessfulScan: RCTDirectEventBlock?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCamera()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupCamera() {
    guard let device = AVCaptureDevice.default(for: .video) else { return }
    do {
        try device.lockForConfiguration()
        device.focusMode = .continuousAutoFocus
        device.unlockForConfiguration()
    } catch {
        print("Error locking configuration: \(error)")
    }
      
    do {
      let input = try AVCaptureDeviceInput(device: device)
      
      let output = AVCaptureVideoDataOutput()
      output.videoSettings = [
        (kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA
      ]
      output.alwaysDiscardsLateVideoFrames = true
      let outputQueue = DispatchQueue(label: "visiondetector.VideoDataOutputQueue")
      output.setSampleBufferDelegate(self, queue: outputQueue)
      
      session.beginConfiguration()
      // When performing latency tests to determine ideal capture settings,
      // run the app in 'release' mode to get accurate performance metrics
      session.sessionPreset = AVCaptureSession.Preset.hd4K3840x2160
      
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
  }
}


extension MLKitView: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    print("Captured Frame")
    let barcodeOptions = BarcodeScannerOptions(formats: .all)
    let barcodeScanner = BarcodeScanner.barcodeScanner(options: barcodeOptions)
    let visionImage = VisionImage(buffer: sampleBuffer)
    barcodeScanner.process(visionImage) { [weak self] features, error in
      print(features)
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard error == nil, let features = features, !features.isEmpty else {
            // Error handling
            return
        }
        
        for barcode in features {
          self?.onSuccessfulScan?(["result": barcode.rawValue ?? ""])
        }
    }
  }
}
