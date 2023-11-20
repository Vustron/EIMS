<hr>
<div class="row">

    <div class="col-6 col-lg-12">
        <div class="info-box mb-3">
            <div class="info-box-content">
                <h4 class="text-center"><b>Inventory Status</b></h4>
                <canvas id="info-table1"></canvas>
            </div>
        </div>
    </div>

    <div class="col-6 col-lg-12">
        <div class="info-box mb-3">
            <div class="info-box-content">

                <div class="card card-outline card-primary">
                    <div class="card-header">
                        <h4 class="text-center">Order Details</h4>
                    </div>

                    <div class="card-body">
                        <div class="container-fluid">
                            <div class="container-fluid">
                                <table class="table table-bordered table-stripped">
                                    <colgroup>
                                        <col width="5%">
                                        <col width="15%">
                                        <col width="25%">
                                        <col width="20%">
                                        <col width="10%">
                                        <col width="10%">
                                        <col width="15%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Order ID</th>
                                            <th>Order Type</th>
                                            <th>Delivery Address</th>
                                            <th>Payment Method</th>
                                            <th>Amount</th>
                                            <th>Products</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        $qry = $conn->query("SELECT * FROM order_details");
                                        $count = 1;
                                        while ($row = $qry->fetch_assoc()) :
                                        ?>
                                            <tr>
                                                <td class="text-center"><?php echo $count ?></td>
                                                <td><?php echo $row['order_id'] ?></td>
                                                <td><?php echo $row['order_type'] ?></td>
                                                <td><?php echo $row['delivery_address'] ?></td>
                                                <td><?php echo $row['payment_method'] ?></td>
                                                <td><?php echo "₱";
                                                    echo $row['amount'] ?></td>
                                                <td><?php echo $row['products'] ?></td>
                                            </tr>
                                        <?php
                                            $count++;
                                        endwhile;
                                        ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- fix for small devices only -->
    <div class="clearfix hidden-md-up"></div>

    <div class="col-6 col-lg-12">
        <div class="info-box mb-3">
            <div class="info-box-content">
                <div class="card card-outline card-primary">
                    <div class="card-header">
                        <h4 class="text-center">Pending Orders</h4>
                    </div>
                    <div class="card-body">
                        <div class="container-fluid">
                            <div class="container-fluid">
                                <table class="table table-bordered table-stripped">
                                    <colgroup>
                                        <col width="5%">
                                        <col width="15%">
                                        <col width="25%">
                                        <col width="20%">
                                        <col width="10%">
                                        <col width="10%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Order ID</th>
                                            <th>Order Type</th>
                                            <th>Delivery Address</th>
                                            <th>Amount</th>
                                            <th>Date Created</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        $qry = $conn->query("SELECT * FROM pending_orders");
                                        $count = 1;
                                        while ($row = $qry->fetch_assoc()) :
                                        ?>
                                            <tr>
                                                <td class="text-center"><?php echo $count ?></td>
                                                <td><?php echo $row['order_id'] ?></td>
                                                <td><?php echo $row['order_type'] ?></td>
                                                <td><?php echo $row['delivery_address'] ?></td>
                                                <td><?php echo "₱" . number_format($row['amount'], 2) ?></td>
                                                <td><?php echo $row['date_created'] ?></td>
                                            </tr>
                                        <?php
                                            $count++;
                                        endwhile;
                                        ?>
                                    </tbody>
                                    <canvas id="info-table4"></canvas>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-6 col-lg-12">
        <div class="info-box mb-3">
            <div class="info-box-content">
                <h4 class="text-center"><b>Popular Products</b></h4>
                <canvas id="info-table2"></canvas>
            </div>
        </div>
    </div>

    <div class="col-6 col-lg-12">
        <div class="info-box mb-3">
            <div class="info-box-content">
                <h4 class="text-center"><b>Sales By Date</b></h4>
                <canvas id="info-table3"></canvas>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Charts -->
    <script>
        const ctx1 = document.getElementById('info-table1');
        const ctx2 = document.getElementById('info-table2');
        const ctx3 = document.getElementById('info-table3');
        const ctx4 = document.getElementById('info-table4');
        const ctx5 = document.getElementById('info-table5');

        // Retrieve the data from the inventory_status view using a SQL query
        <?php
        $query = "SELECT * FROM inventory_status";
        $result = $conn->query($query);

        // Organize the data for Chart.js
        $labels = [];
        $values = [];
        $price = [];
        $quantity = [];

        while ($row = $result->fetch_assoc()) {
            $labels[] = $row['product_name'];
            $values[] = $row['total_value'];
            $price[] = $row['price'];
            $quantity[] = $row['quantity'];
        }
        ?>

        // Create the bar chart using Chart.js
        new Chart("info-table1", {
            type: 'bar',
            data: {
                labels: <?php echo json_encode($labels); ?>,
                datasets: [{
                    label: 'Total Value',
                    data: <?php echo json_encode($values); ?>,
                    backgroundColor: ['red', 'blue', 'green', 'yellow', 'orange'],
                }, {
                    label: 'Price',
                    data: <?php echo json_encode($price); ?>,
                    backgroundColor: ['pink', 'lightblue', 'lightgreen', 'lightyellow'],
                }, {
                    label: 'Quantity',
                    data: <?php echo json_encode($quantity); ?>,
                    backgroundColor: ['cyan', 'violet', 'orange', 'brown', 'coral'],
                }]
            },
            options: {
                responsive: true,
                indexAxis: 'y',
            }
        });

        // Retrieve the data from the popular_products view using a SQL query
        <?php
        $query = "SELECT * FROM popular_products";
        $result = $conn->query($query);

        // Organize the data for Chart.js
        $labels = [];
        $orders = [];
        while ($row = $result->fetch_assoc()) {
            $labels[] = $row['product'];
            $orders[] = $row['orders'];
        }
        ?>

        // Create the bar chart using Chart.js
        new Chart("info-table2", {
            type: 'bar',
            data: {
                labels: <?php echo json_encode($labels); ?>,
                datasets: [{
                    label: 'Number of Orders',
                    data: <?php echo json_encode($orders); ?>,
                    backgroundColor: ['cyan', 'violet', 'orange', 'brown', 'burgundy'],
                }]
            },
            options: {
                responsive: true,
                indexAxis: 'y',
            }
        });

        // Retrieve the data from the sales_by_date view using a SQL query
        <?php
        $query = "SELECT * FROM sales_by_date";
        $result = $conn->query($query);

        // Organize the data for Chart.js
        $labels = [];
        $sales = [];
        while ($row = $result->fetch_assoc()) {
            $labels[] = $row['date'];
            $sales[] = $row['total_sales'];
        }
        ?>

        // Create the line chart using Chart.js
        new Chart("info-table3", {
            type: 'line',
            data: {
                labels: <?php echo json_encode($labels); ?>,
                datasets: [{
                    label: 'Total Sales',
                    data: <?php echo json_encode($sales); ?>,
                    borderColor: 'green', // Customize the line color as needed
                    backgroundColor: 'lightgreen', // Customize the fill color as needed
                }]
            },
            options: {
                // Add any additional chart options here
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Execute the stored procedure to retrieve the pending orders count
        <?php
        $query1 = 'CALL get_pending_orders_count()';
        $result1 = $conn->query($query1);

        // Retrieve the pending orders count from the result
        $pendingCount = 0;
        if ($result1->num_rows > 0) {
            $row = $result1->fetch_assoc();
            $pendingCount = $row['total'];
        }
        ?>

        // Create the bar chart using Chart.js
        new Chart("info-table4", {
            type: 'bar',
            data: {
                labels: ['Total Pending Orders'],
                datasets: [{
                    label: 'Total Pending Orders',
                    data: [<?php echo $pendingCount ?>],
                    borderWidth: 2,
                    barThickness: 50,
                    maxBarThickness: 50,
                    minBarLength: 10,
                    backgroundColor: ['green'],
                }]
            },
            options: {
                responsive: true,
                indexAxis: 'y',
            }
        });

   
    </script>