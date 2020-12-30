import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/appbar.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:card_settings/card_settings.dart';

class MyStoreInfoPage extends StatefulWidget {
  _MyStoreInfoPageState createState() => _MyStoreInfoPageState();
}

class _MyStoreInfoPageState extends State<MyStoreInfoPage> {
  String title = "Spheria";
  String url = "http://www.codyleet.com/spheria";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView.appbar("My Store", true),
        body: Form(
            child: CardSettings(children: <CardSettingsSection>[
          CardSettingsSection(
              header: CardSettingsHeader(
                label: 'Favorite Book',
              ),
              children: <CardSettingsWidget>[

                CardSettingsText(
                  label: 'Store name',
                  initialValue: title,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Title is required.';
                  },
                  onSaved: (value) => title = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),
                CardSettingsText(
                  label: 'URL',
                  initialValue: url,
                  validator: (value) {
                    if (!value.startsWith('http:')) return 'Must be a valid website.';
                  },
                  onSaved: (value) => url = value,
                ),


              ])
        ])));
  }
}
