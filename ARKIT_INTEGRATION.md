# ARKit Entegrasyon Rehberi

## Önemli Not
**ARKit web tarayıcılarında çalışmaz!** ARKit sadece native iOS uygulamalarında çalışır. Bu yüzden web tabanlı sisteminizle tam entegrasyon için native iOS uygulaması geliştirmeniz gerekir.

## Çözüm Seçenekleri

### 1. Native iOS App (Önerilen - Gerçek ARKit)
- **Dil:** Swift + ARKit
- **Hassasiyet:** 5-10cm (iPhone SE 2020 ile)
- **Avantajlar:** Tam ARKit desteği, yüksek hassasiyet
- **Dezavantajlar:** Native app geliştirme gerektirir

### 2. Web Tabanlı Test (DeviceMotion API)
- **Dil:** JavaScript (mevcut sisteminiz)
- **Hassasiyet:** Düşük (dead reckoning, drift var)
- **Avantajlar:** Mevcut web sisteminize entegre
- **Dezavantajlar:** ARKit kalitesinde değil, sadece test için

---

## Native iOS App Geliştirme

### Gereksinimler
- macOS (Xcode için)
- Xcode 14+ 
- iOS 13+ (ARKit 3.0+)
- iPhone SE 2020 destekler (A13 chip)

### Adım 1: Xcode Projesi Oluştur

1. Xcode'u açın
2. "Create a new Xcode project"
3. "iOS" → "App" seçin
4. Product Name: "NoiseRulerARKit"
5. Interface: SwiftUI (veya UIKit)
6. Language: Swift

### Adım 2: ARKit Framework Ekleme

`Info.plist` dosyasına kamera izni ekleyin:
```xml
<key>NSCameraUsageDescription</key>
<string>Konum takibi için kameraya ihtiyacımız var</string>
```

### Adım 3: ARKit Tracking Kodu

**ContentView.swift** (SwiftUI örneği):

```swift
import SwiftUI
import ARKit
import CoreLocation

struct ContentView: View {
    @StateObject private var arViewModel = ARViewModel()
    
    var body: some View {
        ZStack {
            ARViewContainer(viewModel: arViewModel)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text("Position: (\(arViewModel.x, specifier: "%.1f"), \(arViewModel.y, specifier: "%.1f"))")
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

class ARViewModel: ObservableObject {
    @Published var x: Float = 0
    @Published var y: Float = 0
    @Published var isTracking: Bool = false
    
    private var session: ARSession?
    private var anchorPosition: simd_float3?
    private var qrAnchorScanned: Bool = false
    
    func setSession(_ session: ARSession) {
        self.session = session
    }
    
    func updatePosition(_ transform: simd_float4x4) {
        let position = simd_float3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        
        if !qrAnchorScanned {
            // QR kod tarama sonrası anchor belirlenir
            anchorPosition = position
            qrAnchorScanned = true
            return
        }
        
        guard let anchor = anchorPosition else { return }
        
        // Anchor'a göre relatif pozisyon
        let relativePos = position - anchor
        
        // 10m x 10m alan = 240 birim canvas'a map et
        // 1 metre = 24 birim (worldSize = 240, realSize = 10m)
        let scale: Float = 24.0 // 1 metre = 24 canvas birimi
        
        let canvasX = Float(120) + relativePos.x * scale // Merkezden başla
        let canvasY = Float(120) + relativePos.z * scale // Z ekseni Y'ye map edilir
        
        // Smoothing (exponential)
        let alpha: Float = 0.4
        x = alpha * canvasX + (1 - alpha) * x
        y = alpha * canvasY + (1 - alpha) * y
        
        // Clamp to world bounds (0-240)
        x = max(0, min(240, x))
        y = max(0, min(240, y))
    }
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: ARViewModel
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        arView.session.run(configuration)
        viewModel.setSession(arView.session)
        
        // Session delegate
        arView.session.delegate = context.coordinator
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var viewModel: ARViewModel
        
        init(viewModel: ARViewModel) {
            self.viewModel = viewModel
        }
        
        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            let transform = frame.camera.transform
            viewModel.updatePosition(transform)
            viewModel.isTracking = true
        }
        
        func session(_ session: ARSession, didFailWithError error: Error) {
            print("AR Session failed: \(error)")
            viewModel.isTracking = false
        }
    }
}
```

### Adım 4: WebView Entegrasyonu (Mevcut Web Sisteminizle)

Web sisteminize konum verilerini göndermek için JavaScript bridge:

```swift
import WebKit

class WebBridge: NSObject, WKScriptMessageHandler {
    var webView: WKWebView?
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "updateListenerPosition" {
            if let body = message.body as? [String: Any],
               let x = body["x"] as? Float,
               let y = body["y"] as? Float {
                // Web sayfasına konum gönder
                let js = "window.updateListenerPosition(\(x), \(y));"
                webView?.evaluateJavaScript(js, completionHandler: nil)
            }
        }
    }
    
    func sendPosition(x: Float, y: Float) {
        let js = "window.updateListenerPosition(\(x), \(y));"
        webView?.evaluateJavaScript(js, completionHandler: nil)
    }
}
```

Web tarafında (`index.html`):
```javascript
// ARKit'ten gelen konumları al
window.updateListenerPosition = function(x, y) {
    if (state.tracking.enabled && state.tracking.mode === 'arkit') {
        state.listener.x = x;
        state.listener.y = y;
    }
};
```

### Adım 5: QR Kod Anchor Sistemi

ARKit Image Detection kullanarak QR kod anchor:

```swift
// ARWorldTrackingConfiguration'a ekle
let configuration = ARWorldTrackingConfiguration()

// QR kod görüntüsünü anchor olarak kullan
if let qrImage = ARReferenceImage.referenceImages(inGroupNamed: "QRResources", bundle: nil) {
    configuration.detectionImages = qrImage
}

arView.session.run(configuration)
```

QR kod görüntüsünü Xcode projesine ekleyin ve ARResource grup oluşturun.

---

## Web Tabanlı Test Sistemi (DeviceMotion)

Web tabanlı sisteminize DeviceMotion API entegrasyonu eklendi. Bu ARKit kalitesinde değil, ancak test için kullanılabilir.

### Kullanım

1. Telefonunuzda web sayfasını açın
2. "Enable Motion Tracking" butonuna tıklayın
3. İzin isteğini onaylayın
4. Telefonu hareket ettirin (dead reckoning ile konum takibi)

**Not:** DeviceMotion sadece hareket yönünü ve hızlanmayı ölçer, mutlak konum vermez. Bu yüzden drift (sapma) olacaktır.

---

## Karşılaştırma

| Özellik | Native iOS (ARKit) | Web (DeviceMotion) |
|---------|-------------------|-------------------|
| Hassasiyet | 5-10cm | Çok düşük (drift var) |
| Smooth Tracking | Evet | Hayır (drift) |
| QR Anchor | Evet | Hayır |
| Geliştirme | Native app gerekir | Web'de çalışır |
| Uyumluluk | iOS 13+ | Tüm modern telefonlar |

---

## Öneri

Gerçek bir deneyim için **Native iOS App** geliştirmenizi öneriyoruz. Web tabanlı sistem sadece test/prototype amaçlı kullanılmalı.

