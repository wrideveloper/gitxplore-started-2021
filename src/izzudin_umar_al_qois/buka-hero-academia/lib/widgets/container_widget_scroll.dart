import 'package:flutter/material.dart';

class ContainerWidgetScroll extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;
  final ScrollPhysics physics;

  const ContainerWidgetScroll({Key key, this.physics, this.padding, this.margin, this.color, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: physics,
          child: Center(
            child: Container(
              color: color,
              padding: padding,
              margin: margin,
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
                maxWidth: 500.0
              ),
              child: child
            )
          )
        );
      }
    );
  }
}

