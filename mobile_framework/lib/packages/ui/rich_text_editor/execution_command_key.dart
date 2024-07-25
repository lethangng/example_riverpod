class ExecutionCommandKey {
  String rawKey;

  ExecutionCommandKey.noQuote(String value) : rawKey = value;

  ExecutionCommandKey.singleQuote(String value) : rawKey = "'$value'";
}
