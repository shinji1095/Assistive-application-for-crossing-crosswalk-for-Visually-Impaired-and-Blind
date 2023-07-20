import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_model.freezed.dart';

@freezed
class PageModel with _$PageModel {
  const PageModel._();
  const factory PageModel({
    @Default('') String email,
    @Default(false) bool isPolicyChecked,
    @Default([]) List<String> typeList,
  }) = _PageModel;


  PageModel updateEmail(String value) => copyWith(
    email: value
  );

  PageModel updateIsPolicyChecked(bool value) => copyWith(
      isPolicyChecked: value
  );

  PageModel updateTypeList(List<String> list) => copyWith(
      typeList: list
  );
}