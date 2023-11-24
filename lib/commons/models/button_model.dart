import 'package:equatable/equatable.dart';

class ButtonModel extends Equatable {
  final String title;
  final String deeplink;
  final String? backgroundColor;
  final String? textColor;

  ButtonModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        deeplink = json["deeplink"],
        backgroundColor = json["backgroundColor"],
        textColor = json["textColor"];

  @override
  List<Object?> get props => [
        title,
        deeplink,
        backgroundColor,
        textColor,
      ];
}
