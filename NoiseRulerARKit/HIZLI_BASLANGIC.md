# Hızlı Başlangıç Rehberi

## Adım 1: IP Adresinizi Bulun

Terminal'de:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

Örnek çıktı: `inet 192.168.1.100` → IP adresiniz: **192.168.1.100**

## Adım 2: Info.plist Güncelleme (2 Yöntem)

### Yöntem A: GUI (Kolay) ⭐ Önerilen

1. Xcode'da sol panelde **`Info.plist`** dosyasına tıklayın
2. Sağ altta **"+"** butonuna tıklayın
3. Arama kutusuna **`camera`** yazın
4. **"Privacy - Camera Usage Description"** seçin
5. Sağ tarafta **Value** kısmına: `Konum takibi için kameraya ihtiyacımız var` yazın

### Yöntem B: Source Code (Hızlı)

1. Sol panelde **`Info.plist`** dosyasına **sağ tıklayın**
2. **"Open As" > "Source Code"** seçin
3. `</dict>` tag'inden **önce** şunu ekleyin:

```xml
	<key>NSCameraUsageDescription</key>
	<string>Konum takibi için kameraya ihtiyacımız var</string>
```

## Adım 3: ContentView.swift Güncelleme

1. Xcode'da **`ContentView.swift`** dosyasını açın
2. **Tüm içeriği silin** (Cmd+A, sonra Delete)
3. **`ContentView_UPDATED.swift`** dosyasını açın (başka bir editörde)
4. İçeriğini **kopyalayın** (Cmd+A, Cmd+C)
5. Xcode'daki **`ContentView.swift`** dosyasına **yapıştırın** (Cmd+V)
6. **15. satırda** IP adresinizi kontrol edin:
   ```swift
   @State private var serverURLString: String = "http://192.168.1.100:8000/index.html"
   ```
   `192.168.1.100` yerine kendi IP adresinizi yazın!

## Adım 4: Diğer Dosyaları Ekleyin

Xcode'da:
1. Sol panelde proje adına (mavi ikon) **sağ tıklayın**
2. **"Add Files to NoiseRulerARKit..."** seçin
3. Şu dosyaları seçin (NoiseRulerARKit klasöründen):
   - `ARViewModel.swift`
   - `ARViewContainer.swift`
   - `App.swift` (eğer Xcode'un oluşturduğunu kullanmıyorsanız)

## Adım 5: Web Sunucusunu Başlatın

Terminal'de:
```bash
cd "/Volumes/My Library/Extreme SSD Recovery/1. Productions/Coding/noiseruler"
python3 -m http.server 8000
```

**Sunucu çalıştığından emin olun!**

## Adım 6: Xcode'da Çalıştırın

1. Xcode'da üstte **cihaz seçiciyi** açın
2. **iPhone SE (2nd generation)** veya gerçek iPhone'unuzu seçin
3. **Play** butonuna (▶️) tıklayın
4. Kamera izni isteyecek → **"Allow"** seçin
5. Uygulama açılınca **"Start AR Tracking"** butonuna tıklayın

## ✅ Başarılı!

Eğer her şey çalışıyorsa:
- Web sayfanız yüklenecek
- ARKit tracking başlayacak
- Yeşil nokta (listener) telefonunuzun hareketine göre hareket edecek
- Ses sistemi çalışacak!

## ❌ Sorun mu Var?

- **Build hatası:** `INFO_PLIST_REHBERI.md` dosyasına bakın
- **Web sayfası yüklenmiyor:** IP adresini ve web sunucusunu kontrol edin
- **ARKit çalışmıyor:** Gerçek cihaz kullanın (simülatör ARKit desteklemez)

Detaylı rehber: `KURULUM_ADIMLARI.md`

