//
//  AVFoundationView.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 30/12/24.
//

import Foundation
import AVFoundation

class AVFoundationView: UIView {
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
      let input = try AVCaptureDeviceInput(device: device)
      
      let output = AVCaptureMetadataOutput()

      output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      
      session.addInput(input)
      session.addOutput(output)
      
      output.metadataObjectTypes = [.qr]
      
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


extension AVFoundationView: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ output: AVCaptureMetadataOutput,
                          didOutput metadataObjects: [AVMetadataObject],
                          from connection: AVCaptureConnection) {
    guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              metadataObject.type == .qr,
        let stringValue = metadataObject.stringValue else { return }
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      self?.session.stopRunning()
    }
    onSuccessfulScan?(["result" : stringValue])
  }
}
