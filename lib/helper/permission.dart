import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';


saveImage(BuildContext context, var imgPath) async {
  await _askPermission();
  var response = await Dio().get(imgPath,
      options: Options(responseType: ResponseType.bytes));
  final result =
  await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  print(result);
  Navigator.pop(context);
}

_askPermission() async {
  if (Platform.isAndroid) {
    /*Map<PermissionGroup, PermissionStatus> permissions =
          */await PermissionHandler()
        .requestPermissions([PermissionGroup.photos]);
  } else {
    /* PermissionStatus permission = */await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
  }
}