/*
 * base resource define
 */
(function (global, cc) {
	var base_resources = [
	];

	var rootPath = common_server_url;

	var commonRes = {
		ball1_png: rootPath + '/ui/ball1.png',
		ball2_png: rootPath + '/ui/ball2.png',
		over_bg_png: rootPath + '/ui/over_bg.png',
		//basket_png: rootPath + '/ui/basket.png',
		flower_png: rootPath + '/ui/flower.png',
		light_png: rootPath + '/ui/light.png',
		papers: [
			rootPath + '/ui/s1.png',
			rootPath + '/ui/s2.png',
			rootPath + '/ui/s3.png',
			rootPath + '/ui/s4.png',
			rootPath + '/ui/s5.png',
			rootPath + '/ui/s6.png',
		],
		ribbon_green: [
			/*rootPath + '/ui/green/g1.png',
			rootPath + '/ui/green/g2.png',
			rootPath + '/ui/green/g3.png',
			rootPath + '/ui/green/g4.png',
			rootPath + '/ui/green/g5.png',
			rootPath + '/ui/green/g6.png',
			rootPath + '/ui/green/g7.png',
			rootPath + '/ui/green/g8.png',
			rootPath + '/ui/green/g9.png',
			rootPath + '/ui/green/g10.png',*/
		],
		ribbon_blue: [
			/*rootPath + '/ui/blue/b1.png',
			rootPath + '/ui/blue/b2.png',
			rootPath + '/ui/blue/b3.png',
			rootPath + '/ui/blue/b4.png',
			rootPath + '/ui/blue/b5.png',
			rootPath + '/ui/blue/b6.png',
			rootPath + '/ui/blue/b7.png',
			rootPath + '/ui/blue/b8.png',
			rootPath + '/ui/blue/b9.png',
			rootPath + '/ui/blue/b10.png',*/
		],
		ribbon_purple: [
			/*rootPath + '/ui/purple/p1.png',
			rootPath + '/ui/purple/p2.png',
			rootPath + '/ui/purple/p3.png',
			rootPath + '/ui/purple/p4.png',
			rootPath + '/ui/purple/p5.png',
			rootPath + '/ui/purple/p6.png',
			rootPath + '/ui/purple/p7.png',
			rootPath + '/ui/purple/p8.png',
			rootPath + '/ui/purple/p9.png',
			rootPath + '/ui/purple/p10.png',*/
		],
		roles: [
			rootPath + '/ui/role/girl1.png',
			rootPath + '/ui/role/girl2.png',
			rootPath + '/ui/role/girl3.png',
			rootPath + '/ui/role/girl4.png',
			rootPath + '/ui/role/girl5.png',
			rootPath + '/ui/role/girl6.png',
			rootPath + '/ui/role/girl7.png',
			rootPath + '/ui/role/girl8.png',
			rootPath + '/ui/role/girl9.png',
			rootPath + '/ui/role/girl10.png',
			rootPath + '/ui/role/girl11.png',
			rootPath + '/ui/role/girl12.png',
			rootPath + '/ui/role/girl13.png',
			rootPath + '/ui/role/girl14.png',
			rootPath + '/ui/role/girl15.png',
			rootPath + '/ui/role/girl16.png',
			rootPath + '/ui/role/girl17.png',
			rootPath + '/ui/role/girl18.png',
			rootPath + '/ui/role/girl19.png',
			rootPath + '/ui/role/girl20.png',
			rootPath + '/ui/role/girl21.png',
			rootPath + '/ui/role/girl22.png',
			rootPath + '/ui/role/girl23.png',
			rootPath + '/ui/role/girl24.png',
			rootPath + '/ui/role/girl25.png',
			rootPath + '/ui/role/girl26.png',
			rootPath + '/ui/role/girl27.png',
			rootPath + '/ui/role/girl28.png',
			rootPath + '/ui/role/girl29.png',
			rootPath + '/ui/role/girl30.png',
			rootPath + '/ui/role/girl31.png',
			rootPath + '/ui/role/girl32.png',
			rootPath + '/ui/role/girl33.png',
			rootPath + '/ui/role/girl34.png',
			rootPath + '/ui/role/girl35.png',
			rootPath + '/ui/role/girl36.png',
			rootPath + '/ui/role/girl37.png',
			rootPath + '/ui/role/girl38.png',
			rootPath + '/ui/role/girl39.png',
			rootPath + '/ui/role/girl40.png',

		]
	};

	function addModuleResourceByArray(resourceObjArr){
		if(!resourceObjArr) return;
		if(resourceObjArr && resourceObjArr.length && resourceObjArr.length == 0) return;
		for(var i=0;i<resourceObjArr.length;i++){
			base_resources = base_resources.concat(convertObjectToArray(resourceObjArr[i]));
		}
	}

	function addModuleResourceByName(resourceObj){
		base_resources = base_resources.concat(convertObjectToArray(resourceObj));
	}

	function addResourceToModuleByName(resourceObj, targetModuleObj){
		for(var p in resourceObj){
			if(!targetModuleObj[p]) {
				targetModuleObj[p] = resourceObj[p];
			}else{
				console.error("module " + targetModuleObj + " has the same prop: " + p);
			}
		}
	}

	addModuleResourceByName(commonRes);

	global.base_resources = base_resources;
	global.commonRes = commonRes;
	global.addModuleResourceByArray = addModuleResourceByArray;
	global.addModuleResourceByName = addModuleResourceByName;
	global.addResourceToModuleByName = addResourceToModuleByName;
})(window, cc);

/*
 * base component define
 */
(function (global, cc) {
	var BaseScene = cc.Scene.extend({
		ctor: function () {
			this._super();
		},
		onExit: function () {
			this._super();
			this.removeAllChildren(true);
			cc.spriteFrameCache.removeSpriteFrames();
			cc.textureCache.removeAllTextures();
		},
		run: function () {
			// override me
		}
	});

	var Background = cc.Layer.extend({
		img: null,
		ctor: function (texture) {
			this._super();
			var img = new cc.Sprite(texture);
			this.addChild(img);
			img.setPosition(cc.winSize.width * .5, cc.winSize.height * 0.5);

			this.img = img;
		},
		changeTexture: function (texture) {
			var isSpriteFrame = texture.toString()[0] === "#" ? true : false;
			if(isSpriteFrame) {
				this.img.setSpriteFrame(texture.slice(1));
			}else {
				this.img.setTexture(texture);
			}
		}
	});

	var Component = cc.Sprite.extend({
		enabled: true,
		ctor: function (texture) {
			this._super(texture);
		},
		isEnable: function () {
			return this.visible && this.enabled;
		},
		setEnable: function (bool) {
			this.enabled = bool;
		}
	});

	var DragComponent = Component.extend({
		initX: 0,
		initY: 0,
		ctor: function (texture) {
			this._super(texture);

			this.addEventListener();
		},
		setInitPos: function (x, y) {
			this.initX = x;
			this.initY = y;
			this.setPosition(x, y);
		},
		getInitPos: function () {
			return cc.p(this.initX, this.initY);
		},
		reset: function () {
			this.setPosition(this.initX, this.initY);
		},
		addEventListener: function () {
			var touchListener = cc.EventListener.create({
		        event: cc.EventListener.TOUCH_ONE_BY_ONE,
		        swallowTouches: true,
		        onTouchBegan: function (touch, event) {
		            var pos = touch.getLocation();
		            var target = event.getCurrentTarget();

		            if (target.isEnable() && cc.rectContainsPoint(target.getBoundingBoxToWorld(), pos)) {
		            	target.setPosition(pos);
		            	target.touchBeginHandle.call(target, touch, event);
		                return true;
		            }
		            return false;
		        },
		        onTouchMoved: function (touch, event) {
		        	var delta = touch.getDelta();
		        	var target = event.getCurrentTarget();
		        	target.x += delta.x;
		        	target.y += delta.y;
		        },
		        onTouchEnded: function (touch, event) {
		        	var target = event.getCurrentTarget();
		        	target.touchEndHandle.call(target, touch, event);
		        }
		    });

		    cc.eventManager.addListener(touchListener.clone(), this);
		},
		touchBeginHandle: function () {

		},
		touchEndHandle: function (touch, event) {

		}
	});

	global.BaseScene = BaseScene;
	global.Background = Background;
	global.Component = Component;
	global.DragComponent = DragComponent;
})(window, cc);

/*
 * UI Common Layers
 */
(function (wnd) {
	var GameStartLayer = cc.Layer.extend({
		ctor: function (data, callback, target) {
			this._super();

			var w = cc.winSize.width;
			var h = cc.winSize.height;
			width = data.width || w;
			height = data.height || h;

			var bg = new cc.LayerColor(cc.color(255, 255, 255, 200), width, height);
			this.addChild(bg);
			bg.setPosition((w - width) * .5, (h - height) * .5);

			var text = new cc.Sprite(data.text.img);
			this.addChild(text);
			var posText = data.text.position;
			text.setPosition(posText[0], posText[1]);

			var btn = new Button(data.btn.imgs, this.start, this);
			this.addChild(btn);
			var posBtn = data.btn.position;
			btn.setPosition(posBtn[0], posBtn[1]);

			this.cascadeOpacity = true;
			
			addEvent(function(){}, this);

			this.callback = callback;
			this.target = target;
		},
		start: function () {
			this.runAction(cc.spawn(
				cc.fadeOut(.2),
				cc.scaleTo(.3, 1.5, 1.5)
			));

			this.runAction(cc.sequence(
				cc.delayTime(.3),
				cc.callFunc(function () {
					this.removeFromParent(true);
				}, this)
			))

			playBGM(config.effect.bgm);
			if(this.callback && this.target) this.callback.call(this.target);
		}
	});

	var GameOverLayer = cc.Layer.extend({
		roleData: null,
		ctor: function (num, roleData) {
			this._super();

			var w = cc.winSize.width;
			var h = cc.winSize.height;

			var bg = new cc.Sprite(commonRes.over_bg_png);
			this.addChild(bg, 0);
			bg.setPosition(w * .5, h * .5);

			var light = new cc.Sprite(commonRes.light_png);
			this.addChild(light);
			light.setPosition(w*.5, h * .5);

			// var basket = new Basket();
			// this.addChild(basket, 100);
			// basket.setPosition(640, 80);

			var ball1 = new cc.Sprite(commonRes.ball1_png);
			this.addChild(ball1, 100);
			ball1.setPosition(1034, 1170);
			ball1.attr({
				anchorX: 1,
				anchorY: 1
			});

			var ball2 = new cc.Sprite(commonRes.ball2_png);
			this.addChild(ball2, 100);
			ball2.setPosition(1014, 1170);
			ball2.attr({
				anchorX: 0,
				anchorY: 1
			});

			ball1.runAction(cc.sequence(
				cc.rotateTo(.2, 40, 40),
				cc.rotateTo(.1, 25, 25),
				cc.rotateTo(.1, 30, 30)
			));

			ball2.runAction(cc.sequence(
				cc.rotateTo(.2, -40, -40),
				cc.rotateTo(.1, -25, -25),
				cc.rotateTo(.1, -30, -30)
			));

			this.runAction(cc.sequence(
				cc.delayTime(.3),
				cc.callFunc(this.makeFlowers, this)
			));

			this.num = num || 6;
			this.roleData = cc.extend({
				role_position: [1480, 580],
				emotions: commonRes.roles
			}, roleData);

			// this.basket = basket;

			this.initRole();

			addEvent(function() {}, this);
		},
		makeFlowers: function () {
			var h =1070; //cc.winSize.height;
			var posx = [1014, 1015, 1016, 1044, 1054, 1064, 1074, 1084];
			for(var i=0;i<this.num;i++){
				var x = posx.splice(Math.floor(Math.random() * posx.length),1)[0];
				var flower = new Flower(i * .4, x, h, this.count, this);
				this.addChild(flower, 10);
			}

			var pos = [1014, 1013, 1012, 1011, 1010, 999, 998, 997];
			for(var j=0;j<8;j++){
				var ribbon = new Ribbon(j * .4, pos.splice(Math.floor(Math.random() * pos.length),1)[0], h);
				this.addChild(ribbon, 15);
			}

			this.initExplode();
		},
		count: function () {
			// this.basket.add();
		},
		initRole: function () {
			var emotion = this.roleData.emotions;
			var pos = this.roleData.role_position;
			var role = new cc.Sprite(emotion[0]);
			var delayTime = HG.GAMEOVER.DELAY || 0.1;
			this.addChild(role);
			role.setPosition(pos[0], pos[1]);
			var animation = new AnimationFrames(emotion, delayTime);
			role.runAction(cc.repeatForever(cc.sequence(
				cc.delayTime(1),
				animation
			)));
		},
		initExplode: function () {
			var explode = new Explode();
			this.addChild(explode, 90);
			explode.setPosition(1010, 800);
		}
	});

	var Basket = cc.Sprite.extend({
		num: 0,
		ctor: function () {
			this._super(commonRes.basket_png);
			this.scale = 0.5;

			this.num = 0;

			var text = new TextField(this.num, 110);
			this.addChild(text);
			text.setPosition(this.width * .5, 160);
			this.text = text;
		},
		add: function () {
			this.num++;
			this.text.runAction(cc.sequence(
				cc.scaleTo(.1, 1.3, 1.3),
				cc.callFunc(function(){
					this.text.setString(this.num);
				}, this),
				cc.scaleTo(.1, 1, 1)
			));
			
		}
	});

	var Flower = cc.Sprite.extend({
		ctor: function (delayTime, startX, startY, callback, target) {
			this._super(commonRes.flower_png);

			this.setPosition(startX, startY);

			this.scale = 0.5;

			this.opacity = 0;

			var y = HG.GAMEOVER.FALLY || 200;
			this.runAction(cc.sequence(
				cc.delayTime(delayTime),
				cc.spawn(
					cc.fadeIn(.3),
					cc.moveTo(2, cc.p(startX, y))
				),
				cc.callFunc(function(){
					this.disapper();
				}, this)
			));

			this.callback = callback;
			this.target = target;
		},
		disapper: function () {
			var p1 = HG.GAMEOVER.END_POINT;
			var p2 = HG.GAMEOVER.CONTROL_POINT;
			var endPos = cc.p(p1[0], p1[1]);

			var points = [cc.p(this.x, this.y), cc.p(p2[0], p2[1]), endPos];

			var duration = HG.GAMEOVER.DURATION || 1.8;
			this.runAction(cc.spawn(
				cc.sequence(
					cc.delayTime(duration - 0.3),
					cc.fadeOut(.3),
					cc.callFunc(function () {
						if(this.callback) this.callback.call(this.target);
					}, this)
				),
				cc.bezierTo(duration, points)
			));
		}
	});

	var Ribbon = cc.Sprite.extend({
		ctor: function (delayTime, startX, startY) {
			var textures = [
				commonRes.ribbon_green,
				commonRes.ribbon_blue,
				commonRes.ribbon_purple
			];
			var idx = Math.floor(Math.random() * textures.length);
			this._super(textures[idx][0]);

			this.setPosition(startX, startY);

			var frames = textures[idx];

			this.scale = 0.5;

			// this.opacity = 0;
			var ani = new AnimationFrames(frames, 0.05);
			this.runAction(cc.sequence(
				cc.hide(),
				cc.delayTime(delayTime),
				cc.show(),
				cc.spawn(
					cc.moveTo(1, cc.p(startX + Math.random() * 60 - 30, 300)),
					cc.fadeOut(.8)
				)
			));

			this.runAction(cc.repeatForever(ani));
		}
	});

	var GameBaseLayer = cc.Layer.extend({
		showEndDelayTime: 2,
		ctor: function () {
			this._super();
		},
		onEnter: function () {
			this._super();
		},
		playRightSound: function () {

		},
		playWrongSound: function () {

		},
		start: function () {

		},
		readyToOver: function (delayTime) {
			this.runAction(cc.sequence(
				cc.delayTime(delayTime|| this.showEndDelayTime),
				cc.callFunc(function(){
					this.gameover();

					var data = {};
					var command = 'gameover';
					sendCommandToApp(command, data);
				}, this)
			));
		},
		gameover: function () {
			var level = config.level;
			var data = config.over;
			var over = new GameOverLayer(level, data);
			this.addChild(over, 900);
		}
	});

	var Explode = cc.Sprite.extend({
		papers: [],
		ctor: function () {
			this._super();
			this.papers = [];

			this.initPapers();
		},
		initPapers: function () {
			var pos = [
				cc.p(200, 0),
				cc.p(170, -60),
				cc.p(100, -100),
				cc.p(0, -200),
				cc.p(-100, -60),
				cc.p(-200, -40),
			];
			for(var i=0;i<6;i++){
				var paper = new Paper(i);
				this.addChild(paper);
				this.papers.push(paper);

				paper.opacity = 0;
				var delta = Math.random() * 30 + 20;
				paper.runAction(cc.sequence(
					cc.delayTime(.1),
					cc.spawn(
						cc.moveTo(.5, pos[i]),
						cc.fadeIn(.4)
					),
					cc.spawn(
						cc.moveTo(.8, cc.p(pos[i].x > 0 ? pos[i].x + delta :  pos[i].x - delta, pos[i].y - delta)),
						cc.fadeOut(.8)
					)
				));
			}
		}
	});

	var Paper = cc.Sprite.extend({
		ctor: function (idx) {
			var textures = commonRes.papers;
			this._super(textures[idx || 0]);
		}
	});


	wnd.GameStartLayer = GameStartLayer;
	wnd.GameOverLayer = GameOverLayer;
	wnd.GameBaseLayer = GameBaseLayer;
})(window);






