//
//  ARViewModel.swift
//  NoiseRulerARKit
//
//  ARKit tracking view model
//

import Foundation
import ARKit
import Combine

class ARViewModel: ObservableObject {
    @Published var x: Float = 120.0  // Canvas center X (240/2)
    @Published var y: Float = 120.0  // Canvas center Y (240/2)
    @Published var isTracking: Bool = false
    @Published var trackingStatus: String = "Not Started"
    
    private var session: ARSession?
    private var anchorPosition: simd_float3?
    private var qrAnchorScanned: Bool = false
    private var lastUpdateTime: Date?
    
    // Smoothing parameters
    private let smoothingAlpha: Float = 0.4  // Exponential smoothing factor
    private let canvasSize: Float = 240.0    // Canvas world size
    private let realWorldScale: Float = 24.0 // 1 meter = 24 canvas units (10m = 240 units)
    
    func setSession(_ session: ARSession) {
        self.session = session
    }
    
    func resetAnchor() {
        anchorPosition = nil
        qrAnchorScanned = false
        trackingStatus = "Ready - Move phone to scan QR code"
    }
    
    func setAnchor(_ position: simd_float3) {
        anchorPosition = position
        qrAnchorScanned = true
        trackingStatus = "Tracking Active"
        print("[ARKit] Anchor set at: \(position)")
    }
    
    func updatePosition(_ transform: simd_float4x4) {
        let position = simd_float3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        
        // If no anchor set, use first position as anchor
        if !qrAnchorScanned {
            setAnchor(position)
            return
        }
        
        guard let anchor = anchorPosition else { return }
        
        // Calculate relative position from anchor
        let relativePos = position - anchor
        
        // Convert to canvas coordinates
        // X axis in ARKit -> X axis in canvas
        // Z axis in ARKit -> Y axis in canvas (forward is up in canvas)
        let canvasX = (canvasSize / 2) + relativePos.x * realWorldScale
        let canvasY = (canvasSize / 2) + relativePos.z * realWorldScale
        
        // Apply exponential smoothing
        let alpha = smoothingAlpha
        let newX = alpha * canvasX + (1 - alpha) * x
        let newY = alpha * canvasY + (1 - alpha) * y
        
        // Clamp to canvas bounds (0-240)
        x = max(0, min(canvasSize, newX))
        y = max(0, min(canvasSize, newY))
        
        isTracking = true
        lastUpdateTime = Date()
    }
    
    func getPositionJSON() -> String {
        return """
        {
            "x": \(x),
            "y": \(y),
            "tracking": \(isTracking)
        }
        """
    }
}

