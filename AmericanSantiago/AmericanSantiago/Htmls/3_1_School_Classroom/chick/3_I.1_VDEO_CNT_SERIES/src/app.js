var GameScene = BaseScene.extend({
	run: function () {
		var layer = new GameLayer();
		this.addChild(layer);
		runScene(this);
	}
});

var GameLayer = cc.Layer.extend({
	elements: [],
	countIndex: 0,
	isComplete: false,
	ctor: function () {
		this._super();

		this.elements = [];
		this.countIndex = 0;
		this.isComplete = false;

		var bg = new Background(config.bg);
		this.addChild(bg);

		var elements = config.elements;
		var startNum = config.start_number;
		var endNum = config.end_number;

		this.initELements(elements);
		this.initNumber();

		// this.startCount(startNum-1, endNum, this.countEnd, this);

		playAudio(config.effect.question, function () {
			this.startCount(startNum-1, endNum, this.countEnd, this);
		}, this);

		cc.audioPlayer.playAudio(config.effect.bgm, true, 0.15);
	},
	initELements: function (elements) {
		for(var i=0;i<elements.length;i++) {
			var element = new Element(elements[i].img);
			this.addChild(element);
			var pos = elements[i].position;
			element.setPosition(pos[0], pos[1]);
			this.elements.push(element);
		}

	},
	initNumber: function () {
		var startNum = config.start_number;
		var pos = config.number_position;
		this.number = new NumberOption(startNum);
		this.addChild(this.number);
		this.number.setInitPos(pos[0], pos[1]);
	},
	startCount: function (startNum, endNum, callback, target) {
		var self = this;
		var idx = startNum;
		this.timer = setInterval(function () {
			self.count(idx);
			idx++;
			if(idx >= endNum) {
				callback.call(target);
				clearInterval(self.timer);
			}
		}, 1200);
	},
	stop: function (){
		if(this.timer) clearInterval(this.timer);
	},
	count: function (index) {
		this.elements[index].count();
		playEffect(config.effect.numbers[index]);
		this.number.setNum(index+1);
	},
	countEnd: function () {
		console.log("end");
	},
	playRightSound: function () {
		playEffect(config.effect.right);
	},
	playWrongSound: function () {
		playEffect(config.effect.wrong);
	}
});

var NumberOption = cc.Sprite.extend({
	num: 0,
	ctor: function (num) {
		var imgs = config.numbers;
		this._super(imgs[num-1]);

		this.num = num;
		this.imgs = imgs;

		/*var text = new TextField(num, 60);
		this.addChild(text);
		this.text = text;*/
	},
	setInitPos: function (x, y) {
		this.setPosition(x, y);
		this.initX = x;
		this.initY = y;
	},
	getNum: function () {
		return this.num;
	},
	setNum: function (num) {
		this.num = num;
		// this.text.setString(num);
		this.initWithFile(this.imgs[num-1]);
		this.setPosition(this.initX, this.initY);
	}
});

var Element = cc.Sprite.extend({
	ctor: function (img) {
		this._super(img);

	},
	count: function () {
		this.runAction(cc.sequence(
			cc.scaleTo(0.1, 1.2, 1.2),
			cc.delayTime(.1),
			cc.scaleTo(0.1, 1, 1)
		));
	}
});



