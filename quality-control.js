// adds .u-error--insufficient-alt if alt attribute is < 7 or > 81
var qcImages = document.querySelectorAll("main img");
qcImages.forEach(function(el) {
	if(el.alt.length < 7 || el.alt.length > 81) {
		el.classList.add('u-error--insufficient-alt');
		el.parentElement.classList.add('u-error--insufficient-alt');
    }
});
