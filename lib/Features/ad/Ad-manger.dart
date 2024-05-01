import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManger {
  static bool isTest = true;
  static String bannerHome = isTest
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-2560484982433313/6503436468';
  static String interstitalHome = isTest
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-2560484982433313/6052118126';

  static late InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitalHome,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;

          if (_isAdLoaded) {
            _interstitialAd!.show();
          } else {
            print('Interstitial ad not yet loaded');
          }
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }
}
