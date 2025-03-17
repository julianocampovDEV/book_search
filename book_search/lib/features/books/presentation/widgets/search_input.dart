import 'package:flutter/material.dart';

import 'package:book_search/config/theme/app_colors.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController searchController;
  final ValueChanged onChanged;

  const SearchInput({
    super.key,
    required this.searchController,
    required this.onChanged,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: AppColors.primary),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.webSearch,
                  controller: widget.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search book...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: widget.onChanged,
                ),
              ),
              widget.searchController.text != ''
                  ? IconButton(
                    onPressed: () {
                      widget.searchController.clear();
                      widget.onChanged('');
                      setState(() {});
                    },
                    icon: Icon(Icons.cancel),
                  )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
