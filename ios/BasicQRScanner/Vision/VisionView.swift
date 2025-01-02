//
//  VisionView.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 02/01/25.
//

import Foundation
import AVFoundation
import Vision

class VisionView: UIView {
  private let session = AVCaptureSession()
  private let barcodeRequest = VNDetectBarcodesRequest()
  
  @objc var onSuccessfulScan: RCTDirectEventBlock?
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    barcodeRequest.symbologies = [.qr]
    setupCamera()
  }
  
  func setupCamera() {
    guard let device = AVCaptureDevice.default(for: .video) else { return }
      
    do {
      let input = try AVCaptureDeviceInput(device: device)

      let output = AVCaptureVideoDataOutput()

      output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VisionView.queueLabel"))
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
  }
}

extension VisionView: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//    let image = imageFromSampleBuffer(sampleBuffer: sampleBuffer)
    let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer)
    Task { [weak self] in
      guard let self = self else {
        print("self is nil!")
        return
      }
      do {
        try requestHandler.perform([self.barcodeRequest])
        guard let results = barcodeRequest.results else {
          print("No results found in the image")
          return
        }
        if !results.isEmpty {
          results.forEach { observation in
            print(observation.payloadStringValue, observation.confidence)
          }
          DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.session.stopRunning()
          }
          onSuccessfulScan?(["result": results.first?.payloadStringValue])
        }
      }
    }
  }
}
