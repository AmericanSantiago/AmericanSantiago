var res = {
	bg_png: 'res/bg_petstore.png',
	Farm_a_Dog_dn_png: 'res/Farm_a_Dog_dn.png',
	Farm_a_Dog_bjwy_png: 'res/Farm_a_Dog_bjwy.png',
	Farm_a_Dog_hd_png: 'res/Farm_a_Dog_hd.png',
	num1_png: 'res/nums/num1.png',
	num2_png: 'res/nums/num2.png',
	num3_png: 'res/nums/num3.png',
	
};

var resAudio = {
	question_wav: 'res/question.wav',
	bgm_mp3: 'res/bgm.mp3',
	right_mp3: 'res/right.mp3',
	wrong_mp3: 'res/wrong.mp3',
	numbers: [
		'res/number/1.wav',
		'res/number/2.wav',
		'res/number/3.wav',
	]
};


var g_resources = [];
for (var i in res) {
    g_resources.push(res[i]);
}