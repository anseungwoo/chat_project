import 'package:flutter/cupertino.dart';

class PageProvider extends ChangeNotifier{
  int _pageIndex;
  PageController _pageController;

  PageProvider(){
    this._pageIndex=0;
    this._pageController=PageController(initialPage: 0);
  }
  get pageIndex => _pageIndex;
  get pageController => _pageController;

  void setPageIndex(int index){
    if(_pageIndex!= index) {
      _pageIndex = index;
    }
    if(_pageController.page.toInt() != _pageIndex){
      _pageController.jumpToPage(_pageIndex);
    }
    notifyListeners() ;
  }

  void OnPagechaged(int index){
    _pageIndex = index;
    notifyListeners() ;
  }


}