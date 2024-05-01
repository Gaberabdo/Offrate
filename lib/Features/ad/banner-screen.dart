import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Ad-manger.dart';
import 'interstital-screen.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({Key? key}) : super(key: key);

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  BannerAd? bannerAd;
  bool isLoad = false;

  void load() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdManger.bannerHome,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isLoad = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: AdRequest())
      ..load();
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  void dispose() {
    if (isLoad) {
      bannerAd!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Center(
            child: isLoad
                ? SizedBox(
                    width: bannerAd!.size.width.toDouble(),
                    height: bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: bannerAd!))
                : SizedBox(),
          ),

        ],
      ),
    );
  }
}
