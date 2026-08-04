import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/input_text_field.dart';
import 'package:frontend/models/watchlist_form_result.dart';
import 'package:frontend/models/watchlist_item.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:frontend/utils/watchlist_status_label.dart';

class UpdateWatchlistSheet extends StatefulWidget {
  final WatchlistItem existingItem;
  const UpdateWatchlistSheet({super.key, required this.existingItem});

  @override
  State<UpdateWatchlistSheet> createState() => _UpdateWatchlistSheetState();
}

class _UpdateWatchlistSheetState extends State<UpdateWatchlistSheet> {
  late WatchStatus _status;
  int? _rating;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final existing = widget.existingItem;
    _status = existing.status;
    _rating = existing.rating;
    _controller = TextEditingController(text: existing.notes ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Uppdatera watchlist item',
            style: AppTextStyles.buttonTextBlack,
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField(
            initialValue: _status,
            decoration: const InputDecoration(labelText: 'Status'),
            items: WatchStatus.values.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(watchlistStatusLabel(status)),
              );
            }).toList(),
            onChanged: (value) => setState(() => _status = value!),
          ),
          const SizedBox(height: 16),

          Text('Rating'),
          Slider(
            value: (_rating ?? 0).toDouble(),
            onChanged: (value) =>
                setState(() => _rating = value == 0 ? null : value.round()),
            min: 0,
            max: 5,
            divisions: 5,
            label: _rating?.toString() ?? '-',
          ),
          const SizedBox(height: 8),

          InputTextField(
            hintText: 'Lägg till anteckningar',
            isPassword: false,
            controller: _controller,
            maxLines: 3,
          ),
          const SizedBox(height: 24),

          CustomButton(
            buttonText: 'UPPDATERA',
            onPressedButton: () {
              Navigator.pop(
                context,
                WatchlistFormResult(
                  status: _status,
                  rating: _rating,
                  notes: _controller.text.isEmpty ? null : _controller.text,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
