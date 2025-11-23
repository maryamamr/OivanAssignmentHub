import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oivan_assignment/core/constants/app_assets.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage(
      {super.key,
      required String? imageUrl,
      BoxFit? fit,
      bool useOldImageOnUrlChange = false,
      BorderRadius borderRadius = BorderRadius.zero,
      Widget Function(BuildContext context, String url)? placeholder,
      double? width,
      double? height,
      String? cacheKey,
      this.useMemCache = false,
      ImageWidgetBuilder? builder})
      : _imageUrl = imageUrl,
        _fit = fit,
        _useOldImageOnUrlChange = useOldImageOnUrlChange,
        _borderRadius = borderRadius,
        _placeholder = placeholder,
        _width = width,
        _height = height,
        _cacheKey = cacheKey,
        _builder = builder;

  final String? _imageUrl;
  final BoxFit? _fit;
  final bool _useOldImageOnUrlChange;
  final BorderRadius _borderRadius;
  final Widget Function(BuildContext context, String url)? _placeholder;
  final double? _width;
  final double? _height;
  final String? _cacheKey;
  final bool useMemCache;
  final ImageWidgetBuilder? _builder;

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    Widget child = ClipRRect(
      borderRadius: _borderRadius,
      child: _imageUrl?.isNotEmpty == true
          ? LayoutBuilder(
              builder: (context, constraints) => CachedNetworkImage(
                memCacheWidth: useMemCache
                    ? _width != null
                        ? (_width! * dpr).toInt()
                        : null
                    : null,
                cacheKey: _cacheKey,
                imageUrl: _imageUrl ?? '',
                fadeInDuration: const Duration(milliseconds: 300),
                fit: _fit,
                width: _width,
                height: _height,
                useOldImageOnUrlChange: _useOldImageOnUrlChange,
                imageBuilder: _builder,
                placeholder:
                    _placeholder ?? (_, __) => imageNotExistPlaceHolder(),
              ),
            )
          : imageNotExistPlaceHolder(),
    );

    return child;
  }

  Widget imageNotExistPlaceHolder() => Image.asset(
        AppAssets.placeHolder,
        width: _width,
        height: _height,
        fit: BoxFit.cover,
      );
}
