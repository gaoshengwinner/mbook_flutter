import 'package:flutter/material.dart';

class FooterParam {
  Text? title;
  Icon? icon;
  GestureTapCallback? onTap;
}

class Footer extends StatelessWidget {
  final FooterParam footerParam;

   Footer({required this.footerParam});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: footerParam.onTap,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: footerParam.icon == null
                    ? null
                    : SizedBox(
                        height: 36,
                        width: 36,
                        child: Center(
                          child: footerParam.icon,
                        ),
                      ),
                title: footerParam.title,
              ),
              const Divider(height: 0),
            ],
          ),
        ));
  }
}
