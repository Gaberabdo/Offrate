import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hesabe/hesabe.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';

import '../../core/helper/cache/cache_helper.dart';

void paymentKnet({
  required String amountController,
  required String phoneController,
  required String nameController,
  required BuildContext context,
  required String coponId,
  required String emailController,
  required FeedsCubit cubit,
}) {
  final Hesabe hesabe;
  hesabe = Hesabe(
    baseUrl: 'https://api.hesabe.com',
    accessCode: '52a540ae-f522-4864-a133-7ee6cc1d8610',
    ivKey: 'ZDK9lePmLM08p2G7',
    secretKey: '6Am1LQJwZDK9lePmLM08p2G7d5jqyRzO',
  );
  Map<String, dynamic> getPaymentRequestObject() {
    return {
      "merchantCode": "95551624",
      "amount": amountController,
      "paymentType": "0",
      "responseUrl": "https://api.hesabe.com/customer-response?id=842217",
      "failureUrl": "https://api.hesabe.com/customer-response?id=842217",
      "version": "2.0",
      "orderReferenceNumber": "OR-12345",
      "name": nameController,
      "mobile_number": phoneController,
      'email': emailController,
    };
  }

  print(getPaymentRequestObject());
  hesabe.openCheckout(
    context,
    paymentRequestObject: getPaymentRequestObject(),
  );

  hesabe.on(Hesabe.EVENT_PAYMENT_SUCCESS, (data) {
    print('payment success');

    cubit.uploadImages(
      uId: CacheHelper.getData(key: 'uId'),
    );

    cubit.useCoupon(coponId, CacheHelper.getData(key: 'uId'), nameController);
  });
  hesabe.on(Hesabe.EVENT_PAYMENT_ERROR, (data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Transaction Failed'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    print('payment error');
  });
}
