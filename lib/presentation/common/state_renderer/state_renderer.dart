import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miseo/data/mapper/mapper.dart';
import 'package:miseo/data/network/failure.dart';
import 'package:miseo/presentation/resources/assets_manager.dart';
import 'package:miseo/presentation/resources/color_manager.dart';
import 'package:miseo/presentation/resources/font_manager.dart';
import 'package:miseo/presentation/resources/strings_manager.dart';
import 'package:miseo/presentation/resources/styles_manager.dart';
import 'package:miseo/presentation/resources/values_manager.dart';

enum StateRendererType {
  //POPUP STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
 
  //FULLSCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,

  CONTENT_SCREEN_STATE, // the ui of the screen
  EMPTY_SCREEN_STATE // empty view when we receive no data from api site for list screen
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function? retryActionFunction;

  StateRenderer(
      {Key? key,
      required this.stateRendererType,
      Failure? failure,
      String? message,
      String? title,
      required this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context){
    switch(stateRendererType){
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(context,[_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context,[_getAnimatedImage(JsonAssets.error),_getMessage(message),_getRetryButton(AppStrings.ok, context)]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.loading),_getMessage(message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.error),_getMessage(message),_getRetryButton( AppStrings.retryAgain,context)]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.empty),_getMessage(message)]);
      default:
        return Container();
    }
  }

  Widget _getDialogContent(BuildContext context,List<Widget> children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }


  Widget _getPopUpDialog(BuildContext context,List<Widget> children){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: [BoxShadow(color: Colors.black26,blurRadius: AppSize.s12,offset: Offset(AppSize.s0,AppSize.s12),),]
        ),
        child: _getDialogContent(context,children),
      ),
    );
  }




  Widget _getRetryButton(String buttonTitle,BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(onPressed: (){
            if(stateRendererType == StateRendererType.FULL_SCREEN_ERROR_STATE){
              retryActionFunction?.call(); // to call the api function again to retry
            }else {
              Navigator.of(context).pop(); // Popup state Error --> dismiss the dialog
            }
          }, child: Text(buttonTitle ),),
        ),
      ),
    );  
  }


  Widget _getAnimatedImage(String animationName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName), 
    );
  }

    Widget _getMessage(String message){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(message,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children ,
      ),
    );
  }

}
