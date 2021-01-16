import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

enum ActionOption {
  Delete,
}

typedef DeleteCallBack<E> = void Function(E item);
typedef CreateListWidget<E> = Widget Function(
    BuildContext context, E item, int index);

class FBListViewWidget<E> extends StatefulWidget {
  List<E> _list;
  DeleteCallBack<E> onDeleted;
  CreateListWidget<E> createLeading;
  CreateListWidget<E> createTitle;
  CreateListWidget<E> createSubTitle;
  bool canBeMove = false;

  List<ActionOption> actions = null;
  List<ActionOption> seActions = null;

  FBListViewWidget(this._list,
      {this.actions,
      this.seActions,
      this.createLeading,
      this.createTitle,
      this.createSubTitle,
      this.onDeleted,
      this.canBeMove});

  _FBListViewWidgetState createState() => _FBListViewWidgetState<E>(this._list,
      actions: this.actions,
      seActions: this.seActions,
      onDeleted: this.onDeleted,
      createLeading: this.createLeading,
      createTitle: this.createTitle,
      createSubTitle: this.createSubTitle,
      canBeMove: this.canBeMove);
}

class _FBListViewWidgetState<E> extends State<FBListViewWidget>
    with SingleTickerProviderStateMixin {
  _FBListViewWidgetState(this._list,
      {this.actions,
      this.seActions,
      this.createLeading,
      this.createTitle,
      this.createSubTitle,
      this.onDeleted,
      this.canBeMove}) {
    if (!(this.canBeMove is bool)) {
      this.canBeMove = false;
    }
  }

  List<ActionOption> seActions = null;

  DeleteCallBack<E> onDeleted;
  CreateListWidget<E> createLeading;
  CreateListWidget<E> createTitle;
  CreateListWidget<E> createSubTitle;
  List<ActionOption> actions = null;
  bool canBeMove = false;

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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
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
    final theme = Theme.of(context);

    Widget buildReorderable(
      dynamic item,
      Widget Function(Widget tile) transitionBuilder,
    ) {
      return Reorderable(
        key: ValueKey(item),
        builder: (context, dragAnimation, inDrag) {
          final t = dragAnimation.value;
          final tile = _buildTile(t, item);

          return transitionBuilder(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                tile,
                const Divider(height: 10),
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
        return buildReorderable(lang, (tile) {
          return SizeFadeTransition(
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: itemAnimation,
            child: tile,
          );
        });
      },
      footer: _buildFooter(context, theme.textTheme),
    );
  }

  Widget _buildFooter(BuildContext context, TextTheme textTheme) {
    return Box(
      color: Colors.white,
      onTap: () async {
        print("footer ");
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const SizedBox(
              height: 36,
              width: 36,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
              ),
            ),
            title: Text(
              'Add a language',
              style: textTheme.bodyText1.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }

  Widget _buildTile(double t, E item) {
    final color = Color.lerp(Colors.white, Colors.grey.shade100, t);
    final elevation = lerpDouble(0, 8, t);

    List<Widget> actions = null;
    if (_list.length > 0 && this.actions != null) {
      actions = [];
      this.actions.forEach((element) {
        if (element == ActionOption.Delete) {
          actions.add(getSlideActionDelete(item));
        }
      });
    }

    List<Widget> seActions = null;
    if (_list.length > 0 && this.seActions != null) {
      seActions = [];
      this.seActions.forEach((element) {
        if (element == ActionOption.Delete) {
          seActions.add(getSlideActionDelete(item));
        }
      });
    }

    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      actions: this.actions == null ? null : actions,
      secondaryActions: this.seActions == null ? null : seActions,
      child: Box(
        color: color,
        //elevation: elevation,
        alignment: Alignment.center,
        child: ListTile(
            leading: createLeading == null
                ? null
                : createLeading(context, item, this._list.indexOf(item)),
            // SizedBox(
            //   width: 36,
            //   height: 100,
            //   child: Center(
            //     child: createLeading(context, item),
            //   ),
            // ),
            title: createTitle == null
                ? null
                : createTitle(context, item, this._list.indexOf(item)),
            subtitle: createSubTitle == null
                ? null
                : createSubTitle(context, item, this._list.indexOf(item)),
            trailing: !this.canBeMove
                ? Text("")
                : const Handle(
                    delay: Duration(milliseconds: 100),
                    child: Icon(
                      Icons.drag_handle,
                      color: Colors.grey,
                    ),
                  )),
      ),
    );
  }

  Widget getSlideActionDelete(E item) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SlideAction(
      closeOnTap: true,
      color: Colors.deepPurple,
      onTap: () {
        setState(
          () {
            _list.remove(item);
            if (onDeleted != null) {
              onDeleted(item);
            }
          },
        );
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
              style: textTheme.bodyText2.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ShadowDirection {
  topLeft,
  top,
  topRight,
  right,
  bottomRight,
  bottom,
  bottomLeft,
  left,
  center,
}

class Box extends StatelessWidget {
  final double borderRadius;
  final double elevation;
  final double height;
  final double width;
  final Border border;
  final BorderRadius customBorders;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;
  final Color color;
  final Color shadowColor;
  final List<BoxShadow> boxShadows;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onDoubleTap;
  final BoxShape boxShape;
  final AlignmentGeometry alignment;
  final ShadowDirection shadowDirection;
  final Color splashColor;
  final Duration duration;
  final BoxConstraints constraints;

  const Box({
    Key key,
    this.child,
    this.border,
    this.color = Colors.transparent,
    this.borderRadius = 0.0,
    this.elevation = 0.0,
    this.splashColor,
    this.shadowColor = Colors.black12,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.height,
    this.width,
    this.margin,
    this.customBorders,
    this.alignment,
    this.boxShadows,
    this.constraints,
    this.duration,
    this.boxShape = BoxShape.rectangle,
    this.shadowDirection = ShadowDirection.bottomRight,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  static const wrap = -1;

  bool get circle => boxShape == BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final w = width;
    final h = height;
    final br = customBorders ??
        BorderRadius.circular(
          boxShape == BoxShape.rectangle
              ? borderRadius
              : w != null
                  ? w / 2.0
                  : h != null
                      ? h / 2.0
                      : 0,
        );

    Widget content = Padding(
      padding: padding,
      child: child,
    );

    if (boxShape == BoxShape.circle ||
        (customBorders != null || borderRadius > 0.0)) {
      content = ClipRRect(
        borderRadius: br,
        child: content,
      );
    }

    if (onTap != null || onLongPress != null || onDoubleTap != null) {
      content = Material(
        color: Colors.transparent,
        type: MaterialType.transparency,
        shape: circle
            ? const CircleBorder()
            : RoundedRectangleBorder(borderRadius: br),
        child: InkWell(
          splashColor: splashColor ?? theme.splashColor,
          highlightColor: theme.highlightColor,
          hoverColor: theme.hoverColor,
          focusColor: theme.focusColor,
          customBorder: circle
              ? const CircleBorder()
              : RoundedRectangleBorder(borderRadius: br),
          onTap: onTap,
          onLongPress: onLongPress,
          onDoubleTap: onDoubleTap,
          child: content,
        ),
      );
    }

    final List<BoxShadow> boxShadow =
        boxShadows ?? (elevation > 0 && (shadowColor?.opacity ?? 0) > 0)
            ? [
                BoxShadow(
                  color: shadowColor ?? Colors.black12,
                  offset: _getShadowOffset(min(elevation / 5.0, 1.0)),
                  blurRadius: elevation,
                  spreadRadius: 0,
                ),
              ]
            : null;

    final boxDecoration = BoxDecoration(
      color: color,
      borderRadius: circle || br == BorderRadius.zero ? null : br,
      shape: boxShape,
      boxShadow: boxShadow,
      border: border,
    );

    return duration != null
        ? AnimatedContainer(
            height: h,
            width: w,
            margin: margin,
            alignment: alignment,
            duration: duration,
            decoration: boxDecoration,
            constraints: constraints,
            child: content,
          )
        : Container(
            height: h,
            width: w,
            margin: margin,
            alignment: alignment,
            decoration: boxDecoration,
            constraints: constraints,
            child: content,
          );
  }

  Offset _getShadowOffset(double ele) {
    final ym = 5 * ele;
    final xm = 2 * ele;
    switch (shadowDirection) {
      case ShadowDirection.topLeft:
        return Offset(-1 * xm, -1 * ym);
        break;
      case ShadowDirection.top:
        return Offset(0, -1 * ym);
        break;
      case ShadowDirection.topRight:
        return Offset(xm, -1 * ym);
        break;
      case ShadowDirection.right:
        return Offset(xm, 0);
        break;
      case ShadowDirection.bottomRight:
        return Offset(xm, ym);
        break;
      case ShadowDirection.bottom:
        return Offset(0, ym);
        break;
      case ShadowDirection.bottomLeft:
        return Offset(-1 * xm, ym);
        break;
      case ShadowDirection.left:
        return Offset(-1 * xm, 0);
        break;
      default:
        return Offset.zero;
        break;
    }
  }
}
