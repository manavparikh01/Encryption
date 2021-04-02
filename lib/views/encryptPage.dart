import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
//import 'package:flutter/src/foundation/key.dart' as prefix;

class EncryptPage extends StatefulWidget {
  @override
  _EncryptPageState createState() => _EncryptPageState();
}

class _EncryptPageState extends State<EncryptPage> {
  final _textController = TextEditingController();

  var text = '';
  var hashText = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.text;
  }

  void encryptor() async {
    final plainText = _textController.text;
    final key = encrypt.Key.fromUtf8('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    print(key.base64);

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    //final decrypted = encrypter.decrypt(encrypted, iv: iv);

    //print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    setState(() {
      text = encrypted.base64;
    });
  }

  void hash() {
    var bytes = utf8.encode(_textController.text); // data being hashed

    var digest = sha256.convert(bytes);

    //print("Digest as bytes: ${digest.bytes}");
    setState(() {
      hashText = digest.toString();
    });
    //print("Digest as hex string: $digest");
  }

  void refresh() {
    setState(() {
      _textController.text = '';
      text = '';
      hashText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  child: Text(
                    'Encryption Try',
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: Text('Refresh'),
                    onPressed: refresh,
                  ),
                ),
                SizedBox(
                  height: height * 0.039,
                ),
                Container(
                  child: TextField(
                    controller: _textController,
                    textAlign: TextAlign.center,

                    //showCursor: true,
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Encrypted Code - AES',
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: height * 0.0125,
                ),
                Container(
                  height: height * 0.045,
                  alignment: Alignment.center,
                  child: Text(text),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hashed Code - SHA-256',
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: height * 0.0125,
                ),
                Container(
                  height: height * 0.045,
                  alignment: Alignment.center,
                  child: Text(hashText),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: height * 0.155),
                ElevatedButton(
                  child: Text('Encrypt'),
                  onPressed: encryptor,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                ElevatedButton(
                  child: Text('Crypto Hashing'),
                  onPressed: hash,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
