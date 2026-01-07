# Info.plist Güncelleme Rehberi

## Yöntem 1: Xcode GUI ile (Kolay)

1. Xcode'da sol panelde `Info.plist` dosyasını bulun
2. Dosyaya **tıklayın** (açılır)
3. Sağ tarafta "+" butonuna tıklayın (yeni key eklemek için)
4. Şu key'leri ekleyin:

### Kamera İzni:
- **Key:** `Privacy - Camera Usage Description` (veya `NSCameraUsageDescription`)
- **Type:** String
- **Value:** `Konum takibi için kameraya ihtiyacımız var`

### Konum İzni (opsiyonel):
- **Key:** `Privacy - Location When In Use Usage Description` (veya `NSLocationWhenInUseUsageDescription`)
- **Type:** String
- **Value:** `Konum takibi için konum bilgisine ihtiyacımız var`

## Yöntem 2: Source Code ile (Daha Hızlı)

1. Xcode'da sol panelde `Info.plist` dosyasını bulun
2. Dosyaya **sağ tıklayın**
3. **"Open As" > "Source Code"** seçin
4. `</dict>` tag'inden önce şunları ekleyin:

```xml
<key>NSCameraUsageDescription</key>
<string>Konum takibi için kameraya ihtiyacımız var</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Konum takibi için konum bilgisine ihtiyacımız var</string>
```

Örnek (dosyanın sonu şöyle görünmeli):
```xml
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>NSCameraUsageDescription</key>
	<string>Konum takibi için kameraya ihtiyacımız var</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>Konum takibi için konum bilgisine ihtiyacımız var</string>
</dict>
</plist>
```

## Kontrol

Info.plist'i güncelledikten sonra:
1. Xcode'da "Property List" görünümüne dönün (sağ tıklayıp "Open As" > "Property List")
2. Eklediğiniz key'lerin göründüğünü kontrol edin

## Önemli

- Bu izinler zorunludur - olmadan ARKit çalışmaz
- İlk çalıştırmada iOS bu mesajları kullanıcıya gösterecek
- Kullanıcı izin vermezse ARKit tracking çalışmaz

