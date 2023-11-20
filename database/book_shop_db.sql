-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2023 at 05:21 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `book_shop_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cart_total` (IN `client_id` INT)   BEGIN
    SELECT SUM(quantity) as total_items
    FROM cart
    WHERE client_id = client_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_pending_orders_count` ()   BEGIN
    DECLARE pending_count INT;

    SELECT COUNT(id) INTO pending_count
    FROM orders
    WHERE status = '0';

    SELECT pending_count AS total;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sales_total` ()   BEGIN
    DECLARE sales_total DECIMAL(10, 2);

    SELECT SUM(total_amount) INTO sales_total
    FROM sales;

    SELECT sales_total AS total;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_total_sales_amount` ()   BEGIN
    DECLARE total DECIMAL(10, 2);

    SELECT SUM(total_amount) INTO total
    FROM sales;

    SELECT total AS total_amount;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(30) NOT NULL,
  `client_id` int(30) NOT NULL,
  `inventory_id` int(30) NOT NULL,
  `price` double NOT NULL,
  `quantity` int(30) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(30) NOT NULL,
  `category` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`, `description`, `status`, `date_created`) VALUES
(1, 'Educational', '&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px;&quot;&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam non ultrices tortor. Sed at ligula non lectus tempor bibendum a nec ante. Maecenas iaculis vitae nisi eu dictum. Duis sit amet enim arcu. Etiam blandit vulputate magna, non lobortis velit pharetra vel. Morbi sollicitudin lorem sed augue suscipit, eu commodo tortor vulputate. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent eleifend interdum est, at gravida erat molestie in. Vestibulum et consectetur dui, ac luctus arcu. Curabitur et viverra elit. Cras ac eleifend ipsum, ac suscipit leo. Vivamus porttitor ac risus eu ultricies. Morbi malesuada mi vel luctus sagittis. Ut vestibulum porttitor est, id rutrum libero. Mauris at lacus vehicula, aliquam purus quis, pharetra lorem.&lt;/p&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px;&quot;&gt;Proin consectetur massa ut quam molestie porta. Donec sit amet ligula odio. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Morbi ex sapien, pulvinar ac arcu at, luctus scelerisque nibh. In dolor velit, pellentesque eu blandit a, mollis ac neque. Fusce tortor lectus, aliquam et eleifend id, aliquet ut libero. Nunc scelerisque vulputate turpis quis volutpat. Vivamus malesuada sem in dapibus aliquam. Vestibulum imperdiet, nulla vitae pharetra pretium, magna felis placerat libero, quis tincidunt felis diam nec nisi. Sed scelerisque ullamcorper cursus. Suspendisse posuere, velit nec rhoncus cursus, urna sapien consectetur est, et lacinia odio leo nec massa. Nam vitae nunc vitae tortor vestibulum consequat ac quis risus. Sed finibus pharetra orci, id vehicula tellus eleifend sit amet.&lt;/p&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px;&quot;&gt;Morbi id ante vel velit mollis egestas. Suspendisse pretium sem urna, vitae placerat turpis cursus faucibus. Ut dignissim molestie blandit. Phasellus pulvinar, eros id ultricies mollis, lectus velit viverra mi, at venenatis velit purus id nisi. Duis eu massa lorem. Curabitur sed nibh felis. Donec faucibus, nulla at faucibus blandit, mi justo efficitur dui, non mattis nisl purus non lacus. Maecenas vel congue tellus, in convallis nisi. Curabitur faucibus interdum massa, eu facilisis ligula pretium quis. Nunc eleifend orci nec volutpat tincidunt.&lt;/p&gt;', 1, '2021-07-16 09:08:44'),
(2, 'Fiction', '&lt;p&gt;Sample 102&lt;/p&gt;', 1, '2021-07-16 09:09:25'),
(3, 'Novels', '&lt;p&gt;Sample 103&lt;/p&gt;', 1, '2021-07-16 09:09:46'),
(4, 'Sample Category', '&lt;p&gt;Sample Category 104&lt;/p&gt;', 1, '2021-07-16 11:33:52');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(30) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `contact` varchar(15) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` text NOT NULL,
  `default_delivery_address` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `firstname`, `lastname`, `gender`, `contact`, `email`, `password`, `default_delivery_address`, `date_created`) VALUES
(6, 'Karl', 'Gulay', 'Male', '09123123', 'karl123@email.com', '827ccb0eea8a706c4c34a16891f84e7b', 'Manila', '2023-05-31 11:14:45');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(30) NOT NULL,
  `product_id` int(30) NOT NULL,
  `quantity` double NOT NULL,
  `price` float NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `product_id`, `quantity`, `price`, `date_created`, `date_updated`) VALUES
(1, 1, 50, 2500, '2021-07-16 10:02:39', NULL),
(2, 2, 50, 3500, '2021-07-16 10:09:08', '2023-05-31 11:12:49'),
(3, 3, 50, 1000, '2021-07-16 12:05:54', '2023-05-31 11:12:30'),
(4, 4, 50, 1250.5, '2021-07-16 13:12:10', '2023-05-17 15:05:05');

--
-- Triggers `inventory`
--
DELIMITER $$
CREATE TRIGGER `update_cart_price` AFTER UPDATE ON `inventory` FOR EACH ROW BEGIN
    UPDATE cart
    SET cart.price = NEW.price
    WHERE cart.inventory_id = NEW.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `inventory_status`
-- (See below for the actual view)
--
CREATE TABLE `inventory_status` (
`product_name` varchar(250)
,`quantity` double
,`price` float
,`total_value` double
);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(30) NOT NULL,
  `client_id` int(30) NOT NULL,
  `delivery_address` text NOT NULL,
  `payment_method` varchar(100) NOT NULL,
  `order_type` tinyint(1) NOT NULL COMMENT '1= pickup,2= deliver',
  `amount` double NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `paid` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `client_id`, `delivery_address`, `payment_method`, `order_type`, `amount`, `status`, `paid`, `date_created`, `date_updated`) VALUES
(15, 6, 'Manila', 'cod', 2, 1000, 0, 0, '2023-05-31 11:19:51', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `order_details`
-- (See below for the actual view)
--
CREATE TABLE `order_details` (
`order_id` int(30)
,`order_type` tinyint(1)
,`delivery_address` text
,`payment_method` varchar(100)
,`amount` double
,`products` mediumtext
);

-- --------------------------------------------------------

--
-- Table structure for table `order_list`
--

CREATE TABLE `order_list` (
  `id` int(30) NOT NULL,
  `order_id` int(30) NOT NULL,
  `product_id` int(30) NOT NULL,
  `quantity` int(30) NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_list`
--

INSERT INTO `order_list` (`id`, `order_id`, `product_id`, `quantity`, `price`, `total`) VALUES
(14, 15, 3, 1, 1000, 1000);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pending_orders`
-- (See below for the actual view)
--
CREATE TABLE `pending_orders` (
`order_id` int(30)
,`order_type` tinyint(1)
,`delivery_address` text
,`amount` double
,`date_created` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `popular_products`
-- (See below for the actual view)
--
CREATE TABLE `popular_products` (
`product` varchar(250)
,`orders` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(30) NOT NULL,
  `category_id` int(30) NOT NULL,
  `sub_category_id` int(30) NOT NULL,
  `title` varchar(250) NOT NULL,
  `author` text NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `sub_category_id`, `title`, `author`, `description`, `status`, `date_created`) VALUES
(1, 1, 1, 'The Joy of PHP: A Beginner\\\'s Guide to Programming', 'Alan Forbes', '&lt;p&gt;&lt;span style=\\\\\\&quot;text-align: justify;\\\\\\&quot;&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam non ultrices tortor. Sed at ligula non lectus tempor bibendum a nec ante. Maecenas iaculis vitae nisi eu dictum. Duis sit amet enim arcu. Etiam blandit vulputate magna, non lobortis velit pharetra vel. Morbi sollicitudin lorem sed augue suscipit, eu commodo tortor vulputate. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent eleifend interdum est, at gravida erat molestie in. Vestibulum et consectetur dui, ac luctus arcu. Curabitur et viverra elit. Cras ac eleifend ipsum, ac suscipit leo. Vivamus porttitor ac risus eu ultricies. Morbi malesuada mi vel luctus sagittis. Ut vestibulum porttitor est, id rutrum libero. Mauris at lacus vehicula, aliquam purus quis, pharetra lorem.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;', 1, '2021-07-16 09:43:11'),
(2, 1, 1, 'Modern PHP: New Features and Good Practices', 'Josh Lockhart', '&lt;p&gt;&lt;span style=\\\\\\\\\\\\\\&quot;text-align: justify;\\\\\\\\\\\\\\&quot;&gt;Proin consectetur massa ut quam molestie porta. Donec sit amet ligula odio. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Morbi ex sapien, pulvinar ac arcu at, luctus scelerisque nibh. In dolor velit, pellentesque eu blandit a, mollis ac neque. Fusce tortor lectus, aliquam et eleifend id, aliquet ut libero. Nunc scelerisque vulputate turpis quis volutpat. Vivamus malesuada sem in dapibus aliquam. Vestibulum imperdiet, nulla vitae pharetra pretium, magna felis placerat libero, quis tincidunt felis diam nec nisi. Sed scelerisque ullamcorper cursus. Suspendisse posuere, velit nec rhoncus cursus, urna sapien consectetur est, et lacinia odio leo nec massa. Nam vitae nunc vitae tortor vestibulum consequat ac quis risus. Sed finibus pharetra orci, id vehicula tellus eleifend sit amet.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;', 1, '2021-07-16 10:08:53'),
(3, 1, 2, 'English Grammar in Use', 'Raymond Murphy, Surai Pongtongcharoen', '&lt;p&gt;&lt;span style=\\&quot;text-align: justify;\\&quot;&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam non ultrices tortor. Sed at ligula non lectus tempor bibendum a nec ante. Maecenas iaculis vitae nisi eu dictum. Duis sit amet enim arcu. Etiam blandit vulputate magna, non lobortis velit pharetra vel. Morbi sollicitudin lorem sed augue suscipit, eu commodo tortor vulputate. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent eleifend interdum est, at gravida erat molestie in. Vestibulum et consectetur dui, ac luctus arcu. Curabitur et viverra elit. Cras ac eleifend ipsum, ac suscipit leo. Vivamus porttitor ac risus eu ultricies. Morbi malesuada mi vel luctus sagittis. Ut vestibulum porttitor est, id rutrum libero. Mauris at lacus vehicula, aliquam purus quis, pharetra lorem.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;', 1, '2021-07-16 12:03:08'),
(4, 1, 2, 'English Grammar for Dummies', 'Geraldine Woods', '&lt;p style=\\&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px;\\&quot;&gt;Ut et urna sapien. Nulla lacinia sagittis felis id cursus. Etiam eget lacus quis enim aliquet dignissim. Nulla vel elit ultrices, venenatis quam sed, rutrum magna. Pellentesque ultricies non lorem hendrerit vestibulum. Maecenas lacinia pharetra nisi, at pharetra nunc placerat nec. Maecenas luctus dolor in leo malesuada, vel aliquet metus sollicitudin. Curabitur sed pellentesque sem, in tincidunt mi. Aliquam sodales aliquam felis, eget tristique felis dictum at. Proin leo nisi, malesuada vel ex eu, dictum pellentesque mauris. Quisque sit amet varius augue.&lt;/p&gt;&lt;p style=\\&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px;\\&quot;&gt;Sed quis imperdiet est. Donec lobortis tortor id neque tempus, vel faucibus lorem mollis. Fusce ut sollicitudin risus. Aliquam iaculis tristique nunc vel feugiat. Sed quis nulla non dui ornare porttitor eu vitae nisi. Curabitur at quam ut libero convallis mattis vel eget mauris. Vivamus vitae lectus ligula. Nulla facilisi. Vivamus tristique maximus nulla, vel mollis felis blandit posuere. Curabitur mi risus, rutrum non magna at, molestie gravida magna. Aenean neque sapien, volutpat a ullamcorper nec, iaculis quis est.&lt;/p&gt;', 1, '2021-07-16 13:11:17');

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `add_inventory_row` AFTER INSERT ON `products` FOR EACH ROW BEGIN
    INSERT INTO inventory (product_id, quantity, price, date_created)
    VALUES (NEW.id, 0, 0, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(30) NOT NULL,
  `order_id` int(30) NOT NULL,
  `total_amount` double NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `order_id`, `total_amount`, `date_created`) VALUES
(13, 15, 1000, '2023-05-31 11:19:52');

-- --------------------------------------------------------

--
-- Stand-in structure for view `sales_by_date`
-- (See below for the actual view)
--
CREATE TABLE `sales_by_date` (
`date` date
,`total_sales` double
);

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` int(30) NOT NULL,
  `parent_id` int(30) NOT NULL,
  `sub_category` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `parent_id`, `sub_category`, `description`, `status`, `date_created`) VALUES
(1, 1, 'Programming', '&lt;p&gt;Sample Sub Category&lt;/p&gt;', 1, '2021-07-16 09:10:44'),
(2, 1, 'Grammar', '&lt;p&gt;Sample Sub 102&lt;/p&gt;', 1, '2021-07-16 09:11:05'),
(3, 2, 'Literary', '&lt;p&gt;Sample Sub 103&lt;/p&gt;', 1, '2021-07-16 09:11:36'),
(4, 2, 'Historical', '&lt;p&gt;Sample 104&lt;/p&gt;', 1, '2021-07-16 09:12:51'),
(5, 3, 'Fantasy', '&lt;p&gt;Sample Sub 105&lt;/p&gt;', 1, '2021-07-16 09:13:28'),
(6, 3, 'Action and Adventure', '&lt;p&gt;Sample Sub 106&lt;/p&gt;', 1, '2021-07-16 09:13:49'),
(7, 4, 'Sub Cat 101', '&lt;p&gt;Sample Sub 107&lt;/p&gt;', 1, '2021-07-16 11:34:22');

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Online Bookstore Management Sytsem'),
(6, 'short_name', 'OBMS'),
(11, 'logo', 'uploads/1684393140_tinywow_logo_11379111.png'),
(13, 'user_avatar', 'uploads/user_avatar.jpg'),
(14, 'cover', 'uploads/1684318020_bg2.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `date_added`, `date_updated`) VALUES
(1, 'Adminstrator', 'Admin', 'admin', '0192023a7bbd73250516f069df18b500', 'uploads/1681790160_1671504240_wojak_studio (1).png', NULL, 1, '2021-01-20 14:02:37', '2023-04-18 11:56:27');

-- --------------------------------------------------------

--
-- Structure for view `inventory_status`
--
DROP TABLE IF EXISTS `inventory_status`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inventory_status`  AS SELECT `products`.`title` AS `product_name`, `inventory`.`quantity` AS `quantity`, `inventory`.`price` AS `price`, `inventory`.`quantity`* `inventory`.`price` AS `total_value` FROM (`inventory` join `products` on(`products`.`id` = `inventory`.`product_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `order_details`
--
DROP TABLE IF EXISTS `order_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_details`  AS SELECT `orders`.`id` AS `order_id`, `orders`.`order_type` AS `order_type`, `orders`.`delivery_address` AS `delivery_address`, `orders`.`payment_method` AS `payment_method`, `orders`.`amount` AS `amount`, group_concat(`products`.`title` separator ',') AS `products` FROM ((`order_list` join `orders` on(`orders`.`id` = `order_list`.`order_id`)) join `products` on(`products`.`id` = `order_list`.`product_id`)) GROUP BY `orders`.`id` ;

-- --------------------------------------------------------

--
-- Structure for view `pending_orders`
--
DROP TABLE IF EXISTS `pending_orders`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pending_orders`  AS SELECT `orders`.`id` AS `order_id`, `orders`.`order_type` AS `order_type`, `orders`.`delivery_address` AS `delivery_address`, `orders`.`amount` AS `amount`, `orders`.`date_created` AS `date_created` FROM `orders` WHERE `orders`.`status` = 0 ;

-- --------------------------------------------------------

--
-- Structure for view `popular_products`
--
DROP TABLE IF EXISTS `popular_products`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `popular_products`  AS SELECT `products`.`title` AS `product`, count(`order_list`.`product_id`) AS `orders` FROM (`order_list` join `products` on(`products`.`id` = `order_list`.`product_id`)) GROUP BY `order_list`.`product_id` ORDER BY count(`order_list`.`product_id`) DESC LIMIT 0, 10 ;

-- --------------------------------------------------------

--
-- Structure for view `sales_by_date`
--
DROP TABLE IF EXISTS `sales_by_date`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sales_by_date`  AS SELECT cast(`sales`.`date_created` as date) AS `date`, sum(`sales`.`total_amount`) AS `total_sales` FROM `sales` GROUP BY cast(`sales`.`date_created` as date) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cart_clients` (`client_id`),
  ADD KEY `fk_cart_inventory` (`inventory_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_inventory_products` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_orders_client` (`client_id`);

--
-- Indexes for table `order_list`
--
ALTER TABLE `order_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_orders` (`order_id`),
  ADD KEY `fk_order_product` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_product_category` (`category_id`),
  ADD KEY `fk_product_subcategory` (`sub_category_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sales_order` (`order_id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_parent_category` (`parent_id`);

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `order_list`
--
ALTER TABLE `order_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_cart_clients` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cart_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_inventory_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_list`
--
ALTER TABLE `order_list`
  ADD CONSTRAINT `fk_order_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_product_subcategory` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `fk_sales_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `fk_parent_category` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
