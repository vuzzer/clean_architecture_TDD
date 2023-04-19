// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_trivia.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NumberTrivia extends NumberTrivia {
  @override
  final int number;
  @override
  final String text;

  factory _$NumberTrivia([void Function(NumberTriviaBuilder)? updates]) =>
      (new NumberTriviaBuilder()..update(updates))._build();

  _$NumberTrivia._({required this.number, required this.text}) : super._() {
    BuiltValueNullFieldError.checkNotNull(number, r'NumberTrivia', 'number');
    BuiltValueNullFieldError.checkNotNull(text, r'NumberTrivia', 'text');
  }

  @override
  NumberTrivia rebuild(void Function(NumberTriviaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NumberTriviaBuilder toBuilder() => new NumberTriviaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NumberTrivia &&
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
    return (newBuiltValueToStringHelper(r'NumberTrivia')
          ..add('number', number)
          ..add('text', text))
        .toString();
  }
}

class NumberTriviaBuilder
    implements Builder<NumberTrivia, NumberTriviaBuilder>, TriviaBuilder {
  _$NumberTrivia? _$v;

  int? _number;
  int? get number => _$this._number;
  set number(covariant int? number) => _$this._number = number;

  String? _text;
  String? get text => _$this._text;
  set text(covariant String? text) => _$this._text = text;

  NumberTriviaBuilder();

  NumberTriviaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _number = $v.number;
      _text = $v.text;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant NumberTrivia other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NumberTrivia;
  }

  @override
  void update(void Function(NumberTriviaBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NumberTrivia build() => _build();

  _$NumberTrivia _build() {
    final _$result = _$v ??
        new _$NumberTrivia._(
            number: BuiltValueNullFieldError.checkNotNull(
                number, r'NumberTrivia', 'number'),
            text: BuiltValueNullFieldError.checkNotNull(
                text, r'NumberTrivia', 'text'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
