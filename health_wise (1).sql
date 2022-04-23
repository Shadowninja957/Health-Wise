-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 23, 2022 at 01:16 AM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `health_wise`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
CREATE TABLE IF NOT EXISTS `appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `cancel` int(1) DEFAULT 0,
  `details` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
CREATE TABLE IF NOT EXISTS `doctors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `work_address` varchar(255) DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `work_number` varchar(100) DEFAULT NULL,
  `work_days` varchar(100) DEFAULT NULL,
  `work_hours` varchar(100) DEFAULT NULL,
  `speciality_id` int(11) DEFAULT NULL,
  `verified` int(1) DEFAULT 0,
  `location_lat` double DEFAULT NULL,
  `location_lng` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `speciality_id` (`speciality_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `user_id`, `first_name`, `last_name`, `date_of_birth`, `gender`, `work_address`, `email_address`, `work_number`, `work_days`, `work_hours`, `speciality_id`, `verified`, `location_lat`, `location_lng`, `created_at`, `updated_at`) VALUES
(1, 1, 'Janissa', 'Baksh', NULL, 'F', 'Couva Hospital', 'Janissabaksh@gmail.com', '779-9278', NULL, NULL, 6, 0, 10.405752383125494, -61.415466172172685, NULL, '2022-04-15 18:23:02'),
(2, 2, 'Sachin', 'Bidhesi', NULL, 'M', 'South West Regional Health Authority Administration', 'sach_rj@hotmail.com', '706-4030', NULL, NULL, 5, 0, 10.278304612718587, -61.468630616887225, NULL, NULL),
(3, 3, 'Kirin', 'Rambaran', NULL, NULL, 'Port of Spain General Hospital', 'kirin.rambaran@gmail.com', '476-6461', NULL, NULL, 19, 0, 10.661729090359918, -61.507411964765524, NULL, NULL),
(4, 4, 'Valmiki', 'Seecheran', NULL, 'M', 'Eric Williams Medical Sciences Complex', 'vseecheran@gmail.com', '704-0276', NULL, NULL, 7, 0, 10.646961898549742, -61.42390496052942, NULL, '2022-04-15 18:38:05'),
(5, 5, 'Devan', 'Ramnarine', NULL, NULL, 'Eric Williams Medical Services Complex', 'Devan.ramnarine95@gmail.com', '745-9922', NULL, NULL, 7, 0, 10.646961898549742, -61.42390496052942, NULL, NULL),
(6, 7, 'Test', 'Doctor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_hours`
--

DROP TABLE IF EXISTS `doctor_hours`;
CREATE TABLE IF NOT EXISTS `doctor_hours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) DEFAULT NULL,
  `day` int(11) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctor_hours`
--

INSERT INTO `doctor_hours` (`id`, `doctor_id`, `day`, `start_time`, `end_time`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '08:00:00', '16:00:00', '2022-04-18 22:37:45', '2022-04-18 22:37:45'),
(2, 1, 2, '08:00:00', '16:00:00', '2022-04-18 22:37:54', '2022-04-18 22:37:54'),
(3, 1, 3, '08:00:00', '16:00:00', '2022-04-18 22:37:59', '2022-04-18 22:37:59'),
(4, 1, 4, '08:00:00', '16:00:00', '2022-04-18 22:38:04', '2022-04-18 22:38:04'),
(5, 1, 5, '08:00:00', '16:00:00', '2022-04-18 22:38:12', '2022-04-18 22:38:12');

-- --------------------------------------------------------

--
-- Table structure for table `medical_conditions`
--

DROP TABLE IF EXISTS `medical_conditions`;
CREATE TABLE IF NOT EXISTS `medical_conditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis` varchar(255) DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `description` text NOT NULL,
  `speciality_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medical_conditions`
--

INSERT INTO `medical_conditions` (`id`, `diagnosis`, `symptoms`, `description`, `speciality_id`, `created_at`, `updated_at`) VALUES
(1, 'Acne', 'Whiteheads (closed plugged pores), Blackheads (open plugged pores),Small red, tender bumps (papules),Pimples (pustules), which are papules with pus at their tips, Large, solid, painful lumps under the skin (nodules), Painful, pus-filled lumps under the skin (cystic lesions)', 'Acne is a common skin condition where the pores of your skin become blocked by hair, sebum (an oily substance), bacteria and dead skin cells. Those blockages produce blackheads, whiteheads, nodules and other types of pimples. If you have acne, know you’re not alone. It’s the most common skin condition that people experience. It’s estimated that 80% of people ages 11 to 30 will have at least a mild form of acne, and most people are affected by it at some point in their lives. ', NULL, '2022-04-15 15:16:46', '2022-04-15 15:16:46'),
(2, 'Cold Sore', 'Tingling and itching. Many people feel itching, burning or tingling around the lips for a day or so before a small, hard, painful spot appears and blisters erupt., Blisters. Small fluid-filled blisters typically erupt along the border of your lips. Sometimes they appear around the nose or cheeks or inside the mouth., Oozing and crusting. The small blisters may merge and then burst, leaving shallow open sores that ooze and crust over.', 'Cold sores — also called fever blisters — are a common viral infection. They are tiny, fluid-filled blisters on and around your lips. These blisters are often grouped together in patches. After the blisters break, a scab forms that can last several days. Cold sores usually heal in two to three weeks without leaving a scar.', NULL, '2022-04-15 15:19:10', '2022-04-15 15:19:10'),
(3, 'Blister', 'Blood blisters: You can get blood blisters when something pinches your skin. Instead of clear liquid, blood floods the area from broken blood vessels and damage to the lower layers of the skin. The blood pools and forms a blister., Friction blisters: Caused by rubbing on the skin, friction blisters form when clear fluid builds up in the upper layers of skin. Many people get friction blisters from walking too much in poor-fitting shoes or by not wearing socks. You can also get them on your hands from holding things like shovels or other tools., Heat blisters: You can get these blisters from burns or sunburns. They may also form after you warm up from frostbite. Blistering skin is part of a second-degree burn.', 'Your skin consists of three layers: the epidermis, the dermis and subcutaneous (below the skin) fat. A blister forms under the epidermis as a fluid-filled sac. Typically, it may be filled with clear liquid or blood, depending on the injury that damaged your skin. \r\nBlisters may be painful or itchy. If a blister gets infected, it will fill with milky-white pus. Blisters most often show up on the feet or hands, but they can appear anywhere on the body.\r\n', NULL, '2022-04-15 15:24:05', '2022-04-15 15:24:05'),
(4, 'Hives', 'Red, raised welts or bumps on the skin., Blanching (the center of the hive turns white when pressed)., Itchy skin., Swelling (angioedema).\r\n', 'Hives are raised red bumps (welts) or splotches on the skin. They are a type of swelling on the surface of your skin. They happen when your body has an allergic reaction to an allergen, a substance that’s harmless to most people. But can also occur in autoimmune conditions or systemic conditions, if hives last for a prolonged period of time.\r\nHives may be itchy, or you might feel them burning or stinging. They can be as small as a pinprick or as big as a dinner plate. The medical name for hives is urticaria.\r\nSometimes, the welts from hives join together to form larger areas called plaques. Hives tend to fade within 24 hours, although they may be noticeable for several days or longer.\r\n', NULL, '2022-04-15 15:25:29', '2022-04-15 15:25:29'),
(5, 'Actinic Keratosis', 'Bleeding, Burning, stinging or itching, Dry, scaly lips, Hornlike skin growths that stick out (like an animal’s horn), Loss of color in the lips, Pain or tenderness\r\n', 'Actinic keratosis (AK) is a skin disorder that causes rough, scaly patches of skin. Another name for AK is solar keratosis. AK is a type of precancer, which means that if you don’t treat the condition, it could turn into cancer. Without treatment, AK can lead to a type of skin cancer called squamous cell carcinoma. ', NULL, '2022-04-19 02:04:59', '2022-04-19 02:04:59'),
(6, 'Rosacea', 'Flushing: Many people who have rosacea have a history of frequent blushing or flushing. The facial redness, which might come and go, often is the earliest sign of the disorder, Persistent redness: Persistent facial redness might resemble a blush or sunburn that does not go away, Bumps and pimples: Small red solid bumps or pus-filled pimples often develop. Sometimes the bumps might resemble acne, but blackheads are absent. Burning or stinging might be present, Visible blood vessels: Small blood vessels become visible on the skin of many people who have rosacea, Eye irritation: The eyes might be irritated, and appear watery or bloodshot in some people with rosacea. This condition, called ocular rosacea, can also involve styes as well as redness and swelling of the eyelids. Severe cases, if left untreated, can result in corneal damage and vision loss, Burning or stinging: Burning or stinging sensations might occur on the face, and itchiness or a feeling of tightness might also develop, Dry appearance: The central facial skin might be rough, and thus appear to be very dry, Plaques: Raised red patches (plaques) might develop without changes in the surrounding skin, Skin thickening: In some cases of rosacea, the skin might thicken and enlarge from excess tissue, resulting in a condition called rhinophyma. This condition often occurs on the nose, causing it to have a bulbous appearance, Swelling: Facial swelling (edema) can occur independently or can accompany other signs of rosacea, Signs beyond the face: Signs and symptoms might develop beyond the face, affecting areas including the neck, chest, scalp or ears', 'Rosacea is a common disorder that most usually affects facial skin. It causes redness on the nose, chin, cheeks and forehead. Over time, the redness may become more intense, taking on a ruddy appearance. Small blood vessels may become visible.\r\nIn some cases, rosacea can appear on the chest, ears, neck or scalp. If rosacea is not treated, red solid bumps and pus-filled pimples can develop. The disorder can cause the nose to take on a bulbous, swollen appearance called rhinophyma. Rosacea can affect the eyes, causing them to feel irritated and to appear bloodshot or watery. Styes may occur. This is called ocular rosacea.', NULL, '2022-04-19 02:08:34', '2022-04-19 02:08:34'),
(7, 'Carbuncle', 'Becomes painful: The area is sensitive, and it may itch before the boil forms, Fills with pus: It may feel squishy or firm, Grows in size: It usually starts smaller than a pencil eraser. It can grow as large as a golf ball, Has a yellow or white center (similar to a pimple): The skin around the center (“head”) is red and shiny, May “weep” or crust over: The boil may ooze pus as your body fights the infection, Might spread to other areas: The bacteria that caused the boil can spread to other parts of your body. You can also pass the infection to other people through close contact or by sharing towels or other personal items', 'A boil (or furuncle) is a pus-filled bump that develops in your skin. Carbuncles are clusters of several boils. Boils usually begin as red bumps, which quickly increase in size and fill with pus. Boils are usually caused by the bacteria Staphylococcus aureus (staph infection).\r\nThese painful skin abscesses result from bacteria infecting a hair follicle. They commonly occur on the face, neck, armpits, buttocks, and thighs, but can appear anywhere on your body.\r\n', NULL, '2022-04-19 02:12:08', '2022-04-19 02:12:08'),
(8, 'Eczema', 'Depression, Difficulty relaxing, Use of alcohol, tobacco, or illegal drugs to relax, A negative opinion of yourself (low self-esteem), Anxiety, constant worry, Feeling overwhelmed, Difficulty with concentration, Irritability, mood swings, or a short temper,\r\nNausea and dizziness, Not wanting to have sex, Sleeping too much, Sleeping too little, Diarrhea, Constipation, Muscle tension, Aches and pains, Dry skin, Itchy skin, Red rashes, Bumps on the skin, Scaly, leathery patches of skin, Crusting skin, Swelling\r\n', 'Eczema (also called atopic dermatitis) is a condition that causes your skin to become dry, red, itchy and bumpy. It’s one of many types of dermatitis. Eczema damages the skin barrier function (the \"glue\" of your skin). This loss of barrier function makes your skin more sensitive and more prone to infection and dryness.', NULL, '2022-04-19 02:16:45', '2022-04-19 02:16:45'),
(9, 'Psoriasis', 'Itchiness, Cracked, dry skin, Scaly scalp, Skin pain, Nails that are pitted, cracked or crumbly, Joint pain', 'Psoriasis is a chronic skin disorder, which means a skin condition that doesn’t go away. People with psoriasis have thick, pink or red patches of skin covered with white or silvery scales. The thick, scaly patches are called plaques.Psoriasis usually starts in early adulthood, though it can begin later in life. People of any age, gender or race can get psoriasis. It can get better and worse throughout your life.', NULL, '2022-04-21 21:25:55', '2022-04-21 21:25:55'),
(10, 'Cellulitis', 'Pain, Tenderness, Redness, Swelling, Warmth, Fluid-filled blisters, Discharge\r\n', 'Cellulitis is bacterial infection of the skin and the tissues beneath the skin. It can occur on any part of the body.', NULL, '2022-04-21 21:29:03', '2022-04-21 21:29:03'),
(11, 'Measles', 'A sore throat.\r\nWhite spots in the mouth.\r\nMuscle pain.\r\nSensitivity to light (light makes your eyes hurt).\r\n', 'Measles is an airborne disease caused by a virus, and it’s very contagious. Symptoms may develop about eight to 12 days after you’re exposed. Symptoms can last 10 to 14 days.Measles is also called rubeola, 10-day measles or red measles. It’s not the same as German measles, or rubella.\r\n', NULL, '2022-04-21 21:32:11', '2022-04-21 21:32:11'),
(12, 'Basal Cell Carcinoma', 'Lumps or nodules on the skin that look shiny or that have visible blood vessels. The lumps can get bigger over time., Areas on the skin that look like scars, Itchy patches, Areas of red or patchy skin that look like eczema, Sores that look crusty, have a depression in the middle, or bleed often', 'BCC is a type of skin cancer that may form in the basal cells of the skin. These cells are the ones that make new cells to replace the cells that die.', NULL, '2022-04-21 21:34:55', '2022-04-21 21:34:55'),
(13, 'Squamous Cell Carcinoma', 'A rough-feeling bump or growth which might then crust over and bleed, A growth that is higher than the skin but has a depression in the middle, A sore that will not heal, or a sore that heals and then comes back, A piece of skin that is flat, is scaly and red, A precancerous growth called actinic keratosis, which is a bump or lump that can feel dry, itchy, scaly, or be discolored, A precancerous skin lesion called actinic cheilitis, which happens mainly on the lower lip. The tissue becomes pale, dry, and cracked, A precancerous condition called leukoplakia, in which white spots develop in the mouth, on the tongue, gums, or cheeks', 'SCC, or cutaneous squamous cell carcinoma (CSCC), is the second most common form of skin cancer. It starts in cells of the outer layer of the skin, the epidermis. Usually SCCs are found on the parts of skin that are most often exposed to the sun. This means hands, face, arms, legs, ears, mouths, and even bald spots on the top of the head. SCCs can also form in areas such as mucus membranes and genitals.', NULL, '2022-04-21 21:39:09', '2022-04-21 21:39:09'),
(14, 'Melanoma', 'Changes in the size, shape, color, or feel of a mole are often the first warning signs of melanoma. These changes can occur in an existing mole, or melanoma may appear as a new or unusual-looking mole.', 'Melanoma, which means \"black tumor,\" is the most dangerous type of skin cancer. It grows quickly and has the ability to spread to any organ.\r\nMelanoma comes from skin cells called melanocytes. These cells produce melanin, the dark pigment that gives skin its color. Most melanomas are black or brown in color, but some are pink, red, purple or skin-colored.\r\n', NULL, '2022-04-21 21:44:46', '2022-04-21 21:44:46'),
(15, 'Lupus', 'Joint pain, Muscle pain, Rashes, Fever, Sensitivity to sunlight, Hair loss, Mouth sores, Dry eyes, Fatigue, Chest pain, Stomach pain, Shortness of breath, Swollen glands, Headaches, Confusion, Depression, Issues with the kidneys, heart or lungs, Seizures, Blood clots, Anemia, Raynaud’s phenomenon', 'Systemic lupus erythematosus (SLE), commonly referred to simply as lupus, is a chronic autoimmune disease that can cause swelling (inflammation) and pain throughout your body. When you have an autoimmune disease, your body’s immune system fights itself. The immune system is supposed to fight possible threats to the body — infections, for example — but, in this case, it goes after healthy tissue.', NULL, '2022-04-21 21:49:27', '2022-04-21 21:49:27'),
(16, 'Contact Dermatitis', 'Red Skin Rash, Swollen, blistering or oozing, Burning or stinging, Flaky or scaling, Swollen or hive-like, Itchy, Painful\r\n', 'Dermatitis is the medical term for skin inflammation (irritation). Contact dermatitis is an allergic or irritant reaction that causes a painful or itchy skin rash. As the name suggests, you get contact dermatitis from coming into contact with an allergen (like poison ivy) or an irritant (like a chemical).', NULL, '2022-04-21 21:52:59', '2022-04-21 21:52:59'),
(17, 'Vitiligo', 'Patches of skin lose color. This can include the eyes and/or the mucous membranes in your mouth or nose, Patches of hair on your head or face turn prematurely gray or white.\r\n', 'Vitiligo (vit-il-EYE-go) is a skin disorder that causes the skin to lose its color. Smooth white areas (called macules if less than 5mm or patches if 5mm or larger) appear on a person’s skin. If you have vitiligo in a place that has hair, the hair on your body may also turn white.\r\nThe condition occurs when melanocytes (the skin cells that produce melanin, the chemical that gives skin its color, or pigmentation) are destroyed by the body’s immune system.\r\n', NULL, '2022-04-21 21:54:54', '2022-04-21 21:54:54'),
(18, 'Wart', 'Dome-shaped, Flat, Rough, Skin-colored, brown, grey or black.\r\n', 'Warts are noncancerous (benign) rough bumps that form on the skin. They develop when the human papillomavirus, or HPV, enters a cut or break in the skin and causes an infection.', NULL, '2022-04-21 21:56:58', '2022-04-21 21:56:58'),
(19, 'Chickenpox', 'Fever, Feeling tired, Headache, A stomach ache that lasts for one or two days, A skin rash that is very itchy and looks like many small blisters, Bumps filled with a liquid that looks like milky water, Scabs after the blisters break, Skin that looks blotchy, Spots that fade away', 'Chickenpox is an infection that causes a skin rash. The disease is caused by a germ called varicella-zoster virus. (Chickenpox itself is also called varicella-zoster.) Most people will get the virus when they’re young if they haven’t had a chickenpox vaccine.', NULL, '2022-04-21 22:01:24', '2022-04-21 22:01:24'),
(20, 'Seborrheic Keratosis', 'Itching, Irritation from friction, Bleeding\r\n', 'A seborrheic keratosis (seb-o-REE-ik ker-uh-TOE-sis) is a common benign skin growth, similar to a mole. Most people will have at least one in their lifetime. They tend to appear in mid-adulthood and their frequency increases with age. They are harmless and don’t require treatment, but you can have them removed if they bother you.', NULL, '2022-04-21 22:07:34', '2022-04-21 22:07:34'),
(21, 'Keratosis Pilaris', 'Itchy or dry skin, especially on the backs of your upper arms, legs or buttocks, Irritation of the bumps that causes them to become more red and noticeable. This is known as frictional lichenoid dermatitis, Rough, sandpaper-like skin where the bumps appear, Worsening of the bumps when the air is drier (such as in winter months)', 'Keratosis pilaris is a benign (not harmful) skin condition that looks like small bumps. If you have this condition, you may notice small, painless bumps on your skin around the hair follicles. These bumps may have a red, brown or white color — they can also be skin-colored. You may hear keratosis pilaris called KP or even “chicken skin” because of its goose bump-like appearance.', NULL, '2022-04-21 22:10:10', '2022-04-21 22:10:10'),
(22, 'Athlete’s Foot', 'Circular, ring-shaped rash, Itchy skin, Scaly, cracked skin, Redness, Hair loss or bald spots\r\n', 'Ringworm is a contagious fungal infection that causes different itchy skin problems, including athlete’s foot, jock itch and scalp ringworm. A ring-shaped itchy rash forms on infected skin. Treatments can stop the fungus from spreading and clear it up.\r\n', NULL, '2022-04-21 22:11:18', '2022-04-21 22:11:18'),
(23, 'Ichthyosis', 'Dry, itchy skin, Thick, rough skin that looks dirty, most noticeably on the palms and soles of the feet, White, gray or brown scales on the front of the legs, back of the arms, scalp, back or stomach. If scales appear on the face, it’s mostly on the forehead and cheeks. Sometimes the edges of the scales curl, making the skin feel rough, Extra lines on the palms of the hands and the soles of the feet. The lines may run deep in severe cases, causing cracks in the skin. If the cracks are deep enough, an infection may develop, Rough bumps on the arms, thighs and buttocks (keratosis pilaris). The bumps are often mistaken for acne blemishes, Inability to perspire (sweat) adequately. This happens in severe cases and can cause overheating (because perspiration cools down the body)', 'Ichthyosis is a skin disease with more than 20 varieties. Ichthyosis vulgaris is the most common and mildest form of ichthyosis. Of those who have some form of ichthyosis, 95 percent have ichthyosis vulgaris. \r\nThe main feature of ichthyosis vulgaris is dry, thick and scaly skin. The condition can begin in childhood, often in the first year of life. Adults can also develop the disease.\r\n', NULL, '2022-04-21 22:13:41', '2022-04-21 22:13:41'),
(24, 'Alopecia Areata', 'Hair loss', 'Alopecia areata is a condition that causes a person\'s hair to fall out. (Alopecia is the medical term for hair loss; there are various types of alopecia, including alopecia areata.)', NULL, '2022-04-21 22:18:03', '2022-04-21 22:18:03');

-- --------------------------------------------------------

--
-- Table structure for table `medical_condition_treatments`
--

DROP TABLE IF EXISTS `medical_condition_treatments`;
CREATE TABLE IF NOT EXISTS `medical_condition_treatments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medical_condition_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medical_condition_id` (`medical_condition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medical_condition_treatments`
--

INSERT INTO `medical_condition_treatments` (`id`, `medical_condition_id`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'Benzoyl peroxide is available as an over-the-counter product (such as Clearasil®, Stridex®, PanOxyl®) as a leave-on gel or wash. It targets surface bacteria, which often aggravates acne. Lower concentrations and wash formulations are less irritating to your skin. Irritation (dryness) is a common side effect.', '2022-04-15 15:26:40', '2022-04-15 15:26:40'),
(2, 1, 'Salicylic acid is available over-the-counter for acne, as a cleanser or lotion. It helps remove the top layer of damaged skin. Salicylic acid dissolves dead skin cells to prevent your hair follicles from clogging.', '2022-04-15 15:27:05', '2022-04-15 15:27:05'),
(3, 1, 'Azelaic acid is a natural acid found in various grains such as barley, wheat and rye. It kills microorganisms on the skin and reduces swelling.', '2022-04-15 15:27:29', '2022-04-15 15:27:29'),
(4, 1, 'Retinoids (vitamin A derivatives) such as Retin-A®, Tazorac®, and Differin® (which is now available without a prescription) break up blackheads and whiteheads and help to prevent clogged pores, the first signs of acne', '2022-04-15 15:27:41', '2022-04-15 15:27:41'),
(5, 1, 'Antibiotics (topical types include clindamycin and erythromycin) control surface bacteria that aggravate and often encourage the swelling of acne. Antibiotics are more effective when combined with benzoyl peroxide.', '2022-04-15 15:27:50', '2022-04-15 15:27:50'),
(6, 1, 'Dapzone (Aczone®) is a topical gel, which also has antibacterial properties, can be used for inflamed acne. It’s applied to the skin twice a day.', '2022-04-15 15:28:01', '2022-04-15 15:28:01'),
(7, 1, 'Antibiotics, especially tetracycline antibiotics such as minocycline and doxycycline, are commonly used to treat moderate to severe acne.', '2022-04-15 15:28:23', '2022-04-15 15:28:23'),
(8, 1, 'Oral contraceptives can help with breakouts associated with menstrual cycles. Three classes of medications have been approved by the FDA for acne patients. Some brand names include Estrostep®, Beyaz®, Ortho Tri-Cyclen® and Yaz ®.', '2022-04-15 15:28:35', '2022-04-15 15:28:35'),
(9, 1, 'Isotretinoin (Amnesteem®, Claravis®, Sotret®), an oral retinoid, is an especially effective drug used only for the most severe cases of acne. Isotretinoin shrinks the size of oil glands, which contributes to acne formation', '2022-04-15 15:28:50', '2022-04-15 15:28:50'),
(10, 1, 'Steroids. Rarely, steroids can be used to treat severe acne or injected into large nodules to reduce inflammation.', '2022-04-15 15:29:10', '2022-04-15 15:29:10'),
(11, 1, 'Lasers. Currently, lasers are primarily used to treat acne scars. A laser delivers heat to the scarred collagen under the skin, this relies on the body’s wound healing response to create new, healthy collagen.', '2022-04-15 15:29:27', '2022-04-15 15:29:27'),
(12, 1, 'Chemical Peels. This treatment uses special chemicals to remove the top layer of old skin. Typically whenever the top layer is removed, the new skin that grows in is smoother and can lessen acne scars.', '2022-04-15 15:29:47', '2022-04-15 15:29:47'),
(13, 2, 'Acyclovir (Zovirax)', '2022-04-15 15:30:15', '2022-04-15 15:30:15'),
(14, 2, 'Valacyclovir (Valtrex)', '2022-04-15 15:30:29', '2022-04-15 15:30:29'),
(15, 2, 'Famciclovir', '2022-04-15 15:30:39', '2022-04-15 15:30:39'),
(16, 2, 'Penciclovir (Denavir)', '2022-04-15 15:30:50', '2022-04-15 15:30:50'),
(17, 3, 'Wash the area gently with a mild soap.', '2022-04-15 15:31:14', '2022-04-15 15:31:14'),
(18, 3, 'Apply antibacterial cream or ointment.', '2022-04-15 15:31:23', '2022-04-15 15:31:23'),
(19, 3, 'Cover the blister with a bandage or gauze.', '2022-04-15 15:31:32', '2022-04-15 15:31:32'),
(20, 4, 'Allergy medications: Medicines called antihistamines block histamine’s effects on your body. Antihistamines relieve itching from hives and prevent allergic reactions. Some antihistamines react fast, like diphenhydramine (Benadryl®). Depending how severe the hives are, your healthcare provider may recommend daily over-the-counter (OTC) or prescription allergy medications, like loratadine (Claritin®). fexofenadine (Allegra®), cetirizine (Zyrtec®) or levocetirizine (Xyzal®).', '2022-04-15 15:32:04', '2022-04-15 15:32:04'),
(21, 4, 'Allergy shots: For hard-to-treat chronic hives, your healthcare provider may recommend a monthly injection of a drug called omalizumab (Xolair®). This medication blocks the body’s allergy antibody, immunoglobin E (IgE), from causing allergy reactions. People with severe allergies can make too much IgE, leading to problems like hives and asthma.', '2022-04-15 15:32:15', '2022-04-15 15:32:15'),
(22, 4, 'At-home treatments: To relieve hives, you can take a cool bath or shower, wear loose-fitting clothing and apply cold compresses. An OTC hydrocortisone cream, such as Cortizone®, can relieve itching and swelling. ', '2022-04-15 15:32:23', '2022-04-15 15:32:23'),
(23, 4, 'Epinephrine: Severe allergic reactions and swelling can lead to a life-threatening condition called anaphylaxis. Symptoms include hives, swelling, shortness of breath, wheezing, vomiting and low blood pressure. People experiencing anaphylaxis need an immediate epinephrine injection (EpiPen®) to open a swollen airway. ', '2022-04-15 15:32:35', '2022-04-15 15:32:35'),
(24, 4, 'Oral steroids: Corticosteroids, such as prednisone, can relieve hive symptoms that don’t respond to antihistamines.', '2022-04-15 15:32:45', '2022-04-15 15:32:45'),
(25, 5, 'Chemical peels: A chemical peel is like a medical-grade face mask. Your healthcare provider applies the peel during an office visit. The chemicals in the treatment safely destroy unwanted patches in your top layer of skin. In the first few days, the treated area will be sore and red. As the skin heals, you will see a new, healthy layer of skin. ', '2022-04-19 02:05:53', '2022-04-19 02:05:53'),
(26, 5, 'Cryotherapy: If you have one or two AKs, your provider may use cryotherapy. During this treatment, your provider uses a cold substance such as liquid nitrogen to freeze skin growths. Within a few days, these growths will blister and peel off. ', '2022-04-19 02:06:13', '2022-04-19 02:06:13'),
(27, 5, 'Excision: During this treatment, your healthcare provider first numbs the skin around your AK. Your provider then scrapes away or cuts out the AKs and stitches the area back together. Usually, your wound will heal in two to three weeks.', '2022-04-19 02:06:27', '2022-04-19 02:06:27'),
(28, 5, 'Photodynamic therapy: If you have multiple AKs or AKs that return after treatment, your provider may recommend photodynamic therapy. This treatment uses creams and special light therapy to destroy precancerous skin cells. You will need to stay out of the sun for a few days while the treated skin heals.', '2022-04-19 02:06:40', '2022-04-19 02:06:40'),
(29, 6, 'Medicines: Sometimes, doctors prescribe oral and topical medicines to treat the disorder\'s associated bumps, pimples and redness. Medicines can bring the condition under control and then maintain its state of remission.\r\n', '2022-04-19 02:10:18', '2022-04-19 02:10:18'),
(30, 6, 'Surgical procedures: Doctors can use lasers to remove visible blood vessels, limit the amount of extensive redness on the face, or correct nose disfigurement in some cases.', '2022-04-19 02:10:36', '2022-04-19 02:10:36'),
(31, 7, 'Apply warm, moist compresses (such as a damp washcloth) several times a day. This can speed healing and relieve some of the pain and pressure you’re experiencing. You should use a clean washcloth (and towel) each time.', '2022-04-19 02:12:44', '2022-04-19 02:12:44'),
(32, 7, 'See a healthcare provider if the boil persists or comes back, or if it is located on the spine or on your face.', '2022-04-19 02:12:59', '2022-04-19 02:12:59'),
(33, 8, 'Use a humidifier if dry air makes your skin dry. \r\n', '2022-04-19 02:17:19', '2022-04-19 02:17:19'),
(34, 8, 'See a psychiatrist for medication and a therapist for counseling if you’re experiencing symptoms of poor mental/emotional health.', '2022-04-19 02:17:31', '2022-04-19 02:17:31'),
(35, 8, 'Moisturize your skin using a cream or ointment. Lotions don’t work as well. Apply several times a day, including after you bathe or shower. Use lukewarm water in the tub or shower instead of hot. ', '2022-04-19 02:17:42', '2022-04-19 02:17:42'),
(36, 8, 'Use mild soaps and other products that are free of perfumes, dyes and alcohol. Look for products labeled “fragrance free,” “hypoallergenic” and “for sensitive skin.” ', '2022-04-19 02:17:53', '2022-04-19 02:17:53'),
(37, 8, 'Use skin products that contain ceramide. These moisturizers replace some of the “glue” (the barrier) missing from your skin.', '2022-04-19 02:18:08', '2022-04-19 02:18:08'),
(38, 8, 'Apply cortisone creams and ointments. Cortisone is an over-the-counter steroid found in hydrocortisone (Cortisone 10®) and hydrocortisone acetate (Cort-Aid®). They may help control the itching and redness.', '2022-04-19 02:18:21', '2022-04-19 02:18:21'),
(39, 8, 'ake over-the-counter antihistamines for severe itching. ', '2022-04-19 02:18:34', '2022-04-19 02:18:34'),
(40, 8, 'Take prescription medications. Your healthcare provider may prescribe steroid creams, pills and/or shots. Long-term risks include side effects like high blood pressure, weight gain and thinning of the skin. There are newer medications, called topical immunomodulators (TIMs) that show progress in treating patients who do not respond to other treatments. They change the body’s immune response to allergens and have fewer side effects', '2022-04-19 02:18:50', '2022-04-19 02:18:50'),
(41, 8, 'TPhototherapy: The ultraviolet light waves found in sunlight have been shown to help certain skin disorders, including eczema. Phototherapy uses ultraviolet light, usually ultraviolet B (UVB), from special lamps.', '2022-04-19 02:19:03', '2022-04-19 02:19:03'),
(42, 9, 'Steroid creams.', '2022-04-21 21:26:56', '2022-04-21 21:26:56'),
(43, 9, 'Moisturizers for dry skin.', '2022-04-21 21:27:11', '2022-04-21 21:27:11'),
(44, 9, 'Anthralin, a medication to slow skin cell production.', '2022-04-21 21:27:22', '2022-04-21 21:27:22'),
(45, 9, 'Medicated lotions, shampoos and bath solutions to improve scalp psoriasis. Your provider may combine it with ultraviolet (UV) light therapy for severe cases.', '2022-04-21 21:27:33', '2022-04-21 21:27:33'),
(46, 9, 'Vitamin D3 ointment.', '2022-04-21 21:27:48', '2022-04-21 21:27:48'),
(47, 10, 'Cellulitis is usually treated with antibiotics such as dicloxacillin or cephalexin.', '2022-04-21 21:29:46', '2022-04-21 21:29:46'),
(48, 10, 'Warm compresses can be applied to the affected area to reduce symptoms and irritation.', '2022-04-21 21:30:08', '2022-04-21 21:30:08'),
(49, 10, 'Elevating the affected area can help reduce swelling.', '2022-04-21 21:30:18', '2022-04-21 21:30:18'),
(50, 11, 'Taking acetaminophen or ibuprofen for aches, pains or fever.', '2022-04-21 21:32:40', '2022-04-21 21:32:40'),
(51, 11, 'Getting plenty of rest.\r\n', '2022-04-21 21:32:50', '2022-04-21 21:32:50'),
(52, 11, 'Drinking enough fluids.', '2022-04-21 21:33:07', '2022-04-21 21:33:07'),
(53, 11, 'Gargling with salt water.', '2022-04-21 21:33:19', '2022-04-21 21:33:19'),
(54, 11, 'Avoiding harsh light if your eyes hurt.', '2022-04-21 21:33:48', '2022-04-21 21:33:48'),
(55, 12, 'Scratching off with a curette, an instrument that may end in a ring or a spoon, and then burning with a special electric needle. This method is called electrodessication and curettage', '2022-04-21 21:35:22', '2022-04-21 21:35:22'),
(56, 12, 'Surgical removal', '2022-04-21 21:35:35', '2022-04-21 21:35:35'),
(57, 12, 'Freezing (cryotherapy or cryosurgery)', '2022-04-21 21:35:47', '2022-04-21 21:35:47'),
(58, 12, 'Applying chemotherapy medication to the skin', '2022-04-21 21:35:59', '2022-04-21 21:35:59'),
(59, 12, 'Using lasers', '2022-04-21 21:36:12', '2022-04-21 21:36:12'),
(60, 12, 'Using blue light and a light-sensitive agent applied to the skin (photodynamic therapy or PDT)', '2022-04-21 21:36:22', '2022-04-21 21:36:22'),
(61, 12, 'Using radiation (rare)', '2022-04-21 21:36:35', '2022-04-21 21:36:35'),
(62, 13, 'Scratching off with a curette, an instrument that may end in a ring or a spoon, and then burning with a special electric needle. This method is called electrodessication and curettage.', '2022-04-21 21:39:32', '2022-04-21 21:39:32'),
(63, 13, 'Surgical removal', '2022-04-21 21:39:51', '2022-04-21 21:39:51'),
(64, 13, 'Freezing (cryotherapy or cryosurgery).', '2022-04-21 21:40:05', '2022-04-21 21:40:05'),
(65, 13, 'Applying chemotherapy medication to the skin.', '2022-04-21 21:40:18', '2022-04-21 21:40:18'),
(66, 13, 'Using lasers.', '2022-04-21 21:40:30', '2022-04-21 21:40:30'),
(67, 13, 'Using blue light and a light-sensitive agent applied to the skin (photodynamic therapy or PDT).', '2022-04-21 21:40:41', '2022-04-21 21:40:41'),
(68, 13, 'Using radiation (rare for the primary treatment of CSCC).', '2022-04-21 21:40:53', '2022-04-21 21:40:53'),
(69, 14, 'Melanoma Surgery: In the early stages, surgery has a high probability of being able to cure your melanoma. Usually performed in an office, a dermatologist numbs the skin with a local anesthetic and removes the melanoma and margins (healthy surrounding skin).', '2022-04-21 21:45:20', '2022-04-21 21:45:20'),
(70, 14, 'Lymphadenectomy: In cases where melanoma has spread, removal of the lymph nodes near the primary diagnosis site may be required. This can prevent the spread to other areas of your body.', '2022-04-21 21:45:35', '2022-04-21 21:45:35'),
(71, 14, 'Metastasectomy: Metastasectomy is used to remove small melanoma bits from organs.', '2022-04-21 21:45:51', '2022-04-21 21:45:51'),
(72, 14, 'Targeted cancer therapy: In this treatment option, drugs are used to attack specific cancer cells. This “targeted” approach goes after cancer cells, leaving healthy cells untouched.', '2022-04-21 21:46:02', '2022-04-21 21:46:02'),
(73, 14, 'Radiation Therapy: Radiation therapy includes treatments with high-energy rays to attack cancer cells and shrink tumors.', '2022-04-21 21:46:16', '2022-04-21 21:46:16'),
(74, 14, 'Immunotherapy: immunotherapy stimulates your own immune system to help fight the cancer.', '2022-04-21 21:46:27', '2022-04-21 21:46:27'),
(75, 15, 'Steroids (corticosteroids, including prednisone): Steroid creams can be directly applied to rashes. The use of creams is usually safe and effective, especially for mild rashes. The use of steroid creams or pills in low doses can be effective for mild or moderate features of lupus. Steroids can also be used in higher doses when internal organs are threatened. Unfortunately, high doses are also most likely to produce side effects.', '2022-04-21 21:50:00', '2022-04-21 21:50:00'),
(76, 15, 'Hydroxychloroquine (Plaquenil®): This medication is commonly used to help keep mild lupus-related problems, such as skin and joint disease, under control. It’s also used to treat fatigue and mouth sores.', '2022-04-21 21:50:11', '2022-04-21 21:50:11'),
(77, 15, 'Azathioprine (Imuran®): A medication originally used to prevent rejection of transplanted organs, this is commonly used to treat the more serious features of lupus.', '2022-04-21 21:50:25', '2022-04-21 21:50:25'),
(78, 15, 'Methotrexate (Rheumatrex®): This medication is another chemotherapy drug that’s used to suppress the immune system', '2022-04-21 21:50:36', '2022-04-21 21:50:36'),
(79, 15, 'Cyclophosphamide (Cytoxan®) and mycophenolate mofetil (CellCept®): These medications are chemotherapy drugs that have very powerful effects on reducing the activity of the immune system. They are used to treat more severe forms of lupus, especially lupus that affects the kidneys.', '2022-04-21 21:50:47', '2022-04-21 21:50:47'),
(80, 15, 'Belimumab (Benlysta®): This medication is a monoclonal antibody that reduces the activity of white blood cells (lymphocytes) that make autoantibodies. Autoantibodies are important as they cause tissue damage. Belimumab is used to treat lupus that does not involve the kidneys and has not responded to other types of treatments.', '2022-04-21 21:50:59', '2022-04-21 21:50:59'),
(81, 15, 'Rituximab (Rituxan®): This medication is also a monoclonal antibody that reduces the activity of white blood cells (lymphocytes) that make autoantibodies. It’s sometimes used to treat lupus that has not responded to other types of treatments.', '2022-04-21 21:51:13', '2022-04-21 21:51:13'),
(82, 16, 'Avoidance: If you can figure out what’s causing the rash, take steps to avoid it or minimize exposure.', '2022-04-21 21:53:23', '2022-04-21 21:53:23'),
(83, 16, 'Anti-itch creams: Corticosteroid creams can ease inflammation and itching.', '2022-04-21 21:53:33', '2022-04-21 21:53:33'),
(84, 16, 'Oral steroids: Prednisone, a type of steroid, can relieve rash symptoms that don’t respond to antihistamines or other treatments.', '2022-04-21 21:53:44', '2022-04-21 21:53:44'),
(85, 16, 'Immunosuppressive medications: In severe cases, where repeated bouts of oral steroids are needed.', '2022-04-21 21:53:59', '2022-04-21 21:53:59'),
(86, 17, 'Camouflage therapy', '2022-04-21 21:55:19', '2022-04-21 21:55:19'),
(87, 17, 'Repigmentation therapy', '2022-04-21 21:55:30', '2022-04-21 21:55:30'),
(88, 17, 'Light therapy', '2022-04-21 21:55:41', '2022-04-21 21:55:41'),
(89, 17, 'Surgery', '2022-04-21 21:55:52', '2022-04-21 21:55:52'),
(90, 18, 'At-home wart removal: Over-the-counter (OTC) wart removal medications, such as Compound W®, contain salicylic acid. This chemical dissolves warts one layer at a time. ', '2022-04-21 21:57:20', '2022-04-21 21:57:20'),
(91, 18, 'Freezing: During a procedure called cryotherapy, your doctor applies liquid nitrogen to freeze the wart. After freezing, a blister forms. Eventually, the blister and wart peel off. You may need several treatments. ', '2022-04-21 21:57:32', '2022-04-21 21:57:32'),
(92, 18, 'Immunotherapy: For stubborn warts that don’t respond to traditional treatments, immunotherapy helps your immune system fight the virus. This process involves a topical chemical, such as diphencyprone (DCP). DCP causes a mild allergic reaction that makes the wart go away. ', '2022-04-21 21:57:43', '2022-04-21 21:57:43'),
(93, 18, 'Laser treatment: Your doctor uses laser light to heat and destroy tiny blood vessels inside the wart. The process cuts off blood supply, killing the wart.', '2022-04-21 21:57:56', '2022-04-21 21:57:56'),
(94, 18, 'Topical medicine: Your doctor may apply a liquid mixture containing the chemical cantharidin. A blister forms under the wart and cuts off its blood supply. You must return to your doctor’s office in about a week to have the dead wart removed. ', '2022-04-21 21:58:09', '2022-04-21 21:58:09'),
(95, 19, 'Press a cool, moist rag on the rash.', '2022-04-21 22:01:53', '2022-04-21 22:01:53'),
(96, 19, 'Keep your child cool.', '2022-04-21 22:03:18', '2022-04-21 22:03:18'),
(97, 19, 'Encourage your child not to scratch. Trim their fingernails so they can\'t scratch.', '2022-04-21 22:03:54', '2022-04-21 22:03:54'),
(98, 19, 'Put a lotion with antihistamines on the rash. These lotions are available at the drugstore. If you don\'t know what to buy, ask the pharmacist for help.', '2022-04-21 22:04:13', '2022-04-21 22:04:13'),
(99, 19, 'Give your child an over-the-counter (OTC) form of antihistamine. Diphenhydramine (Benadryl®) and cetirizine (Zyrtec®) are two examples of OTC antihistamines.', '2022-04-21 22:04:27', '2022-04-21 22:04:27'),
(100, 19, 'Give your child a cool bath or shower every day. You can also give your child an oatmeal bath. When you’re drying them off, don’t rub with the towel. Pat your child dry.', '2022-04-21 22:04:37', '2022-04-21 22:04:37'),
(101, 20, 'Cryotherapy. Your healthcare provider will numb the skin and then use liquid nitrogen to freeze the growth. This will cause it to fall off within a few days or weeks.', '2022-04-21 22:08:06', '2022-04-21 22:08:06'),
(102, 20, 'Electrodessication/Curettage. Your healthcare provider will numb the skin and then use a targeted electrocurrent to burn the seborrheic keratosis. They use a surgical instrument called a curette to scrape away the remains of the growth.', '2022-04-21 22:08:16', '2022-04-21 22:08:16'),
(103, 20, 'Shave Excision. This is the preferred method when your healthcare provider wants to preserve a sample of the growth to analyze in the lab. After numbing the skin, your healthcare provider will carefully shave off the growth and smooth the skin underneath with a surgical curette. Then they’ll send the shaved growth to the lab for analysis.', '2022-04-21 22:08:26', '2022-04-21 22:08:26'),
(104, 20, 'Laser Therapy. Lasers offer an alternative to surgery by burning the growth, sterilizing the wound and sealing the tissue all at once. Laser therapy is quick, but the wound will be sore for a while afterward. Lasers are associated with good cosmetic results.', '2022-04-21 22:08:39', '2022-04-21 22:08:39'),
(105, 20, 'Prescription Hydrogen Peroxide. The FDA has recently approved a topical solution of 40% hydrogen peroxide to treat seborrheic keratosis. (Over-the-counter hydrogen peroxide is a 1% solution.) The solution comes in an applicator pen, which your healthcare provider will apply to your seborrheic keratosis several times in one visit. You may need more than one visit to see results. Mild skin reactions are a common side effect.', '2022-04-21 22:08:50', '2022-04-21 22:08:50'),
(106, 22, 'Antifungal creams or powders: Over-the-counter (OTC) and prescription antifungal creams or powders work well on athlete’s foot and jock itch. These products include clotrimazole (Lotrimin®), miconazole (Desenex®) and terbinafine (Lamisil AT®).\r\n', '2022-04-21 22:12:11', '2022-04-21 22:12:11'),
(107, 22, 'Oral antifungal medication: For scalp ringworm, your healthcare provider will prescribe an oral antifungal medication. You’ll need to take this medication for one to three months to get rid of the fungus completely. If you stop treatment too soon, the infection may come back and be harder to treat. Oral antifungal medications include fluconazole (Diflucan®), griseofulvin (Griasctin®), itraconazole (Sporanox®) and terbinafine (Lamisil®).', '2022-04-21 22:12:23', '2022-04-21 22:12:23'),
(108, 22, 'Antifungal shampoo: Your provider may prescribe an antifungal shampoo, such as ketoconazole shampoo (Nizoral A-D®), to stop scalp ringworm from spreading. But antifungal shampoo won’t cure scalp ringworm. You also need to take a prescribed oral antifungal medication. Uninfected family members may also need to use the shampoo to keep from getting ringworm.', '2022-04-21 22:12:36', '2022-04-21 22:12:36'),
(109, NULL, 'Take baths more than once a day. Hydrating the skin softens the scales.', '2022-04-21 22:13:56', '2022-04-21 22:13:56'),
(110, NULL, 'Before bathing, apply petroleum jelly or other thick, bland emollients to open sores or deep cracks. Such ointments can ease the burning or stinging that the water might cause and can rid the skin of deep cracks. Adding sea salt to bath water may also reduce burning, stinging and itching.', '2022-04-21 22:15:36', '2022-04-21 22:15:36'),
(111, NULL, 'Immediately after bathing, apply a liberal amount of moisturizer. Moisturizer can lock in moisture from the bath into the skin. Certain heavy duty moisturizers that include the chemicals lactic acid, salicylic acid and urea can also help the skin shed properly.', '2022-04-21 22:15:48', '2022-04-21 22:15:48'),
(112, NULL, 'Take oral and/or skin medications the doctor prescribes, including antibiotics to treat skin infections.', '2022-04-21 22:15:58', '2022-04-21 22:15:58'),
(113, NULL, 'Add a small amount of bleach to bath water if skin infections are frequent. Bleach reduces the number of bacteria on the skin. (Take this step only if directed by a doctor.)', '2022-04-21 22:16:17', '2022-04-21 22:16:17'),
(114, NULL, 'Rub scales gently with an abrasive sponge while bathing, after the bathwater has softened the scales. This will remove dead skin.', '2022-04-21 22:16:27', '2022-04-21 22:16:27'),
(115, NULL, 'Treat the disease, or reduce the dose of medication, that caused acquired ichthyosis vulgaris.', '2022-04-21 22:16:37', '2022-04-21 22:16:37'),
(116, 24, 'Corticosteroids: anti-inflammatory drugs that are prescribed for autoimmune diseases. Corticosteroids can be given as an injection into the scalp or other areas, orally (as a pill), or applied topically (rubbed into the skin) as an ointment, cream, or foam. Response to therapy may be gradual.', '2022-04-21 22:18:30', '2022-04-21 22:18:30'),
(117, 24, 'Rogaine ® (minoxidil): this topical drug is already used as a treatment for pattern baldness. It usually takes about 12 weeks of treatment with Rogaine before hair begins to grow.', '2022-04-21 22:18:41', '2022-04-21 22:18:41');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
CREATE TABLE IF NOT EXISTS `patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `user_id`, `first_name`, `last_name`, `contact_number`, `address`, `created_at`, `updated_at`) VALUES
(1, 6, 'Test', 'User', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `patient_feedbacks`
--

DROP TABLE IF EXISTS `patient_feedbacks`;
CREATE TABLE IF NOT EXISTS `patient_feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient_feedbacks`
--

INSERT INTO `patient_feedbacks` (`id`, `patient_id`, `name`, `email`, `contact`, `doctor_id`, `subject`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'Test User', 'testuser@healthwise.com', '3227222', 1, 'Bad Service', 'Long wait times', NULL, NULL),
(2, 1, 'Test User', 'testuser@healthwise.com', '568-8955', 1, 'headaches', 'not going', NULL, NULL),
(3, 1, 'Test User', 'testuser@healthwise.com', '565-8852', 2, 'headache', 'not going away', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `patient_feedback_replies`
--

DROP TABLE IF EXISTS `patient_feedback_replies`;
CREATE TABLE IF NOT EXISTS `patient_feedback_replies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_feedback_id` int(11) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `message_read` int(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_feedback_id` (`patient_feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient_feedback_replies`
--

INSERT INTO `patient_feedback_replies` (`id`, `patient_feedback_id`, `detail`, `patient_id`, `doctor_id`, `message_read`, `created_at`, `updated_at`) VALUES
(1, 1, 'hi', 1, NULL, 0, '2022-04-15 17:11:46', '2022-04-15 17:11:46'),
(2, 1, 'hello', NULL, 1, 0, '2022-04-15 17:13:07', '2022-04-15 17:13:07'),
(3, 3, 'hi', 1, NULL, 0, '2022-04-15 20:07:29', '2022-04-15 20:07:29'),
(4, 3, 'hello', NULL, 2, 0, '2022-04-15 20:13:13', '2022-04-15 20:13:13');

-- --------------------------------------------------------

--
-- Table structure for table `specialities`
--

DROP TABLE IF EXISTS `specialities`;
CREATE TABLE IF NOT EXISTS `specialities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detail` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `specialities`
--

INSERT INTO `specialities` (`id`, `detail`, `created_at`, `updated_at`) VALUES
(1, 'Allergy and Immunology', '2022-03-02 04:04:56', '2022-03-02 04:04:56'),
(2, 'Anesthesiology', '2022-03-02 04:05:06', '2022-03-02 04:05:06'),
(3, 'Dermatology', '2022-03-02 04:05:19', '2022-03-02 04:05:19'),
(4, 'Diagnostic radiology', '2022-03-02 04:05:31', '2022-03-02 04:05:31'),
(5, 'Emergency medicine', '2022-03-02 04:05:44', '2022-03-02 04:05:44'),
(6, 'Family medicine', '2022-03-02 04:05:53', '2022-03-02 04:05:53'),
(7, 'Internal medicine', '2022-03-02 04:06:01', '2022-03-02 04:06:01'),
(8, 'Medical genetics', '2022-03-02 04:06:13', '2022-03-02 04:06:13'),
(9, 'Neurology', '2022-03-02 04:06:22', '2022-03-02 04:06:22'),
(10, 'Nuclear medicine', '2022-03-02 04:06:34', '2022-03-02 04:06:34'),
(11, 'Obsterics and gynecology', '2022-03-02 04:06:45', '2022-03-02 04:06:45'),
(12, 'Ophthalmology', '2022-03-02 04:06:56', '2022-03-02 04:06:56'),
(13, 'Pathology', '2022-03-02 04:07:06', '2022-03-02 04:07:06'),
(14, 'Pediatrics', '2022-03-02 04:07:16', '2022-03-02 04:07:16'),
(15, 'PHysical medicine and rehabilitation', '2022-03-02 04:07:36', '2022-03-02 04:07:36'),
(16, 'Preventive medicine', '2022-03-02 04:07:57', '2022-03-02 04:07:57'),
(17, 'Psychiatry', '2022-03-02 04:08:08', '2022-03-02 04:08:08'),
(18, 'Radiation oncology', '2022-03-02 04:08:22', '2022-03-02 04:08:22'),
(19, 'Surgery', '2022-03-02 04:08:30', '2022-03-02 04:08:30'),
(20, 'Urology', '2022-03-02 04:08:36', '2022-03-02 04:08:36');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `user_email` varchar(100) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `password_reset` int(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `user_name`, `user_email`, `password`, `password_reset`, `created_at`, `updated_at`) VALUES
(1, 2, 'janissabaksh@gmail.com', NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, NULL, NULL),
(2, 2, 'sach_rj@hotmail.com', NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, NULL, NULL),
(3, 2, 'kirin.rambaran@gmail.com', NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, NULL, NULL),
(4, 2, 'vseecheran@gmail.com', NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, NULL, NULL),
(5, 2, 'devan.ramnarine95@gmail.com', NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, NULL, NULL),
(6, 1, 'testuser@healthwise.com', NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, NULL, NULL),
(7, 2, 'testdoctor@healthwise.com', NULL, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detail` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `detail`, `created_at`, `updated_at`) VALUES
(1, 'Patient', '2022-03-02 06:39:47', '2022-03-02 06:39:47'),
(2, 'Doctor', '2022-03-02 06:39:54', '2022-03-02 06:39:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `medical_conditions`
--
ALTER TABLE `medical_conditions` ADD FULLTEXT KEY `symptoms` (`symptoms`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);

--
-- Constraints for table `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`speciality_id`) REFERENCES `specialities` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `doctor_hours`
--
ALTER TABLE `doctor_hours`
  ADD CONSTRAINT `doctor_hours_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `medical_condition_treatments`
--
ALTER TABLE `medical_condition_treatments`
  ADD CONSTRAINT `medical_condition_treatments_ibfk_1` FOREIGN KEY (`medical_condition_id`) REFERENCES `medical_conditions` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `patient_feedbacks`
--
ALTER TABLE `patient_feedbacks`
  ADD CONSTRAINT `patient_feedbacks_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `patient_feedbacks_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `patient_feedback_replies`
--
ALTER TABLE `patient_feedback_replies`
  ADD CONSTRAINT `patient_feedback_replies_ibfk_1` FOREIGN KEY (`patient_feedback_id`) REFERENCES `patient_feedbacks` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
