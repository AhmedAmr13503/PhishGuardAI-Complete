// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScanModel _$ScanModelFromJson(Map<String, dynamic> json) {
  return _ScanModel.fromJson(json);
}

/// @nodoc
mixin _$ScanModel {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get verdict => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  @JsonKey(name: 'risk_level')
  String get riskLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'scanned_at')
  DateTime get scannedAt => throw _privateConstructorUsedError;
  String get engine => throw _privateConstructorUsedError;
  List<String> get signals => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScanModelCopyWith<ScanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanModelCopyWith<$Res> {
  factory $ScanModelCopyWith(ScanModel value, $Res Function(ScanModel) then) =
      _$ScanModelCopyWithImpl<$Res, ScanModel>;
  @useResult
  $Res call(
      {String id,
      String url,
      String verdict,
      double confidence,
      @JsonKey(name: 'risk_level') String riskLevel,
      @JsonKey(name: 'scanned_at') DateTime scannedAt,
      String engine,
      List<String> signals});
}

/// @nodoc
class _$ScanModelCopyWithImpl<$Res, $Val extends ScanModel>
    implements $ScanModelCopyWith<$Res> {
  _$ScanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? verdict = null,
    Object? confidence = null,
    Object? riskLevel = null,
    Object? scannedAt = null,
    Object? engine = null,
    Object? signals = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      verdict: null == verdict
          ? _value.verdict
          : verdict // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      scannedAt: null == scannedAt
          ? _value.scannedAt
          : scannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      engine: null == engine
          ? _value.engine
          : engine // ignore: cast_nullable_to_non_nullable
              as String,
      signals: null == signals
          ? _value.signals
          : signals // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScanModelImplCopyWith<$Res>
    implements $ScanModelCopyWith<$Res> {
  factory _$$ScanModelImplCopyWith(
          _$ScanModelImpl value, $Res Function(_$ScanModelImpl) then) =
      __$$ScanModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      String verdict,
      double confidence,
      @JsonKey(name: 'risk_level') String riskLevel,
      @JsonKey(name: 'scanned_at') DateTime scannedAt,
      String engine,
      List<String> signals});
}

/// @nodoc
class __$$ScanModelImplCopyWithImpl<$Res>
    extends _$ScanModelCopyWithImpl<$Res, _$ScanModelImpl>
    implements _$$ScanModelImplCopyWith<$Res> {
  __$$ScanModelImplCopyWithImpl(
      _$ScanModelImpl _value, $Res Function(_$ScanModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? verdict = null,
    Object? confidence = null,
    Object? riskLevel = null,
    Object? scannedAt = null,
    Object? engine = null,
    Object? signals = null,
  }) {
    return _then(_$ScanModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      verdict: null == verdict
          ? _value.verdict
          : verdict // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      scannedAt: null == scannedAt
          ? _value.scannedAt
          : scannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      engine: null == engine
          ? _value.engine
          : engine // ignore: cast_nullable_to_non_nullable
              as String,
      signals: null == signals
          ? _value._signals
          : signals // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScanModelImpl implements _ScanModel {
  const _$ScanModelImpl(
      {required this.id,
      required this.url,
      required this.verdict,
      required this.confidence,
      @JsonKey(name: 'risk_level') required this.riskLevel,
      @JsonKey(name: 'scanned_at') required this.scannedAt,
      this.engine = '',
      final List<String> signals = const <String>[]})
      : _signals = signals;

  factory _$ScanModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanModelImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String verdict;
  @override
  final double confidence;
  @override
  @JsonKey(name: 'risk_level')
  final String riskLevel;
  @override
  @JsonKey(name: 'scanned_at')
  final DateTime scannedAt;
  @override
  @JsonKey()
  final String engine;
  final List<String> _signals;
  @override
  @JsonKey()
  List<String> get signals {
    if (_signals is EqualUnmodifiableListView) return _signals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signals);
  }

  @override
  String toString() {
    return 'ScanModel(id: $id, url: $url, verdict: $verdict, confidence: $confidence, riskLevel: $riskLevel, scannedAt: $scannedAt, engine: $engine, signals: $signals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.verdict, verdict) || other.verdict == verdict) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.scannedAt, scannedAt) ||
                other.scannedAt == scannedAt) &&
            (identical(other.engine, engine) || other.engine == engine) &&
            const DeepCollectionEquality().equals(other._signals, _signals));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      url,
      verdict,
      confidence,
      riskLevel,
      scannedAt,
      engine,
      const DeepCollectionEquality().hash(_signals));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanModelImplCopyWith<_$ScanModelImpl> get copyWith =>
      __$$ScanModelImplCopyWithImpl<_$ScanModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanModelImplToJson(
      this,
    );
  }
}

abstract class _ScanModel implements ScanModel {
  const factory _ScanModel(
      {required final String id,
      required final String url,
      required final String verdict,
      required final double confidence,
      @JsonKey(name: 'risk_level') required final String riskLevel,
      @JsonKey(name: 'scanned_at') required final DateTime scannedAt,
      final String engine,
      final List<String> signals}) = _$ScanModelImpl;

  factory _ScanModel.fromJson(Map<String, dynamic> json) =
      _$ScanModelImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String get verdict;
  @override
  double get confidence;
  @override
  @JsonKey(name: 'risk_level')
  String get riskLevel;
  @override
  @JsonKey(name: 'scanned_at')
  DateTime get scannedAt;
  @override
  String get engine;
  @override
  List<String> get signals;
  @override
  @JsonKey(ignore: true)
  _$$ScanModelImplCopyWith<_$ScanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
