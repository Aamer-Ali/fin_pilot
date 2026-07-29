// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_expense_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddExpenseState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddExpenseState()';
}


}

/// @nodoc
class $AddExpenseStateCopyWith<$Res>  {
$AddExpenseStateCopyWith(AddExpenseState _, $Res Function(AddExpenseState) __);
}


/// Adds pattern-matching-related methods to [AddExpenseState].
extension AddExpenseStatePatterns on AddExpenseState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddExpenseInitial value)?  initial,TResult Function( AddExpenseSubmitting value)?  submitting,TResult Function( AddExpenseSuccess value)?  success,TResult Function( AddExpenseFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddExpenseInitial() when initial != null:
return initial(_that);case AddExpenseSubmitting() when submitting != null:
return submitting(_that);case AddExpenseSuccess() when success != null:
return success(_that);case AddExpenseFailure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddExpenseInitial value)  initial,required TResult Function( AddExpenseSubmitting value)  submitting,required TResult Function( AddExpenseSuccess value)  success,required TResult Function( AddExpenseFailure value)  failure,}){
final _that = this;
switch (_that) {
case AddExpenseInitial():
return initial(_that);case AddExpenseSubmitting():
return submitting(_that);case AddExpenseSuccess():
return success(_that);case AddExpenseFailure():
return failure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddExpenseInitial value)?  initial,TResult? Function( AddExpenseSubmitting value)?  submitting,TResult? Function( AddExpenseSuccess value)?  success,TResult? Function( AddExpenseFailure value)?  failure,}){
final _that = this;
switch (_that) {
case AddExpenseInitial() when initial != null:
return initial(_that);case AddExpenseSubmitting() when submitting != null:
return submitting(_that);case AddExpenseSuccess() when success != null:
return success(_that);case AddExpenseFailure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  submitting,TResult Function()?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AddExpenseInitial() when initial != null:
return initial();case AddExpenseSubmitting() when submitting != null:
return submitting();case AddExpenseSuccess() when success != null:
return success();case AddExpenseFailure() when failure != null:
return failure(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  submitting,required TResult Function()  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case AddExpenseInitial():
return initial();case AddExpenseSubmitting():
return submitting();case AddExpenseSuccess():
return success();case AddExpenseFailure():
return failure(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  submitting,TResult? Function()?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case AddExpenseInitial() when initial != null:
return initial();case AddExpenseSubmitting() when submitting != null:
return submitting();case AddExpenseSuccess() when success != null:
return success();case AddExpenseFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AddExpenseInitial implements AddExpenseState {
  const AddExpenseInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddExpenseState.initial()';
}


}




/// @nodoc


class AddExpenseSubmitting implements AddExpenseState {
  const AddExpenseSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddExpenseState.submitting()';
}


}




/// @nodoc


class AddExpenseSuccess implements AddExpenseState {
  const AddExpenseSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddExpenseState.success()';
}


}




/// @nodoc


class AddExpenseFailure implements AddExpenseState {
  const AddExpenseFailure(this.message);
  

 final  String message;

/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddExpenseFailureCopyWith<AddExpenseFailure> get copyWith => _$AddExpenseFailureCopyWithImpl<AddExpenseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AddExpenseState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $AddExpenseFailureCopyWith<$Res> implements $AddExpenseStateCopyWith<$Res> {
  factory $AddExpenseFailureCopyWith(AddExpenseFailure value, $Res Function(AddExpenseFailure) _then) = _$AddExpenseFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AddExpenseFailureCopyWithImpl<$Res>
    implements $AddExpenseFailureCopyWith<$Res> {
  _$AddExpenseFailureCopyWithImpl(this._self, this._then);

  final AddExpenseFailure _self;
  final $Res Function(AddExpenseFailure) _then;

/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AddExpenseFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
