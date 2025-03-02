part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}
final class ThemeisLight extends ThemeState {}
final class ThemeisDark extends ThemeState {}

