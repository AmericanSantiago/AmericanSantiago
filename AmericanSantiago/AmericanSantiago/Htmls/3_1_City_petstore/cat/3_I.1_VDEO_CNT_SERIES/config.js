var config = {
	bg: res.bg_png,//背景
	start_number: 1,//数字开始
	end_number: 3,//数字结束
	number_position: [1025, 950],
	elements: [
		{
			img: res.Farm_a_Cat_twdm_png,
			position: [625, 620]
		},
		{
			img: res.Farm_a_Cat_twdm_png,
			position: [1025, 620]
		},
		{
			img: res.Farm_a_Cat_twdm_png,
			position: [1425, 620]
		},
	
		//参照物图片及坐标
	],
	numbers: [
		res.num1_png,
		res.num2_png,
		res.num3_png,
		//数字图片
	],
	effect: {
		question: resAudio.question_wav,
		equation: resAudio.equation_wav,
		bgm: resAudio.bgm_mp3,
		right: resAudio.right_mp3,
		wrong: resAudio.wrong_mp3,
		numbers: resAudio.numbers
	}
};