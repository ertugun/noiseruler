# Test Rehberi - ARKit Uygulaması

## ✅ Ön Hazırlık Kontrolleri

### 1. Web Sunucusu Çalışıyor mu?

Terminal'de kontrol edin:
```bash
curl http://192.168.1.100:8000/index.html
```

Eğer HTML kodu gelirse → ✅ Çalışıyor!
Eğer "Connection refused" hatası alırsanız → Web sunucusunu başlatın:
```bash
cd "/Volumes/My Library/Extreme SSD Recovery/1. Productions/Coding/noiseruler"
python3 -m http.server 8000
```

### 2. Xcode Projesi Hazır mı?

Kontrol listesi:
- ✅ `App.swift` eklendi
- ✅ `ARViewModel.swift` eklendi  
- ✅ `ARViewContainer.swift` eklendi
- ✅ `ContentView.swift` güncellendi (ContentView_UPDATED.swift içeriği ile)
- ✅ Info.plist'te kamera izni var (veya Build Settings'te)

### 3. IP Adresi Doğru mu?

`ContentView.swift` dosyasında 15. satırda:
```swift
@State private var serverURLString: String = "http://192.168.1.100:8000/index.html"
```

IP adresiniz farklıysa burayı güncelleyin!

---

## 📱 Test Adımları

### Adım 1: iPhone'unuzu Bilgisayara Bağlayın

1. iPhone'unuzu USB kablosu ile Mac'inize bağlayın
2. iPhone'da **"Bu Bilgisayara Güven"** mesajı çıkarsa → **"Güven"** butonuna tıklayın
3. Xcode'da üstteki cihaz seçicisinde iPhone'unuz görünmeli

### Adım 2: Xcode'da Cihazı Seçin

1. Xcode'da üstteki cihaz seçici açılır menüsüne tıklayın
2. **iPhone'unuzun adını** seçin (örnek: "Erturan's iPhone")
3. **Simülatör kullanmayın!** ARKit sadece gerçek cihazlarda çalışır

### Adım 3: Build ve Çalıştır

1. Xcode'da **Play** butonuna (▶️) tıklayın
2. İlk build biraz zaman alabilir (30 saniye - 2 dakika)
3. Xcode kodu compile edip iPhone'unuza yükleyecek

### Adım 4: Kamera İzni

1. Uygulama açıldığında iOS kamera izni isteyecek
2. **"Allow"** veya **"İzin Ver"** butonuna tıklayın
3. İzin vermezseniz ARKit çalışmaz!

### Adım 5: Server URL Ayarlama

1. Uygulama açıldığında bir ekran göreceksiniz
2. **"Enter your server URL"** kısmında URL görünecek:
   ```
   http://192.168.1.100:8000/index.html
   ```
3. Bu URL doğruysa → **"Start AR Tracking"** butonuna tıklayın
4. Eğer IP adresiniz farklıysa, URL'yi düzenleyip sonra "Start AR Tracking" butonuna tıklayın

### Adım 6: ARKit Tracking Başlatma

1. **"Start AR Tracking"** butonuna tıklayın
2. Kamera açılacak (arka planda, görünmez)
3. Telefonu **yavaşça hareket ettirin**
4. ARKit dünyayı analiz edecek (5-10 saniye)

### Adım 7: Web Sayfası Yüklenmesi

1. Web sayfanız yüklenmeye başlayacak
2. Ekranda NoiseRuler arayüzünü göreceksiniz
3. Sol altta **debug overlay** göreceksiniz:
   - Position: (x, y)
   - Status: "Tracking" veya "Initializing..."

### Adım 8: Tracking Testi

1. Telefonu **yavaşça hareket ettirin**
2. Debug overlay'de **Position** değerlerinin değiştiğini görmelisiniz
3. Web sayfasındaki **yeşil nokta (listener)** hareket etmeli
4. Sesler çalışmaya başlamalı

---

## ✅ Başarı Kriterleri

Eğer şunlar oluyorsa → **ÇALIŞIYOR!** ✅

1. ✅ Uygulama açılıyor
2. ✅ Kamera izni veriliyor
3. ✅ Web sayfası yükleniyor
4. ✅ Debug overlay'de Position değerleri görünüyor
5. ✅ Telefonu hareket ettirdiğinizde Position değerleri değişiyor
6. ✅ Web sayfasındaki yeşil nokta hareket ediyor
7. ✅ Sesler çalışıyor

---

## ❌ Sorun Giderme

### Sorun 1: "Build Failed"

**Olası Nedenler:**
- Swift dosyaları eksik veya hatalı
- Info.plist hatası
- Xcode cache sorunu

**Çözüm:**
```bash
# Xcode'da:
Product > Clean Build Folder (Cmd+Shift+K)
Product > Build (Cmd+B)
```

### Sorun 2: "Web sayfası yüklenmiyor"

**Kontrol:**
1. Web sunucusu çalışıyor mu? (Terminal'de kontrol edin)
2. Bilgisayar ve iPhone aynı Wi-Fi ağında mı?
3. IP adresi doğru mu? (ContentView.swift'te kontrol edin)
4. iPhone'da Safari'de test edin: `http://192.168.1.100:8000/index.html`

### Sorun 3: "ARKit çalışmıyor" / "Tracking başlamıyor"

**Kontrol:**
1. Kamera izni verildi mi?
2. Gerçek cihaz kullanıyor musunuz? (Simülatör ARKit desteklemez)
3. İyi ışıklandırma var mı? (ARKit karanlıkta çalışmaz)
4. Telefonu yavaşça hareket ettirin (ARKit'in dünyayı analiz etmesi gerekiyor)

### Sorun 4: "Position değerleri değişmiyor"

**Kontrol:**
1. ARKit tracking başladı mı? (Status: "Tracking" olmalı)
2. Telefonu yeterince hareket ettirdiniz mi?
3. Çok hızlı hareket ettirmeyin (ARKit takip edemez)

### Sorun 5: "Yeşil nokta hareket etmiyor"

**Kontrol:**
1. Debug overlay'de Position değerleri değişiyor mu?
2. Web sayfasında JavaScript console'u açın (Safari Developer Tools)
3. `window.updateListenerPosition` fonksiyonu çağrılıyor mu?

### Sorun 6: "Ses çalmıyor"

**Kontrol:**
1. Web sayfasında "START THE EXPERIENCE" butonuna tıklayın
2. Telefon sesi açık mı?
3. Web sayfasındaki ses kontrollerini kontrol edin

---

## 🔍 Debug İpuçları

### Xcode Console'da Ne Aranmalı?

Xcode'da alt kısımdaki **Console** penceresinde şunları görebilirsiniz:

- ✅ `[ARViewModel] Tracking started` → ARKit başladı
- ✅ `[WebView] Page loaded successfully` → Web sayfası yüklendi
- ❌ `[WebView] JS error: ...` → JavaScript hatası
- ❌ `[ARViewModel] Tracking failed` → ARKit hatası

### Web Sayfası Console (Safari Developer Tools)

1. Mac'inizde Safari'yi açın
2. **Develop** > **[iPhone Adınız]** > **[NoiseRuler ARKit]** menüsüne gidin
3. Console'u açın
4. `updateListenerPosition` fonksiyonunun çağrıldığını görmelisiniz

---

## 🎯 Sonraki Adımlar

Eğer her şey çalışıyorsa:

1. **Tracking kalitesini iyileştirin:**
   - Işığı artırın
   - Daha yavaş hareket edin
   - Reset Anchor butonunu kullanın

2. **Ses sistemini test edin:**
   - Farklı konumlara gidin
   - Ses kaynaklarının doğru çaldığını kontrol edin

3. **Multi-user test:**
   - Birden fazla telefonla test edin
   - Her telefonun kendi tracking'ini yapıp yapmadığını kontrol edin

---

## 📞 Yardım

Hala sorun mu var? Şunları kontrol edin:
- `HIZLI_BASLANGIC.md` - Kurulum adımları
- `KURULUM_ADIMLARI.md` - Detaylı kurulum
- `INFO_PLIST_REHBERI.md` - Info.plist sorunları
- `ARKIT_INTEGRATION.md` - ARKit teknik detayları

