enum AlertType {
  success(lifetime: 3),
  error(lifetime: 3),
  warning(lifetime: 3),
  info(lifetime: 3),
  loading(lifetime: 25),
  idle(lifetime: 0);

  final int lifetime;

  const AlertType({required this.lifetime});
}
