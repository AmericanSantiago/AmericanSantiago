var common_server_url =  '../../../common';

function loadScript(url, domElement) {
	var script = document.createElement('script');
	script.src = url;
	script.type = 'text/javascript';
	document.body.insertBefore(script, domElement);
}
loadScript(common_server_url + '/frameworks/cocos2d-js-v3.1.custom.js', document.getElementsByTagName('script')[2]);