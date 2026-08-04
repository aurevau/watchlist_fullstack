import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/input_text_field.dart';
import 'package:frontend/models/watchlist_form_result.dart';
import 'package:frontend/models/watchlist_item.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:frontend/utils/watchlist_status_label.dart';

class AddToWatchlistSheet extends StatefulWidget {
  const AddToWatchlistSheet({super.key});

  @override
  State<AddToWatchlistSheet> createState() => _AddToWatchlistSheetState();
}

class _AddToWatchlistSheetState extends State<AddToWatchlistSheet> {
  WatchStatus _status = WatchStatus.planned;
  int? _rating;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Lägg till i watchlist', style: AppTextStyles.buttonTextBlack),
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
            min: 0,
            max: 5,
            divisions: 5,
            label: _rating?.toString() ?? '-',
            onChanged: (value) =>
                setState(() => _rating = value == 0 ? null : value.round()),
          ),
          const SizedBox(height: 8),

          InputTextField(
            hintText: 'Lägg till anteckningar',
            isPassword: false,
            controller: _notesController,
            maxLines: 3,
          ),
          const SizedBox(height: 24),

          CustomButton(
            buttonText: 'SPARA',
            onPressedButton: () {
              Navigator.pop(
                context,
                WatchlistFormResult(
                  status: _status,
                  rating: _rating,
                  notes: _notesController.text.isEmpty
                      ? null
                      : _notesController.text,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
