// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//jQuery.ajaxSetup({
//    'beforeSend': function(xhr) {
//        xhr.setRequestHeader("Accept", "text/javascript");
//    },
//    cache: false
// });

$(document).ready(function() {

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

});
