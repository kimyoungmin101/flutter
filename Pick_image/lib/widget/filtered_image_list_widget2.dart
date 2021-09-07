import 'package:flutter/material.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:image/image.dart' as img;
import 'package:pickle_intern_2021/widget/filtered_image_widget.dart';


class FilteredImageListWidget2 extends StatefulWidget {
  final Map<String, List<Filter>> filters;
  final List<String> filterkey;
  final img.Image image;
  final ValueChanged<Filter> onChangedFilter;

  const FilteredImageListWidget2({
    Key key,
    @required this.filters,
    @required this.filterkey,
    @required this.image,
    @required this.onChangedFilter
  }) : super(key: key);

  @override
  _FilteredImageListWidgetState2 createState() => _FilteredImageListWidgetState2();
}

class _FilteredImageListWidgetState2 extends State<FilteredImageListWidget2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.lightBlueAccent),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.filterkey.length,
          itemBuilder: (context, index){
            final filter_name = widget.filterkey[index];
            return Container(
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.filters[filter_name].length,
                  itemBuilder: (context, index2){
                    final filter = widget.filters[filter_name][index2];
                    return InkWell(
                      onTap: () => widget.onChangedFilter(filter),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.brown,
                              child: Text(filter.name),
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
                  }
              ),
            );
          }
          ),
    );
  }
}




