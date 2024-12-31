//
//  VisionKitView.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 31/12/24.
//

import Foundation
import VisionKit

@available(iOS 16.0, *)
class VisionKitView: UIView {
  private let scannerView = DataScannerViewController(
    recognizedDataTypes: [.barcode()],
    qualityLevel: .accurate,
    recognizesMultipleItems: false,
    isHighFrameRateTrackingEnabled: true,
    isPinchToZoomEnabled: true,
    isGuidanceEnabled: false,
    isHighlightingEnabled: true)
  
  @objc var onSuccessfulScan: RCTDirectEventBlock?
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCamera()
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      print("Starting to scan")
      try? self?.scannerView.startScanning()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupCamera() {
    scannerView.delegate = self
    scannerView.view.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(scannerView.view)
    scannerView.view.frame = UIScreen.main.bounds
  }
}

@available(iOS 16.0, *)
extension VisionKitView: DataScannerViewControllerDelegate {
  func dataScanner(_: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems _: [RecognizedItem]) {
      processAddedItems(items: addedItems)
  }

  func dataScanner(_: DataScannerViewController, didTapOn item: RecognizedItem) {
      processItem(item: item)
  }

  func processAddedItems(items: [RecognizedItem]) {
      for item in items {
          processItem(item: item)
      }
  }

  func processItem(item: RecognizedItem) {
      switch item {
      case let .barcode(code):
          print(code.payloadStringValue ?? "Nothing found")
      case .text:
          break
      @unknown default:
          print("Should not happen")
      }
  }
}

