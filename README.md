**MAIN:**  
Entry point dari aplikasi Flutter. Berikut yang terjadi secara berurutan:
Fungsi main() dipanggil pertama kali saat aplikasi dijalankan.

initialRoute: '/' menentukan halaman pertama yang ditampilkan ketika aplikasi dibuka, yaitu / (LoginPage).  
Bagian routes: adalah peta rute (route mapping) yang berfungsi menghubungkan nama rute dengan halaman tertentu.  
Setiap rute berupa pasangan:  
'/': (context) => const LoginPage()  
'/home': (context) => const HomePage()  
'/huntersNote': (context) => const HuntersNote()  
'/about': (context) => const AboutPage()  
'/addEntry': (context) => const AddEntry()  
'/deleteEntry': (context) => const DeleteEntry()  
Ketika aplikasi melakukan navigasi dengan Navigator.pushNamed(context, '/home'), Flutter akan memanggil halaman yang sesuai berdasarkan peta rute ini.

**LOGIN:**  
Halaman LoginPage berfungsi sebagai tampilan untuk proses login pengguna. Dua TextField digunakan untuk menerima input username dan password, lalu ketika tombol login ditekan, aplikasi memeriksa apakah keduanya bernilai “admin”. Jika sesuai, username disimpan ke dalam penyimpanan lokal menggunakan SharedPreferences, pesan konfirmasi ditampilkan, dan pengguna diarahkan ke halaman HuntersNote yang berperan sebagai home page. Jika tidak sesuai, dialog peringatan muncul untuk memberitahukan bahwa kredensial salah.

**HUNTER'S NOTE:**  
Pada halaman HuntersNote, aplikasi menampilkan daftar catatan monster yang dimiliki pengguna. Saat halaman pertama kali dibuka, program memuat nama pengguna yang tersimpan pada local storage menggunakan SharedPreferences, kemudian memuat daftar data monster. Aplikasi memiliki tiga entri monster bawaan yang selalu ditampilkan. Selain itu, jika pengguna pernah menambah entri baru, data tersebut akan dibaca dari penyimpanan lokal, lalu digabungkan dengan daftar bawaan.

Setiap entri monster disimpan dalam bentuk map yang diubah menjadi JSON, sehingga dapat disimpan dan dibaca kembali melalui SharedPreferences. Dalam tampilan, setiap monster ditampilkan menggunakan card yang memuat nama, habitat, kelemahan, dan deskripsi. Untuk monster yang ditambahkan oleh pengguna, tersedia tombol hapus. Ketika tombol tersebut dipilih, aplikasi akan menampilkan dialog konfirmasi sebelum menghapus data dari penyimpanan. Halaman ini juga menampilkan pesan sambutan acak yang menggunakan nama pengguna, dan menyediakan tombol untuk menuju halaman penambahan entri baru.

**ADD ENTRY**  
Halaman AddEntry digunakan untuk menambahkan catatan monster baru ke dalam penyimpanan lokal aplikasi. Pada halaman ini, terdapat beberapa TextField yang berfungsi mengumpulkan data nama monster, habitat, kelemahan, serta deskripsinya. Ketika tombol “Save Entry” ditekan, program pertama-tama memeriksa apakah seluruh kolom telah diisi. Jika ada yang kosong, pengguna akan menerima peringatan melalui dialog. Jika semua data lengkap, sistem menyimpan entri tersebut ke dalam SharedPreferences dalam bentuk JSON, sekaligus memberikan identitas unik untuk setiap data yang ditambahkan. Setelah penyimpanan berhasil, aplikasi menampilkan pesan konfirmasi, lalu mengarahkan pengguna kembali ke halaman daftar catatan monster.

**ABOUT**  
Halaman AboutPage menampilkan informasi mengenai tujuan aplikasi. Tampilan menggunakan Scaffold dengan AppBar dan Side Menu, serta latar belakang yang konsisten dengan tema aplikasi. Pada bagian isi halaman, terdapat teks yang terpusat dan diberi jarak menggunakan Padding. Teks tersebut menjelaskan bahwa aplikasi berfungsi sebagai jurnal pribadi bagi pemburu untuk mencatat informasi monster, seperti habitat dan kelemahannya, serta mendukung pengguna dalam menyimpan catatan dan perkembangan perburuan.
