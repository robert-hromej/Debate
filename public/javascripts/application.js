// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(function($) {
    observe_element('ajax_paginator');
});

function observe_element(element) {
    jQuery('.' + element + ' a').bind('click', function () {
        jQuery.ajax({
            dataType:'script',
            url:this.href,
            type:this.method,
            success: function() {
                observe_element(element);
            }
        });
        return false;
    });
}
