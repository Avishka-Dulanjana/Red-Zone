# red_zone

“RedZone” - Real-Time Natural Disasters Prevention Alerts and Risk Management Mobile Application

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Project Start 2024.01.23

```agsl
 flutter pub run flutter_native_splash:create --path=splash.yaml
```

For the Splash screen size is 460 x Width & Height where as the icon inside is only 250 x width & height. This means, the icon should have a space around it. For the Onboarding you can use any size because we are making sure to assign only 60% width to the total screen.

# Primary_header_container.dart - Special Note

- <b>We cannot create more than one POSITIONED() widget inside the STACK() widget. It will error occurred. So that we wrap STACK() with SIZEDBOX(); widget to get rid of this error.</b>

## Before

```agsl
 @override
  Widget build(BuildContext context) {
    return TCustomCurvedWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        /// -- If [size.isFinite': is not true.in stack] error occurred -> Read README.md file
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Positioned(
                  top: -150,
                  right: -250,
                  child: TCircularContainer(
                      backgroundColor: TColors.textWhite.withOpacity(0.1))),
              Positioned(
                  top: 100,
                  right: -300,
                  child: TCircularContainer(
                      backgroundColor: TColors.textWhite.withOpacity(0.1))),
            ],
          ),
        ),
      ),
    );
  }
```

## After

```agsl
@override
  Widget build(BuildContext context) {
    return TCustomCurvedWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.only(bottom: 0),

        /// -- If [size.isFinite': is not true.in stack] error occurred -> Read README.md file
        constraints: const BoxConstraints(minHeight: 400),
        
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
```

# Quick fix dart errors command

- It can used to remove unused imports, add necessary const keywords.

```agsl

dart fix --apply

```

# Image Carousel design

```agsl

pub add carousel_slider

```
### Image container set
```agsl

Padding(
  padding: const EdgeInsets.all(TSizes.defaultSpace),
  child: Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(TSizes.md)),
    child: ClipRRect(borderRadius: BorderRadius.circular(TSizes.md),
       child: const Image( image: AssetImage(TImages.banner1)),
       ),
    ),
)
```

# Google SignIn adding

```agsl
flutter pub add google_sign_in   
```

# SHA1, SHA256

```agsl
keytool -list -v -keystore "C:\Users\Avishka Dulanjana\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```