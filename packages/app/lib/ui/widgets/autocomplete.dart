// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/material.dart';

import 'package:app/utils/debouncable.dart';

typedef OptionsRequest = Future<Iterable<String>> Function(String);

class MeliAutocomplete extends StatefulWidget {
  final OptionsRequest onOptionsRequest;
  final Function? onChanged;

  MeliAutocomplete({
    super.key,
    required this.onOptionsRequest,
    this.onChanged,
  });

  @override
  State<MeliAutocomplete> createState() => _MeliAutocompleteState();
}

class _MeliAutocompleteState extends State<MeliAutocomplete> {
  late final Debounceable<Iterable<String>?, String> _debouncedSearch;

  // The query currently being searched for. If null, there is no pending
  // request.
  String? _currentQuery;

  // A network error was recieved on the most recent query.
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _debouncedSearch = debounce<Iterable<String>?, String>(_search);
  }

  // Calls the "remote" API to search with the given query. Returns null when
  // the call has been made obsolete.
  Future<Iterable<String>?> _search(String query) async {
    _currentQuery = query;

    late final Iterable<String> options;
    try {
      options = await widget.onOptionsRequest(query);
    } catch (error) {
      setState(() {
        _isError = true;
      });

      return <String>[];
    }

    // If another search happened after this one, throw away these options.
    if (_currentQuery != query) {
      return null;
    }

    _currentQuery = null;

    return options;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Autocomplete<String>(
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.arrow_drop_down),
              errorText: _isError ? 'Error, please try again.' : null,
            ),
            controller: controller,
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
          );
        },
        optionsViewBuilder:
            (BuildContext context, onSelected, Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(4.0)),
              ),
              child: Container(
                height: 52.0 * options.length,
                width: constraints.maxWidth,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return InkWell(
                      onTap: () => onSelected(option),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(option),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
        optionsBuilder: (TextEditingValue textEditingValue) async {
          final Iterable<String>? options =
              await _debouncedSearch(textEditingValue.text);

          if (textEditingValue.text.isEmpty) {
            return [];
          }

          if (options == null) {
            return [];
          }

          return [textEditingValue.text, ...options];
        },
        onSelected: (String selection) {
          if (widget.onChanged != null) {
            widget.onChanged!.call(selection);
          }
        },
      );
    });
  }
}
