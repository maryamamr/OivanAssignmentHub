import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum LoadingStyle { defaultStyle, shimmerList, pagination, none }

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    LoadingStyle loadingStyle = LoadingStyle.defaultStyle,
    bool useColumn = false,
    Color? color,
  }) : _loadingStyle = loadingStyle,
       _useColumn = useColumn,
       _color = color;

  final LoadingStyle _loadingStyle;
  final bool _useColumn;
  final Color? _color;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    switch (_loadingStyle) {
      case LoadingStyle.defaultStyle:
        child = _buildDefaultLoading();
        break;
      case LoadingStyle.shimmerList:
        child = _buildShimmerListLoading();
        break;
      case LoadingStyle.pagination:
        child = _buildPaginationLoading();
        break;
      case LoadingStyle.none:
        child = const SizedBox();
        break;
    }
    return Padding(
      padding: _loadingStyle == LoadingStyle.pagination
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.all(16.0),
      child: child,
    );
  }

  Widget _buildDefaultLoading() =>
      Center(child: CircularProgressIndicator(color: _color));

  Widget _buildPaginationLoading() => Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: 12.5,
      height: 12.5,
      child: FittedBox(child: CircularProgressIndicator(color: _color)),
    ),
  );

  Widget _buildShimmerListLoading() => Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    enabled: true,
    child: _useColumn
        ? Column(
            children: List.generate(15, (index) => const _ListItemShimmer()),
          )
        : ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (_, __) => const _ListItemShimmer(),
            itemCount: 15,
          ),
  );
}

class _ListItemShimmer extends StatelessWidget {
  const _ListItemShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  height: 14.0,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                Container(width: 100.0, height: 14.0, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
