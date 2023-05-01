import 'package:flutter/material.dart';

extension ShortSizedBoxCall on num {
  SizedBox get bh => SizedBox(height: toDouble());
  SizedBox get bw => SizedBox(width: toDouble());
}
