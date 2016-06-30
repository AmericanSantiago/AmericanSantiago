'use strict';

;(function () {
    window.onload = function () {
        cc.game.onStart = function(){
            cc.view.setDesignResolutionSize(HG.STAGE.WIDTH, HG.STAGE.HEIGHT, cc.ResolutionPolicy.SHOW_ALL);
            cc.view.resizeWithBrowserSize(true);

            var loaderScene = new LoaderScene();
            cc.loaderScene = loaderScene;

            cc.LoaderScene.preload(base_resources, function(){
                var scene = new GameScene();
                scene.run();
            }, this);
        }
        cc.game.run("gameCanvas");
    }
})();




