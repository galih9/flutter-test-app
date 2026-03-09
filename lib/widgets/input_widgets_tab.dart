import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InputWidgetsTab extends StatefulWidget {
  final bool isCupertino;
  const InputWidgetsTab({super.key, required this.isCupertino});

  @override
  State<InputWidgetsTab> createState() => _InputWidgetsTabState();
}

class _InputWidgetsTabState extends State<InputWidgetsTab> {
  bool _switchVal = false;
  bool _checkVal1 = false;
  bool _checkVal2 = true;
  double _sliderVal = 50;
  int _radioValue = 1;

  final Set<String> _selectedChips = {'Flutter'};

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    if (!widget.isCupertino) {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
      }
    } else {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newDate) {
                setState(() => _selectedDate = newDate);
              },
            ),
          ),
        ),
      );
    }
  }

  Future<void> _selectTime(BuildContext context, {bool use24h = false}) async {
    if (!widget.isCupertino) {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(alwaysUse24HourFormat: use24h),
            child: child!,
          );
        },
      );
      if (picked != null && picked != _selectedTime) {
        setState(() {
          _selectedTime = picked;
        });
      }
    } else {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.time,
              use24hFormat: use24h,
              onDateTimeChanged: (DateTime newTime) {
                setState(() => _selectedTime = TimeOfDay.fromDateTime(newTime));
              },
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = _selectedDate == null
        ? 'No Date Chosen'
        : '${_selectedDate!.toLocal()}'.split(' ')[0];
    final timeStr = _selectedTime == null
        ? 'No Time Chosen'
        : _selectedTime!.format(context);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Text Fields:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        if (!widget.isCupertino) ...[
          const TextField(
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'Enter a username',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: UnderlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Pickers:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              OutlinedButton.icon(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.calendar_today),
                label: Text(dateStr),
              ),
              OutlinedButton.icon(
                onPressed: () => _selectTime(context),
                icon: const Icon(Icons.access_time),
                label: Text(timeStr),
              ),
              OutlinedButton.icon(
                onPressed: () => _selectTime(context, use24h: true),
                icon: const Icon(Icons.access_time_filled),
                label: Text('24h: $timeStr'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Toggles & Selections:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Notifications Switch'),
            subtitle: const Text('Turn on to receive updates'),
            value: _switchVal,
            onChanged: (val) => setState(() => _switchVal = val),
          ),
          CheckboxListTile(
            title: const Text('Agree to Terms 1'),
            value: _checkVal1,
            onChanged: (val) => setState(() => _checkVal1 = val ?? false),
          ),
          CheckboxListTile(
            title: const Text('Agree to Terms 2 (Tristate/Error)'),
            value: _checkVal2,
            isError: true,
            onChanged: (val) => setState(() => _checkVal2 = val ?? false),
          ),
          const SizedBox(height: 16),
          const Text('Radio Selection:'),
          RadioGroup<int>(
            groupValue: _radioValue,
            onChanged: (int? value) {
              setState(() => _radioValue = value!);
            },
            child: Row(
              children: [
                Radio.adaptive(value: 1),
                const Text('Option 1'),
                const SizedBox(width: 16),
                Radio.adaptive(value: 2),
                const Text('Option 2'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Chips:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: <Widget>[
              FilterChip(
                label: const Text('Flutter'),
                selected: _selectedChips.contains('Flutter'),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedChips.add('Flutter');
                    } else {
                      _selectedChips.remove('Flutter');
                    }
                  });
                },
              ),
              FilterChip(
                label: const Text('Dart'),
                selected: _selectedChips.contains('Dart'),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedChips.add('Dart');
                    } else {
                      _selectedChips.remove('Dart');
                    }
                  });
                },
              ),
              const ActionChip(
                label: Text('Action Chip'),
                avatar: Icon(Icons.flash_on),
              ),
            ],
          ),
          const SizedBox(height: 24),

          const Text(
            'Volume Slider:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Slider(
            value: _sliderVal,
            min: 0,
            max: 100,
            divisions: 10,
            label: _sliderVal.round().toString(),
            onChanged: (val) => setState(() => _sliderVal = val),
          ),
        ] else ...[
          const CupertinoTextField(
            placeholder: 'Username',
            prefix: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(CupertinoIcons.person),
            ),
            padding: EdgeInsets.all(12),
          ),
          const SizedBox(height: 16),
          const CupertinoTextField(
            placeholder: 'Password',
            obscureText: true,
            prefix: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(CupertinoIcons.lock),
            ),
            padding: EdgeInsets.all(12),
          ),
          const SizedBox(height: 24),
          const Text(
            'Pickers:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                onPressed: () => _selectDate(context),
                child: Text(
                  'Date: $dateStr',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                onPressed: () => _selectTime(context),
                child: Text(
                  'Time: $timeStr',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                onPressed: () => _selectTime(context, use24h: true),
                child: Text(
                  '24h: $timeStr',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Toggles & Selections:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Notifications Switch'),
              CupertinoSwitch(
                value: _switchVal,
                onChanged: (val) => setState(() => _switchVal = val),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Agree to Terms 1'),
              CupertinoCheckbox(
                value: _checkVal1,
                onChanged: (val) => setState(() => _checkVal1 = val ?? false),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Agree to Terms 2'),
              CupertinoCheckbox(
                value: _checkVal2,
                activeColor: CupertinoColors.destructiveRed,
                onChanged: (val) => setState(() => _checkVal2 = val ?? false),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Radio Selection (mock via Buttons)'),
          const SizedBox(height: 8),
          Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => setState(() => _radioValue = 1),
                child: Icon(
                  _radioValue == 1
                      ? CupertinoIcons.circle_fill
                      : CupertinoIcons.circle,
                ),
              ),
              const Text('Option 1'),
              const SizedBox(width: 16),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => setState(() => _radioValue = 2),
                child: Icon(
                  _radioValue == 2
                      ? CupertinoIcons.circle_fill
                      : CupertinoIcons.circle,
                ),
              ),
              const Text('Option 2'),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Chips (Mock):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: <Widget>[
              CupertinoButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                minimumSize: Size.zero,
                color: _selectedChips.contains('Flutter')
                    ? CupertinoColors.activeBlue
                    : CupertinoColors.systemGrey5,
                onPressed: () {
                  setState(() {
                    if (_selectedChips.contains('Flutter')) {
                      _selectedChips.remove('Flutter');
                    } else {
                      _selectedChips.add('Flutter');
                    }
                  });
                },
                child: Text(
                  'Flutter',
                  style: TextStyle(
                    color: _selectedChips.contains('Flutter')
                        ? CupertinoColors.white
                        : CupertinoColors.black,
                  ),
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                minimumSize: Size.zero,
                color: _selectedChips.contains('Dart')
                    ? CupertinoColors.activeBlue
                    : CupertinoColors.systemGrey5,
                onPressed: () {
                  setState(() {
                    if (_selectedChips.contains('Dart')) {
                      _selectedChips.remove('Dart');
                    } else {
                      _selectedChips.add('Dart');
                    }
                  });
                },
                child: Text(
                  'Dart',
                  style: TextStyle(
                    color: _selectedChips.contains('Dart')
                        ? CupertinoColors.white
                        : CupertinoColors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Volume Slider:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          CupertinoSlider(
            value: _sliderVal,
            min: 0,
            max: 100,
            divisions: 10,
            onChanged: (val) => setState(() => _sliderVal = val),
          ),
        ],
      ],
    );
  }
}
