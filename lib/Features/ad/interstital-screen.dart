import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Home-feature/view/screens/home/feeds_details.dart';
import 'Ad-manger.dart';
import 'banner-screen.dart';

class InterstitalScreen extends StatefulWidget {
  const InterstitalScreen({
    super.key,
    required this.productId,
    required this.uid,
    required this.value,
    required this.ContextScreen,
  });

  final String uid;
  final String productId;
  final BuildContext ContextScreen;
  final dynamic value;
  @override
  State<InterstitalScreen> createState() => _InterstitalScreenState();
}

class _InterstitalScreenState extends State<InterstitalScreen> {
  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    loadInterstitialAd();

  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdManger.interstitalHome,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            interstitialAd = ad;
            isAdLoaded = true;

            showInterstitialAd();
            Navigator.push(
              widget.ContextScreen,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  context = widget.ContextScreen;
                  return HomeFeedsDetails(
                    uid: widget.uid,
                    value: widget.value,
                    productId: widget.productId,
                  );
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(1.0, 0.0);
                  var end = Offset.zero;
                  var curve = Curves.ease;
                  var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );

          });
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void dispose() {
    super.dispose();
    interstitialAd.dispose();
  }

  void showInterstitialAd() {
    if (isAdLoaded) {
      interstitialAd.show();
    } else {
      print('Interstitial ad not yet loaded');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ads'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        // Your widget content
      ),
    );
  }

}