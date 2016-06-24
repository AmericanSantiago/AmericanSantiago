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