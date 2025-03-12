import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/filter/filter_bloc.dart';

class FilterWidget extends StatefulWidget {
  final Map<String, List<String>> filters;
  final Map<String, List<String>> selectedFilters;
  final Function(Map<String, List<String>>) onFiltersApplied;

  const FilterWidget({
    required this.filters,
    required this.selectedFilters,
    required this.onFiltersApplied,
    super.key,
  });

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late Map<String, List<String>> selectedFilters;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedFilters = Map.from(widget.selectedFilters);

    setState(() {
      selectedCategory = context.read<FilterBloc>().state.selectedCategory;
    });
    print("selectedCategory, $selectedCategory, $selectedFilters");
  }

  void resetFilters() {
    setState(() {
      selectedFilters.clear();
    });
  }

  void toggleSubcategory(String category, String subcategory) {
    setState(() {
      selectedFilters.putIfAbsent(category, () => []);
      if (selectedFilters[category]!.contains(subcategory)) {
        selectedFilters[category]!.remove(subcategory);
      } else {
        selectedFilters[category]!.add(subcategory);
      }
      if (selectedFilters[category]!.isEmpty) {
        selectedFilters.remove(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 6,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filters',
                    style: Theme.of(context).textTheme.headlineMedium),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Row(
              children: [
                BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    return Expanded(
                      flex: 2,
                      child: ListView(
                        children: state.productFilterTypesList.map((category) {
                          return ListTile(
                            trailing: Checkbox(
                              activeColor: AppColors.secondary,
                              value:
                                  selectedFilters.containsKey(category.queryId),
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedFilters[category.queryId!] = [];
                                    selectedCategory = category.queryId;
                                    context.read<FilterBloc>().add(
                                        HandleSelectedCategory(
                                            category.queryId));
                                  } else {
                                    selectedFilters.remove(category.queryId);
                                    if (selectedCategory == category.queryId) {
                                      selectedCategory = null;
                                      context
                                          .read<FilterBloc>()
                                          .add(HandleSelectedCategory(null));
                                    }
                                  }
                                });
                              },
                            ),
                            title: Text(
                              category.name!,
                              style: TextStyle(fontSize: 14),
                            ),
                            onTap: () {
                              setState(() {
                                selectedCategory = category.queryId;
                              });
                              context.read<FilterBloc>().add(
                                  HandleSelectedCategory(category.queryId));
                              context.read<FilterBloc>().add(
                                  FetchProductFilterByType(category.type!));
                            },
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const VerticalDivider(width: 1, color: Colors.grey),
                // Right Panel: Subcategories
                Expanded(
                  flex: 3,
                  child: selectedCategory == null
                      ? const Center(
                          child: Text('Select a category to view options'))
                      : BlocBuilder<FilterBloc, FilterState>(
                          builder: (context, state) {
                            return ListView(
                              children: state.productFilterByTypeList
                                  .map((subcategory) {
                                return CheckboxListTile(
                                  value: selectedFilters[selectedCategory]
                                          ?.contains(subcategory.value) ??
                                      false,
                                  title: Text(subcategory.name!),
                                  onChanged: (value) => toggleSubcategory(
                                      selectedCategory!, subcategory.value!),
                                );
                              }).toList(),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          // Bottom Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    widget.onFiltersApplied(
                        selectedFilters); // Apply and send back filters
                  },
                  child: Text('Show Results',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                ),
                TextButton(
                  onPressed: resetFilters,
                  child: const Text(
                    'Reset',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int calculateResults() {
    // Placeholder logic to calculate results based on selectedFilters
    return 240 -
        (selectedFilters.values.fold(0, (acc, list) => acc + list.length) * 10);
  }
}
