# Adım Adım Kurulum Rehberi

## Adım 1: IP Adresinizi Bulun

Terminal'de (macOS):
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

veya daha basit:
```bash
ipconfig getifaddr en0
```

Örnek çıktı: `192.168.1.100`

## Adım 2: ContentView.swift'i Güncelleyin

1. Xcode'da `ContentView.swift` dosyasını açın
2. Şu anki içeriği **tamamen silin**
3. `ContentView_UPDATED.swift` dosyasındaki kodu kopyalayıp yapıştırın
4. **ÖNEMLİ:** 15. satırda IP adresinizi değiştirin:
   ```swift
   @State private var serverURLString: String = "http://192.168.1.100:8000/index.html"
   ```
   `192.168.1.100` yerine kendi IP adresinizi yazın!

## Adım 3: Info.plist'i Güncelleyin

### Yöntem A: Xcode GUI (Kolay)

1. Sol panelde `Info.plist` dosyasını bulun
2. Dosyaya **tıklayın**
3. Sağ altta **"+"** butonuna tıklayın
4. Arama kutusuna `camera` yazın
5. **"Privacy - Camera Usage Description"** seçin
6. Sağ tarafta Value kısmına: `Konum takibi için kameraya ihtiyacımız var` yazın

### Yöntem B: Source Code (Hızlı)

1. Sol panelde `Info.plist` dosyasına **sağ tıklayın**
2. **"Open As" > "Source Code"** seçin
3. `</dict>` tag'inden **önce** şunu ekleyin:

```xml
	<key>NSCameraUsageDescription</key>
	<string>Konum takibi için kameraya ihtiyacımız var</string>
```

Dosyanın sonu şöyle görünmeli:
```xml
	</array>
	<key>NSCameraUsageDescription</key>
	<string>Konum takibi için kameraya ihtiyacımız var</string>
</dict>
</plist>
```

## Adım 4: Diğer Swift Dosyalarını Ekleyin

Xcode'da sol panelde proje adına sağ tıklayın → **"Add Files to NoiseRulerARKit..."**

Şu dosyaları ekleyin (NoiseRulerARKit klasöründen):
- `ARViewModel.swift`
- `ARViewContainer.swift`
- `App.swift` (eğer yoksa)

**ÖNEMLİ:** Xcode'un oluşturduğu `App.swift` varsa, onu **silin** ve bizimkini ekleyin.

## Adım 5: Framework'leri Kontrol Edin

1. Sol panelde proje adına (mavi ikon) tıklayın
2. **"TARGETS"** altında `NoiseRulerARKit`'i seçin
3. **"Build Phases"** sekmesine gidin
4. **"Link Binary With Libraries"** bölümünü genişletin
5. Şunlar olmalı (yoksa "+" ile ekleyin):
   - `ARKit.framework`
   - `SceneKit.framework`

## Adım 6: Deployment Target

1. Aynı **"TARGETS" > "NoiseRulerARKit"** bölümünde
2. **"General"** sekmesinde
3. **"Minimum Deployments"**: iOS 13.0 veya üzeri

## Adım 7: Web Sunucusunu Başlatın

Terminal'de:
```bash
cd "/Volumes/My Library/Extreme SSD Recovery/1. Productions/Coding/noiseruler"
python3 -m http.server 8000
```

Sunucu çalıştığını göreceksiniz: `Serving HTTP on 0.0.0.0 port 8000...`

## Adım 8: Xcode'da Çalıştırın

1. Xcode'da üstte cihaz seçiciyi açın
2. **iPhone SE (2nd generation)** veya gerçek iPhone'unuzu seçin
3. **Play** butonuna (▶️) tıklayın
4. İlk çalıştırmada kamera izni isteyecek → **"Allow"** seçin
5. Uygulama açılınca **"Start AR Tracking"** butonuna tıklayın

## Sorun Giderme

### Build Hatası: "Cannot find type 'ARViewModel'"
- `ARViewModel.swift` dosyasının projeye eklendiğinden emin olun
- Build Phases > Compile Sources'da `ARViewModel.swift` olmalı

### Build Hatası: "Cannot find type 'WKWebView'"
- `import WebKit` ekleyin (ContentView.swift'in başına)

### Web sayfası yüklenmiyor
- Web sunucunuzun çalıştığından emin olun
- IP adresinin doğru olduğundan emin olun
- iPhone ve bilgisayar aynı WiFi ağında olmalı

### ARKit çalışmıyor
- Simülatör ARKit desteklemez - gerçek cihaz kullanın
- iOS 13+ gereklidir
- Kamera izni verildiğinden emin olun

## Başarı!

Eğer her şey çalışıyorsa:
- Web sayfanız yüklenecek
- ARKit tracking başlayacak
- Yeşil nokta (listener) telefonunuzun hareketine göre hareket edecek
- Ses sistemi çalışacak!

🎉 Tebrikler!

