function check_sign_input(ele,num1,num2){
				var num=parseInt(ele);
				var temp_id="#input_label_"+num;
				var the_ele=$("#"+ele);
				var the_ele1=$(temp_id);
				var min=parseInt(num1);
				var max=parseInt(num2);
				var the_length=$("#"+ele).val().length;
				if(the_length>=min&&the_length<max){
					the_ele1.removeClass();
					the_ele1.addClass("badge badge-success");
					$(temp_id).html(the_length);
				}
				else if(the_length==max){
					the_ele1.removeClass();
					the_ele1.addClass("badge badge-warning");
					$(temp_id).html(the_length);
				}
				else if(the_length>max){
					the_ele1.removeClass();
					the_ele1.addClass("badge badge-important");
					$(temp_id).html(the_length);
				}else{
					the_ele1.removeClass();
					the_ele1.addClass("badge");
					$(temp_id).html(the_length);
				}
			}
function disable_btn(ele){
				$(ele).attr("disabled","disabled");
			}
function enable_btn(ele){
	$(ele).removeAttr("disabled")
}
function check_input_ok(ele1,ele2,min,max,target,key){//用于检测两次输入是否一致，是否满足最大最小长度限制，是则开启按钮
				the_ele1=$(ele1).val();
				the_ele2=$(ele2).val();
				ele1_l=the_ele1.length;
				ele2_l=the_ele2.length;
				the_target=$(target);
				the_min=parseInt(min);
				the_max=parseInt(max);
				if(the_ele1==the_ele2&&ele1_l>=min&&ele1_l<=max){
					if(key=="on"){
						enable_btn(target);
					}
					return true;
				}else{
					disable_btn(target);
					return false;
				}
			}