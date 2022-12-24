

class PhoneParser {

  static String normalize(phone) {
    phone = phone.trim();
    if (phone.startsWith('+62')) {
      phone = '0' + phone.slice(3);
    } else if (phone.startsWith('62')) {
      phone = '0' + phone.slice(2);
    }
    return phone.replace(RegExp(r"/[- .]/g"), '');
  }

  static bool isValid(phone) {
    phone = normalize(phone);
    return !(phone == null ||
        !RegExp(r"/^08[1-9][0-9]{7,10}$/").hasMatch(phone));
  }

  static String? getBrand(phone) {
    phone = normalize(phone);
    var prefix = phone.slice(0, 4);
    if (['0831', '0832', '0833', '0838'].contains(prefix)) return 'AXIS';
    if (['0895', '0896', '0897', '0898', '0899'].contains(prefix)) return 'THREE';
    if (['0817', '0818', '0819', '0859', '0878', '0877'].contains(prefix)) return 'XL';
    if (['0814', '0815', '0816', '0855', '0856', '0857', '0858'].contains(prefix)) return 'INDOSAT';
    if (['0812', '0813', '0852', '0853', '0821', '0823', '0822', '0851', '0811'].contains(prefix)) return 'TELKOMSEL';
    if (['0881', '0882', '0883', '0884', '0885', '0886', '0887', '0888', '0889'].contains(prefix)) return 'SMARTFREN';
    return null;
  }
}
