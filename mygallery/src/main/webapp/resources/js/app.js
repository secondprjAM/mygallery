var faceList = document.getElementById('faceList');
var faceText = '<span></span>';
var listArray = [];
var uf = document.img_rename;

var checkboxes = document.querySelectorAll('.checkbox1');

for (var checkbox of checkboxes) {
	checkbox.addEventListener('click', function() {
		if (this.checked == true) {
			listArray.push(this.value);
			faceList.innerHTML = faceText + listArray.join(',');
		} else {
			listArray = listArray.filter(e => e !== this.value);
			faceList.innerHTML = faceText + listArray.join(',');
		}
	});

}

/*=================================================================*/

var noseList = document.getElementById('noseList');
var noseText = '<span></span>';
var noseArray = [];

var checkboxes = document.querySelectorAll('.checkbox2');
 
for (var radio of checkboxes) {
	radio.addEventListener('click', function() {	
		if (this.checked == true) {
			noseArray.push(this.value);
			noseList.innerHTML = noseText + noseArray.join(',');
			noseArray = noseArray.filter(e => e !== this.value);
		}
	});

}

/*=================================================================*/

var rightList = document.getElementById('rightList');
var rightText = '<span></span>';
var rightArray = [];

var checkboxes = document.querySelectorAll('.checkbox3');

for (var checkbox of checkboxes) {
	checkbox.addEventListener('click', function() {
		if (this.checked == true) {
			rightArray.push(this.value);
			rightList.innerHTML = rightText + rightArray.join(',');
			rightArray = rightArray.filter(e => e !== this.value);
		}
	});

}

/*=================================================================*/

var leftList = document.getElementById('leftList');
var leftText = '<span></span>';
var leftArray = [];

var checkboxes = document.querySelectorAll('.checkbox4');

for (var checkbox of checkboxes) {
	checkbox.addEventListener('click', function() {
		if (this.checked == true) {
			leftArray.push(this.value);
			leftList.innerHTML = leftText + leftArray.join(',');
			leftArray = leftArray.filter(e => e !== this.value);
		}
	});

}

