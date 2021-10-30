<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Inventaris SMKN 6 Malang</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: OnePage - v4.1.0
  * Template URL: https://bootstrapmade.com/onepage-multipurpose-bootstrap-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center justify-content-between">

      <h1 class="logo"><a href="index.php">Inventaris</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto active" href="#hero">Home</a></li>
          <li><a class="nav-link scrollto" href="#inventaris">Inventaris</a></li>
          <li><a class="nav-link scrollto" href="#pegawai">Pegawai</a></li>
          <li><a class="nav-link scrollto o" href="#peminjaman">Peminjaman</a></li>
          <li><a class="nav-link scrollto" href="#biodata">Biodata</a></li>
          <li><a class="getstarted scrollto" href="login.php">Login</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

    </div>
  </header><!-- End Header -->

  <!-- ======= Hero Section ======= -->
  <section id="hero" class="d-flex align-items-center">
    <div class="container position-relative" data-aos="fade-up" data-aos-delay="100">
      <div class="row justify-content-center">
        <div class="col-xl-7 col-lg-9 text-center">
          <h1>INVENTARIS LABORATORIUM KOMPUTER SEKOLAH</h1>
          <h2>Silahkan login untuk fitur lebih</h2>
        </div>
      </div>
      <div class="text-center">
        
        



      </div>
      </div>
  </section><!-- End Hero -->

  <main id="main">

    <!-- ======= About Section ======= -->
    <section id="inventaris" class="about">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Daftar Inventaris</h2>
          <form method="post">
          <input type="text" name="nt" placeholder="Masukkan Nama Barang">
          <input type="submit" name="caribrg" value="cari" action="index.php?=#inventaris">

                              
    <table class="table-bordered table-striped" align="center" border=3>
      <tr align="center">
        <td bgcolor="orange"> ID Inventaris </td>
        <td bgcolor="orange"> Nama Barang</td>
        <td bgcolor="orange"> Merk </td>
        <td bgcolor="orange"> Kondisi </td>
        <td bgcolor="orange"> Stok </td>
      </tr>
<?php
  include "koneksi.php"; //memanggil dan menjalankan file koneksi.php
  if(!ISSET($_POST['caribrg'])){
  $query=mysqli_query($connect, "SELECT * FROM inventaris");
  while($row=mysqli_fetch_array($query))
    {
?>
  <form method='GET'>
  <tr align="center">
    <td> <?php echo "$row[0]"; ?> </td>
    <td> <?php echo "$row[1]"; ?> </td>
    <td> <?php echo "$row[2]"; ?> </td>
    <td> <?php echo "$row[3]"; ?> </td>
    <td> <?php echo "$row[4]"; ?> </td>
  </tr>
  </form>
  <?php
    }
  }
  ?>


                          <?php if (ISSET($_POST['caribrg'])){
                           $cari = $_POST['nt'];
                           $query2 = "SELECT * FROM inventaris WHERE nama_barang LIKE '%$cari%'";
                           
                           $sql = mysqli_query($connect, $query2);
                           while ($r = mysqli_fetch_array($sql)){
                            ?>
                          <tr>
                           <td><?php echo $r['id_inventaris']; ?></td>
                           <td><?php echo $r['nama_barang']; ?></td>
                           <td><?php echo $r['merk']; ?></td>
                           <td><?php echo $r['kondisi']; ?></td>
                           <td><?php echo $r['stok']; ?></td>
                          </tr>  
                           <?php }} ?>
</table>      
<p align="center"><a href="index.php?=#inventaris"> Tampilkan Semua </a></p>
</div>
        </div>
                        


    </section><!-- End Inventaris Section -->

   

    <!-- ======= Services Section ======= -->
    <section id="pegawai" class="services section-bg">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Daftar Pegawai</h2>
          <form method="post">
          <input type="text" name="np" placeholder="Masukkan Nama Pegawai">
          <input type="submit" name="caripgw" value="cari" action="index.php?=#pegawai">


            
          <table class="table-bordered table-striped" align="center" border=3>
          <tr align="center">
            <td bgcolor="orange"> ID PEGAWAI </td>
            <td bgcolor="orange"> NAMA</td>
            <td bgcolor="orange"> NIP </td>
            <td bgcolor="orange"> ALAMAT </td>
          </tr>
<?php
  include "koneksi.php"; //memanggil dan menjalankan file koneksi.php
  if(!ISSET($_POST['caripgw'])){
  $query=mysqli_query($connect, "SELECT * FROM pegawai");
  while($row=mysqli_fetch_array($query))
    {
?>
  <form method='GET'>
  <tr align="center">
    <td> <?php echo "$row[0]"; ?> </td>
    <td> <?php echo "$row[1]"; ?> </td>
    <td> <?php echo "$row[2]"; ?> </td>
    <td> <?php echo "$row[3]"; ?> </td>
  </tr>
  </form>
  <?php
    }
  }
  ?>


<?php if (ISSET($_POST['caripgw'])){
                         $cari = $_POST['np'];
                         $query3 = "SELECT * FROM pegawai WHERE nama LIKE '%$cari%'";
                         
                         $sql = mysqli_query($connect, $query3);
                         while ($r = mysqli_fetch_array($sql)){
                          ?>
                        <tr>
                         <td><?php echo $r['id_pegawai']; ?></td>
                         <td><?php echo $r['nama']; ?></td>
                         <td><?php echo $r['nip']; ?></td>
                         <td><?php echo $r['alamat']; ?></td>
                        </tr>  
                         <?php }} ?>
</table>
<p align="center"><a href="index.php?=#peminjaman"> Tampilkan Semua </a></p>



        </div>
      </div>
    </section><!-- End Sevices Section -->


    <!-- ======= Peminjaman Section ======= -->
    <section id="peminjaman" class="services section-bg">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Riwayat Peminjaman</h2>
          <form method="post">
          <input type="text" name="npj" placeholder="Masukkan ID Peminjaman">
          <input type="submit" name="caripmj" value="cari" action="index.php?=#peminjaman">

          <table align="center" border=3>
          
  <tr align="center">
  <td bgcolor="orange"> ID Pinjam </td>
    <td bgcolor="orange"> ID Pegawai</td>
    <td bgcolor="orange"> ID Inventaris </td>
    <td bgcolor="orange"> Tanggal Pinjam </td>
    <td bgcolor="orange"> Tanggal Kembali </td>
    <td bgcolor="orange"> Lama Pinjam (hari) </td>
  </tr>
<?php
  include "koneksi.php"; //memanggil dan menjalankan file koneksi.php
  if(!ISSET($_POST['caripmj'])){
  $query=mysqli_query($connect, "SELECT * FROM peminjaman");
  while($row=mysqli_fetch_array($query))
    {
?>
  <form method='GET'>
  <tr align="center">
    <td> <?php echo "$row[0]"; ?> </td>
    <td> <?php echo "$row[1]"; ?> </td>
    <td> <?php echo "$row[2]"; ?> </td>
    <td> <?php echo "$row[3]"; ?> </td>
    <td> <?php echo "$row[4]"; ?> </td>
    <td> <?php echo "$row[5]"; ?> </td>
  </tr>
  </form>
  <?php
    }
  }
  ?>

<?php if (ISSET($_POST['caripmj'])){
                           $cari = $_POST['npj'];
                           $query2 = "SELECT * FROM peminjaman WHERE id_peminjaman LIKE '%$cari%'";
                           
                           $sql = mysqli_query($connect, $query2);
                           while ($r = mysqli_fetch_array($sql)){
                            ?>
                          <tr>
                           <td><?php echo $r['id_peminjaman']; ?></td>
                           <td><?php echo $r['id_pegawai']; ?></td>
                           <td><?php echo $r['id_inventaris']; ?></td>
                           <td><?php echo $r['tgl_pinjam']; ?></td>
                           <td><?php echo $r['tgl_kembali']; ?></td>
                           <td><?php echo $r['lama_pinjam']; ?></td>
                          </tr>  
                           <?php }} ?>

</table>
<p align="center"><a href="index.php?=#peminjaman"> Tampilkan Semua </a></p>


        </div>
      </div>
    </section><!-- End Peminjaman Section -->


    <!-- ======= Contact Section ======= -->
    <section id="biodata" class="contact">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Profil</h2>
          
          <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100">
            <div class="member">
              <div class="member-img">
                <img src="assets/img/team/team-1.jpg" class="img-fluid" alt="">
                <div class="social">
                  <a href=""><i class="bi bi-twitter"></i></a>
                  <a href=""><i class="bi bi-facebook"></i></a>
                  <a href=""><i class="bi bi-instagram"></i></a>
                  <a href=""><i class="bi bi-linkedin"></i></a>
                </div>
              </div>
              <div class="member-info">
                <h4>Miko Yusrizal Fahreza</h4>
                <span>XII RPL 2</span>
              </div>
            </div>
          </div>

        </div>

        <div class="row mt-5">

          <div class="col-lg-4">
            <div class="info">
              <div class="address">
                <i class="bi bi-geo-alt"></i>
                <h4>Alamat:</h4>
                <p>Jalan Raya Kidal, Tumpang, Malang 65156</p>
              </div>

              <div class="email">
                <i class="bi bi-envelope"></i>
                <h4>Email:</h4>
                <p>mikoyusrizal@gmail.com</p>
              </div>

              <div class="phone">
                <i class="bi bi-phone"></i>
                <h4>Telepon:</h4>
                <p>+62 851 3586 3004</p>
              </div>

            </div>

          </div>

        </div>

      </div>
    </section><!-- End Contact Section -->

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
    <div class="container d-md-flex py-4">

      <div class="me-md-auto text-center text-md-start">
        <div class="copyright">
          &copy; Copyright <strong><span>OnePage</span></strong>. All Rights Reserved
        </div>
        <div class="credits">
          <!-- All the links in the footer should remain intact. -->
          <!-- You can delete the links only if you purchased the pro version. -->
          <!-- Licensing information: https://bootstrapmade.com/license/ -->
          <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/onepage-multipurpose-bootstrap-template/ -->
          Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
        </div>
      </div>
      <div class="social-links text-center text-md-right pt-3 pt-md-0">
        <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
        <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
        <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
        <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
        <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
      </div>
    </div>
  </footer><!-- End Footer -->

  <div id="preloader"></div>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/vendor/purecounter/purecounter.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>