CREATE TABLE `attraction` (
  `id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coverimage` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `attraction` (`id`, `name`, `detail`, `coverimage`, `latitude`, `longitude`) VALUES
(1, 'Phi Phi Islands', 'Phi Phi Islands are a group of islands in Thailand between the large island of Phuket and the Malacca Coastal Strait of Thailand.', 'https://www.melivecode.com/attractions/1.jpg', 7.737619, 98.7068755),
(2, 'Eiffel Tower', 'Eiffel Tower is one of the most famous structures in the world. Eiffel Tower is named after a leading French architect and engineer. It was built as a symbol of the World Fair in 1889.', 'https://www.melivecode.com/attractions/2.jpg', 48.8583736, 2.2922926),
(3, 'Times Square', 'Times Square has become a global landmark and has become a symbol of New York City. This is a result of Times Square being a modern, futuristic venue, with huge advertising screens dotting it', 'https://www.melivecode.com/attractions/3.jpg', 40.7589652, -73.9893574),
(4, 'Mount Fuji', 'Mount Fuji is the highest mountain in Japan, about 3,776 meters (12,388 feet) situated to the west of Tokyo. Mount Fuji can be seen from Tokyo on clear days.', 'https://www.melivecode.com/attractions/4.jpg', 35.3606422, 138.7186086),
(5, 'Big Ben', 'Westminster Palace Clock Tower which is most often referred to as Big Ben. This is actually the nickname for the largest bell that hangs in the vent above the clock face.', 'https://www.melivecode.com/attractions/5.jpg', 51.5007325, -0.1268141),
(6, 'Taj Mahal', 'The Taj Mahal or Tachomhal is a burial building made of ivory white marble. The Taj Mahal began to be built in 1632 and was completed in 1643.', 'https://www.melivecode.com/attractions/6.jpg', 27.1751496, 78.0399535),
(7, 'Stonehenge', 'Stonehenge is a monument prehistoric In the middle of a vast plain in the southern part of the British. The monument itself consists of 112 gigantic stone blocks arranged in 3 overlapping cir', 'https://www.melivecode.com/attractions/7.jpg', 51.1788853, -1.8284037),
(8, 'Statue of Liberty', 'The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States. The copper statue, a gift from the people of France to ', 'https://www.melivecode.com/attractions/8.jpg', 40.689167, -74.044444),
(9, 'Sydney Opera House', 'The Sydney Opera House is a multi-venue performing arts centre in Sydney. Located on the banks of the Sydney Harbour, it is often regarded as one of the most famous and distinctive buildings ', 'https://www.melivecode.com/attractions/9.jpg', -33.858611, 151.214167),
(10, 'Great Pyramid of Giza', 'The Great Pyramid of Giza is the oldest and largest of the pyramids in the Giza pyramid complex bordering present-day Giza in Greater Cairo, Egypt. It is the oldest of the Seven Wonders of th', 'https://www.melivecode.com/attractions/10.jpg', 29.979167, 31.134167),
(11, 'Hollywood Sign', 'The Hollywood Sign is an American landmark and cultural icon overlooking Hollywood, Los Angeles, California. It is situated on Mount Lee, in the Beachwood Canyon area of the Santa Monica Moun', 'https://www.melivecode.com/attractions/11.jpg', 34.134061, -118.321592),
(12, 'Wat Phra Kaew', 'Wat Phra Kaew, commonly known in English as the Temple of the Emerald Buddha and officially as Wat Phra Si Rattana Satsadaram, is regarded as the most sacred Buddhist temple in Thailand. The ', 'https://www.melivecode.com/attractions/12.jpg', 13.751389, 100.4925);


ALTER TABLE `attraction`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `attraction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
