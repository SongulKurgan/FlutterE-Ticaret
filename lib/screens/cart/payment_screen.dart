import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  static const routName = '/PaymentScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Ödeme işlemi devam ediyor...'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ödeme işlemini tamamlama işlemleri buraya eklenebilir.
                Navigator.of(context).pop();
              },
              child: Text('Ödemeyi Tamamla'),
            ),
          ],
        ),
      ),
    );
  }
}
