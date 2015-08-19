//switch
$(document).ready(function(){
	$('.menu-inner a').click(function(e){
		e.preventDefault();

		$('.menu-inner a').removeClass('selected');
		$(this).addClass('selected');
		updateViews();
	});	

	var updateViews = function(){
		$('.menu-inner a').each(function(index,elm){
			if ($(elm).attr('class').indexOf('selected')> -1){
				$($(elm).attr('content')).show();
			}else{
				$($(elm).attr('content')).hide();
			}
		})
	}
})
