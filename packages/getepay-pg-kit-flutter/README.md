# Getepay PG Kit Flutter



## Getting started

### Step 1:

Import getepay_pg_kit in your pubspec.yaml



### Step 2:

Add this widget:

PGKit(

    terminalId: 'XXX@XXXXX',

    mid: 'XXXXX',

    amount: 100,

    name: 'XXXX',

    mobile: 8384947087,

    child: Center(child: Icon(Icons.paypal)),
    onError: (String error) {
    log('onError: $error');
    },

    onSuccess: (PgInvoiceResponse success) {
    log('onSuccess: $success');
    },
    
    pgIv: 'hlnuyA9b4YxDq6oJSZFl8g==',

    pgKey: 'JoYPd+qso9s7T+Ebj8pi4Wl8i+AHLv+5UNJxA3JkDgY=',

    test: true / false,
    
)


### Android permissions

    <uses-permission android:name="android.permission.INTERNET"/>

    <queries>

        <!-- If your app checks for SMS support -->

        <intent>

            <action android:name="android.intent.action.VIEW" />

            <data android:scheme="sms" />

        </intent>

        <!-- If your app checks for call support -->

        <intent>

            <action android:name="android.intent.action.VIEW" />

            <data android:scheme="tel" />

        </intent>

        <intent>

            <action android:name="android.intent.action.VIEW" />

            <data android:scheme="https" />

        </intent>

    </queries>

### Ios Permission
    <key>LSApplicationQueriesSchemes</key>

    <array>

    <string>sms</string>

    <string>tel</string>

    <string>https</string>

    <string>gpay</string>

    <string>paytm</string>

    <string>phonepe</string>

    </array>


### Important commands
dart run build_runner build --delete-conflicting-outputs
