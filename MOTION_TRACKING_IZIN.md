# iOS Motion Tracking İzin Rehberi

## Sorun: "Permission Denied" Hatası

iOS'ta DeviceMotion API kullanmak için özel izin gereklidir. İzin reddedildikten sonra, iOS izin isteğini tekrar göstermez. Çözüm için aşağıdaki adımları deneyin.

## ÖNEMLİ NOT

**"Motion & Orientation Access" ayarı bazı iOS sürümlerinde/cihazlarda YOKTUR!** Bu ayarın varlığı iOS versiyonuna ve cihaz modeline göre değişir. iPhone SE 2020'de bu ayar olmayabilir - bu normal.

## Çözüm Adımları

### Yöntem 1: Safari'yi Kapatıp Yeniden Aç (Önerilen)

1. **Safari'yi tamamen kapatın:**
   - App Switcher'ı açın (ekranın altından yukarı kaydırın)
   - Safari kartını yukarı kaydırarak kapatın
   
2. **Safari'yi tekrar açın** ve sayfaya gidin

3. **Sayfayı yenileyin** (pull down to refresh)

4. **"Enable Motion Tracking"** checkbox'ını işaretleyin

5. İzin isteği tekrar gelecek, bu sefer **"Allow"** (İzin Ver) seçin

### Yöntem 2: Safari Geçmişini Temizle (Dikkatli!)

⚠️ **DİKKAT:** Bu yöntem tüm Safari geçmişini ve web sitesi verilerini siler!

1. **Ayarlar** > **Safari**
2. **"Clear History and Website Data"** (Geçmişi ve Web Sitesi Verilerini Temizle)
3. **"Clear History and Data"** butonuna tıklayın
4. Sayfayı yeniden açın ve tekrar deneyin

### Yöntem 3: Sayfayı Private Browsing'de Aç (Geçici Çözüm)

1. Safari'de yeni **Private Tab** açın (sağ alttaki iki kare ikonu)
2. Sayfayı private tab'de açın
3. Private tab'lerde izin ayarları farklı çalışır, tekrar izin isteyebilir

## Alternatif: Manual Mode Kullanın (En Kolay)

Motion tracking kullanmak istemiyorsanız veya izin sorunu yaşıyorsanız:

1. **Tracking Mode** → **"Manual (Drag)"** seçin
2. Canvas'taki **yeşil noktaya** (listener) dokunup sürükleyerek konumu manuel olarak değiştirin
3. Bu mod **hiçbir izin gerektirmez**
4. Her zaman çalışır

## Önemli Notlar

- **DeviceMotion Test Modu ARKit kalitesinde DEĞİLDİR**
- Drift (sapma) olacaktır - hassas konum takibi yapmaz
- Gerçek ARKit için native iOS app gerekir (bkz: ARKIT_INTEGRATION.md)
- Test modu sadece deneme amaçlıdır
- **Manual (Drag) modu daha güvenilir ve kolaydır**

## Neden "Motion & Orientation Access" Ayarı Yok?

Bu ayar:
- iOS versiyonuna göre değişir (bazı sürümlerde yok)
- Cihaz modeline göre değişir
- iOS 13+ bazı cihazlarda olmayabilir
- **Bu normaldir!** Alternatif çözümler yukarıda.

## Öneri

İzin sorunları yaşıyorsanız, **Manual (Drag) modunu kullanın** - daha basit, daha güvenilir ve hiçbir izin gerektirmez!

