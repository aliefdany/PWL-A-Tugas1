use buku_pbd6maretsp;

select * from detail_buku;


-- SOAL NO 1 - Menambah data penulis
CREATE OR REPLACE PROCEDURE tambahPenulis(namaPenulis varchar(50))
BEGIN
    -- cek apakah penulis sudah terdaftar di database
    IF EXISTS(SELECT nama_penulis FROM penulis WHERE nama_penulis = namaPenulis) THEN
        SELECT 'Penulis sudah terdaftar' as error;
    ELSE
    -- cek apakah tidak memasukkan nama yang kosong ('')
        IF(namaPenulis = '') THEN
            SELECT 'Nama penulis tidak boleh kosong';
        ELSE
            INSERT INTO penulis (nama_penulis) VALUES (namaPenulis);
            SELECT CONCAT("Sukses memasukkan penulis ","'",namaPenulis,"'"," ke database") as success;
        END IF;
    END IF;
END

-- SOAL NO 2 - Mengetahui jumlah buku genre tertentu
CREATE OR REPLACE PROCEDURE jumlahBukuPerGenre(genreInput varchar(30))
BEGIN
    -- cek apakah genre buku tersedia
    IF EXISTS(SELECT genre FROM buku WHERE genre = genreInput) THEN
        SELECT SUM(d.stok) jumlahBuku FROM buku b 
        JOIN detail_buku d 
        ON b.id_buku = d.id_buku
        WHERE b.genre = genreInput;
    ELSE
        SELECT CONCAT("Tidak ada buku dengan genre ","'", genreInput,"'") AS error;
    END IF;
END

call tambahPenulis('James Clear')
call jumlahBukuPerGenre('')