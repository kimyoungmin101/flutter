import 'package:flutter/material.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:image/image.dart' as img;
import 'package:pickle_intern_2021/util/filter_utils.dart';

//stateless라서 setstate해도 안바뀜
//provider로 값을 가져와서 한번 해볼것

class FilteredImageWidget extends StatefulWidget{
  final Filter filter;
  final img.Image image;
  final Widget Function() errorBuilder;
  final Widget Function(List<int> imageBytes) successBuilder;
  final Widget Function() loadingbuilder;

  const FilteredImageWidget({
    Key key,
    @required this.filter,
    @required this.image,
    @required this.errorBuilder,
    @required this.successBuilder,
    @required this.loadingbuilder
  }) : super(key: key);

  @override
  _FilteredImageWidgetState createState() => _FilteredImageWidgetState();
}

class _FilteredImageWidgetState extends State<FilteredImageWidget> {
  Widget build(BuildContext context){
    final cachedimageBytes = FilterUtils.getCachedFilter(widget.filter);

    if(cachedimageBytes == null){
      return buildFilterFuture(widget.filter, widget.image);
    }else{
      return buildFilter(cachedimageBytes);
    }
  }

  Widget buildFilterFuture(Filter filter, img.Image image){
    return FutureBuilder(
        future: FilterUtils.applyFilter(image, filter),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return widget.loadingbuilder();
            default:
              if(snapshot.hasError){
                return buildError();
              }else{
                FilterUtils.savveCachedFilter(filter, snapshot.data);
                return buildFilter(snapshot.data);
              }
          }
        }
    );
  }

  Widget buildFilter(List<int> imageBytes) => widget.successBuilder(imageBytes);

  Widget buildError() => widget.errorBuilder();
}