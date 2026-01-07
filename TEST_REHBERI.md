# Telefondan Test Rehberi

## Adım Adım Test Etme

### 1. Bilgisayarınızda Web Sunucusu Başlatın

Web sayfası CORS kısıtlamaları nedeniyle `file://` protokolüyle çalışmaz. Local bir web sunucusu başlatmanız gerekir.

**Seçenek 1: Python (Önerilen - En Kolay)**

Terminal'de proje klasörüne gidin:
```bash
cd "/Volumes/My Library/Extreme SSD Recovery/1. Productions/Coding/noiseruler"
```

Python 3 varsa:
```bash
python3 -m http.server 8000
```

Python 2 varsa:
```bash
python -m SimpleHTTPServer 8000
```

Sunucu başladığında şunu göreceksiniz:
```
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```

**Seçenek 2: Node.js (http-server)**

Eğer Node.js yüklüyse:
```bash
npx http-server -p 8000
```

**Seçenek 3: VS Code Live Server**

VS Code kullanıyorsanız, "Live Server" extension'ını yükleyin ve sağ alttaki "Go Live" butonuna tıklayın.

---

### 2. Bilgisayarınızın IP Adresini Öğrenin

**macOS/Linux:**
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

veya daha basit:
```bash
ipconfig getifaddr en0
```

**Windows:**
```bash
ipconfig
```

"IPv4 Address" satırını arayın (örn: 192.168.1.100)

---

### 3. Telefon ve Bilgisayar Aynı WiFi Ağında Olmalı

- Telefonunuz ve bilgisayarınız **aynı WiFi ağına** bağlı olmalı
- Farklı ağlardaysa bağlanamazsınız

---

### 4. Telefonunuzda Tarayıcıyı Açın

iPhone'unuzda Safari'yi açın ve adres çubuğuna şunu yazın:

```
http://BILGISAYAR_IP:8000/index.html
```

Örnek:
```
http://192.168.1.100:8000/index.html
```

**Not:** `BILGISAYAR_IP` yerine yukarıda bulduğunuz IP adresini yazın.

---

### 5. Sayfa Açıldığında

- Sayfa yüklenecek
- Eğer ses dosyaları yüklü değilse, önce ses dosyalarını yüklemeniz gerekebilir
- "START THE EXPERIENCE" butonuna tıklayın (ses için)

---

### 6. Tracking'i Aktifleştirin

1. Sağ taraftaki **"Debug"** tab'ına tıklayın
2. Aşağıya doğru scroll edin
3. **"Position Tracking"** bölümünü bulun
4. **"Tracking Mode"** dropdown'ından **"Device Motion (Test)"** seçin
5. **"Enable Motion Tracking"** checkbox'ını işaretleyin

---

### 7. İzin İsteğini Onaylayın

iPhone'da hareket sensörü izni isteyecek:
- **"Allow"** veya **"İzin Ver"** butonuna tıklayın
- Bu izin sadece test için gereklidir

---

### 8. Test Edin

- Telefonu hafifçe hareket ettirin
- Ekrandaki yeşil nokta (listener) hareket etmeli
- **Not:** Bu test modudur, drift (sapma) olacaktır
- Gerçek ARKit kalitesi için native iOS app gerekir

---

## Sorun Giderme

### "Sayfa yüklenmiyor"

1. **Bilgisayar ve telefon aynı WiFi'de mi?** Kontrol edin
2. **Firewall:** Bilgisayarınızın firewall'u port 8000'i engelliyor olabilir
   - macOS: System Preferences → Security & Privacy → Firewall
   - Port 8000'i açmanız gerekebilir
3. **IP adresi doğru mu?** Tekrar kontrol edin

### "Motion tracking çalışmıyor"

1. **İzin verildi mi?** Safari ayarlarından kontrol edin:
   - Settings → Safari → Privacy & Security
2. **DeviceMotion destekleniyor mu?** iPhone SE 2020 destekler
3. **Sayfayı yenileyin** (refresh)

### "Ses çalmıyor"

- Önce ses dosyalarını yüklemeniz gerekebilir
- "START THE EXPERIENCE" butonuna tıklayın
- Kulaklık takılı olabilir (kulaklık çıkarın)

---

## Test Modu Hakkında

**Önemli:** Web tabanlı "Device Motion" test modu ARKit kalitesinde DEĞİLDİR:

- ✅ Çalışır ve test edebilirsiniz
- ❌ Drift (sapma) olacak
- ❌ Hassas konum takibi yok
- ❌ Gerçek ARKit için native iOS app gerekir

Gerçek ARKit deneyimi için `ARKIT_INTEGRATION.md` dosyasındaki native iOS app rehberini takip edin.

---

## Hızlı Test (Alternatif)

Eğer bilgisayarınızda test etmek isterseniz:

1. Chrome/Edge'de sayfayı açın
2. F12 → Device Toolbar (Ctrl+Shift+M)
3. iPhone SE görünümü seçin
4. Debug tab → Tracking Mode → Manual
5. Canvas'ı tıklayıp sürükleyin (mouse ile)

Bu yöntemle tracking'i test edebilirsiniz, ama gerçek telefon hareketi olmaz.

