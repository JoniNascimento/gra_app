import 'package:flutter/material.dart';

class BottomPaginationWidget extends StatelessWidget {
  BottomPaginationWidget(
      {super.key, required this.onPageChanged, required int listLength}) {
    _totalPages =
        (listLength ~/ _itemsPerPage) < 1 ? 1 : (listLength ~/ _itemsPerPage);
  }
  final void Function(int selectedPage)? onPageChanged;
  final int listLength = 1;
  int _selectedPage = 1;
  final int _itemsPerPage = 10;
  int _totalPages = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: () {
              _selectedPage = 1;
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              if (_selectedPage > 1) _selectedPage--;
            },
          ),
          Text('$_selectedPage / $_totalPages'),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () {
              if (_selectedPage < _totalPages) _selectedPage++;
            },
          ),
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: () {
              _selectedPage = _totalPages;
            },
          ),
        ],
      ),
    );
  }
}