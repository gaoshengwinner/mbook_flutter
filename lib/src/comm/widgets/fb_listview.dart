import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

typedef DeleteCallBack<E> = void Function(E item);
typedef CreateSubWidget<E> = Widget Function(
    BuildContext context, E item, int index);

typedef CreateSubWidgetList<E> = List<Widget> Function(
    BuildContext context, E item, int index);

// ignore: must_be_immutable
class FBListViewWidget<E> extends StatefulWidget {
  List<E> _list;
  DeleteCallBack<E> onDeleted;
  CreateSubWidget<E> setSubWidget;
  bool canBeMove = false;

  CreateSubWidgetList<E> setActions;
  CreateSubWidgetList<E> setSeActions;
  Widget footer;

  FBListViewWidget(this._list,
      {this.setActions,
      this.setSeActions,
      this.setSubWidget,
      this.onDeleted,
      this.canBeMove,
      this.footer});

  _FBListViewWidgetState createState() => _FBListViewWidgetState<E>(this._list,
      setActions: this.setActions,
      setSeActions: this.setSeActions,
      setSubWidget: this.setSubWidget,
      onDeleted: this.onDeleted,
      canBeMove: this.canBeMove,
      footer: this.footer);

  static Widget getMoveListWidget() {
    return const Handle(
      delay: Duration(milliseconds: 100),
      child: Icon(
        Icons.more_vert,
        color: Colors.grey,
      ),
    );
  }

  static Widget getSlideActionDelete(BuildContext context, Function onTap) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SlideAction(
      closeOnTap: true,
      color: Color.fromRGBO(255, 205, 210, 1),
      onTap: () {
        onTap();
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            const SizedBox(height: 4),
            Text(
              'Delete',
              style: textTheme.bodyText2.copyWith(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget getSlideActionCopy(BuildContext context, Function onTap) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SlideAction(
      closeOnTap: true,
      color: Color.fromRGBO(255, 205, 210, 1),
      onTap: () {
        onTap();
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.copy,
              color: Colors.green,
            ),
            const SizedBox(height: 4),
            Text(
              'Copy',
              style: textTheme.bodyText2.copyWith(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget getSlideActionBrush(BuildContext context, Function onTap) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SlideAction(
      closeOnTap: true,
      color: Color.fromRGBO(255, 205, 210, 1),
      onTap: () {
        onTap();
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.brunch_dining,
              color: Colors.green,
            ),
            const SizedBox(height: 4),
            Text(
              'Paste',
              style: textTheme.bodyText2.copyWith(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildFooter(BuildContext context,
      {IconData icon, String title = "", Function onTap}) {
    return GestureDetector(
        onTap: () async {
          if (onTap != null) onTap();
        },
        child: Card(
          color: Color.fromRGBO(237, 231, 246, 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: icon == null
                    ? null
                    : SizedBox(
                        height: 36,
                        width: 36,
                        child: Center(
                          child: Icon(
                            icon,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                title: Text(
                  title,
                ),
              ),
              const Divider(height: 0),
            ],
          ),
        ));
  }
}

class _FBListViewWidgetState<E> extends State<FBListViewWidget>
    with SingleTickerProviderStateMixin {
  _FBListViewWidgetState(this._list,
      {this.setActions,
      this.setSeActions,
      this.setSubWidget,
      this.onDeleted,
      this.canBeMove = false,
      this.footer}) {
    if (!(this.canBeMove is bool)) {
      this.canBeMove = false;
    }
  }

  DeleteCallBack<E> onDeleted;
  CreateSubWidget<E> setSubWidget;
  CreateSubWidgetList<E> setActions;
  CreateSubWidgetList<E> setSeActions;
  bool canBeMove = false;
  Widget footer;

  List<E> _list;
  ScrollController scrollController;
  bool inReorder = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void onReorderFinished(List<E> newItems) {
    scrollController.jumpTo(scrollController.offset);
    setState(() {
      inReorder = false;
      _list
        ..clear()
        ..addAll(newItems);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xFFEFEFF4),
      padding: EdgeInsets.only(top: 3),
      child: ListView(
        controller: scrollController,
        physics: inReorder ? const NeverScrollableScrollPhysics() : null,
        padding: const EdgeInsets.only(bottom: 24),
        children: <Widget>[
          _buildVerticalList(),
          //const SizedBox(height: 600),
        ],
      ),
    );
  }

  // * An example of a vertically reorderable list.
  Widget _buildVerticalList() {

    Widget buildReorderable(
      dynamic item,
      int index,
      Widget Function(Widget tile) transitionBuilder,
    ) {
      return Reorderable(
        key: ValueKey(item),
        builder: (context, dragAnimation, inDrag) {
          final t = dragAnimation.value;
          final tile = _buildTile(t, item, index);

          return transitionBuilder(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                tile,
                // Divider(
                //   height: 10,
                //   color: Color(0xFFEFEFF4).withOpacity(0),
                // ),
              ],
            ),
          );
        },
      );
    }

    return ImplicitlyAnimatedReorderableList<E>(
      items: _list,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      areItemsTheSame: (oldItem, newItem) => oldItem == newItem,
      onReorderStarted: (item, index) => setState(() => inReorder = true),
      onReorderFinished: (movedLanguage, from, to, newItems) {
        // Update the underlying data when the item has been reordered!
        onReorderFinished(newItems);
      },
      itemBuilder: (context, itemAnimation, lang, index) {
        if (index == this._list.length) {
          return null;
        }

        return buildReorderable(lang, index, (tile) {
          return SizeFadeTransition(
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: itemAnimation,
            child: tile,
          );
        });
      },
      footer: footer, //_buildFooter(context, theme.textTheme),
    );
  }

  Widget _buildTile(double t, E item, int index) {

    return Slidable(
        actionPane: const SlidableBehindActionPane(),
        actions: this.setActions == null
            ? null
            : this.setActions(context, item, index),
        secondaryActions: this.setSeActions == null
            ? null
            : this.setSeActions(context, item, index),
        child: Stack(children: <Widget>[
          Card(
            color: Color.fromRGBO(237, 231, 246, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            elevation: 20,
            child: this.setSubWidget(context, item, index),
          ),
          new Positioned(
            child: const Handle(
              delay: Duration(milliseconds: 100),
              child: Icon(
                Icons.drag_handle,
                color: Colors.grey,
              ),
            ),
            left: MediaQuery.of(context).size.width - 40,
            top: 0,
          ),
          new Positioned(
            child: Container(
              child: Text(
                "No.${index + 1}",
                style: TextStyle(fontSize: 12),
              ),
            ),
            left: 0,
            top: 0,
          )
        ]));
  }
}
