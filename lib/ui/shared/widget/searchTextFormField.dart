import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextFormField extends StatelessWidget {
   SearchTextFormField({
    Key? key,
    required this.searchController,
    required this.onPressed,
    required this.onChange,
  }) : super(key: key);

  final TextEditingController searchController;
  final void Function()? onPressed;
  void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: 303.w,
      child: TextFormField(
        onChanged: onChange,
          cursorColor: const Color(0xFF21AA93),
          controller: searchController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF3B3B3B),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none
            ),
            suffixIconColor: const Color(0xFF21AA93),
            hintText: "Search by the keyword..." ,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            hintStyle: const TextStyle( color: Color(0xFFBDBDBD),),
            suffixIcon: IconButton(onPressed: onPressed, icon: const Icon(Icons.cancel_outlined, color: Colors.white,)),
          )
      ),
    );
  }
}
