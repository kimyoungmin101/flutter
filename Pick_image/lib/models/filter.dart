import 'dart:typed_data';

import 'package:photofilters/filters/color_filters.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/subfilters.dart';

// NoFilter: No filter
class NoFilter extends ColorFilter {
  double opacitys = 1;

  NoFilter() : super(name: "필터 없음");

  @override
  void apply(Uint8List pixels, int width, int height) {
    // Do nothing
  }
}

// Clarendon: adds light to lighter areas and dark to darker areas
class ClarendonFilter extends ColorFilter {
  double opacitys = 1;

  ClarendonFilter() : super(name: "Clarendon") {
    subFilters.add(new BrightnessSubFilter(.1 * opacitys));
    subFilters.add(new ContrastSubFilter(.1 * opacitys));
    subFilters.add(new SaturationSubFilter(.15 * opacitys));

  }
}

// Juno: Brightens colors, and intensifies red and yellow hues
class JunoFilter extends ColorFilter {
  double opacitys = 1;

  JunoFilter() : super(name: "Juno") {
    subFilters.add(new RGBScaleSubFilter(1.01 * opacitys, 1.04 * opacitys, 1 * opacitys));
    subFilters.add(new SaturationSubFilter(0.3 * opacitys));
  }
}

// Mayfair: Applies a warm pink tone, subtle vignetting to brighten the photograph center and a thin black border
class MayfairFilter extends ColorFilter {
  double opacitys = 1;

  MayfairFilter() : super(name: "Mayfair") {
    subFilters.add(new RGBOverlaySubFilter(230*opacitys, 115*opacitys, 108*opacitys, 0.05*opacitys));
    subFilters.add(new SaturationSubFilter(0.15*opacitys));
  }
}

// Inkwell: Direct shift to black and white
class InkwellFilter extends ColorFilter {
  double opacitys = 1;

  InkwellFilter() : super(name: "Inkwell") {
    subFilters.add(new GrayScaleSubFilter());
  }
}

// Hefe: Hight contrast and saturation, with a similar effect to Lo-Fi but not quite as dramatic
class HefeFilter extends ColorFilter {
  double opacitys = 1;

  HefeFilter() : super(name: "Hefe") {
    subFilters.add(new ContrastSubFilter(0.1 * opacitys));
    subFilters.add(new SaturationSubFilter(0.15 * opacitys));
  }
}

// Sutro: Burns photo edges, increases highlights and shadows dramatically with a focus on purple and brown colors
class SutroFilter extends ColorFilter {
  double opacitys = 1;

  SutroFilter() : super(name: "Sutro") {
    subFilters.add(new BrightnessSubFilter(-0.1 * opacitys));
    subFilters.add(new SaturationSubFilter(-0.1 * opacitys));
  }
}

// Skyline: brightens to the image pop
class SkylineFilter extends ColorFilter {
  double opacitys = 1;

  SkylineFilter() : super(name: "Skyline") {
    subFilters.add(new SaturationSubFilter(0.35 * opacitys));
    subFilters.add(new BrightnessSubFilter(0.1 * opacitys));
  }
}

// Dogpatch: increases the contrast, while washing out the lighter colors
class DogpatchFilter extends ColorFilter {
  double opacitys = 1;

  DogpatchFilter() : super(name: "Dogpatch") {
    subFilters.add(new ContrastSubFilter(0.15*opacitys));
    subFilters.add(new BrightnessSubFilter(0.1*opacitys));
  }
}

//농도조절 Filter (NoFilter, InkWell{흑백} 제외)
//4단계 추가 darker  dark  bright  brighter


class ClarendonFilterdarker extends ColorFilter {
  double opacitys = 0.1;

  ClarendonFilterdarker() : super(name: "Clarendon-2") {
    subFilters.add(new BrightnessSubFilter(.1 * opacitys));
    subFilters.add(new ContrastSubFilter(.1 * opacitys));
    subFilters.add(new SaturationSubFilter(.15 * opacitys));

  }
}

class ClarendonFilterdark extends ColorFilter {
  double opacitys = 0.5;

  ClarendonFilterdark() : super(name: "Clarendon-1") {
    subFilters.add(new BrightnessSubFilter(.1 * opacitys));
    subFilters.add(new ContrastSubFilter(.1 * opacitys));
    subFilters.add(new SaturationSubFilter(.15 * opacitys));

  }
}

class ClarendonFilterbright extends ColorFilter {
  double opacitys = 1.5;

  ClarendonFilterbright() : super(name: "Clarendon+1") {
    subFilters.add(new BrightnessSubFilter(.1 * opacitys));
    subFilters.add(new ContrastSubFilter(.1 * opacitys));
    subFilters.add(new SaturationSubFilter(.15 * opacitys));

  }
}

class ClarendonFilterbrighter extends ColorFilter {
  double opacitys = 2 ;

  ClarendonFilterbrighter() : super(name: "Clarendon+2") {
    subFilters.add(new BrightnessSubFilter(.1 * opacitys));
    subFilters.add(new ContrastSubFilter(.1 * opacitys));
    subFilters.add(new SaturationSubFilter(.15 * opacitys));

  }
}

class JunoFilterdarker extends ColorFilter {
  double opacitys = 0.1;

  JunoFilterdarker() : super(name: "Juno-2") {
    subFilters.add(new RGBScaleSubFilter(1.01 * opacitys, 1.04 * opacitys, 1 * opacitys));
    subFilters.add(new SaturationSubFilter(0.3 * opacitys));
  }
}

class JunoFilterdark extends ColorFilter {
  double opacitys = 0.5;

  JunoFilterdark() : super(name: "Juno-1") {
    subFilters.add(new RGBScaleSubFilter(1.01 * opacitys, 1.04 * opacitys, 1 * opacitys));
    subFilters.add(new SaturationSubFilter(0.3 * opacitys));
  }
}

class JunoFilterbright extends ColorFilter {
  double opacitys = 1.5;

  JunoFilterbright() : super(name: "Juno+1") {
    subFilters.add(new RGBScaleSubFilter(1.01 * opacitys, 1.04 * opacitys, 1 * opacitys));
    subFilters.add(new SaturationSubFilter(0.3 * opacitys));
  }
}

class JunoFilterbrighter extends ColorFilter {
  double opacitys = 2;

  JunoFilterbrighter() : super(name: "Juno+2") {
    subFilters.add(new RGBScaleSubFilter(1.01 * opacitys, 1.04 * opacitys, 1 * opacitys));
    subFilters.add(new SaturationSubFilter(0.3 * opacitys));
  }
}

class MayfairFilterdarker extends ColorFilter {
  double opacitys = 0.1;

  MayfairFilterdarker() : super(name: "Mayfair-2") {
    subFilters.add(new RGBOverlaySubFilter(230*opacitys, 115*opacitys, 108*opacitys, 0.05*opacitys));
    subFilters.add(new SaturationSubFilter(0.15*opacitys));
  }
}

class MayfairFilterdark extends ColorFilter {
  double opacitys = 0.5;

  MayfairFilterdark() : super(name: "Mayfair-1") {
    subFilters.add(new RGBOverlaySubFilter(230*opacitys, 115*opacitys, 108*opacitys, 0.05*opacitys));
    subFilters.add(new SaturationSubFilter(0.15*opacitys));
  }
}

class MayfairFilterbright extends ColorFilter {
  double opacitys = 1.5;

  MayfairFilterbright() : super(name: "Mayfair+1") {
    subFilters.add(new RGBOverlaySubFilter(230*opacitys, 115*opacitys, 108*opacitys, 0.05*opacitys));
    subFilters.add(new SaturationSubFilter(0.15*opacitys));
  }
}

class MayfairFilterbrighter extends ColorFilter {
  double opacitys = 2;

  MayfairFilterbrighter() : super(name: "Mayfair+2") {
    subFilters.add(new RGBOverlaySubFilter(230*opacitys, 115*opacitys, 108*opacitys, 0.05*opacitys));
    subFilters.add(new SaturationSubFilter(0.15*opacitys));
  }
}

class HefeFilterdarker extends ColorFilter {
  double opacitys = 0.1;

  HefeFilterdarker() : super(name: "Hefe-2") {
    subFilters.add(new ContrastSubFilter(0.1 * opacitys));
    subFilters.add(new SaturationSubFilter(0.15 * opacitys));
  }
}

class HefeFilterdark extends ColorFilter {
  double opacitys = 0.5;

  HefeFilterdark() : super(name: "Hefe-1") {
    subFilters.add(new ContrastSubFilter(0.1 * opacitys));
    subFilters.add(new SaturationSubFilter(0.15 * opacitys));
  }
}

class HefeFilterbright extends ColorFilter {
  double opacitys = 1.5;

  HefeFilterbright() : super(name: "Hefe+1") {
    subFilters.add(new ContrastSubFilter(0.1 * opacitys));
    subFilters.add(new SaturationSubFilter(0.15 * opacitys));
  }
}

class HefeFilterbrighter extends ColorFilter {
  double opacitys = 2;

  HefeFilterbrighter() : super(name: "Hefe+2") {
    subFilters.add(new ContrastSubFilter(0.1 * opacitys));
    subFilters.add(new SaturationSubFilter(0.15 * opacitys));
  }
}

class SutroFilterdarker extends ColorFilter {
  double opacitys = 0.1;

  SutroFilterdarker() : super(name: "Sutro-2") {
    subFilters.add(new BrightnessSubFilter(-0.1 * opacitys));
    subFilters.add(new SaturationSubFilter(-0.1 * opacitys));
  }
}

class SutroFilterdark extends ColorFilter {
  double opacitys = 0.5;

  SutroFilterdark() : super(name: "Sutro-1") {
    subFilters.add(new BrightnessSubFilter(-0.1 * opacitys));
    subFilters.add(new SaturationSubFilter(-0.1 * opacitys));
  }
}

class SutroFilterbright extends ColorFilter {
  double opacitys = 1.5;

  SutroFilterbright() : super(name: "Sutro+1") {
    subFilters.add(new BrightnessSubFilter(-0.1 * opacitys));
    subFilters.add(new SaturationSubFilter(-0.1 * opacitys));
  }
}

class SutroFilterbrighter extends ColorFilter {
  double opacitys = 2;

  SutroFilterbrighter() : super(name: "Sutro+2") {
    subFilters.add(new BrightnessSubFilter(-0.1 * opacitys));
    subFilters.add(new SaturationSubFilter(-0.1 * opacitys));
  }
}

class SkylineFilterdarker extends ColorFilter {
  double opacitys = 0.1;

  SkylineFilterdarker() : super(name: "Skyline-2") {
    subFilters.add(new SaturationSubFilter(0.35 * opacitys));
    subFilters.add(new BrightnessSubFilter(0.1 * opacitys));
  }
}

class SkylineFilterdark extends ColorFilter {
  double opacitys = 0.5;

  SkylineFilterdark() : super(name: "Skyline-1") {
    subFilters.add(new SaturationSubFilter(0.35 * opacitys));
    subFilters.add(new BrightnessSubFilter(0.1 * opacitys));
  }
}

class SkylineFilterbright extends ColorFilter {
  double opacitys = 1.5;

  SkylineFilterbright() : super(name: "Skyline+1") {
    subFilters.add(new SaturationSubFilter(0.35 * opacitys));
    subFilters.add(new BrightnessSubFilter(0.1 * opacitys));
  }
}

class SkylineFilterbrighter extends ColorFilter {
  double opacitys = 2;

  SkylineFilterbrighter() : super(name: "Skyline+2") {
    subFilters.add(new SaturationSubFilter(0.35 * opacitys));
    subFilters.add(new BrightnessSubFilter(0.1 * opacitys));
  }
}

class DogpatchFilterdarker extends ColorFilter {
  double opacitys = 0.1;

  DogpatchFilterdarker() : super(name: "Dogpatch-2") {
    subFilters.add(new ContrastSubFilter(0.15*opacitys));
    subFilters.add(new BrightnessSubFilter(0.1*opacitys));
  }
}

class DogpatchFilterdark extends ColorFilter {
  double opacitys = 0.5;

  DogpatchFilterdark() : super(name: "Dogpatch-1") {
    subFilters.add(new ContrastSubFilter(0.15*opacitys));
    subFilters.add(new BrightnessSubFilter(0.1*opacitys));
  }
}

class DogpatchFilterbright extends ColorFilter {
  double opacitys = 1.5;

  DogpatchFilterbright() : super(name: "Dogpatch+1") {
    subFilters.add(new ContrastSubFilter(0.15*opacitys));
    subFilters.add(new BrightnessSubFilter(0.1*opacitys));
  }
}

class DogpatchFilterbrighter extends ColorFilter {
  double opacitys = 2;

  DogpatchFilterbrighter() : super(name: "Dogpatch+2") {
    subFilters.add(new ContrastSubFilter(0.15*opacitys));
    subFilters.add(new BrightnessSubFilter(0.1*opacitys));
  }
}









List<Filter> presetFiltersList = [
  NoFilter(),
  ClarendonFilter(),
  DogpatchFilter(),
  InkwellFilter(),
  JunoFilter(),
  MayfairFilter(),
  SkylineFilter(),
  SutroFilter(),
  HefeFilter()
];
