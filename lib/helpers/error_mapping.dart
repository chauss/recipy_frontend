String errorMessageFor(String error) {
  if (error.contains("Connection refused")) {
    return "Server konnte nicht erreicht werden.";
  }
  return error;
}
