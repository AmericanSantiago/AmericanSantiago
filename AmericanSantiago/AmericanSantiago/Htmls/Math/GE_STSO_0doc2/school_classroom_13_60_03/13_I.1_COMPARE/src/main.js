'use strict';

;(function () {
    window.onload = function () {
        cc.game.onStart = function(){
            cc.view.setDesignResolutionSize(HG.STAGE.WIDTH, HG.STAGE.HEIGHT, cc.ResolutionPolicy.SHOW_ALL);
            cc.view.resizeWithBrowserSize(true);

            cc._loaderImage = common_server_url + '/ui/loading.png';
            var loaderScene = new cc.LoaderScene();
            loaderScene.init();
            loaderScene._label.setColor(cc.color(254, 154, 1));
            loaderScene._label.setFontSize(20);
            loaderScene._label.zIndex = 11;
            loaderScene._label.y += 50;
            cc.loaderScene = loaderScene;

            cc.LoaderScene.preload(base_resources, function(){
                var scene = new GameScene();
                scene.run();
            }, this);
        }
        cc.game.run("gameCanvas");  
    }
})();

