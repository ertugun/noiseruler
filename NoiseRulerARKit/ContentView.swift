//
//  ContentView.swift
//  NoiseRulerARKit
//
//  Main view with ARKit tracking and WebView
//

import SwiftUI

struct ContentView: View {
    @StateObject private var arViewModel = ARViewModel()
    @State private var showARView = false
    @State private var webViewURL: URL?
    @State private var serverURLString: String = "http://192.168.1.100:8000/index.html"
    
    var body: some View {
        ZStack {
            if showARView, let url = webViewURL {
                // AR View (hidden background - for tracking only)
                ARViewContainer(viewModel: arViewModel)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0)
                    .allowsHitTesting(false)
                
                // Web View (visible foreground)
                WebViewWithARKit(viewModel: arViewModel, url: url)
                    .edgesIgnoringSafeArea(.all)
                
                // Debug overlay (optional - tap to hide/show)
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("ARKit Tracking")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Position: (\(String(format: "%.1f", arViewModel.x)), \(String(format: "%.1f", arViewModel.y)))")
                            .font(.caption)
                            .foregroundColor(.white)
                        Text("Status: \(arViewModel.trackingStatus)")
                            .font(.caption)
                            .foregroundColor(arViewModel.isTracking ? .green : .yellow)
                        Button("Reset Anchor") {
                            arViewModel.resetAnchor()
                        }
                        .font(.caption)
                        .padding(4)
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding()
                }
            } else {
                // Setup screen
                VStack(spacing: 20) {
                    Text("NoiseRuler ARKit")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Enter your server URL:")
                        .font(.headline)
                    
                    TextField("http://192.168.1.100:8000/index.html", text: $serverURLString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.URL)
                    
                    Text("Make sure your web server is running!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Button(action: {
                        if let url = URL(string: serverURLString) {
                            webViewURL = url
                            showARView = true
                        } else {
                            print("Invalid URL: \(serverURLString)")
                        }
                    }) {
                        Text("Start AR Tracking")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
            }
        }
    }
}

// WebView that receives ARKit position updates
struct WebViewWithARKit: UIViewRepresentable {
    @ObservedObject var viewModel: ARViewModel
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.preferences.javaScriptEnabled = true
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = UIColor.black
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Send position updates to web view
        let js = """
            if (typeof window.updateListenerPosition === 'function') {
                window.updateListenerPosition(\(viewModel.x), \(viewModel.y));
            }
        """
        
        webView.evaluateJavaScript(js) { result, error in
            if let error = error {
                // Silently fail - function might not be loaded yet
                print("[WebView] JS error: \(error.localizedDescription)")
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var viewModel: ARViewModel
        
        init(viewModel: ARViewModel) {
            self.viewModel = viewModel
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("[WebView] Page loaded successfully")
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("[WebView] Navigation failed: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
