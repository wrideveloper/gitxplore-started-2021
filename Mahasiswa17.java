public class Mahasiswa17 {

    String nim, nama, notelp;

    public Mahasiswa17() {
    }

    public Mahasiswa17(String nim, String nama, String notelp) {
        this.nim = nim;
        this.nama = nama;
        this.notelp = notelp;
    }

    @Override
    public String toString() {
        return "Mahasiswa{" + "nim=" + nim + ", nama=" + nama + ", notelp="
                + notelp + '}';
    }
}
