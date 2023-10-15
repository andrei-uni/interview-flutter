import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RadioButtonSelection<T> extends StatefulWidget {
  RadioButtonSelection({
    super.key,
    required this.label,
    required this.items,
    required this.groupValue,
    required this.onChanged,
  });

  final Widget label;
  final List<RadioButtonSelectionItem<T>> items;
  T groupValue;
  final ValueChanged<T> onChanged;

  @override
  State<RadioButtonSelection<T>> createState() => _RadioButtonSelectionState<T>();
}

class _RadioButtonSelectionState<T> extends State<RadioButtonSelection<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label,
        for (final item in widget.items)
          _RadioButtonSelectionWidget(
            groupValue: widget.groupValue,
            item: item,
            onChanged: _changeRadioSelection,
          ),
      ],
    );
  }

  void _changeRadioSelection(T value) {
    setState(() {
      widget.groupValue = value;
    });
    widget.onChanged(value);
  }
}

class _RadioButtonSelectionWidget<T> extends StatelessWidget {
  const _RadioButtonSelectionWidget({
    super.key,
    required this.groupValue,
    required this.item,
    required this.onChanged,
  });

  final T groupValue;
  final RadioButtonSelectionItem<T> item;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(item.value),
      child: Row(
        children: [
          Radio(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
            ),
            value: item.value,
            groupValue: groupValue,
            onChanged: (_) => onChanged(item.value),
          ),
          item.child,
        ],
      ),
    );
  }
}

class RadioButtonSelectionItem<T> {
  const RadioButtonSelectionItem({
    required this.value,
    required this.child,
  });

  final T value;
  final Widget child;
}
