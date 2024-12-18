part of 'calendar_week.dart';

class _DateItem extends StatefulWidget {
  /// Date
  final DateTime date;

  /// Date
  final double opacity;

  /// [TextStyle] of day
  final TextStyle dateStyle;

  /// [TextStyle] of day after pressed
  final TextStyle pressedDateStyle;

  /// [Background] of day
  final Color backgroundColor;

  /// [Background] of today
  final Color todayBackgroundColor;

  /// [Background] of day after pressed

  final Color pressedBackgroundColor;

  /// [Alignment] of decoration
  final Alignment decorationAlignment;

  /// [ShapeBorder] of day
  final OutlinedBorder dayShapeBorder;

  /// [Callback] function after pressed on date
  final void Function(DateTime)? onDatePressed;

  /// [Callback] function after long pressed on date
  final void Function(DateTime)? onDateLongPressed;

  /// Decoration [Widget]
  final Widget? decoration;

  /// [BehaviorSubject] emit, listen last date pressed
  final BehaviorSubject<DateTime> subject;

  _DateItem({
    required this.date,
    required this.opacity,
    required this.dateStyle,
    required this.pressedDateStyle,
    this.backgroundColor = Colors.transparent,
    this.todayBackgroundColor = Colors.orangeAccent,
    required this.pressedBackgroundColor,
    this.decorationAlignment = FractionalOffset.center,
    required this.dayShapeBorder,
    this.onDatePressed,
    this.onDateLongPressed,
    this.decoration,
    required this.subject,
  });

  @override
  __DateItemState createState() => __DateItemState();
}

class __DateItemState extends State<_DateItem> {
  /// Default [Background] of day
  late Color _defaultBackgroundColor;

  /// Default [TextStyle] of day
  late TextStyle _defaultTextStyle;

  @override
  Widget build(BuildContext context) => StreamBuilder<DateTime>(
        stream: widget.subject,
        builder: (_, data) {
          /// Set default [Background] of day
          Color? selectedBackgroundColor;
          TextStyle? selectedTextStyle;

          /// If today, set [Background] of today
          if (data.hasData) {
            final DateTime? dateSelected = data.data;
            if (_compareDate(widget.date, dateSelected)) {
              selectedBackgroundColor = widget.pressedBackgroundColor;
              selectedTextStyle = widget.pressedDateStyle;
            }
          }
          if (null == selectedBackgroundColor && _compareDate(widget.date, _today)) {
            selectedBackgroundColor = widget.todayBackgroundColor;
          }

          _defaultBackgroundColor = selectedBackgroundColor ?? widget.backgroundColor;
          _defaultTextStyle = selectedTextStyle ?? widget.dateStyle;

          return _body();
        },
      );

  /// Body layout
  Widget _body() => Center(
        child: GestureDetector(
          onLongPress: null == widget.onDateLongPressed ? null : _onLongPressed,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: TextButton(
                onPressed: null == widget.onDatePressed ? null : _onPressed,
                style: TextButton.styleFrom(
                  backgroundColor: _defaultBackgroundColor,
                  shape: widget.dayShapeBorder,
                  padding: EdgeInsets.all(5),
                ),
                child: Opacity(
                  opacity: widget.opacity,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${widget.date.day}',
                            style: _defaultTextStyle,
                          ),
                        ),
                      ),
                      _decoration()
                    ],
                  ),
                )),
          ),
        ),
      );

  /// Decoration layout
  Widget _decoration() => Positioned(
        top: 28,
        left: 0,
        right: 0,
        child: widget.decoration != null
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: widget.decoration,
              )
            : Container(),
      );

  /// Handler pressed
  void _onPressed() {
    widget.subject.add(widget.date);
    widget.onDatePressed!.call(widget.date);
  }

  /// Handler long pressed
  void _onLongPressed() {
    widget.subject.add(widget.date);
    widget.onDateLongPressed!.call(widget.date);
  }
}
