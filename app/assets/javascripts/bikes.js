$('.btn').button();

$("#add_bike_submit").click(function(){

  json_data = { bikes: [{
      serial_number:      $("#serial_number").val(),
      bike_brand_id:      parseInt($("#bike_brand_id").val()),
      shop_id:            parseInt($("#shop_id").val()),
      model:              $("#model").val(),
      bike_style_id:      parseInt($('input[name=bike_style]:checked').val()),
      seat_tube_height:   parseFloat($("#seat_tube_height").val()),
      bike_condition_id:  parseInt($('input[name=bike_condition]:checked').val()),
      bike_purpose_id:    1,
      bike_wheel_size_id: parseInt($("#bike_wheel_size_id").val()),
    }]};

  $.ajax({
    url: $("#add_bike_submit").data("url"),
    type: "POST",
    data: JSON.stringify(json_data),
    contentType: 'application/json',
    dataType: "json",
    success: function(data, status, xhr){
      window.location = data.bikes[0].id + "?add_bike=1";
    },
    error: function(data, status ){
      displayFormErrors(data.responseJSON);
    }
  });

});
