_giv = {

  status: {},

  page_ready: function(){
    _giv.setup_search_field();
    _giv.setup_cookie_alert();
    _giv.setup_resizable_text();
  },

  setup_resizable_text: function(){
  
    var rt = $(".review-text.original");
    
    rt.each(function(){
    
      var so = $(this).height();
      var si = $(this).find(".review-text-inner").height();
      if(so < si){
        $(this).addClass("shrunk");
        $(this).find(".read-more").removeClass("hidden");
      }
    });
    
    rt.click(function(){
      $(this).removeClass("original");
      $(this).removeClass("shrunk");
      $(this).addClass("expanded");
    });
  },
  

  setup_cookie_alert: function(){
    $('#giv_cookie_alert').on('closed.bs.alert', function () {
      document.cookie = "giv_cookie_alert_confirmed=done";
    });
  
  
  },
  setup_search_field: function(){

    var pf = $('.property-search-field');
    var sf = $(".property_search_form");
    var sb = sf.find("input:submit");
    var ilat = $("#location_latitude");
    
    var ilng = $("#location_longitude");
    ilat.val("");
    ilng.val("");
      
    pf.on('blur', function(ev){
    
      if($(this).val() == null || $(this).val() == ''){
      
        $(this).val(_giv.constants.current_location_text);
      }
    }).on('focus', function(){
      ilat.val("");
      ilng.val("");
      if($(this).val() == _giv.constants.current_location_text){
      
        $(this).val("");
        sb.attr("disabled", null);
      }
      
    });
    
    
    
    sf.on("submit", function(ev){
      
      
      if($(this).find('.property-search-field').val() == _giv.constants.current_location_text){
        if(ilng.val()=="" || ilat.val()==""){
          ev.preventDefault();
          _giv.get_location();
        }
      }
    });
    
    $("a.current-location").on("click", function(ev){
      ev.preventDefault();
      pf.val(_giv.constants.current_location_text);
      sb.click();
    });
  },
  
  show_error: function(error){
    $("#notice").html(error);
  },
  
  show_location_error: function(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
            _giv.show_error("User denied the request for Geolocation.");
            _giv.use_location_position({coords: {latitude: 51.5, longitude: 0}});
            break;
        case error.POSITION_UNAVAILABLE:
            _giv.show_error("Location information is unavailable.");
            break;
        case error.TIMEOUT:
           _giv.show_error("The request to get user location timed out.");
            break;
        case error.UNKNOWN_ERROR:
            _giv.show_error("An unknown error occurred.");
            break;
    }
    
  },
  
  get_location: function (form) {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(_giv.use_location_position, _giv.show_location_error);
    } else {
        _giv.show_error("Geolocation is not supported by this browser.");
    }
  },
  use_location_position: function (position) {
 
    $("#location_latitude").val(position.coords.latitude);
    
    $("#location_longitude").val(position.coords.longitude);
    
    
    $(".property_search_form").submit();
  }
};

$(document).ready(function() {

  _giv.page_ready();

});
