var GameScene = BaseScene.extend({
	run: function () {
		var layer = new GameLayer();
		this.addChild(layer);

		var start_data = config.start;
		var start = new GameStartLayer(start_data, function(){
			layer.start();
		}, this);
		this.addChild(start);

		runScene(this);
	}
});

var GameLayer = GameBaseLayer.extend({
	items: [],
	wrongNum: 0,
	ctor: function () {
		this._super();

		this.items = [];
		this.wrongNum = 0;

		var bg = new Background(config.bg);
		this.addChild(bg);

		var question = config.question;
		this.question = question;

		var items = config.items;
		var elements = config.elements;

		this.showQuestion();

		this.initItems(items);
		this.initElements(elements);
	},
	start: function () {
		playEffect(config.effect.question);
	},
	showQuestion: function () {

		var text = this.question.text;
		if(text) {
			var t = new TextField(text, 40);
			this.addChild(t);
			t.setPosition(t.width*.5 + 50, 600);
		}
	},
	initItems: function (items) {
		for(var i=0;i<items.length;i++){
			var poly = new Poly(items[i], this.selectPoly, this);
			this.addChild(poly);
			var pos = {x: items[i].position[0], y: items[i].position[1]};
			poly.setPosition(pos);
			this.items.push(poly);
		}
	},
	selectPoly: function (poly) {
		if(this.question.answer == poly.getValue()) {
			this.playRightSound();

			this.readyToOver();
		}else{
			this.playWrongSound();
			this.tip(this.question.answer);
			/*this.wrongNum++;
			if(this.wrongNum >= 3) {
				this.wrongNum = 0;
				this.tip(this.question.answer);
			}*/
		}
	},
	tip: function (value) {
		for(var i=0;i<this.items.length;i++){
			if(this.items[i].getValue() == value) {
				this.items[i].blink();
			}
		}
	},
	playRightSound: function () {
		this._super();
		playEffect(config.effect.right);
	},
	playWrongSound: function () {
		this._super();
		playEffect(config.effect.wrong);
	},
	initElements: function (elements) {
		if(elements && elements.length > 0) {
			for(var i=0;i<elements.length;i++){
				var el = new cc.Sprite(elements[i].img);
				this.addChild(el);
				el.setPosition(elements[i].position[0], elements[i].position[1]);
			}
		}
	}
});

var PolyBase = cc.Sprite.extend({
	data: null,
	ctor: function (data) {
		this._super(data.img);

		this.data = data;
	},
	getValue: function () {
		return this.data.value;
	}
});

var Poly = PolyBase.extend({
	ctor: function (data, callback, target) {
		this._super(data);

		var self = this;
		addEvent(function () {
			callback.call(target, self);
		}, this);
	},
	blink: function () {
		this.stopAllActions();
		this.alpha = 255;
		this.runAction(cc.blink(1,4));
	}
});




