import 'package:flutter/material.dart';

class PaymentBottomSheet extends StatelessWidget {
  final void Function(String) onOptionSelected;

  const PaymentBottomSheet({Key? key, required this.onOptionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Open UPI Link',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Text('Choose an app to open the UPI link'),
          SizedBox(height: 20),
          ListTile(
            title: Center(child: Text('PhonePe', style: TextStyle(fontSize: 16))),
            onTap: () => onOptionSelected('phonepe://'),
          ),
          Divider(),
          ListTile(
            title: Center(child: Text('Google Pay', style: TextStyle(fontSize: 16))),
            onTap: () => onOptionSelected('tez://upi/'),
          ),
          Divider(),
          ListTile(
            title: Center(child: Text('Paytm', style: TextStyle(fontSize: 16))),
            onTap: () => onOptionSelected('paytm://'),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
