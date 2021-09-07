import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photofilters/filters/filters.dart';
//import 'package:photofilters/filters/preset_filters.dart';
import 'package:pickle_intern_2021/models/filter.dart';
import 'package:pickle_intern_2021/widget/filtered_image_list_widget2.dart';
import 'package:provider/provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

import '../provider/image_provider.dart';
import 'package:pickle_intern_2021/util/filter_utils.dart';
import 'package:pickle_intern_2021/widget/filtered_image_widget.dart';
import 'package:pickle_intern_2021/widget/filtered_image_list_widget.dart';

//8월 중순 리액션기능 구현중  사진에 대한 리액션?? 다른사람 사진에 스티커나 이런걸 넣어버리는, ar로도 리액션 넣으면 좋을듯
//필터기능을 최대한 손봐서 피클앱넣을 수 있으면 좋겠다 - (민주) 집중적으로
//DM기능 생각중, 리액션 기능 - 이모티콘 + 음성
//컨텐츠 추천 로직 - 백엔드를
//채팅기능을 구현할 예정 - 개인적으로 연락할 예정 - 필터도 개인적으로


class ImageFilterScreen extends StatefulWidget {
  @override
  _ImageFilterScreenState createState() => _ImageFilterScreenState();
}

class _ImageFilterScreenState extends State<ImageFilterScreen> {
  Filter filter;
  img.Image image;
  List<int> filter_image;
  bool check;
  SliderController _firstSliderController = SliderController(50.0);
  File file_test;

  int width;
  int height;
  Uint8List imagebyte;
  Uint8List temp_imagebyte;

  //필터 조절시 0.5~ 2배까지?
  // 1~100까지 중간(1)은 50, 1당 0.02?
  // 0.02 ~ 2까지
  List<Filter> custom_filter = [
    NoFilter(),//필터 없음 - 조절 없어도 됨
    ClarendonFilter(),
    DogpatchFilter(),
    HefeFilter(),
    InkwellFilter(),//흑백 - 조절이 없는듯
    JunoFilter(),
    MayfairFilter(),
    SkylineFilter(),
    SutroFilter()
  ];

  List<String> custom_string_list = [
    'NoFilter',
    'ClarendonFilter',
    'DogpatchFilter',
    'HefeFilter',
    'InkwellFilter',
    'JunoFilter',
    'MayfairFilter',
    'SkylineFilter',
    'SutroFilter'
  ];

  //이거 map으로 사용하려면 string리스트도 필요할거같은데?
  Map<String, List<Filter>> custom = {
    'NoFilter': [NoFilter()],
    'ClarendonFilter': [ClarendonFilter(), ClarendonFilterbright()],
    'DogpatchFilter' : [DogpatchFilter(), DogpatchFilterbrighter()],
    'HefeFilter' : [HefeFilter(), HefeFilterbrighter()],
    'InkwellFilter' : [InkwellFilter()],
    'JunoFilter' : [JunoFilter(), JunoFilterbrighter()],
    'MayfairFilter' : [MayfairFilter(), MayfairFilterbrighter()],
    'SkylineFilter' : [SkylineFilter(), SkylineFilterbrighter()],
    'SutroFilter' : [SutroFilter(), SutroFilterbrighter()]
  };

  //각 필터 개수를 5개 X, 1~2개정도
  //미리 캐쉬로 저장해두면 좋을듯??
  //메인 이미지 로드하는데도 오래걸림
  //처음에는 provider로 했다가 필터 처음 클릭시 true로
  //image.memory로 변경하는것도 좋을듯
  //시작시 필터에 맞는 image.memory캐쉬로 저장

  void initState(){
    super.initState();
    filter = custom_filter.first;
    check = true;

  }

  //각각의 필터를 선언할 시 필터의 값이 고정되어 추가로

  @override
  Widget build(BuildContext context) {
    PickImageProvider provider = Provider.of<PickImageProvider>(context);

    Future pickImage() async{
      final imageBytes = provider.getselectImage.readAsBytesSync();
      final newImage = img.decodeImage(imageBytes);

      width = newImage.width;
      height = newImage.height;
      imagebyte = newImage.getBytes();

      FilterUtils.clearCache();
      setState(() {
        this.image = newImage;
      });
    }

    if(check){
      check = false;
      pickImage();
    }


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: (){

              }
          ),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
                setState(() {
                  filter = custom_filter[0];
                });
              }
          )
        ],
      ),
      body: build_screen(context, provider),
    );
  }

  Widget build_screen(BuildContext context, PickImageProvider provider){
    return ListView(
      children: [
        buildImage(),
        buildFilters(),
        buildFilterpreset()
      ],
    );
  }

  //stateless -> stateful로 바꿔보자
  Widget buildImage(){
    const double height = 400;
    if(image == null) return Container();

    return FilteredImageWidget(
      filter: filter,
      image: image,
      errorBuilder: () => Container(
        height: height,
      ),
      successBuilder: (imageBytes) =>
          Image.memory(imageBytes, height: height, fit: BoxFit.fitHeight,),
      loadingbuilder: () => Container(
          height: height,
          child: CircularProgressIndicator()),
    );
  }

  Widget buildFilters(){
    if(image == null) return Container();

    return FilteredImageListWidget(
      filters: custom_filter,
      image: image,
      onChangedFilter: (filter){
        setState(() {
          this.filter = filter;
        });
      },
    );
  }

  Widget buildFilterpreset(){
    if(image == null) return Container();

    return FilteredImageListWidget2(
        filters: custom,
        filterkey: custom_string_list,
        image: image,
        onChangedFilter: (filter){
          setState(() {
            this.filter = filter;
          });
        }
    );
  }


}


class SliderController{
  double sliderValue;
  SliderController(this.sliderValue);
}
