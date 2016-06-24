/*
 * 按钮
 * params: states, [normalImage,selectedImage,disabledImage] ,按钮三种状态资源路径
 * params: callback, 回调
 * params: target
 */
var Button = cc.Sprite.extend({
    enabled: true,
    ctor: function (states, callback, target) {
        this.states = states;
        this._super(states[0]);
        if(!this.states[1]) this.states[1] = this.states[0];
        if(!this.states[2]) this.states[2] = this.states[0];

        var self = this;
        addEvent([
            function () {
                if(!self.enabled) return;
                self.setStates("selected");                
            },
            function () {},
            function () {
                if(!self.enabled) return;
                self.setStates("normal");
                callback.call(target, self);
            }
        ], this);
    },
    setStates: function (state) {
        switch(state) {
            case "normal":
                this.setTexture(this.states[0]);
                break;
            case "selected":
                this.setTexture(this.states[1]);
                break;
            case "disable":
                this.setTexture(this.states[2])
                break;
            default: console.error("unkonwn state: " + state);
        }
    },
    enable: function () {
        this.enabled = true;
    },
    disable: function () {
        this.enabled = false;
    }
});


/*
 * 文本框
 * params: text, 显示文字
 * params: size, 大小
 * params: font, 字体
 * params: color, 颜色
 */
var TextField = cc.LabelTTF.extend({
    ctor: function (text, size, font, color) {
        size = size || 22;
        font = font || "comic Sans Ms";
        color = color || cc.color(0, 0, 0);
        var fontDef = new cc.FontDefinition();
        fontDef.fontName = font;
        fontDef.fontSize = size;
        fontDef.fillStyle = color;
        this._super(text, fontDef);
    },
    getWidth: function () {
        return this.getContentSize().width;
    },
    getHeight: function () {
        return this.getContentSize().height;
    }
});

/*
 * 输入文本框
 * params: size, 显示区域大小, cc.size(w, h)
 * params: placeholder, placeholder
 * params: fontSize, 字体大小
 * params: fontColor, 颜色
 */
var TextInput = cc.EditBox.extend({
    ctor: function (size, placeholder, fontSize, fontColor) {
        this._super(size, new cc.Scale9Sprite());

        placeholder = placeholder || '';
        fontSize = fontSize || 20;
        fontColor = fontColor || cc.color(0, 0, 0);
        this.setPlaceHolder(placeholder);
        this.placeHolderFontSize = fontSize;
        this.placeHolderFontColor = cc.color(150, 150, 150);
        this.setFontColor(fontColor);
        this.setFontSize(fontSize);
        this.setDelegate(this);
    },
    setInputType: function (type) {
        this.setInputFlag(type);
    }
});

/*
 * 图片
 * params: url, 资源路径
 */
var Img = cc.Sprite.extend({
    ctor: function (url) {
        this._super(url);
        this.ignoreAnchor = true;
    }
});


/*
 * 序列帧动画
 * params: plist资源文件
 * params: delay, 单位为秒
 * params: restOrigFrame, 动画播放结束是否恢复第一帧, 默认为false
 */
var Animation = cc.Animate.extend({
    ctor: function (plistUrl, delay, restOrigFrame) {
        var frames = [], //序列帧
            frameConfigCache = cc.spriteFrameCache._frameConfigCache, //cocos2d-js 帧缓存
            delay = delay || 0.1;

        if (!plistUrl) {
            console.error("plist file can not be none.");
            return;
        }

        if (isNaN(delay)) {
            console.error("delay value must be a number.");
            return;
        }

        if (!frameConfigCache[plistUrl] || !frameConfigCache[plistUrl].frames) {
            console.error("plist file: " + plistUrl + "not found.");
            return;
        }

        var frameNames = [];
        for (var name in frameConfigCache[plistUrl].frames) {
            frameNames.push(name);
        }

        var reg = /\d/g;
        frameNames.sort(function(a, b){
            return a.match(reg).join("") - b.match(reg).join("");
        });

        for(var i=0;i<frameNames.length;i++){
            frames.push(cc.spriteFrameCache.getSpriteFrame(frameNames[i]));
        }

        this.animation = new cc.Animation(frames);
        this.animation.setDelayPerUnit(delay);
        this.animation.setRestoreOriginalFrame(restOrigFrame || false);

        this._super(this.animation);
    }
});

/*
 * 序列帧动画2
 * params: animationImages, 序列帧资源数组
 * params: delay, 单位为秒
 * params: restOrigFrame, 动画播放结束是否恢复第一帧, 默认为false
 */
var AnimationFrames = cc.Animate.extend({
    ctor: function (animationImages, delay, restOrigFrame) {
        delay = delay || 0.1;

        this.animation = new cc.Animation();
        this.animation.setDelayPerUnit(delay);
        this.animation.setRestoreOriginalFrame(restOrigFrame || false);

        for (var i = 0; i < animationImages.length; i++) {
            this.animation.addSpriteFrameWithFile(animationImages[i]);
        }

        this._super(this.animation);
    }
});

/*
 * 音频播放控制(android)
 */
var AudioPlayer = cc.Class.extend({
    currentAudioUrl: null,
    volume: 1,
    player: null,
    callback: null,
    _isPlaying: false,
    ctor: function () {

        return true;
    },
    init: function () {
        this.player = document.createElement('audio');

        this._handlePlayEvent();
    },
    playAudio: function (url, isRepeat, volume) {
        if(!url) return;
        if(!this.player) {
            this.init();
        }
        this.player.src = url;
        this.player.play();
        this.currentAudioUrl = url;
        this.isRepeat = isRepeat ==undefined? true :isRepeat;
        this._isPlaying = true;
        
        if(volume && volume > 0) this.setVolume(volume);
    },
    pauseAudio: function () {
        if(this.player && !this._isPlaying) {
            this.player.pause();
            this._isPlaying = false;
        }
    },
    resumeAudio: function () {
        if(!this.currentAudioUrl) return;
        this.player.play();
        this._isPlaying = true;
    },
    _handlePlayEvent: function () {
        this.player.addEventListener("ended",this._playEndHandler,false);
        this.player.addEventListener("error",this._playErrorHandler,false);

        cc.eventManager.addCustomListener(cc.game.EVENT_HIDE, function () {
            cc.audioPlayer.pauseAudio();
        });
        cc.eventManager.addCustomListener(cc.game.EVENT_SHOW, function () {
            cc.audioPlayer.resumeAudio();
        });
    },
    _playEndHandler: function () {
        cc.audioPlayer._isPlaying = false;
        if(cc.audioPlayer.isRepeat){
            if(cc.audioPlayer.player.paused){
                cc.audioPlayer.player.currentTime = 0.1;
                cc.audioPlayer.player.src = cc.audioPlayer.currentAudioUrl;
                cc.audioPlayer.player.play();
                cc.audioPlayer._isPlaying = true;
            }
        }
    },
    _playErrorHandler: function (err) {
        alert("音频播放错误! " + ' code: ' + err.code + ' message: ' + err.message);
    },
    setVolume: function(volume){
        if(volume > 1) volume = 1;
        if(volume < 0) volume = 0;
        this.volume = volume;
        this.player.volume = volume;
    },

    getVolume: function(){
        return this.volume;
    }
});
cc.audioPlayer = new AudioPlayer();

/*
 * 播放背景音乐
 * params: url, 资源路径
 */
function playBGM(url) {
    cc.audioPlayer.playAudio(url, true);
}

/*
 * 播放音效
 * params: url, 资源路径
 * params: isRepeat, 是否重复播放
 */
function playEffect(url, isRepeat) {
    if(!url) return;
    isRepeat == isRepeat === undefined ? false : isRepeat;
    cc.audioEngine.stopAllEffects();
    return cc.audioEngine.playEffect(url, isRepeat);
}

/*
 * 播放音乐
 * params: url, 资源路径
 * params: isRepeat, 是否重复播放
 */
function playSound(url, isRepeat) {
    if(!url) return;
    isRepeat == isRepeat === undefined ? true : isRepeat;
    if (!cc.audioEngine.isMusicPlaying()) {
        cc.audioEngine.stopMusic();
        return cc.audioEngine.playMusic(url, true);
    }
    
    return null;
}

function stopAllEffects() {
    cc.audioEngine.stopAllEffects();
    if(window.__currentAudio) window.__currentAudio.stop();
    //bug to fix
    if(window.__currentAudioAction) {
        var target = window.__currentAudioAction.getOriginalTarget();
        var element = cc.director.getActionManager()._hashTargets[target.__instanceId];
        if(element) {
            target.stopAction(window.__currentAudioAction);
        }
    }
    
}

function stopAllMusics() {
    if(cc.sys.os == cc.sys.OS_ANDROID) {
        cc.audioPlayer.stopAllSounds();
    }else{
        cc.audioEngine.stopMusic();
    }
}

/*
 * 播放声音(回调)
 * params: url, 资源路径
 * params: callback, 回调方法
 * params: target, target
 */
function playAudio(url, callback, target) {
    var audio,
        startTime,
        deltaTime,
        timeAction,
        duration = 0;
    audio = cc.loader.cache[url];
    if(!audio){
        startTime = new Date;
        cc.loader.load(url, function (err, data) {
            var id = playEffect(url);
            // audio = cc.loader.cache[url];
            audio = cc.audioEngine._effects[id];
            window.__currentAudio = audio;
            target.runAction(cc.sequence(
                cc.delayTime(1),
                cc.callFunc(function () {
                    if(audio._buffer) {
                        deltaTime = new Date - startTime;
                        duration = audio._buffer.duration;
                        duration -= deltaTime/1000;
                        timeAction = target.runAction(cc.sequence(cc.delayTime(duration), new cc.CallFunc(function () {
                            target.stopAction(timeAction);
                            callback.call(target, audio);
                        }, target)));
                        window.__currentAudioAction = timeAction;
                    }else{
                        audio.currentTime = 0.01;

                        var endFoo = function () {
                            window.__currentAudio = null;
                            audio.removeEventListener('ended', endFoo);
                            callback.call(target, audio);
                        };
                        audio.addEventListener('ended', endFoo);
                    }
                    
                }, target)
            ));
            
        })
    }else {
        window.__currentAudio = audio;
        if(audio._buffer) {
            audio.play();
            duration = audio._buffer.duration;
            timeAction = target.runAction(cc.sequence(cc.delayTime(duration), new cc.CallFunc(function () {
                target.stopAction(timeAction);
                callback.call(target, audio);
            }, target)));
            window.__currentAudioAction = timeAction;
        }else {
            audio.currentTime = 0.01;
            audio.play();

            var endFoo = function () {
                window.__currentAudio = null;
                audio.removeEventListener('ended', endFoo);
                callback.call(target, audio);
            };
            audio.addEventListener('ended', endFoo);
        }
    }
}

/*function playAudio(url, callback, target) {
    var audio,
        startTime,
        deltaTime,
        timeAction,
        duration = 0;
    audio = cc.loader.cache[url];
    if(!audio){
        startTime = new Date;
        cc.loader.load(url, function (err, data) {
            audio = cc.loader.cache[url];
            window.__currentAudio = audio;
            
            if(duration = audio._AUDIO_TYPE === "WEBAUDIO") {
                audio.play();
                deltaTime = new Date - startTime;
                duration = audio._buffer.duration;
                duration -= deltaTime/1000;
                timeAction = target.runAction(cc.sequence(cc.delayTime(duration), new cc.CallFunc(function () {
                    target.stopAction(timeAction);
                    callback.call(target, audio);
                }, target)));
                window.__currentAudioAction = timeAction;
            }else{
                audio._element.currentTime = 0.01;
                audio.play();
                var endFoo = function () {
                    window.__currentAudio = null;
                    audio._element.removeEventListener('ended', endFoo);
                    callback.call(target, audio);
                };
                audio._element.addEventListener('ended', endFoo);
            }
        })
    }else {
        window.__currentAudio = audio;
        if(duration = audio._AUDIO_TYPE === "WEBAUDIO") {
            audio.play();
            duration = audio._buffer.duration;
            timeAction = target.runAction(cc.sequence(cc.delayTime(duration), new cc.CallFunc(function () {
                target.stopAction(timeAction);
                callback.call(target, audio);
            }, target)));
            window.__currentAudioAction = timeAction;
        }else {
            audio._element.currentTime = 0.01;
            audio.play();

            var endFoo = function () {
                window.__currentAudio = null;
                audio._element.removeEventListener('ended', endFoo);
                callback.call(target, audio);
            };
            audio._element.addEventListener('ended', endFoo);
        }
    }

}*/

function setMusicVolume (volume) {
    if(cc.sys.os == cc.sys.OS_ANDROID) {
        cc.audioPlayer.setSoundVolume(volume);
    }else{
        cc.audioEngine.setMusicVolume(volume);
    }
}

/*
 * 渲染场景
 * params: scene, scene name
 */
function runScene(scene) {
    cc.director.runScene(scene);
};


function convertObjectToArray(obj) {
    var arr = [];
    for (var p in obj) {
        if (Object.prototype.toString.call(obj[p]) == '[object Array]') {
            arr = arr.concat(convertObjectToArray(obj[p]));
        } else if (typeof obj[p] == 'object' && Object.prototype.toString.call(obj[p]) == '[object Object]') {
            arr = arr.concat(convertObjectToArray(obj[p]));
        } else if (typeof obj[p] == 'string' || Object.prototype.toString.call(obj[p]) == '[object String]') {
            arr.push(obj[p]);
        } else if (typeof obj[p] == 'number' || Object.prototype.toString.call(obj[p]) == '[object Number]') {
            arr.push(obj[p]);
        } else {
            console.error("error format data object. please check {" + p + ":: " + obj[p] + "}.");
            break;
        }
    }

    return arr;
}

/*
 * 添加touch事件
 * */
function addEvent(funcList, obj, isSwallowTouches) {
    var beganFunc, movedFunc, endedFunc;

    if (cc.isArray(funcList)) {
        beganFunc = funcList[0];
        movedFunc = funcList[1];
        endedFunc = funcList[2];
    } else if (cc.isFunction(funcList)) {
        endedFunc = funcList;
    }

    var touchListener = cc.EventListener.create({
        event: cc.EventListener.TOUCH_ONE_BY_ONE,
        swallowTouches: isSwallowTouches || true,
        onTouchBegan: function (touch, event) {
            var pos = touch.getLocation();
            var target = event.getCurrentTarget();

            if (target.visible && cc.rectContainsPoint(target.getBoundingBoxToWorld(), pos)) {
                if (cc.isFunction(beganFunc)) {
                    var result = beganFunc(pos, target);
                    if (result != undefined) {
                        return result;
                    }
                }
                
                return true;
            }
            return false;
        },
        onTouchMoved: function (touch, event) {
            if (cc.isFunction(movedFunc))
                movedFunc(touch, event.getCurrentTarget());

        },
        onTouchEnded: function (touch, event) {
            if (cc.isFunction(endedFunc))
                endedFunc(touch.getLocation(), event.getCurrentTarget());
        }
    });

    cc.eventManager.addListener(touchListener.clone(), obj);
}

/*
 * 检测是否为安卓盒子
 * */
 function isAndroidBox() {
    return cc.sys.os == cc.sys.OS_ANDROID && cc.sys.platform == cc.sys.MOBILE_BROWSER;
 }