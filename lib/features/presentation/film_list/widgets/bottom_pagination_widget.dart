import 'package:flutter/material.dart';

class BottomPaginationWidget extends StatelessWidget {
  const BottomPaginationWidget({
    Key? key,
    required this.onPageChanged,
    required this.listLength,
    required this.itemsPerPage,
    required this.totalPages,
    required this.selectedPage,
  }) : super(key: key);

  final void Function(int selectedPage) onPageChanged;
  final int listLength;
  final int selectedPage;
  final int itemsPerPage;
  final int totalPages;

  void _onFirstPage() => onPageChanged(1);
  void _onPreviousPage() {
    if (selectedPage > 1) {
      onPageChanged(selectedPage - 1);
    }
  }

  void _onNextPage() {
    if (selectedPage < totalPages) {
      onPageChanged(selectedPage + 1);
    }
  }

  void _onLastPage() => onPageChanged(totalPages);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: _onFirstPage,
          ),
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: _onPreviousPage,
          ),
          Text('$selectedPage / $totalPages'),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: _onNextPage,
          ),
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: _onLastPage,
          ),
        ],
      ),
    );
  }
}
