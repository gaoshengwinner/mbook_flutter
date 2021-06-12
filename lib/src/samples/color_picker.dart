
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbook_flutter/src/comm/tools/radio_choice.dart';


class ColorPickerPage extends StatefulWidget {
  @override
  _MyHomeState createState() => new _MyHomeState();
}

class _MyHomeState extends State<ColorPickerPage> {
  static final Map<String, String> genderMap = {
    'male': 'Male',
    'female': 'Female',
    'other': 'Other',
  };

  String _selectedGender = genderMap.keys.first;

  @override
  Widget build(BuildContext context) {
    final genderSelectionTile = new Material(
      color: Colors.transparent,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Select Gender',
              style: TextStyle(
                color: CupertinoColors.systemBlue,
                fontSize: 15.0,
              )),
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
          ),
          CupertinoRadioChoice(
              choices: genderMap,
              onChange: onGenderSelected,
              initialKeyValue: _selectedGender)
        ],
      ),
    );

    return new Scaffold(
      body:
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
          child: Column(children: <Widget>[genderSelectionTile])),
    );
  }

  void onGenderSelected(String genderKey) {
    setState(() {
      _selectedGender = genderKey;
    });
  }
}
//
// class ColorPickerPage extends StatefulWidget {
//   ColorPickerPage();
//
//   _ColorPickerPageState createState() => _ColorPickerPageState();
// }
// class _ColorPickerPageState extends State<ColorPickerPage> {
//   final double _iconSize = 90;
//   List<Widget> _tiles;
//
//   @override
//   void initState() {
//     super.initState();
//     _tiles = <Widget>[
//       Icon(Icons.filter_1, size: _iconSize),
//       Icon(Icons.filter_2, size: _iconSize),
//       Icon(Icons.filter_3, size: _iconSize),
//       Icon(Icons.filter_4, size: _iconSize),
//       Icon(Icons.filter_5, size: _iconSize),
//       Icon(Icons.filter_6, size: _iconSize),
//       Icon(Icons.filter_7, size: _iconSize),
//       Icon(Icons.filter_8, size: _iconSize),
//       Icon(Icons.filter_9, size: _iconSize),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     void _onReorder(int oldIndex, int newIndex) {
//       setState(() {
//         Widget row = _tiles.removeAt(oldIndex);
//         _tiles.insert(newIndex, row);
//       });
//     }
//
//     var wrap = ReorderableWrap(
//         spacing: 8.0,
//         runSpacing: 4.0,
//         padding: const EdgeInsets.all(8),
//         children: _tiles,
//         onReorder: _onReorder,
//         onNoReorder: (int index) {
//           //this callback is optional
//           debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
//         },
//         onReorderStarted: (int index) {
//           //this callback is optional
//           debugPrint('${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
//         }
//     );
//
//     var column = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         wrap,
//         ButtonBar(
//           alignment: MainAxisAlignment.start,
//           children: <Widget>[
//             // IconButton(
//             //   iconSize: 50,
//             //   icon: Icon(Icons.add_circle),
//             //   color: Colors.deepOrange,
//             //   padding: const EdgeInsets.all(0.0),
//             //   onPressed: () {
//             //     var newTile = Icon(Icons.filter_9_plus, size: _iconSize);
//             //     setState(() {
//             //       _tiles.add(newTile);
//             //     });
//             //   },
//             // ),
//             // IconButton(
//             //   iconSize: 50,
//             //   icon: Icon(Icons.remove_circle),
//             //   color: Colors.teal,
//             //   padding: const EdgeInsets.all(0.0),
//             //   onPressed: () {
//             //     setState(() {
//             //       _tiles.removeAt(0);
//             //     });
//             //   },
//             // ),
//           ],
//         ),
//       ],
//     );
//
//     return SingleChildScrollView(
//       child: column,
//     );
//
//   }
// }