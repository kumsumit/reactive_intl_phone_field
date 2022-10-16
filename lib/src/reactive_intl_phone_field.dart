// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveIntlPhoneField] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [ReactiveIntlPhoneField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveIntlPhoneField<T, V> extends ReactiveFormField<T, V> {
  /// Creates a [ReactiveIntlPhoneField] that contains a [TextField].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveIntlPhoneField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveIntlPhoneField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveIntlPhoneField(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveIntlPhoneField(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [TextField], the constructor.
  ReactiveIntlPhoneField({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, V>? valueAccessor,
    ShowErrorsFunction? showErrors,
    required this.stringify,
    // Duration debounceDuration = const Duration(milliseconds: 300),
    // WidgetBuilder? loadingBuilder,
    // WidgetBuilder? noItemsFoundBuilder,
    // double animationStart = 0.25,
    // Duration animationDuration = const Duration(milliseconds: 500),
    // bool getImmediateSuggestions = false,
    // double suggestionsBoxVerticalOffset = 5.0,
    // AxisDirection direction = AxisDirection.down,
    // bool hideOnLoading = false,
    // bool hideOnEmpty = false,
    // bool hideOnError = false,
    // bool hideSuggestionsOnKeyboardHide = true,
    // bool keepSuggestionsOnLoading = true,
    // bool keepSuggestionsOnSuggestionSelected = false,
    // bool autoFlipDirection = false,
    // bool hideKeyboard = false,
    // InputDecoration decoration = const InputDecoration(),
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    // TextStyle? style,
    // StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    // bool autofocus = false,
    // bool readOnly = false,
    // ToolbarOptions? toolbarOptions,
    // bool? showCursor,
    // bool obscureText = false,
    // String obscuringCharacter = '•',
    // bool autocorrect = true,
    required final SelectorConfig selectorConfig,
    final ValueChanged<PhoneNumber>? onInputChanged,
    final ValueChanged<bool>? onInputValidated,
    final VoidCallback? onSubmit,
    final ValueChanged<String>? onFieldSubmitted,
    final String? Function(String?)? validator,
    final ValueChanged<PhoneNumber>? onSaved,
    final Key? fieldKey,
    final TextEditingController? textFieldController,
    final TextInputAction? keyboardAction,
    final PhoneNumber? initialValue,
    final String? hintText,
    final Widget? label,
    final String? errorMessage,
    final Widget? selectorButtonBottomWidget,
    final Widget? betweenTextFieldWidget,
    // final int maxLength;
    required final bool formatInput,
    required final AutovalidateMode autoValidateMode,
    required final bool ignoreBlank,
    final String? locale,
    final TextStyle? textStyle,
    final TextStyle? selectorTextStyle,
    final TextStyle? flagStyle,
    final InputBorder? inputBorder,
    final InputDecoration? inputDecoration,
    final InputDecoration? searchBoxDecoration,
    final Color? cursorColor,
    final FocusNode? focusNode,
    final Iterable<String>? autofillHints,
    final List<String>? countries,

    /// Disable view Min/Max Length check
    required final bool disableLengthCheck,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactiveIntlPhoneFieldState<T, V>;
            final effectiveDecoration = inputDecoration ??
                const InputDecoration().applyDefaults(
                    Theme.of(state.context).inputDecorationTheme);
            state._setFocusNode(focusNode);
            final controller = textFieldController ?? state._textController;
            return InternationalPhoneNumberInput(
              keyboardType:
                  keyboardType ?? const TextInputType.numberWithOptions(),
              focusNode: state.focusNode,
              onInputChanged: onInputChanged,
              onInputValidated: onInputValidated,
              onSubmit: onSubmit,
              onFieldSubmitted: onFieldSubmitted,
              validator: validator,
              onSaved: onSaved,
              fieldKey: fieldKey,
              textFieldController: controller,
              keyboardAction: keyboardAction,
              inputDecoration: effectiveDecoration,
              searchBoxDecoration: searchBoxDecoration,
              initialValue: initialValue,
              locale: locale,
              textStyle: textStyle,
              flagStyle: flagStyle,
              selectorTextStyle: selectorTextStyle,
              inputBorder: inputBorder,
              cursorColor: cursorColor,
              autofillHints: autofillHints,
              countries: countries,
              selectorButtonBottomWidget: selectorButtonBottomWidget,
              betweenTextFieldWidget: betweenTextFieldWidget,
              label: label,
              textDirection: textDirection ?? TextDirection.ltr,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
            );
          },
        );

  final String Function(V value) stringify;

  @override
  ReactiveFormFieldState<T, V> createState() =>
      _ReactiveIntlPhoneFieldState<T, V>();
}

class _ReactiveIntlPhoneFieldState<T, V> extends ReactiveFormFieldState<T, V> {
  late TextEditingController _textController;
  FocusNode? _focusNode;
  late FocusController _focusController;

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();

    final initialValue = value;
    _textController = TextEditingController(
      text: initialValue == null
          ? ''
          : (widget as ReactiveIntlPhoneField<T, V>).stringify(initialValue),
    );
  }

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final effectiveValue = (value == null) ? '' : value.toString();
    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      selection: TextSelection.collapsed(offset: effectiveValue.length),
      composing: TextRange.empty,
    );

    super.onControlValueChanged(value);
  }

  // @override
  // ControlValueAccessor<T, V> selectValueAccessor() {
  //   if (control is FormControl<int>) {
  //     return IntValueAccessor() as ControlValueAccessor<T, String>;
  //   } else if (control is FormControl<double>) {
  //     return DoubleValueAccessor() as ControlValueAccessor<T, String>;
  //   } else if (control is FormControl<DateTime>) {
  //     return DateTimeValueAccessor() as ControlValueAccessor<T, String>;
  //   } else if (control is FormControl<TimeOfDay>) {
  //     return TimeOfDayValueAccessor() as ControlValueAccessor<T, String>;
  //   }
  //
  //   return super.selectValueAccessor();
  // }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }
}
