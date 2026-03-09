import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_constants.dart';
import '../../manager/sign_up_bloc.dart';
import '../../manager/sign_up_events.dart';
import '../../manager/sign_up_states.dart';

class RememberCheckBox extends StatelessWidget {
  const RememberCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.isPolicyAccepted != current.isPolicyAccepted,
      builder: (context, state) {
        final isRemember = state.isPolicyAccepted;
        return GestureDetector(
          onTap: () {
            context.read<SignUpBloc>().add(TogglePolicyEvent(!isRemember));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width:
                AppConstants.w * 0.045, // Slightly larger for better tap area
            height: AppConstants.w * 0.045,
            decoration: BoxDecoration(
              color: isRemember ? const Color(0xFFDC2626) : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isRemember
                    ? const Color(0xFFCE1126)
                    : const Color(0xFFD1D8DD),
                width: 1.5,
              ),
            ),
            child: AnimatedScale(
              scale: isRemember ? 1 : 0,
              duration: const Duration(milliseconds: 150),
              child: Icon(
                Icons.check,
                size: AppConstants.w * 0.035,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
