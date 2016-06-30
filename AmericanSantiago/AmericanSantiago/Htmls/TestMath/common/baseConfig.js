var HG = HG || {};

HG.STAGE = {
	WIDTH: 2048,
	HEIGHT: 1536
};

//结束界面
HG.GAMEOVER = {
	//帧间隔
	DELAY: 0.05,
	//花下落到的y的位置
	FALLY: 450,
	//结束点的位置
	END_POINT: [HG.STAGE.WIDTH - 600, HG.STAGE.HEIGHT - 450],
	//贝塞尔曲线控制点的位置
	CONTROL_POINT: [1200, 300],
	//曲线动画的时长, 单位为秒
	DURATION: 1.8
};