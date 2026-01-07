//
//  ARViewContainer.swift
//  NoiseRulerARKit
//
//  ARKit SceneKit view container
//

import SwiftUI
import ARKit
import SceneKit

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: ARViewModel
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        
        // Configure AR session
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        // Enable environment texturing for better tracking
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            configuration.sceneReconstruction = .mesh
        }
        
        arView.session.run(configuration)
        arView.session.delegate = context.coordinator
        viewModel.setSession(arView.session)
        
        // Set background color
        arView.backgroundColor = UIColor.black
        
        // Disable auto-lighting (we'll use real lighting)
        arView.automaticallyUpdatesLighting = true
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // Updates handled by session delegate
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var viewModel: ARViewModel
        var lastUpdateTime: Date?
        let updateInterval: TimeInterval = 0.05 // 20 updates per second (50ms)
        
        init(viewModel: ARViewModel) {
            self.viewModel = viewModel
        }
        
        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            let transform = frame.camera.transform
            viewModel.updatePosition(transform)
        }
        
        func session(_ session: ARSession, didFailWithError error: Error) {
            print("[ARKit] Session failed: \(error.localizedDescription)")
            viewModel.isTracking = false
            viewModel.trackingStatus = "Tracking Failed: \(error.localizedDescription)"
        }
        
        func sessionWasInterrupted(_ session: ARSession) {
            print("[ARKit] Session interrupted")
            viewModel.isTracking = false
            viewModel.trackingStatus = "Tracking Interrupted"
        }
        
        func sessionInterruptionEnded(_ session: ARSession) {
            print("[ARKit] Session interruption ended")
            viewModel.trackingStatus = "Tracking Resumed"
        }
    }
}

