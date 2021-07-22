import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

typedef ActionFunction = void Function(int index);
enum ActionsKind { delete, copy, paste }

class ActionsParam {
  ActionsKind kind;
  ActionFunction? actFuction;

  ActionsParam({required this.kind, this.actFuction});
}

class FooterParam {
  Text? title;
  Icon? icon;
  GestureTapCallback? onTap;
}

class FBReorderableList<T extends Object> extends StatefulWidget {
  final List<T> items;
  final Function body;
  final List<ActionsParam>? actions;
  final List<ActionsParam>? secondaryActions;
  final bool? needHandle;
  final ReorderFinishedCallback<T>? onReorderFinished;
  final FooterParam? footerParam;

  FBReorderableList(
      {required this.items,
      required this.body,
      this.actions,
      this.secondaryActions,
      this.needHandle,
      this.onReorderFinished,
      this.footerParam});

  @override
  _FBReorderableListState createState() => _FBReorderableListState();
}

class _FBReorderableListState<T extends Object>
    extends State<FBReorderableList> {
  var _displayHandle = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (widget.needHandle == true) {
          setState(() {
            _displayHandle = !_displayHandle;
          });
        }
      },
      child: Container(
        child: ImplicitlyAnimatedReorderableList(
          items: widget.items,
          onReorderFinished: (item, rom, to, newItems) {

          },
          areItemsTheSame: (oldItem, newItem) {
            return oldItem == newItem;
          },
          itemBuilder: (context, animation, item, i) {
            return Reorderable(
                key: ValueKey(item),
                builder: (context, dragAnimation, inDrag) {
                  return SizeFadeTransition(
                      //sizeFraction: 0.7,
                      curve: Curves.easeInOut,
                      animation: animation,
                      child: getListTitle(
                          title: widget.body(item!, i),
                          actions: getActions(context, widget.actions, item, i),
                          secondaryActions: getActions(
                              context, widget.secondaryActions, item, i)));
                });
          },
          footer: widget.footerParam == null
              ? null
              : buildFooter(context, widget.footerParam!),
        ),
      ),
    );
  }

  List<Widget>? getActions(
      BuildContext context, List<ActionsParam>? actions, item, int i) {
    if (actions == null) return null;
    List<Widget> result = [];
    for (ActionsParam action in actions) {
      switch (action.kind) {
        case ActionsKind.delete:
          {
            result.add(getSlideActionDelete(context, action.actFuction, i));
            break;
          }

        case ActionsKind.copy:
          {
            result.add(getSlideActionCopy(context, action.actFuction, i));
            break;
          }

        case ActionsKind.paste:
          {
            result.add(getSlideActionPaste(context, action.actFuction, i));
            break;
          }
      }
    }
    return result.length == 0 ? null : result;
  }

  Widget buildFooter(BuildContext context, FooterParam footerParam) {
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

  static Widget getSlideActionDelete(
      BuildContext context, ActionFunction? onTap, int i) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SlideAction(
      closeOnTap: true,
      color: Colors.red,
      onTap: () {
        if (onTap != null )onTap(i);
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            const SizedBox(height: 4),
            Text(
              'Delete',
              style: textTheme.bodyText2?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSlideActionCopy(
      BuildContext context, ActionFunction? onTap, int i) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SlideAction(
      closeOnTap: true,
      color: Colors.green,
      onTap: () {
        if (onTap != null)  onTap(i);
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.copy,
              color: Colors.white,
            ),
            const SizedBox(height: 4),
            Text(
              'Copy',
              style: textTheme.bodyText2?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSlideActionPaste(
      BuildContext context, ActionFunction? onTap, int i) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SlideAction(
      closeOnTap: true,
      color: Colors.deepOrange,
      onTap: () {
        if (onTap != null ) onTap(i);
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.brunch_dining,
              color: Colors.white,
            ),
            const SizedBox(height: 4),
            Text(
              'Paste',
              style: textTheme.bodyText2?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Slidable getListTitle(
      {Widget? title, List<Widget>? actions, List<Widget>? secondaryActions}) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actions: actions,
      secondaryActions: secondaryActions,
      child: Stack(
        children: [
          Card(
            child:title,
          ),
          if (_displayHandle == true) Handle(
            delay: const Duration(milliseconds: 100),
            child: Icon(
              Icons.list,
            ),
          ),
        ],
      ),
    );
  }
}
