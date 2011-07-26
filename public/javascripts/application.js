// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//jQuery.ajaxSetup({
//    'beforeSend': function(xhr) {
//        xhr.setRequestHeader("Accept", "text/javascript");
//    },
//    cache: false
// });

$(document).ready(function() {

    // TODO Delete Me
    $('#test_rpc').click(function(){
        alert('Calling JSON reponse function');
    });

    $('.associate_poid_form').hide();



    $('.compliance_set_selector_radio').change(function() {
        //console.log(this);
        // Hide all compliance_set_divs & remove any selected formatting
        // Show the one that is selected with the selected formatting
        $('.associate_poid_form').hide();
        $('.compliance_set').removeClass("compliance_set_selected");
        $('#associate_pos_form_'+this.value).show();
        $('#compliance_set_'+this.value).addClass("compliance_set_selected");

    });

    // Jquery UI manipulation functions to control the display of WEEEE data form elements
    $('#wee_fields').hide();
    $('#show_wee_fields').click(function(){
        $('#wee_fields').show();
    });
    $("#hide_wee_fields").click(function() {
       $('#wee_fields').hide();
    });

    // Hide the wee category details till the sku is wee compliant
    $('#wee_category_selector').hide();
    if($('#compliance_wee_compliance').is(':checked')) {
        $('#wee_category_selector').show();
    }
    $('#compliance_wee_compliance').change(function(){
       $('#wee_category_selector').show();
    });

    // Hide the wee battery details till the sku contains a battery
    $('#wee_battery_details').hide();
    if($('#compliance_contains_battery').is(':checked')) {
        $('#wee_battery_details').show();
    }
    $('#compliance_contains_battery').change(function() {
       $('#wee_battery_details').show();
    });
});
