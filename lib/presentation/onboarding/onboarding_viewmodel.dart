import 'dart:async';

import 'package:miseo/domain/model/model.dart';
import 'package:miseo/presentation/base/baseviewmodel.dart';
import 'package:miseo/presentation/resources/assets_manager.dart';
import 'package:miseo/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream controllers
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  //data
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    //send this slider data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    _currentIndex++;
    int nextIndex = _currentIndex;
    if (nextIndex >= _list.length) {
      _currentIndex = 0; // infinite loop to go to the first item of slider list
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    _currentIndex--;
    int previousIndex = _currentIndex;
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; // infinite loop to go to the length of slider list
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  //inputs
  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //private functions

  //populate list
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
      ];

  //send data to view
  _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

//orders that our view model will receive from our view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user clicks on right arrow or swipe left
  void goPrevious(); // when user clicks on left arrow right
  void onPageChanged(int index);

  Sink get inputSliderViewObject; // add data to the stream -> stream input
}

//results that will be sent from our viewmodel to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
