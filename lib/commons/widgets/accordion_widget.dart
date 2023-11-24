import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AccordionWidget extends StatefulWidget {
  final Widget child;
  final String title;
  final Function()? onTitleContainerTapped;

  AccordionWidget({
    Key? key,
    required this.title,
    required this.child,
    this.onTitleContainerTapped,
  }) : super(key: key);

  @override
  State<AccordionWidget> createState() => _AccordionWidgetState();
}

class _AccordionWidgetState extends State<AccordionWidget> {
  bool isOpen = true;
  GlobalKey containedItemKey = GlobalKey();
  double childHeight = 0.0;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        final context = containedItemKey.currentContext;
        final newHeight = context?.size?.height;

        if (newHeight != null) {
          if (childHeight != newHeight) {
            setState(() {
              childHeight = newHeight;
            });
          }
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });

            Timer(
              Duration(milliseconds: 700),
              () {
                if (widget.onTitleContainerTapped != null)
                  widget.onTitleContainerTapped!();
              },
            );
          },
          child: Container(
            height: 42.0,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isOpen ? (-0.25) : (0.25),
                  duration: Duration(milliseconds: 500),
                  child: Icon(
                    Icons.chevron_left,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: isOpen ? childHeight : 0.0,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  key: containedItemKey,
                  child: widget.child,
                  padding: EdgeInsets.only(top: 16.0),
                ),
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
              ),
            ],
          ),
          curve: Curves.easeInOut,
        ),
      ],
    );
  }
}
