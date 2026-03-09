import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/presentation/bloc/bloc.dart';
import '../login/presentation/bloc/loginEvents.dart';
import '../login/presentation/bloc/login_states.dart';

Widget buil_remember_mark() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return GestureDetector(
        onTap: () {
          context.read<LoginBloc>().add(
            SetRemember(isRemember: !state.isRemember),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: state.isRemember
                ? const Color(0xFFDC0000)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: state.isRemember
                  ? const Color(0xFFDC2626)
                  : Colors.grey.shade400,
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: state.isRemember
              ? const Icon(
                  Icons.check,
                  size: 12,
                  color: Colors.white,
                  // weight: 700, // Uncomment if using Material 3 icons
                )
              : null,
        ),
      );
    },
  );
}
