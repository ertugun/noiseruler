# Xcode Projesi Kurulum Rehberi

## Adım 1: Xcode'u Açın

1. macOS'ta Xcode'u açın (App Store'dan indirebilirsiniz, ücretsizdir)
2. Xcode açıldığında: **"Create a new Xcode project"** seçin

## Adım 2: Proje Şablonu Seçin

1. **"iOS"** sekmesini seçin
2. **"App"** şablonunu seçin
3. **"Next"** butonuna tıklayın

## Adım 3: Proje Bilgilerini Girin

- **Product Name:** `NoiseRulerARKit`
- **Team:** Kendi Apple ID'nizi seçin (veya "None" - sadece simülatör için)
- **Organization Identifier:** `com.yourname` (örnek: `com.johndoe`)
- **Bundle Identifier:** Otomatik oluşturulur (`com.yourname.NoiseRulerARKit`)
- **Interface:** **SwiftUI** (önerilen)
- **Language:** **Swift**
- **Storage:** "None" yeterli
- **Include Tests:** İsteğe bağlı (şimdilik kapalı bırakabilirsiniz)

**"Next"** butonuna tıklayın.

## Adım 4: Proje Konumunu Seçin

1. Projeyi kaydetmek istediğiniz yeri seçin
2. **"Create"** butonuna tıklayın

## Adım 5: Dosyaları Kopyalayın

Xcode projesi oluşturulduktan sonra:

1. Proje klasörüne gidin (NoiseRulerARKit klasörü)
2. Bu rehberin yanındaki Swift dosyalarını kopyalayın:
   - `App.swift`
   - `ContentView.swift`
   - `ARViewModel.swift`
   - `ARViewContainer.swift`
   - `Info.plist` (Xcode'un oluşturduğunu değiştirin)

## Adım 6: Xcode'da Dosyaları Ekleme

1. Xcode'da sol panelde proje navigator'da `NoiseRulerARKit` klasörüne sağ tıklayın
2. **"Add Files to NoiseRulerARKit..."** seçin
3. Kopyaladığınız Swift dosyalarını seçin:
   - `App.swift`
   - `ContentView.swift`
   - `ARViewModel.swift`
   - `ARViewContainer.swift`
4. **"Copy items if needed"** checkbox'ını işaretleyin
5. **"Add"** butonuna tıklayın

## Adım 7: Info.plist'i Güncelleme

1. Xcode'da `Info.plist` dosyasını açın
2. Sağ tıklayıp **"Open As" > "Source Code"** seçin
3. Bu rehberdeki `Info.plist` içeriğini kopyalayın
4. Xcode'daki `Info.plist` içeriğini değiştirin

Veya manuel olarak şu key'leri ekleyin:
- `NSCameraUsageDescription`: "Konum takibi için kameraya ihtiyacımız var"
- `NSLocationWhenInUseUsageDescription`: "Konum takibi için konum bilgisine ihtiyacımız var"

## Adım 8: Deployment Target Ayarlayın

1. Sol panelde proje adına (mavi ikon) tıklayın
2. **"TARGETS"** altında `NoiseRulerARKit`'i seçin
3. **"General"** sekmesinde:
   - **Minimum Deployments:** iOS 13.0 veya üzeri (ARKit 3.0+ için)

## Adım 9: Framework'leri Ekleme

1. Aynı **"TARGETS" > "NoiseRulerARKit"** bölümünde
2. **"Build Phases"** sekmesine gidin
3. **"Link Binary With Libraries"** bölümünü genişletin
4. **"+"** butonuna tıklayın
5. Şunları ekleyin:
   - `ARKit.framework`
   - `SceneKit.framework`
   - (Diğerleri otomatik gelir)

## Adım 10: Server URL'ini Ayarlayın

1. `ContentView.swift` dosyasını açın
2. `serverURLString` değişkenini bulun
3. Bilgisayarınızın IP adresini yazın (örnek: `http://192.168.1.100:8000/index.html`)

IP adresinizi bulmak için Terminal'de:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

## Adım 11: Test Edin

1. **Web sunucunuzu başlatın:**
   ```bash
   cd "/Volumes/My Library/Extreme SSD Recovery/1. Productions/Coding/noiseruler"
   python3 -m http.server 8000
   ```

2. **Xcode'da:**
   - Üstte cihaz seçiciyi açın
   - iPhone SE (2nd generation) veya başka bir cihaz seçin
   - **Play** butonuna (▶️) tıklayın

3. **İlk çalıştırmada:**
   - Kamera izni isteyecek - **"Allow"** seçin
   - Uygulama açılacak
   - "Start AR Tracking" butonuna tıklayın
   - Web sayfanız yüklenecek ve ARKit tracking başlayacak!

## Sorun Giderme

### "Build Failed" Hatası
- Xcode'un en güncel versiyonunu kullanın
- Product > Clean Build Folder (Shift+Cmd+K)
- Tekrar build edin

### "ARKit is not available"
- Gerçek cihaz kullanın (simülatör ARKit desteklemez)
- iOS 13+ gereklidir

### Web sayfası yüklenmiyor
- Web sunucunuzun çalıştığından emin olun
- IP adresinin doğru olduğundan emin olun
- iPhone ve bilgisayar aynı WiFi ağında olmalı

### Konum güncellenmiyor
- Console'u kontrol edin (Xcode > View > Debug Area > Show Debug Area)
- `[ARKit]` ve `[WebView]` log'larını kontrol edin

## Sonraki Adımlar

1. QR kod anchor sistemi ekleyebilirsiniz (ARKIT_INTEGRATION.md'ye bakın)
2. Debug overlay'i kaldırabilirsiniz
3. UI'ı özelleştirebilirsiniz

Başarılar! 🎉

