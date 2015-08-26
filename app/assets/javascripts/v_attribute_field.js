
var vAttributeFieldGroup = function(groupObject){
	this.html = groupObject;
	this.groupObject = $(groupObject);
	this.attrFields = [];
	this.submodelIndexes = [];
	this.maxIndex = null;

	this.init = function(){
		var attrFieldArr = [];
		var submodelIndexes = [];
		this.groupObject.find('.attribute-field').each(function(index,element){
			var attrField = new vAttributeField(element);
			attrFieldArr.push(attrField);
			submodelIndexes.push(attrField.submodelIndex);
		})
		this.attrFields = attrFieldArr;
		this.submodelIndexes = submodelIndexes;
		this.maxIndex = Math.max.apply(Math,this.submodelIndexes);
	}
	this.addField = function(){
		var newIndex = this.maxIndex +1;
		var newAttrField = this.attrFields[0].clone(newIndex);
		this.groupObject.append(newAttrField);
		this.init();
	}
	this.removeField = function(index){
		this.attrFields[index].removeThis();
	}
	this.init();
}

var vAttributeField = function(html){
	this.html = html;
	this.object = $(html);
	this.inputs = [];
	this.mainModel = "";
	this.subModel = "";
	this.submodelIndex = null;

	this.init = function(){
		var inputArr = [];
		var self = this;

		this.object.find("input").each(function(index,element){
			input = new vInputObject(element);
			if(self.mainModel==""){self.mainModel=input.mainModel}
			if(self.submodel==""){self.subModel=input.submodel}
			if(self.submodelIndex==null){self.submodelIndex=input.submodelIndex}
			inputArr.push(input);
		})
		this.inputs = inputArr;
	}
	this.clone = function(index){
		var attrField = $('<div></div>');
		attrField.addClass('attribute-field');
		this.inputs.forEach(function(input){
			attrField.append(input.clone(index));
		})
		return attrField;
	}
	this.removeThis = function(){
		this.object.hide();

	}
	this.init();
}

var vInputObject = function(html){
	this.html = html
	this.object = $(html);
	this.name = "";
	this.id = "";
	this.type = "";
	this.value = null;
	this.mainModel = "";
	this.submodel = "";
	this.submodelIndex = null;
	this.submodelAttr = "";

	this.init = function(){
		this.name = this.object.attr('name')
		this.id = this.object.attr('id')
		this.type = this.object.attr('type')
		this.value = this.object.attr('value')

		var attrs = this.name.match(/\w+/g)
		this.mainModel = attrs[0];
		this.submodel = attrs[1];
		this.submodelIndex = parseInt(attrs[2]);
		this.submodelAttr = attrs[3];
	}
	this.clone = function(index){
		var input = $('<input>');
		var newIndex = !isNaN(index)? index : this.submodelIndex;
		var newName = this.mainModel + '[' + this.submodel + ']['+newIndex+']['+this.submodelAttr+']';
		var newId = this.mainModel+'_'+this.submodel+'_'+newIndex+'_'+this.submodelAttr;
		input.attr('name',newName);
		input.attr('id',newId);
		input.attr('type',this.type);
		return input;
	}
	this.init();
}


