# CAPSTONE PROJECT - TETRIS PROGRAM

Repository ini adalah repository yang berisikan Capstone Project saya untuk Tetris Program Batch II pada tahun 2022. Topik yang saya ambil adalah Mengenai apakah Budget Cap dan Regulasi Baru di F1 akan tetap membuat Mercedes Overpower layaknya tim mereka sejak tahun 2014 silam. Prediksi saya ambil berdasarkan data dua balapan pertama pada musim 2022 yakni GP Bahrain dan GP Saudi Arabia, serta data mengenai persaingan konstruktor dan driver sejak dari tahun 2010 hingga 2021.

## Dashboard 
![dashboard](https://github.com/aldifp01/capstone-project/blob/main/CAPSTONE.png)

Dari data yang diperoleh, terlihat masing-masing waktu regulasi didominasi oleh salah satu tim seperti tahun 2010 hingga 2013 didominasi oleh Red Bull Racing. Kemudian, terjadi perubahan regulasi pada tahun 2014 dimana Mercedes mendominasi hingga tahun 2021. Dari segi pembalapnya sendiri juga didominasi oleh pembalap terbaik dari salah satu tim tersebut. Misalnya Sebastian Vettel menjadi juara dunia berturut-turut pada tahun 2010 hingga 2013. Kemudian diikuti oleh Lewis Hamilton yang menjadi juara dunia beruntun juga mulai dari tahun 2014 hingga tahun 2020 (kecuali tahun 2016 dimana dimenangkan oleh Nico Rosberg). Dominasi Mercedes mulai berhenti ketika Max Verstappen menjadi juara dunia Formula 1 pada tahun 2021 yang selisih pointnya sangat tipis dengan Lewis Hamilton. 

Pada tahun 2022 terjadi perubahan regulasi layaknya tahun-tahun sebelumnya. Terdapat beberapa perubahan utama yaitu:
1. Power Unit dibekukan hingga regulasi tahun berikutnya yakni tahun 2026
2. Terdapat dua bagian Pre-Season testing
3. Aturan pembuatan Aerodinamik yang semakin ketat
4. Budget Cap untuk semua tim, dimana dana yang boleh dikeluarkan hanya mencapai $140.000.000 saja
5. Format race week baru, dimana terdapat sprint race untuk beberapa sirkuit
6. Latihan wajib untuk rookie pada free practice
7. Terdapat regulasi ban baru

Berdasarkan data tim pada tahun 2022, supplier mesin atau Power Unit didominasi oleh Mercedes yang mencapai 4 tim, diikuti oleh Ferrari 3 tim, RBPT 3 tim, dan Renault 1 tim. Kemudian, berdasarkan hasil dua balapan pertama diperoleh hasil yang sangat memprihatinkan bagi Mercedes. Dari keempat tim yang menggunakan mesin Mercedes, tiga tim diantaranya hanya mampu berada di posisi juru kunci alias enam posisi terakhir. Sedangkan mesin Ferrari dan RBPT berada di top 4. Sehingga dapat diketahui bahwa mesin Mercedes sudah tidak mendominasi track balapan lagi setidaknya hingga tahun 2026, ditambah lagi konsep mobil Mercedes yang menekankan untuk tidak menggunakan pod atau zero-pod yang mana memiliki aerodinamik yang jauh kalah dibandingkan dengan kompetitornya.

## Library Yang Digunakan
- dplyr
- tidyr
- ggplot2
- plotly
- tidyverse
- Cairo

## Cara menjalankan di lokal
- Set path ke folder "Aldi Fianda Putra - Capstone Project" atau jika diclone maka folder yang terdapat file README.md ini
- Set as working directory
- Run semua kode yang ada di dalam rscript_capstone.R
- Catatan: Akan terdapat beberapa missing value, namun dibiarkan saja karena missing value disini berarti pembalap yang tidak berhasil menyelesaikan balapannya
