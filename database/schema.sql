CREATE TABLE destinations (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  category VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  tags JSON NULL,
  latitude DECIMAL(10,7) NOT NULL,
  longitude DECIMAL(10,7) NOT NULL,
  image_url VARCHAR(500) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE transport_modes (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(30) NOT NULL UNIQUE,
  name VARCHAR(80) NOT NULL,
  icon VARCHAR(40) NULL,
  color CHAR(7) NULL
) ENGINE=InnoDB;

CREATE TABLE routes (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  destination_id INT UNSIGNED NOT NULL,
  mode_id INT UNSIGNED NOT NULL,
  description VARCHAR(255) NOT NULL,
  fare VARCHAR(40) NOT NULL,
  duration_minutes SMALLINT UNSIGNED NOT NULL,
  CONSTRAINT fk_routes_destination FOREIGN KEY (destination_id) REFERENCES destinations(id) ON DELETE CASCADE,
  CONSTRAINT fk_routes_mode FOREIGN KEY (mode_id) REFERENCES transport_modes(id) ON DELETE RESTRICT,
  INDEX idx_routes_destination (destination_id),
  INDEX idx_routes_mode (mode_id)
) ENGINE=InnoDB;

INSERT INTO transport_modes (id, slug, name, icon, color) VALUES
(1,'bst','BST','bus','#1F2E45'), (2,'krl','KRL','train-front','#8C2F27'),
(3,'angkot','Angkot','car','#6B4226'), (4,'ojol','Ojol Last-mile','bike','#B9862F');

INSERT INTO destinations (id,name,category,description,tags,latitude,longitude,image_url) VALUES
(1,'Keraton Kasunanan Surakarta','Budaya & Sejarah','Istana resmi Kasunanan Surakarta, pusat budaya Jawa yang masih aktif digunakan.','["keraton","istana","budaya","sejarah","jawa","kerajaan"]',-7.5775,110.8291,'assets/images/keraton-surakarta.jpg'),
(2,'Pasar Klewer','Belanja','Pusat grosir batik terbesar di Solo, tepat di sisi barat Alun-alun Utara.','["pasar","belanja","batik","grosir","textile"]',-7.5732,110.8319,'assets/images/pasar-klewer.jpg'),
(3,'Taman Sriwedari','Rekreasi','Taman hiburan legendaris dengan gedung wayang orang dan area terbuka hijau.','["taman","rekreasi","hiburan","wayang","sriwedari"]',-7.5608,110.8345,'assets/images/taman-sriwedari.jpg'),
(4,'Kampung Batik Kauman','Budaya & Sejarah','Kampung wisata batik tertua di Solo dengan lorong-lorong rumah kolonial.','["kampung","batik","kauman","budaya","sejarah","kolonial"]',-7.5762,110.8273,'assets/images/kampung-batik-kauman.jpg'),
(5,'Masjid Agung Surakarta','Budaya & Sejarah','Masjid kerajaan yang berdiri sejak era Pakubuwono III, tepat di samping Pasar Klewer.','["masjid","agung","islam","kerajaan","pakubuwono","sejarah"]',-7.5741,110.8327,'assets/images/masjid-agung-surakarta.jpg'),
(6,'Gedung Wayang Orang Sriwedari','Rekreasi','Panggung wayang orang tertua di Indonesia, masih menggelar pertunjukan rutin.','["wayang","orang","sriwedari","teater","budaya","pertunjukan"]',-7.5605,110.8352,'assets/images/wayang-orang-sriwedari.jpg'),
(7,'Pura Mangkunegaran','Budaya & Sejarah','Pura berarsitektur Jawa-Eropa dengan koleksi sejarah Kadipaten Mangkunegaran.','["pura","mangkunegaran","budaya","sejarah","kerajaan","istana"]',-7.5686,110.8227,'assets/images/pura-mangkunegaran.jpg'),
(8,'Museum Batik Danar Hadi','Museum','Museum batik dengan koleksi kain tradisional Nusantara di dalam kompleks House of Danar Hadi.','["museum","batik","danar hadi","budaya","kain","sejarah"]',-7.5680,110.8143,'assets/images/museum-batik-danar-hadi.jpg'),
(9,'Museum Radya Pustaka','Museum','Museum tertua di Indonesia yang menyimpan naskah, arca, dan benda bersejarah Jawa.','["museum","radya pustaka","sejarah","budaya","naskah","arca"]',-7.5651,110.8125,'assets/images/museum-radya-pustaka.jpg'),
(10,'Benteng Vastenburg','Budaya & Sejarah','Benteng peninggalan kolonial di pusat kota yang kini menjadi ruang acara dan sejarah.','["benteng","vastenburg","sejarah","kolonial","landmark","kota"]',-7.5697,110.8311,'assets/images/benteng-vastenburg.jpg'),
(11,'Pasar Gede Harjonagoro','Belanja & Kuliner','Pasar tradisional ikonik untuk berburu jajanan, bahan segar, dan kuliner khas Solo.','["pasar gede","pasar","kuliner","jajanan","belanja","tradisional"]',-7.5693,110.8302,'assets/images/pasar-gede.jpg'),
(12,'Kampung Batik Laweyan','Belanja & Budaya','Kampung saudagar batik dengan workshop, toko kain, dan gang bersejarah yang khas.','["laweyan","kampung batik","batik","belanja","budaya","kampung wisata"]',-7.5688,110.7953,'assets/images/kampung-batik-laweyan.jpg'),
(13,'Taman Balekambang','Taman & Rekreasi','Taman kota bersejarah dengan ruang hijau, danau, serta area rekreasi keluarga.','["balekambang","taman","rekreasi","keluarga","ruang hijau","danau"]',-7.5542,110.8075,'assets/images/taman-balekambang.jpg'),
(14,'Solo Safari','Taman & Rekreasi','Destinasi edukasi satwa dan rekreasi keluarga dengan area jelajah yang interaktif.','["solo safari","kebun binatang","satwa","rekreasi","keluarga","edukasi"]',-7.5942,110.8654,'assets/images/solo-safari.jpg'),
(15,'Taman Cerdas Jebres','Taman & Rekreasi','Ruang edukasi dan bermain publik yang ramah keluarga di kawasan Jebres.','["taman cerdas","jebres","taman","edukasi","keluarga","rekreasi"]',-7.5596,110.8540,'assets/images/taman-cerdas-jebres.jpg'),
(16,'Galabo Solo','Kuliner','Sentra kuliner malam di pusat kota untuk menikmati hidangan khas Solo dan jajanan lokal.','["galabo","kuliner","kuliner malam","jajanan","makanan","street food"]',-7.5700,110.8290,'assets/images/galabo-solo.jpg'),
(17,'Gedung Djoeang 45','Budaya & Sejarah','Bangunan bersejarah dekat Benteng Vastenburg yang menjadi ruang kreatif dan kuliner.','["gedung djoeang","djoeang 45","sejarah","kolonial","kuliner","landmark"]',-7.5708,110.8304,'assets/images/gedung-djoeang-45.svg'),
(18,'Museum Keris Nusantara','Museum','Museum tematik yang mengenalkan keris sebagai warisan budaya dan karya seni Nusantara.','["museum keris","keris","museum","budaya","pusaka","nusantara"]',-7.5725,110.8129,'assets/images/museum-keris-nusantara.jpg');

-- Routes
INSERT INTO routes (destination_id,mode_id,description,fare,duration_minutes) VALUES
(1,1,'Koridor 2 - Kartasura ke Gladag','Rp 3.700',25),(1,3,'Jalur AC - Pasar Gede ke Gladag','Rp 5.000',20),(1,4,'Titik jemput terdekat ke Gladag','Rp 12rb-18rb',15),
(2,1,'Koridor 1 - Palur ke Klewer','Rp 3.700',30),(2,2,'Stasiun Purwosari ke lanjut angkot 10 menit','Rp 8.000',40),(2,4,'Titik jemput terdekat ke Klewer','Rp 10rb-15rb',12),
(3,1,'Koridor 2 - Kartasura ke Sriwedari','Rp 3.700',22),(3,3,'Jalur B - Gading ke Sriwedari','Rp 5.000',18),(3,4,'Titik jemput terdekat ke Sriwedari','Rp 9rb-14rb',10),
(4,1,'Koridor 1 - Palur ke Gladag, jalan kaki 5 menit','Rp 3.700',28),(4,4,'Titik jemput terdekat ke Kauman','Rp 10rb-16rb',13),
(5,1,'Koridor 2 - Kartasura ke Danar Hadi','Rp 3.700',24),(5,2,'Stasiun Purwosari ke lanjut jalan kaki 8 menit','Rp 8.000',35),(5,4,'Titik jemput terdekat ke Masjid Agung','Rp 9rb-14rb',12),
(6,1,'Koridor 1 - Palur ke Sriwedari','Rp 3.700',35),(6,3,'Jalur A - Gading ke Sriwedari','Rp 6.000',30),(6,4,'Titik jemput terdekat ke Sriwedari','Rp 9rb-14rb',10),
(7,1,'Koridor 1 - Palur ke Mangkunegaran','Rp 3.700',20),(7,2,'Stasiun Solo Balapan ke jalan kaki 12 menit','Rp 8.000',25),(7,4,'Titik jemput terdekat ke Mangkunegaran','Rp 10rb-16rb',10),
(8,1,'Koridor 2 - Kartasura ke Slamet Riyadi','Rp 3.700',24),(8,3,'Jalur kota - Pasar Gede ke Sriwedari','Rp 5.000',20),(8,4,'Titik jemput terdekat ke Danar Hadi','Rp 10rb-16rb',11),
(9,1,'Koridor 2 - Kartasura ke Sriwedari','Rp 3.700',22),(9,3,'Jalur B - Gading ke Sriwedari','Rp 5.000',18),(9,4,'Titik jemput terdekat ke Radya Pustaka','Rp 9rb-14rb',10),
(10,1,'Koridor 1 - Palur ke Gladag','Rp 3.700',25),(10,2,'Stasiun Solo Balapan ke lanjut BST','Rp 8.000',30),(10,4,'Titik jemput terdekat ke Vastenburg','Rp 10rb-15rb',12),
(11,1,'Koridor 1 - Palur ke Pasar Gede','Rp 3.700',27),(11,3,'Terminal Tirtonadi ke Pasar Gede','Rp 5.000',22),(11,4,'Titik jemput terdekat ke Pasar Gede','Rp 9rb-15rb',12),
(12,1,'Koridor 2 - Kartasura ke Laweyan','Rp 3.700',30),(12,3,'Jalur A - Gading ke Laweyan','Rp 5.000',25),(12,4,'Titik jemput terdekat ke Laweyan','Rp 12rb-18rb',14),
(13,1,'Koridor 1 - Palur ke Manahan','Rp 3.700',28),(13,3,'Pasar Gede ke Balekambang','Rp 5.000',24),(13,4,'Titik jemput terdekat ke Balekambang','Rp 10rb-16rb',13),
(14,1,'Koridor 3 - Terminal Tirtonadi ke Jurug','Rp 3.700',35),(14,3,'Jalur timur - Palur ke Jurug','Rp 6.000',30),(14,4,'Titik jemput terdekat ke Solo Safari','Rp 15rb-24rb',18),
(15,1,'Koridor 1 - Palur ke Jebres','Rp 3.700',25),(15,3,'Pasar Gede ke Jebres','Rp 5.000',20),(15,4,'Titik jemput terdekat ke Taman Cerdas','Rp 9rb-15rb',11),
(16,1,'Koridor 1 - Palur ke Gladag','Rp 3.700',25),(16,2,'Stasiun Solo Balapan ke lanjut BST','Rp 8.000',30),(16,4,'Titik jemput terdekat ke Galabo','Rp 9rb-14rb',10),
(17,1,'Koridor 1 - Palur ke Gladag','Rp 3.700',25),(17,3,'Pasar Gede ke Gladag','Rp 5.000',20),(17,4,'Titik jemput terdekat ke Gedung Djoeang','Rp 9rb-14rb',11),
(18,1,'Koridor 2 - Kartasura ke Sriwedari','Rp 3.700',22),(18,3,'Jalur B - Gading ke Sriwedari','Rp 5.000',18),(18,4,'Titik jemput terdekat ke Museum Keris','Rp 9rb-14rb',10);

-- Destinations 19-22
INSERT INTO destinations (id,name,category,description,tags,latitude,longitude,image_url) VALUES
(19,'Stadion Manahan Solo','Olahraga & Rekreasi','Stadion berstandar internasional dan ikon kota Solo, sering menggelar konser dan event besar.','["stadion","manahan","olahraga","konser","event","sepakbola"]',-7.5497,110.8084,'assets/images/stadion-manahan.jpg'),
(20,'Solo Grand Mall','Belanja','Pusat perbelanjaan modern di jantung kota Solo dengan beragam tenant fashion, kuliner, dan hiburan.','["mall","belanja","fashion","kuliner","hiburan","modern"]',-7.5580,110.8220,'assets/images/solo-grand-mall.jpg'),
(21,'Taman Satwa Taru Jurug','Taman & Rekreasi','Kebun binatang tertua di Solo dengan koleksi satwa dan area bermain keluarga di tepi Bengawan Solo.','["kebun binatang","jurug","satwa","taman","rekreasi","keluarga"]',-7.5530,110.8640,'assets/images/taman-jurug.jpg'),
(22,'Rumah Atsiri Indonesia','Wisata Edukasi','Museum dan taman tanaman aromatik interaktif dengan pemandangan indah khas pedesaan Solo.','["rumah atsiri","aromatik","museum","edukasi","taman","wisata"]',-7.6042,110.7153,'assets/images/rumah-atsiri.jpg');

-- Routes 19-22
INSERT INTO routes (destination_id,mode_id,description,fare,duration_minutes) VALUES
(19,1,'Koridor 1 - Palur ke Manahan','Rp 3.700',20),(19,3,'Pasar Gede ke Manahan','Rp 5.000',18),(19,4,'Titik jemput terdekat ke Manahan','Rp 9rb-14rb',10),
(20,1,'Koridor 2 - Kartasura ke SGM','Rp 3.700',18),(20,2,'Stasiun Solo Balapan jalan kaki 15 menit','Rp 8.000',25),(20,4,'Titik jemput terdekat ke SGM','Rp 8rb-13rb',8),
(21,1,'Koridor 3 - Terminal Tirtonadi ke Jurug','Rp 3.700',30),(21,3,'Jalur timur ke Jurug','Rp 5.000',25),(21,4,'Titik jemput terdekat ke Jurug','Rp 12rb-18rb',15),
(22,4,'Titik jemput terdekat ke Rumah Atsiri','Rp 20rb-30rb',30);
