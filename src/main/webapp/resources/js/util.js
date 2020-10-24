function WindowOpen(src, title, width, height) {
	window.open(src , title, "toolbar=no,width=" + width + ",height=" + height + ",resizable=yes,scrollbars=yes");
}

function WindowOpenPost(src, title, width, height, data) {
	window.open("" , title, "toolbar=no,width=" + width + ",height=" + height + ",resizable=yes,scrollbars=yes");
    data = typeof data == 'string' ? data : paramCreate(data);
    Log(data);    
    var inputs = '';
    $.each(data.split('&'), function(){ 
        var pair = this.split('=');
        inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
    });
    
    $('<form action="' + src + '" method="post" target="' + title + '">' + inputs + '</form>')
    .appendTo('body').submit().remove();
}

function CheckNull(t) {
	if(t == null || t == undefined) {
		return true;
	}		
	
	return false;
}

function GetSimpleFileDownload(url) {
	if ($("[name='tempIframe']")[0] == undefined || $("[name='tempIframe']")[0] == null) {
		$("[name='tempIframe']").remove();
    }   
	
	$("<iframe name='tempIframe' style='display:none' src='" + url + "'  ></iframe>").appendTo('body');
};

function Log(log) {
    if (console != null && console.log != null) {
        console.log(log);
    }
}

var Ajax = Ajax || {};

Ajax.SyncPostHtml = function (webMethodName, argument) {
	Loding_Start();
    var returnData;
    $.ajax({
        type: 'POST',
        dataType: "html",
        url: webMethodName,
        traditional: true,
        //contentType: "application/json",
        data: argument,
        async: false,
        beforeSend: function (xhr) {

        },
        success: function (result) {
			Loding_Stop();
            returnData = result;
        },
        error: function (response) {
			Loding_Stop();
            if (response != null && response.status != null && response.status != 200)
                //alert(response.status + ' ' + response.statusText);
                Log(response.status + ' ' + response.statusText)
        }
    });

    return returnData;
}


Ajax.SyncPostService = function (webMethodName, argument) {
	Loding_Start();
    var returnData;
    $.ajax({
        type: 'POST',
        dataType: "json",
        url: webMethodName,
        traditional: true,
        //contentType: "application/json",
        data: argument,
        async: false,
        beforeSend: function (xhr) {

        },
        success: function (result) {
			Loding_Stop();
            returnData = result;
        },
        error: function (response) {
			Loding_Stop();
            if (response != null && response.status != null && response.status != 200)
                //alert(response.status + ' ' + response.statusText);
                Log(response.status + ' ' + response.statusText)
        }
    });

    return returnData;
}

Ajax.AsyncPostService = function (webMethodName, argument, callBackFunction, errorFunction) {   
	Loding_Start(); 
    $.ajax({
        type: 'POST',
        dataType: "json",
		//contentType: "application/json",
        url: webMethodName,
        data: argument,
        async: true,
        beforeSend: function (xhr) {

        },
        success: function (result) {
			Loding_Stop();			
            eval(callBackFunction)(result);            
        },
        error: function (response) {
			Loding_Stop();
            //alert(response.status + ' ' + response.statusText);        	
            Log(response.status + ' ' + response.statusText)
            eval(errorFunction)(response.statusText);            
        }
    });
}

Ajax.SyncGetService = function (webMethodName, argument) {
	Loding_Start();
    var callUrl = webMethodName + "?" + argument;
    var returnData;
    $.ajax({
        type: 'GET',
        dataType: "json",
        url: callUrl,
        async: false,
        beforeSend: function (xhr) {

        },
        success: function (result) {
			Loding_Stop();
            returnData = result;
        },
        error: function (response) {
			Loding_Stop();
            //alert(response.status + ' ' + response.statusText);
            Log(response.status + ' ' + response.statusText)
        }
    });

    return returnData;
}

Ajax.AsyncGetService = function (webMethodName, argument, callBackFunction, errorFunction) {
	Loding_Start();
    var callUrl = webMethodName + "?" + argument;
    $.ajax({
        type: 'GET',
        dataType: "json",
        url: callUrl,
        async: true,
        beforeSend: function (xhr) {

        },
        success: function (result) {
			Loding_Stop();
            eval(callBackFunction)(result);
        },
        error: function (response) {
			Loding_Stop();
            //alert(response.status + ' ' + response.statusText);
            Log(response.status + ' ' + response.statusText)
            eval(errorFunction)(response.statusText);
        }
    });
}


Ajax.AjaxResponseModelService = function (srcObj, targetUrl, params, onSuccess, onFailure, options) {
    if (targetUrl == null || targetUrl == '') return;

	Loding_Start();

    var settings = {
        type: 'POST',
        aync: true,
        contentType: 'application/json;charset=utf-8',
        dataType: 'json'
    };

    options = $.extend(true, {}, settings, options);

    $.ajax({
        url: targetUrl,
        data: JSON.stringify(params),
        type: options.type,
        async: options.async,
        contentType: options.contentType,
        dataType: options.dataType
    })
		.done(function (response) {
			Loding_Stop();
		    var result = null;
		    if (response != null) {
		        if (typeof (response.Message) != 'undefined' && $.trim(response.Message) != '') {
		            alert(response.Message);
		        }
		        if (typeof (response.Success) != 'undefined' && response.Success) {
		            if ($.isFunction(onSuccess)) {
		                if (typeof (response.Result) != 'undefined') {
		                    result = response.Result;
		                }
		                onSuccess.call(srcObj, result);
		            }
		        }
		    }
		})
		.fail(function (error) {
			Loding_Stop();
		    var exception = null;
		    if (error != null && typeof (error.responseText) != 'undefined') {
		        try {
		            exception = $.parseJSON(error.responseText);
		            if (typeof (exception.ExceptionMessage) != "undefined" && $.trim(exception.ExceptionMessage) != '') {
		                alert(exception.ExceptionMessage);
		            }
		        } catch (ex) {
		            //alert(ex.name); 
		        }
		    }
		    if ($.isFunction(onFailure)) {
		        onFailure.call(srcObj, exception);
		    }
		});
}

function QueryString() {
  // This function is anonymous, is executed immediately and 
  // the return value is assigned to QueryString!
  var query_string = {};
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
    var pair = vars[i].split("=");
        // If first entry with this name
    if (typeof query_string[pair[0]] === "undefined") {
      query_string[pair[0]] = decodeURIComponent(pair[1]);
        // If second entry with this name
    } else if (typeof query_string[pair[0]] === "string") {
      var arr = [ query_string[pair[0]],decodeURIComponent(pair[1]) ];
      query_string[pair[0]] = arr;
        // If third or later entry with this name
    } else {
      query_string[pair[0]].push(decodeURIComponent(pair[1]));
    }
  } 
    return query_string;
}

function serializeObject(id)
{
	var result = {};
	var extend = function (i, element) {
		var node = result[element.name];

// If node with same name exists already, need to convert it to an array as it
// is a multi-value field (i.e., checkboxes)

		if ('undefined' !== typeof node && node !== null) {
			if ($.isArray(node)) {
				node.push(element.value);
			} else {
				result[element.name] = [node, element.value];
			}
		} else {
			result[element.name] = element.value;
		}
	};

	$.each(this.serializeArray(), extend);
	return result;
}

(function($){
	$.fn.serializeObject = function () {
		"use strict";

		
	};
})(jQuery);


function GetAjaxFileDownload(url, data, method) {    
    if( url && data ){
        data = typeof data == 'string' ? data : paramCreate(data);
        Log(data);        
        var inputs = '';
        $.each(data.split('&'), function(){ 
            var pair = this.split('=');
            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
        });
        
        // request를 보낸다.
        if ($("[name='tempIframe']")[0] == undefined || $("[name='tempIframe']")[0] == null) {
            $("<iframe name='tempIframe' style='display:none'  ></iframe>").appendTo('body');
        }
        $('<form target="tempIframe" action="' + url + '" method="' + (method || 'post') + '">' + inputs + '</form>')
        .appendTo('body').submit().remove();
    };
};

function paramCreate( a, traditional ) {
    var prefix,
		s = [],
		add = function( key, value ) {		    
		    value = jQuery.isFunction( value ) ? value() : ( value == null ? "" : value );
		    s[ s.length ] = key + "=" + value;
		};
    
    if ( traditional === undefined ) {
        traditional = jQuery.ajaxSettings && jQuery.ajaxSettings.traditional;
    }

    if ( jQuery.isArray( a ) || ( a.jquery && !jQuery.isPlainObject( a ) ) ) {        
        jQuery.each( a, function() {
            add( this.name, this.value );
        });

    } else {        
        for (prefix in a) {            
            buildParams(prefix, a[prefix], traditional, add);
        }
    }
    
    return s.join("&").replace(/%20/g, "+");
}

function buildParams(prefix, obj, traditional, add) {
    var name;

    if (jQuery.isArray(obj)) {        
        jQuery.each(obj, function (i, v) {
            if (traditional || rbracket.test(prefix)) {                
                add(prefix, v);

            } else {                
                buildParams(prefix + "[" + (typeof v === "object" ? i : "") + "]", v, traditional, add);
            }
        });

    } else if (!traditional && jQuery.type(obj) === "object") {        
        for (name in obj) {
            buildParams(prefix + "[" + name + "]", obj[name], traditional, add);
        }

    } else {        
        add(prefix, obj);
    }
}

function getUrlParams() {
    var params = {};
    window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
    return params;
}

function enterInput(id, callBackFunction) {
	$(id).keydown(function(key) {
        if (key.keyCode == 13) {			       
			eval(callBackFunction)();   
        }
    });
}