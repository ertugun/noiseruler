# Info.plist Dosyası Yoksa - Çözüm

Modern Xcode versiyonlarında (Xcode 13+) Info.plist dosyası otomatik oluşturulmayabilir. İki yöntem var:

## Yöntem 1: Info.plist Dosyasını Manuel Oluşturun (Önerilen)

### Adım 1: Info.plist Dosyası Oluşturun

1. Xcode'da sol panelde **"NoiseRulerArkit"** klasörüne (mavi klasör ikonu) **sağ tıklayın**
2. **"New File..."** seçin
3. **"iOS"** sekmesinde **"Property List"** seçin
4. **"Next"** butonuna tıklayın
5. İsmini **"Info.plist"** yapın
6. **"Create"** butonuna tıklayın

### Adım 2: İçeriği Doldurun

1. Yeni oluşturduğunuz **Info.plist** dosyasına tıklayın
2. Sağ altta **"+"** butonuna tıklayın
3. **Key** kısmına: `Privacy - Camera Usage Description` yazın (veya arama yapın)
4. **Type:** String
5. **Value:** `Konum takibi için kameraya ihtiyacımız var`

VEYA Source Code modunda:

1. Info.plist dosyasına **sağ tıklayın**
2. **"Open As" > "Source Code"** seçin
3. İçeriği şununla değiştirin:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>NSCameraUsageDescription</key>
	<string>Konum takibi için kameraya ihtiyacımız var</string>
</dict>
</plist>
```

### Adım 3: Build Settings'e Bağlayın

1. Sol panelde proje adına (mavi ikon) tıklayın
2. **"TARGETS"** altında **"NoiseRulerArkit"** seçin
3. **"Build Settings"** sekmesine gidin
4. Arama kutusuna **"Info.plist"** yazın
5. **"Info.plist File"** satırını bulun
6. Değerini **"NoiseRulerArkit/Info.plist"** yapın

---

## Yöntem 2: Build Settings Üzerinden (Info.plist Olmadan)

Info.plist dosyası oluşturmak istemiyorsanız:

1. Sol panelde proje adına (mavi ikon) tıklayın
2. **"TARGETS"** altında **"NoiseRulerArkit"** seçin
3. **"Info"** sekmesine gidin
4. **"Custom iOS Target Properties"** bölümünde **"+"** butonuna tıklayın
5. Arama yapın: **"Privacy - Camera Usage Description"**
6. **Value:** `Konum takibi için kameraya ihtiyacımız var`

---

## Hangisini Kullanmalıyım?

- **Yöntem 1 (Info.plist dosyası):** Daha geleneksel, dosya olarak görebilirsiniz
- **Yöntem 2 (Build Settings):** Daha modern, Xcode otomatik yönetir

İkisi de çalışır! Hangisini tercih ederseniz edin, kamera izni mutlaka eklenmeli.

## Kontrol

İzin ekledikten sonra:
1. Xcode'da uygulamayı çalıştırın
2. İlk çalıştırmada iOS kamera izni isteyecek
3. **"Allow"** seçin
4. ARKit çalışmaya başlayacak

