<?php if ($_settings->chk_flashdata('success')) : ?>
	<script>
		alert_toast("<?php echo $_settings->flashdata('success') ?>", 'success')
	</script>
<?php endif; ?>
<?php if ($_settings->chk_flashdata('error')) : ?>
	<script>
		alert_toast("<?php echo $_settings->flashdata('error') ?>", 'error')
	</script>
<?php endif; ?>
<div class="card card-outline card-primary">
	<div class="card-header bg-white">
			<h3 class="card-title">List of Users</h3>
		</div>
		<div class="card-body bg-white">
			<div class="container-fluid">
				<div class="container-fluid">
					<table class="table table-bordered table-stripped">
						<colgroup>
							<col width="5%">
							<col width="15%">
							<col width="15%">
							<col width="20%">
							<col width="5%">
							<col width="10%">
							<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th class="text-center text-sm">#</th>
								<th class="text-center text-sm">First Name</th>
								<th class="text-center text-sm">Last Name</th>
								<th class="text-center text-sm">Contact</th>
								<th class="text-center text-sm">Email</th>
								<th class="text-center text-sm">Address</th>
								<th class="text-center text-sm">Date Created</th>
								<th class="text-center text-sm">Action</th>
							</tr>
						</thead>
						<tbody>
							<?php
							$qry = $conn->query("SELECT id, firstname, lastname, gender, contact, email, default_delivery_address, date_created FROM clients");
							while ($row = $qry->fetch_assoc()) :
							?>
								<tr>
									<td class="text-center text-sm"><?php echo $row['id'] ?></td>
									<td class="text-center text-sm"><?php echo $row['firstname'] ?></td>
									<td class="text-center text-sm"><?php echo $row['lastname'] ?></td>
									<td class="text-center text-sm"><?php echo $row['contact'] ?></td>
									<td class="text-center text-sm"><?php echo $row['email'] ?></td>
									<td class="text-center text-sm"><?php echo $row['default_delivery_address'] ?></td>
									<td class="text-center text-sm"><?php echo $row['date_created'] ?></td>

									<td align="center">
										<button type="button" class="btn btn-flat btn-default btn-sm dropdown-toggle dropdown-icon" data-toggle="dropdown">
											Action
											<span class="sr-only">Toggle Dropdown</span>
										</button>
										<div class="dropdown-menu bg-white" role="menu">
											<div class="dropdown-divider bg-white"></div>
											<a class="dropdown-item delete_data " href="javascript:void(0)" data-id="<?php echo $row['id'] ?>">
											<span class="fa fa-trash text-danger"></span> 
											Delete
											</a>
										</div>
									</td>
								</tr>
							<?php endwhile; ?>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$('.delete_data').click(function() {
				_conf("Are you sure to delete this user permanently?", "delete_user", [$(this).attr('data-id')])
			})
			$('.table').dataTable();
		})

		function delete_user(id) {
			start_loader();
			$.ajax({
				url: _base_url_ + "classes/Master.php?f=delete_user",
				method: "POST",
				data: {
					id: id
				},
				dataType: "json",
				error: err => {
					console.log(err)
					alert_toast("An error occured.", 'error');
					end_loader();
				},
				success: function(resp) {
					if (typeof resp == 'object' && resp.status == 'success') {
						location.reload();
					} else {
						alert_toast("An error occured.", 'error');
						end_loader();
					}
				}
			})
		}
	</script>