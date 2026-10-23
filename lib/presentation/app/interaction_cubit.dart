import 'package:flutter_base_project/presentation/app/interaction_state.dart';
import 'package:flutter_base_project/presentation/widgets/cubit/base_cubit.dart';
import 'package:flutter_base_project/domain/usecases/settings/get_haptic_enabled_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/set_haptic_enabled_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/get_sound_enabled_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/set_sound_enabled_use_case.dart';

class InteractionCubit extends BaseCubit<InteractionState> {
  final SetHapticEnabledUseCase _setHapticEnabled;
  final SetSoundEnabledUseCase _setSoundEnabled;

  InteractionCubit({
    required GetHapticEnabledUseCase getHapticEnabled,
    required SetHapticEnabledUseCase setHapticEnabled,
    required GetSoundEnabledUseCase getSoundEnabled,
    required SetSoundEnabledUseCase setSoundEnabled,
  }) : _setHapticEnabled = setHapticEnabled,
       _setSoundEnabled = setSoundEnabled,
       super(_loadInitialState(getHapticEnabled, getSoundEnabled));

  static InteractionState _loadInitialState(
    GetHapticEnabledUseCase getHapticEnabled,
    GetSoundEnabledUseCase getSoundEnabled,
  ) {
    final hapticEnabled = getHapticEnabled();
    final soundEnabled = getSoundEnabled();

    return InteractionState(
      hapticEnabled: hapticEnabled,
      soundEnabled: soundEnabled,
    );
  }

  void toggleHaptic() {
    final newValue = !state.hapticEnabled;
    _setHapticEnabled(newValue);
    safeEmit(state.copyWith(hapticEnabled: newValue));
  }

  void toggleSound() {
    final newValue = !state.soundEnabled;
    _setSoundEnabled(newValue);
    safeEmit(state.copyWith(soundEnabled: newValue));
  }
}
