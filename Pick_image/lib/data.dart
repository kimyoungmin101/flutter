import 'package:pickle_intern_2021/models/story_model.dart';
import 'package:pickle_intern_2021/models/user_model.dart';

final User user = User(
  name: 'kimYoungmin',
  profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
);
final List<Story> stories = [
  Story(
    url: 'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
    media: MediaType.image,
    duration: const Duration(seconds: 1),
    user: user,
  ),
  Story(
    url: 'https://firebasestorage.googleapis.com/v0/b/pickle-intern-2021.appspot.com/o/cafe1.jpg?alt=media&token=9a700121-6c1e-4404-821e-1279aff9b4fd',
    media: MediaType.image,
    user: user,
    duration: const Duration(seconds: 1),
  ),
  Story(
    url: 'https://38.media.tumblr.com/c84b404d0799fc1123260ec05c49502d/tumblr_n9dlo0BWUw1thi3ago9_1280.jpg',
    media: MediaType.image,
    duration: const Duration(seconds: 1),
    user: user,
  ),
  Story(
    url: 'https://firebasestorage.googleapis.com/v0/b/pickle-intern-2021.appspot.com/o/cafe2.jpg?alt=media&token=9d5ccd37-64bf-4bf1-a268-8b8f91201241',
    media: MediaType.image,
    duration: const Duration(seconds: 1),
    user: user,
  ),
  Story(
    url:'https://firebasestorage.googleapis.com/v0/b/pickle-intern-2021.appspot.com/o/cafe3.jpg?alt=media&token=0bf30abc-d1f2-4472-98bc-afd27e2c847a',
    media: MediaType.image,
    duration: const Duration(seconds: 1),
    user: user,
  ),
  Story(
    url: 'https://src.hidoc.co.kr/image/lib/2021/1/20/1611132055778_0.jpg',
    media: MediaType.image,
    duration: const Duration(seconds: 1),
    user: user,
  ),
];
