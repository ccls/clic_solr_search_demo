jQuery(function(){
	jQuery('#tabs li a').click(function(){
		jQuery('#tabs li a').removeClass('current');
		jQuery(this).addClass('current');
		tab_content_id = '#'+jQuery(this).parent().attr('class');
		jQuery('.tab_contents').hide();
		jQuery(tab_content_id).show();
		return false;
	});
});
