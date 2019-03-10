<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	     $(document).ready(function(){
      var i=1;
     $("#add_row").click(function(){
      $('#addr'+i).html("<td>"+ (i+1) +"</td><td><input name='Date"+i+"' type='text' placeholder='Date' class='form-control input-md'  /> </td><td><input  name='Doctor's Name"+i+"' type='text' placeholder='Doctor's Name'  class='form-control input-md'></td><td><input  name='Details"+i+"' type='text' placeholder='Details'  class='form-control input-md'></td>");

  $('#tab_logic').append('<tr id="addr'+(i+1)+'"></tr>');
      i++;
  });
     $("#delete_row").click(function(){
    	 if(i>1){
		 $("#addr"+(i-1)).html('');
		 i--;
		 }
	 });

});

</script> 
<div class="container">
    <div class="row clearfix">
		<div class="col-md-12 column">
			<table class="table table-bordered table-hover" id="tab_logic">
				<thead>
					<tr >
						<th class="text-center">
							#
						</th>
						<th class="text-center">
							Date
						</th>
						<th class="text-center">
							Doctor's Name
						</th>
						<th class="text-center">
							Details
						</th>
					</tr>
				</thead>
				<tbody>
					<tr id='addr0'>
						<td>
						1
						</td>
						<td>
						<input type="date" name='name0'  placeholder='Date' class="form-control"/>
						</td>
						<td>
						<input type="text" name='mail0' placeholder="Doctor's Name" class="form-control"/>
						</td>
						<td>
						<input type="text" name='mobile0' placeholder='Details' class="form-control"/>
						</td>
					</tr>
                    <tr id='addr1'></tr>
				</tbody>
			</table>
		</div>
	</div>
	<a id="add_row" class="btn btn-default pull-left">Add Row</a><a id='delete_row' class="pull-right btn btn-default">Delete Row</a>
</div>


