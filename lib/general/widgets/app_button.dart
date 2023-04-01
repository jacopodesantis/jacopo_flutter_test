import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function callback;
  final bool _isDark;
  final double? margin;
  final double? width;
  final bool isLoading;

  const AppButton(
    this.text,
    this.callback, {
    this.margin,
    this.width,
    this.isLoading = false,
    bool isDark = false,
    Key? key,
  })  : _isDark = isDark,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: 50,
      margin: EdgeInsets.only(top: margin ?? 20),
      child: OutlinedButton(
        onPressed: () => callback(),
        style: OutlinedButton.styleFrom(
          backgroundColor: _isDark
              ? Theme.of(context).disabledColor
              : Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
      ),
    );
  }
}
