import 'package:encrypt/encrypt.dart';

class AesConvert {
  static String encryptUsingAes(
      {required String key, required String plainText, required String ivKey}) {
    final keyUtf = Key.fromBase64(key);
    final iv = IV.fromBase64(ivKey);

    final encrypter = Encrypter(AES(keyUtf, mode: AESMode.cbc));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    return encrypted.base16;
  }

  static String encryptUsingAesWithoutIV(
      {String key = r'Pi@aTom#$tech123', required String plainText}) {
    final keyUtf = Key.fromUtf8(key);
    // final keyUtf = Key(Uint8List.fromList(utf8.encode(key)));

    final encrypter = Encrypter(AES(keyUtf, mode: AESMode.ecb));

    final encrypted = encrypter.encrypt(plainText, iv: IV.fromUtf8(''));

    return encrypted.base64;
  }

  static String decryptAes(
      {required String key, required String encoded, required String ivKey}) {
    final keyUtf = Key.fromBase64(key);
    final iv = IV.fromBase64(ivKey);

    final encrypter = Encrypter(AES(keyUtf, mode: AESMode.cbc));

    final decrypted = encrypter.decrypt16(encoded, iv: iv);

    return decrypted;
  }

  static String decryptAesWithoutIv(
      {String key = r'Pi@aTom#$tech123', required String encoded}) {
    final keyUtf = Key.fromUtf8(key);

    final encrypter = Encrypter(AES(keyUtf, mode: AESMode.ecb));

    final decrypted = encrypter.decrypt64(encoded, iv: IV.fromUtf8(''));

    return decrypted;
  }
}
