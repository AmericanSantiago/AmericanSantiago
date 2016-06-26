var projectConfigJSON = {
    "project_type": "javascript",

    "debugMode" : 1,
    "showFPS" : false,
    "frameRate" : 60,
    "id" : "gameCanvas",
    "renderMode" : 1,
    "engineDir":"frameworks/cocos2d-html5",

    "modules" : ["custom"],

    "jsList" : [
        common_server_url + "/baseConfig.js",
        common_server_url + "/common.js",
        common_server_url + "/component.js",
        "src/resource.js",
        "config.js",
        "src/app.js"
    ]
};