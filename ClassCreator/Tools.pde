String getFileExtension(String s) {
  String extension = s.substring(s.lastIndexOf('.') + 1);
  println(extension);
  return extension;
}
