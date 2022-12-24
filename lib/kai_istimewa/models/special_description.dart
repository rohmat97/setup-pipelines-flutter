class SpecialDescription {
  /*
  "deskripsi": "kerete berpenggerak sendiri yang dirancang untuk memenuhi kebutuhan perjalanan pelanggan yang ingin memiliki pengalaman perjalanan yang berbeda, dimana pelanggan bisa menikmati perjalanan sambil melihat langsung pemandangan dari ruang masinis",
  "fasilitas": "Karaoke, Makan dan Minum, Ruang Rapat, Mini Bar, Toilet",
  "layanan": "Ruang Tunggu VIP, Sajian Makan, Aneka Kudapan, Sajian Minuman, Handuk Wajah, Karaoke, Film/Video, Crew Kabin VIP",
  "kapasitas": 40,
  "kisaran_biaya": 100000000
   */

  final String deskripsi;
  final String fasilitas;
  final String layanan;
  final int kapasitas;
  final int kisaranBiaya;

  SpecialDescription(this.deskripsi, this.fasilitas, this.layanan, this.kapasitas, this.kisaranBiaya);

  factory SpecialDescription.fromJson(json){
    return SpecialDescription(
      json["deskripsi"],
      json["fasilitas"],
      json["layanan"],
      json["kapasitas"],
      json["kisaran_biaya"],
    );
  }
}