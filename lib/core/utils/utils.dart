///  字符串是否为空
bool isNullOrBlank(String? data) {
  if (data == null) {
    return true;
  } else {
    return data.trim().isEmpty;
  }
}

/// 字符串不为空
bool isNotNullOrBlank(String? data) {
  return !isNullOrBlank(data);
}
