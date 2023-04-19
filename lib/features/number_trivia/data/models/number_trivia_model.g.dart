// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_trivia_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NumberTriviaModel> _$numberTriviaModelSerializer =
    new _$NumberTriviaModelSerializer();

class _$NumberTriviaModelSerializer
    implements StructuredSerializer<NumberTriviaModel> {
  @override
  final Iterable<Type> types = const [NumberTriviaModel, _$NumberTriviaModel];
  @override
  final String wireName = 'NumberTriviaModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, NumberTriviaModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'number',
      serializers.serialize(object.number, specifiedType: const FullType(int)),
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  NumberTriviaModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NumberTriviaModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$NumberTriviaModel extends NumberTriviaModel {
  @override
  final int number;
  @override
  final String text;

  factory _$NumberTriviaModel(
          [void Function(NumberTriviaModelBuilder)? updates]) =>
      (new NumberTriviaModelBuilder()..update(updates))._build();

  _$NumberTriviaModel._({required this.number, required this.text})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        number, r'NumberTriviaModel', 'number');
    BuiltValueNullFieldError.checkNotNull(text, r'NumberTriviaModel', 'text');
  }

  @override
  NumberTriviaModel rebuild(void Function(NumberTriviaModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NumberTriviaModelBuilder toBuilder() =>
      new NumberTriviaModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NumberTriviaModel &&
        number == other.number &&
        text == other.text;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, number.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NumberTriviaModel')
          ..add('number', number)
          ..add('text', text))
        .toString();
  }
}

class NumberTriviaModelBuilder
    implements
        Builder<NumberTriviaModel, NumberTriviaModelBuilder>,
        TriviaBuilder {
  _$NumberTriviaModel? _$v;

  int? _number;
  int? get number => _$this._number;
  set number(covariant int? number) => _$this._number = number;

  String? _text;
  String? get text => _$this._text;
  set text(covariant String? text) => _$this._text = text;

  NumberTriviaModelBuilder();

  NumberTriviaModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _number = $v.number;
      _text = $v.text;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant NumberTriviaModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NumberTriviaModel;
  }

  @override
  void update(void Function(NumberTriviaModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NumberTriviaModel build() => _build();

  _$NumberTriviaModel _build() {
    final _$result = _$v ??
        new _$NumberTriviaModel._(
            number: BuiltValueNullFieldError.checkNotNull(
                number, r'NumberTriviaModel', 'number'),
            text: BuiltValueNullFieldError.checkNotNull(
                text, r'NumberTriviaModel', 'text'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
