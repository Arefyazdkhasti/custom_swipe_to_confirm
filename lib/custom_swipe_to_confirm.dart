import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSwipeToConfirmWidget extends StatefulWidget {
  final VoidCallback onFinish;

  /// Event waiting for the process to finish
  final VoidCallback onWaitingProcess;

  /// Animation finish control
  bool isFinished;

  /// error handle
  bool hasFailed;

  /// Button is active value default : true
  final bool isActive;

  /// Button active color value
  final Color activeColor;

  /// Button disable color value
  final Color? disableColor;

  /// Swipe button widget
  final Widget buttonWidget;

  /// Button color default : Colors.white
  final Color? buttonColor;

  /// Button center text
  final String buttonText;

  /// Button text when need to retry
  final String? retryText;

  /// Button text style
  final TextStyle? buttontextstyle;

  /// Circle indicator color
  final Animation<Color?>? indicatorColor;

  /// border radius of the widget
  final BorderRadius borderRadius;

  CustomSwipeToConfirmWidget({
    Key? key,
    required this.onFinish,
    required this.onWaitingProcess,
    required this.activeColor,
    required this.buttonWidget,
    required this.buttonText,
    this.retryText,
    this.isFinished = false,
    this.hasFailed = false,
    this.isActive = true,
    this.disableColor = Colors.grey,
    this.buttonColor = Colors.white,
    this.buttontextstyle =
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    this.indicatorColor = const AlwaysStoppedAnimation<Color>(Colors.white),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(22.5),
    ),
  }) : super(key: key);

  @override
  _CustomSwipeToConfirmWidgetState createState() =>
      _CustomSwipeToConfirmWidgetState();
}

class _CustomSwipeToConfirmWidgetState extends State<CustomSwipeToConfirmWidget>
    with TickerProviderStateMixin {
  bool isAccepted = false;
  double opacity = 1;
  bool isFinishValue = false;

  bool hasFailedValue = false;
  late AnimationController _controller;

  bool isScaleFinished = false;

  init() {
    setState(() {
      isAccepted = false;
      opacity = 1;
      isFinishValue = false;
      hasFailedValue = false;
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      isFinishValue = widget.isFinished;
      hasFailedValue = widget.hasFailed;
    });
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;

    if (widget.isFinished) {
      setState(() {
        isFinishValue = true;
      });
    } else {
      if (isFinishValue) {
        init();
      }
    }
    if (widget.hasFailed) {
      setState(() {
        hasFailedValue = true;
      });
    }
    //TODO if the payment request where failed reset the button to its original
    /*if (hasFailedValue) {
      setState(() {
        //isFinishValue = false;
        isAccepted = false;
        opacity = 1;
        isFinishValue = false;
      });
      //change the opacity back to 1 as well
    }*/

    return Container(
      width: isAccepted
          ? hasFailedValue
              ? 140
              : (width - ((width - 48) * _controller.value))
          : double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: widget.isActive ? widget.activeColor : widget.disableColor,
        borderRadius: widget.borderRadius,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: opacity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 48 for the action button
                  const SizedBox(width: 48),
                  // 6 for seperator
                  const SizedBox(width: 6),
                  Icon(
                    Icons.double_arrow_rounded,
                    color: theme.colorScheme.primaryContainer,
                  ),
                  const SizedBox(width: 23),
                  Expanded(
                    child: Text(
                      widget.buttonText,
                      style: widget.buttontextstyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isAccepted)
            SwipeableWidget(
              isActive: widget.isActive,
              height: 48.0,
              onSwipeValueCallback: (value) {
                setState(() {
                  opacity = value;
                });
              },
              child: SizedBox(
                height: 44.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        elevation: 2,
                        shape: const CircleBorder(),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.buttonColor),
                          child: Center(
                            child: widget.buttonWidget,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onSwipeCallback: () {
                widget.onWaitingProcess();
                setState(() {
                  isAccepted = true;
                });
                _controller.animateTo(1.0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.fastOutSlowIn);
              },
            )
          else
            Align(
              alignment: Alignment.center,
              child: !isFinishValue
                  ? CircularProgressIndicator(valueColor: widget.indicatorColor)
                  : hasFailedValue
                      ? GestureDetector(
                          onTap: () {
                            init();
                            widget.isFinished = false;
                            widget.hasFailed = false;
                            //widget.onReset();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.retryText ?? 'try again',
                                style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.colorScheme.onPrimary),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.close,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        )
                      : Icon(
                          Icons.done,
                          color: theme.colorScheme.onPrimary,
                        ),
            )
        ],
      ),
    );
  }
}

class SwipeableWidget extends StatefulWidget {
  /// The `Widget` on which we want to detect the swipe movement.
  final Widget child;

  /// The Height of the widget that will be drawn, required.
  final double height;

  /// The `VoidCallback` that will be called once a swipe with certain percentage is detected.
  final VoidCallback onSwipeCallback;

  final SwipeValueCallBack onSwipeValueCallback;

  /// The decimal percentage of swiping in order for the callbacks to get called, defaults to 0.75 (75%) of the total width of the children.
  final double swipePercentageNeeded;

  final bool isActive;

  const SwipeableWidget(
      {Key? key,
      required this.child,
      required this.height,
      required this.onSwipeCallback,
      required this.onSwipeValueCallback,
      required this.isActive,
      this.swipePercentageNeeded = 0.75})
      : assert(swipePercentageNeeded <= 1.0),
        super(key: key);

  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var _dxStartPosition = 0.0;
  var _dxEndsPosition = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      });

    _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: (details) {
          setState(() {
            _dxStartPosition = details.localPosition.dx;
          });
        },
        onPanUpdate: (details) {
          if (widget.isActive) {
            final widgetSize = context.size!.width;

            final minimumXToStartSwiping = widgetSize * 0.25;
            if (_dxStartPosition <= minimumXToStartSwiping) {
              setState(() {
                _dxEndsPosition = details.localPosition.dx;
              });
              final widgetSize = context.size!.width;
              final swipeValue = 50.0 / widgetSize;
              final lastSize = widgetSize;
              final val = 1 - ((details.localPosition.dx) / lastSize);
              _controller.value = val < swipeValue ? swipeValue : val;
              widget.onSwipeValueCallback(_controller.value - swipeValue);
            }
          }
        },
        onPanEnd: (details) async {
          if (widget.isActive) {
            final delta = _dxEndsPosition - _dxStartPosition;
            final widgetSize = context.size!.width;
            var deltaNeededToBeSwiped =
                widgetSize * widget.swipePercentageNeeded;
            deltaNeededToBeSwiped -= 45.0;
            final swipeValue = 45.0 / widgetSize;
            if (delta > deltaNeededToBeSwiped) {
              _controller.animateTo(swipeValue,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn);
              widget.onSwipeCallback();
            } else {
              _controller.animateTo(1.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn);
              widget.onSwipeValueCallback(1.0);
            }
          }
        },
        child: SizedBox(
          height: widget.height,
          child: Align(
            alignment: Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: _controller.value,
              heightFactor: 1.0,
              child: widget.child,
            ),
          ),
        ));
  }
}

typedef SwipeValueCallBack(double value);
