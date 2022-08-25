import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

Future<dynamic> uploadImage(File imageFile) async {
  final uri = Uri.parse('https://unscrawl.herokuapp.com/upload');
  // final uri = Uri.parse('http://10.0.2.2:5000/upload');

  final request = http.MultipartRequest('POST', uri);
  final headers = {
    'Content-Type': 'multipart/form-data',
  };

  request.files.add(
    http.MultipartFile(
      'image',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: 'image.png',
    ),
  );

  request.headers.addAll(headers);

  final responseStream = await request.send();
  final response = await http.Response.fromStream(responseStream);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return 'Something Went Wrong';
  }
}

Future<Map<String, dynamic>> storageAccess(String folderPath) async {
  Map<String, dynamic> images = {};
  final storageRef = FirebaseStorage.instance.ref().child(folderPath);

  final list = await storageRef.listAll();

  images['main'] = await list.items.first.getDownloadURL();

  final alphabetImages = await list.prefixes.first.listAll();
  final List<String> alphabetList = [];
  for (var image in alphabetImages.items) {
    String url = await image.getDownloadURL();
    alphabetList.add(url);
  }
  images['alphabet'] = alphabetList;

  final spellingImages = await list.prefixes.last.listAll();
  final List<String> spellingList = [];
  for (var image in spellingImages.items) {
    String url = await image.getDownloadURL();
    spellingList.add(url);
  }
  images['spelling'] = spellingList;

  return images;
}

Future<Map<String, dynamic>> resultWithImageUpload(
    File imageFile, String chapterId) async {
  final response = await uploadImage(imageFile);
  return response;

  // final result = await storageAccess(response['folderID']);
  // final docRef = await FirebaseFirestore.instance.collection('page').add({
  //   'datetime': DateTime.now().toIso8601String(),
  //   'folderID': response['folderID'],
  //   'score': response['score'],
  //   'totalWords': response['totalWords'],
  //   'incorrectWords': response['incorrectWords'],
  //   'alhabetList': response['alphabets']
  // });
  // await FirebaseFirestore.instance
  //     .collection('page')
  //     .doc(docRef.id)
  //     .update({'id': docRef.id});
  // await FirebaseFirestore.instance.collection('chapter').doc(chapterId).update({
  //   'pages': FieldValue.arrayUnion([docRef.id])
  // });

  // result.putIfAbsent('score', () => response['score']);
  // result.putIfAbsent('totalWords', () => response['totalWords']);
  // result.putIfAbsent('incorrectWords', () => response['incorrectWords']);
  // result.putIfAbsent('alphabetList', () => response['alphabets']);
  // //result.putIfAbsent('topFourAlphabets', () => response['topFourAlphabets']);
  // return result;
}

Future<Map<String, dynamic>> resultWithoutUpload(String pageid) async {
  final pageData = await FirebaseFirestore.instance
      .collection('page')
      .doc(pageid)
      .get()
      .then((doc) => doc.data()!);
  final result = await storageAccess(pageData['folderID']);

  result.putIfAbsent('score', () => pageData['score']);
  result.putIfAbsent('totalWords', () => pageData['totalWords']);
  result.putIfAbsent('incorrectWords', () => pageData['incorrectWords']);
  result.putIfAbsent('alphabetList', () => pageData['alhabetList']);
  //result.putIfAbsent('topFourAlphabets', () => pageData['topFourAlphabets']);
  return result;
}
