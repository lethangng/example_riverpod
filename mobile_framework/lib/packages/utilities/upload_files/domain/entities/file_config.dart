import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class FileConfig {
  String downloadBaseUrl;
  Color previewImagesIndicatorColor;
  String maxFileSize;
  String maxImageSize;

  S3BucketType bucketType;
  EnvType envType;

  String Function(bool result)? onSelectImagePredicate;
  Function(bool result)? onSelectFilePredicate;

  FileConfig({
    @Deprecated("Replaced by S3DomainBuilder") this.downloadBaseUrl = "",
    required this.previewImagesIndicatorColor,
    required this.bucketType,
    required this.envType,
    this.maxFileSize = "15 MB",
    this.maxImageSize = "5 MB",
    this.onSelectImagePredicate,
    this.onSelectFilePredicate,
  });
}
