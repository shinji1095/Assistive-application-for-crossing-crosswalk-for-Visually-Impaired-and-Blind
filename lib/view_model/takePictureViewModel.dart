import 'package:app_a/models/page_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final takePictureViewModelProvider =
    StateNotifierProvider.autoDispose<PageViewModel, PageModel>(
        (ref)=>PageViewModel()
    );

class PageViewModel extends StateNotifier<PageModel>{
  PageViewModel()
      : emailController = TextEditingController(),
        super(const PageModel()){
    emailController.addListener(()=>updateEmail(emailController.text));
  }

  final TextEditingController emailController;

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  void updateEmail(String value){
    state = state.updateEmail(value);
  }

  void updateIsPolicyChecked(bool value){
    state = state.updateIsPolicyChecked(value);
  }

  void updateTypeList(String value){
    final listToUpdate = List.of(state.typeList);
    if(listToUpdate.contains(value)){
      listToUpdate.remove(value);
    }else{
      listToUpdate.add(value);
    }
    state = state.updateTypeList(listToUpdate);
  }
}