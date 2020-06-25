void main() {
  Future(() {
    return 'a';
  }).then((value) {
    print('$value');
  }).catchError((e) {
    print('$e');
  });
}
