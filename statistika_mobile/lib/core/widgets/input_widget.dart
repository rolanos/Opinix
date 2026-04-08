import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:statistika_mobile/core/utils/utils.dart';

import '../constants/constants.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    required this.controller,
    this.isPassword = false,
    this.hintText,
    this.disableBorders = true,
    this.onTapOutside,
    this.focusNode,
    this.prefixIcon,
    this.aboveText,
    this.readOnly = false,
    this.textStyle,
  });

  final TextEditingController controller;

  final bool isPassword;

  final String? hintText;

  ///true - убирает границы
  final bool disableBorders;

  final FocusNode? focusNode;

  final void Function(PointerDownEvent)? onTapOutside;

  ///Иконка перед полем
  final String? prefixIcon;

  ///Текст над полем ввода
  final String? aboveText;

  final TextStyle? textStyle;

  final bool readOnly;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _obscure = false;

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside:
          widget.onTapOutside ?? (event) => widget.focusNode?.unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.aboveText != null)
            Text(
              widget.aboveText!,
              style: context.textTheme.bodySmall,
            ),
          TextFormField(
            focusNode: widget.focusNode,
            controller: widget.controller,
            style: widget.textStyle ?? context.textTheme.bodyLarge,
            textAlignVertical: TextAlignVertical.center,
            obscureText: _obscure,
            readOnly: widget.readOnly,
            decoration: InputDecoration(
              hintStyle: widget.textStyle ?? context.textTheme.bodyLarge,
              contentPadding: widget.disableBorders ? EdgeInsets.zero : null,
              isCollapsed: true,
              isDense: true,
              hintText: widget.hintText,
              border: widget.disableBorders ? InputBorder.none : null,
              errorBorder: widget.disableBorders ? InputBorder.none : null,
              enabledBorder: widget.disableBorders ? InputBorder.none : null,
              focusedBorder: widget.disableBorders ? InputBorder.none : null,
              disabledBorder: widget.disableBorders ? InputBorder.none : null,
              focusedErrorBorder:
                  widget.disableBorders ? InputBorder.none : null,
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 24,
                maxWidth: 24,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? SizedBox(
                      child: SvgPicture.asset(
                        widget.prefixIcon!,
                      ),
                    )
                  : null,
              suffixIcon: widget.isPassword
                  ? _VisiableIcon(
                      onTap: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      showPassword: _obscure,
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

class _VisiableIcon extends StatelessWidget {
  const _VisiableIcon({
    required this.showPassword,
    this.onTap,
  });

  final bool showPassword;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        showPassword ? Icons.visibility : Icons.visibility_off,
        color: AppColors.black,
      ),
    );
  }
}
