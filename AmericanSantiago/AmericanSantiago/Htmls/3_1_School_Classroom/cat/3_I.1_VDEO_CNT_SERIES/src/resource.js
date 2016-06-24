var res = {
	bg_png: 'res/bg.png',
	Farm_a_Cat_bs_png: 'res/Farm_a_Cat_bs.png',
	Farm_a_Cat_twdm_png: 'res/Farm_a_Cat_twdm.png',
	Farm_a_Cat_ze_png: 'res/Farm_a_Cat_ze.png',
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