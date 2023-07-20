// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PageModel {
  String get email => throw _privateConstructorUsedError;
  bool get isPolicyChecked => throw _privateConstructorUsedError;
  List<String> get typeList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PageModelCopyWith<PageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageModelCopyWith<$Res> {
  factory $PageModelCopyWith(PageModel value, $Res Function(PageModel) then) =
      _$PageModelCopyWithImpl<$Res, PageModel>;
  @useResult
  $Res call({String email, bool isPolicyChecked, List<String> typeList});
}

/// @nodoc
class _$PageModelCopyWithImpl<$Res, $Val extends PageModel>
    implements $PageModelCopyWith<$Res> {
  _$PageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? isPolicyChecked = null,
    Object? typeList = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isPolicyChecked: null == isPolicyChecked
          ? _value.isPolicyChecked
          : isPolicyChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      typeList: null == typeList
          ? _value.typeList
          : typeList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PageModelCopyWith<$Res> implements $PageModelCopyWith<$Res> {
  factory _$$_PageModelCopyWith(
          _$_PageModel value, $Res Function(_$_PageModel) then) =
      __$$_PageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, bool isPolicyChecked, List<String> typeList});
}

/// @nodoc
class __$$_PageModelCopyWithImpl<$Res>
    extends _$PageModelCopyWithImpl<$Res, _$_PageModel>
    implements _$$_PageModelCopyWith<$Res> {
  __$$_PageModelCopyWithImpl(
      _$_PageModel _value, $Res Function(_$_PageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? isPolicyChecked = null,
    Object? typeList = null,
  }) {
    return _then(_$_PageModel(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isPolicyChecked: null == isPolicyChecked
          ? _value.isPolicyChecked
          : isPolicyChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      typeList: null == typeList
          ? _value._typeList
          : typeList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_PageModel extends _PageModel {
  const _$_PageModel(
      {this.email = '',
      this.isPolicyChecked = false,
      final List<String> typeList = const []})
      : _typeList = typeList,
        super._();

  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final bool isPolicyChecked;
  final List<String> _typeList;
  @override
  @JsonKey()
  List<String> get typeList {
    if (_typeList is EqualUnmodifiableListView) return _typeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeList);
  }

  @override
  String toString() {
    return 'PageModel(email: $email, isPolicyChecked: $isPolicyChecked, typeList: $typeList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PageModel &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isPolicyChecked, isPolicyChecked) ||
                other.isPolicyChecked == isPolicyChecked) &&
            const DeepCollectionEquality().equals(other._typeList, _typeList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, isPolicyChecked,
      const DeepCollectionEquality().hash(_typeList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PageModelCopyWith<_$_PageModel> get copyWith =>
      __$$_PageModelCopyWithImpl<_$_PageModel>(this, _$identity);
}

abstract class _PageModel extends PageModel {
  const factory _PageModel(
      {final String email,
      final bool isPolicyChecked,
      final List<String> typeList}) = _$_PageModel;
  const _PageModel._() : super._();

  @override
  String get email;
  @override
  bool get isPolicyChecked;
  @override
  List<String> get typeList;
  @override
  @JsonKey(ignore: true)
  _$$_PageModelCopyWith<_$_PageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
