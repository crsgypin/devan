var vAttributeAddRow = function(e,object){
	e.preventDefault();
	var vAttrFieldGroup = new vAttributeFieldGroup($(object).closest('.attribute-field-group')[0])
	vAttrFieldGroup.addRow();
}

var vAttributeRemoveRow = function(e,object){
	e.preventDefault();
	var vAttrField = new vAttributeField($(object).closest('.attribute-field')[0])
	vAttrField.removeSelf();
}

var vAttributeFieldGroup = function(html){
	this.html = html;
	this.object = $(html);
	this.maxIndex = 0;

	this.updateIndex = function(){
		var self = this;
		this.object.find('.attribute-field').each(function(index,element){
			var vAF = new vAttributeField(element);
			if(self.maxIndex<vAF.index){
				self.maxIndex = vAF.index;
			}
		})
	}
	this.addRow = function(){
		var newIndex = this.maxIndex +1;
		var vAF = new vAttributeField(this.object.find('.attribute-field')[0])
		this.object.find('.attribute-field').last().after(vAF.clone(newIndex));
		this.updateIndex();
	}
	this.updateIndex();
}

var vAttributeField = function(html){
	this.html = html;
	this.object = $(html);
	this.index = null;
	this.idValue = "";
	this.destroyName = "";

	this.init = function(){
		var self = this;
		this.object.find('*').each(function(index,element){
			var name = $(element).attr('name');
			if(name){
				var nameAttrs = name.match(/\w+/g);
				if(!isNaN(nameAttrs[2]) && self.index==null){
					self.index = parseInt(nameAttrs[2]);
				}
				if(nameAttrs[3]=="id"){
					self.idValue = $(element).attr('value');
				}
				if(self.destroyName==""){
					self.destroyName=nameAttrs[0]+'['+nameAttrs[1]+']['+nameAttrs[2]+'][_destroy]'
				}
			}
		})
	}
	this.clone = function(newIndex){
		var self = this;
		var newObject = this.object.clone();
		newObject.find('*').each(function(index,element){
			var name = $(element).attr('name');
			if(name){
				$(element).attr('name',name.replace('['+self.index+']','['+newIndex+']'))
			};
			var id = $(element).attr('id');
			if(id){
				$(element).attr('id',id.replace('_'+self.index+'_', '_'+newIndex+'_' ) );
			};
			var value = $(element).attr('value');
			if(value){
				$(element).attr('value',"")
			};
			$(element).val("");
		})
		return newObject;
	}
	this.removeSelf = function(){
		if(this.idValue==""){
			this.object.remove();
		}else{
			var hiddenInput = $("<input type='hidden' name=" + this.destroyName + " value='1'>")[0]
				this.object.prepend(hiddenInput);
			this.object.hide();
		}
	}

	this.init();
}

