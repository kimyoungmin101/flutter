import 'package:flutter/material.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:image/image.dart' as img;
import 'package:pickle_intern_2021/widget/filtered_image_widget.dart';


class FilteredImageListWidget extends StatefulWidget {
  final List<Filter> filters;
  final img.Image image;
  final ValueChanged<Filter> onChangedFilter;

  const FilteredImageListWidget({
    Key key,
    @required this.filters,
    @required this.image,
    @required this.onChangedFilter
  }) : super(key: key);

  @override
  _FilteredImageListWidgetState createState() => _FilteredImageListWidgetState();
}

class _FilteredImageListWidgetState extends State<FilteredImageListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.lightGreenAccent, Colors.black54]
        ),
      ),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.filters.length,
          itemBuilder: (context, index){
            final filter = widget.filters[index];
            return InkWell(
              onTap: () => widget.onChangedFilter(filter),
              child: Container(
                padding: EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilteredImageWidget(
                      filter: filter,
                      image: widget.image,
                      errorBuilder: () => CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.report, size: 32,),
                        backgroundColor: Colors.white,
                      ),
                      successBuilder: (imageBytes) =>
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: MemoryImage(imageBytes),
                            backgroundColor: Colors.white,
                          ),
                      loadingbuilder: () => CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Center(child: CircularProgressIndicator(),),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Text(filter.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}