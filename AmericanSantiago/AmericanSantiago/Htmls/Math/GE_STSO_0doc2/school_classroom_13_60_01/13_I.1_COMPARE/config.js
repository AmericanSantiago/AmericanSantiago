var config = {
	bg: res.bg_png,
	
	//难度设定，决定奖励的个数
	level: 3,
	//开始界面设置
	start: {
		btn: {
			imgs: [res.btn_start_png],
			position: [1040, 600]
		},
		text: {
			img: res.question_text_png,
			position: [1040 ,900]
		},
		width: 1000,
		height: 600
	},

	question: {
		answer: "up"
	},
	items: [
		{
			img: res.notebookup_png,
			value: "up",
			position: [560, 770]  //大三角图片及坐标
		},
		{
			img: res.notebookdown_png,
			value: "down",
			position: [1455, 770]   //小三角图片及坐标
		}
	],
	/*elements: [
		{
			img: res.line_png,
			position: [640, 360]
		}
	],*/
	effect: {
		bgm: resAudio.bgm_mp3,
		question: resAudio.question_mp3,
		right: resAudio.right_mp3,
		wrong: resAudio.wrong_mp3
	}
};