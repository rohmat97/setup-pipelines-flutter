class TextFieldValidator {
  static dynamic validateEmail(String? value) {
    String pattern =
        // r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        // r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        // r"{0,253}[a-zA-Z0-9])?)*$";
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong!';
    } else if (!value.contains(regex)) {
      return 'Mohon masukkan email yang benar';
    }
    return null;
  }

  static dynamic isNotEmpty(String? value){
    if (value == null || value.isEmpty) {
      return 'Input tidak boleh kosong!';
    }
    return null;
  }

  static dynamic validatePhone(String? value) {
    // String pattern = r'(^(?:[08])?[0-9]{10,12}$)';
    // RegExp regExp =  RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Nomor Telepon tidak boleh kosong!';
    } else if (value.length < 10) {
      return 'Panjang digit nomor telepon tidak boleh kurang dari 10';
    } else if (value.length > 13) {
      return 'Panjang digit nomor telepon tidak boleh lebih dari 13';
    } else if (value.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Hanya boleh diisi angka!';
    } else if (value.startsWith(RegExp(r'\+?62|\8'))) {
      return 'Nomor telepon harus menggunakan 08';
    }
    return null;
  }

  static dynamic isNotEmptyName(String fullName) {
    if (fullName == "" || fullName.isEmpty) {
      return "Nama lengkap tidak boleh kosong!";
    }
    return null;
  }

  static dynamic phoneOrEmail(String? value) {
    // String phonePattern = r"\[0-9]{10,12}";
    // RegExp regExpPhone =  RegExp(phonePattern);

    // String emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]";
    // RegExp regExpEmail =  RegExp(emailPattern);

    if (value == null || value.isEmpty) {
      return "Mohon masukkan nomor telepon atau email!";
    } else if (value.startsWith(RegExp(r'\+?62|\8'))) {
      return 'Format nomor telepon tidak sesuai';
    } else if (value.startsWith(RegExp(r"[a-zA-Z]")) && !value.contains(RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z]"))) {
      return 'Format email tidak sesuai';
    }
    return null;
  }

  static dynamic passwordIsEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Password tidak boleh kosong!";
    } else if (value.length < 8) {
      return "Minimal Password 8 karakter";
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Minimal mengandung 1 huruf kapital";
    }  else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Minimal mengandung 1 digit angka";
    }
    return null;
  }

}