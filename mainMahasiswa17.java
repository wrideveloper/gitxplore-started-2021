import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;

public class mainMahasiswa17 {

    List<Mahasiswa17> mhs = new ArrayList<>();
    List<mataKuliah17> mk = new ArrayList<>();
    List<nilai17> nli = new ArrayList<>();
    static Scanner vian = new Scanner(System.in);

    public static void main(String[] args) {
        mainMahasiswa17 obj = new mainMahasiswa17();
        int input;
        obj.setData();
        do {
            System.out.println("***********************************************");
            System.out.println("SISTEM PENGOLAHAN DATA NILAI MAHASISWA SEMESTER");
            System.out.println("***********************************************");
            System.out.println("1. Input Nilai");
            System.out.println("2. Tampil Nilai");
            System.out.println("3. Mencari Nilai Mahasiswa");
            System.out.println("4. Urut Data Nilai");
            System.out.println("5. Keluar");
            System.out.println("***********************************************");
            System.out.print("Pilih	: ");
            input = vian.nextInt();

            if (input == 1) {
                obj.pilih1();
            } else if (input == 2) {
                obj.pilih2();
            } else if (input == 3) {
                obj.pilih3();
            } else if (input == 4) {
                obj.pilih4();
            } else {
                System.out.println("Anda Keluar dari Sistem.	");
            }
        } while (input >= 1 && input <= 4);
    }

    void setData() {
        mhs.add(new Mahasiswa17("20001", "Thalhah", "021xxx"));
        mhs.add(new Mahasiswa17("20002", "Zubair", "021xxx"));
        mhs.add(new Mahasiswa17("20003", "Abdur-Rahman", "021xxx"));
        mhs.add(new Mahasiswa17("20004", "Sa' ad", "021xxx"));
        mhs.add(new Mahasiswa17("20005", "Sa' id", "021xxx"));
        mhs.add(new Mahasiswa17("20006", "Ubaidah", "021xxx"));

        mk.add(new mataKuliah17("00001", "Internet of Things", "3"));
        mk.add(new mataKuliah17("00002", "Algoritma dan Struktur Data", "2"));
        mk.add(new mataKuliah17("00003", "Algoritma dan Pemrograman", "2"));
        mk.add(new mataKuliah17("00004", "Praktikum Algoritma dan Struktur Data", "3"));
        mk.add(new mataKuliah17("00005", "Praktikum Algoritma dan Pemrograman", "3"));
    }

    void pilih1() {
        vian.nextLine();
        System.out.println("Masukkan Data ");
        System.out.print("Kode	: ");
        String kode = vian.next();
        System.out.print("Nilai : ");
        float nilai = vian.nextFloat();
        System.out.println("");
        System.out.println("DAFTAR MAHASISWA");
        System.out.println("***********************************************");
        System.out.printf("%-15s	%-15s	%-14s\n", "NIM", "Nama", "Telf");
        for (Mahasiswa17 mahasiswa : mhs) {
            System.out.printf("%-15s	%-15s	%-14s\n", mahasiswa.nim, mahasiswa.nama, mahasiswa.notelp);

        }
        boolean ditemukan = true;
        String pilihmahasiswa;
        int konfirmasi2 = 0;
        do {
            System.out.print("Pilih Mahasiswa by NIM : ");
            pilihmahasiswa = vian.next();
            for (Mahasiswa17 mahasiswa : mhs) {
                if (pilihmahasiswa.equals(mahasiswa.nim)) {
                    ditemukan = false;
                    konfirmasi2++;
                }
            }
            if (konfirmasi2 == 0) {
                System.out.println("Data Kode NIM Tidak Ditemukan");
            }
        } while (ditemukan);
        System.out.println("");
        System.out.println("DAFTAR MATA KULIAH");
        System.out.println("***********************************************");
        System.out.printf("%-15s	%-40s	%-40s\n", "Kode", "Mata Kuliah", "SKS");
        for (mataKuliah17 matakuliah : mk) {
            System.out.printf("%-15s	%-40s	%-40s\n", matakuliah.kode,
                    matakuliah.nmMatkul, matakuliah.sks);
        }
        boolean ditemukan2 = true;
        String pilihmatakuliah;
        int konfirmasi = 0;
        do {
            System.out.print("Pilih Mata Kuliah by Kode : ");
            pilihmatakuliah = vian.next();
            for (mataKuliah17 mklh : mk) {
                if (pilihmatakuliah.equals(mklh.kode)) {
                    ditemukan2 = false;
                    konfirmasi++;

                }
            }
            if (konfirmasi == 0) {
                System.out.println("Data Kode Matakuliah Tidak Ditemukan");
            }
        } while (ditemukan2);
        nli.add(new nilai17(kode, nilai, pilihmatakuliah, pilihmahasiswa));
    }

    void pilih2() {
        System.out.println("NIM\tNama Mahasiswa\tMata Kuliah\t\t\tSKS\tNilai");
        nli.forEach(nilaisatuan -> {
            System.out.print(nilaisatuan.nimMhs + "\t");
            for (Mahasiswa17 mahasiswa : mhs) {
                if (mahasiswa.nim.equals(nilaisatuan.nimMhs)) {
                    System.out.print(mahasiswa.nama + "\t\t");
                }
            }
            for (mataKuliah17 matkul : mk) {
                if (matkul.kode.equals(nilaisatuan.kodeMatakul)) {
                    System.out.print(matkul.nmMatkul + "\t\t" + matkul.sks + "\t");
                }
            }
            System.out.println(nilaisatuan.nilai);
        });
    }

    void pilih3() {
        pilih2();
        System.out.print("Masukkan Data Mahasiswa[nim] : ");
        String cariNIM = vian.next();
        int konfirmasi3 = 0;
        System.out.println("DAFTAR NILAI MAHASISWA");
        System.out.println("***********************************************");
        System.out.println("NIM\t\tNama\t\tMata Kuliah\t\t\tSKS\tNilai");
        for (nilai17 carinilai : nli) {
            if (carinilai.nimMhs.equals(cariNIM)) {
                System.out.print(carinilai.nimMhs + "\t");
                for (Mahasiswa17 mahasiswa : mhs) {
                    if (mahasiswa.nim.equals(carinilai.nimMhs)) {
                        System.out.print(mahasiswa.nama + "\t");
                    }
                }
                for (mataKuliah17 matkul : mk) {
                    if (matkul.kode.equals(carinilai.kodeMatakul)) {
                        System.out.print(matkul.nmMatkul + "\t" + matkul.sks + "\t");
                    }
                }
                System.out.println(carinilai.nilai);
                konfirmasi3++;
            }

        }
        if (konfirmasi3 == 0) {
            System.out.println("Data Dengan NIM " + cariNIM + " Tidak Ditemukan");
        }
    }

    void pilih4() {
        for (int i = 0; i < nli.size() - 1; i++) {
            for (int j = 0; j < nli.size() - i - 1; j++) {
                if (nli.get(j).nilai > nli.get(j + 1).nilai) {
                    float swap = nli.get(j).nilai;
                    nli.get(j).nilai = nli.get(j + 1).nilai;
                    nli.get(j + 1).nilai = swap;
                }
            }
        }
        pilih2();
    }
}
