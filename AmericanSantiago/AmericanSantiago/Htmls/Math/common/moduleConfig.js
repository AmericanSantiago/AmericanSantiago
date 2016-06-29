var moduleConfigJSON = {
    "module" : {
        "actions" : [
            "core",

            "cocos2d/actions/CCAction.js",
            "cocos2d/actions/CCActionInterval.js",
            "cocos2d/actions/CCActionInstant.js",
            "cocos2d/actions/CCActionCamera.js",
            "cocos2d/actions/CCActionEase.js",
            "cocos2d/actions/CCActionCatmullRom.js",
            "cocos2d/actions/CCActionTween.js"
        ],
        "actions3d" : [
            "core", "kazmath", "shaders", "actions", "effects", "render-texture",

            "cocos2d/actions3d/CCActionGrid.js",
            "cocos2d/actions3d/CCActionGrid3D.js",
            "cocos2d/actions3d/CCActionTiledGrid.js",
            "cocos2d/actions3d/CCActionPageTurn3D.js"
        ],
        "audio" : [
            "core",

            "cocos2d/audio/CCAudio.js"
        ],
        "clipping-nodes" : [
            "core", "shape-nodes",

            "cocos2d/clipping-nodes/CCClippingNode.js",
            "cocos2d/clipping-nodes/CCClippingNodeCanvasRenderCmd.js",
            "cocos2d/clipping-nodes/CCClippingNodeWebGLRenderCmd.js"
        ],
        "compression" : [
            "core",

            "cocos2d/compression/ZipUtils.js",
            "cocos2d/compression/base64.js",
            "cocos2d/compression/gzip.js",
            "cocos2d/compression/zlib.min.js"
        ],
        "core" : [
            "CCDebugger.js",
            "cocos2d/core/utils/BinaryLoader.js",
            "Base64Images.js",
            "cocos2d/core/platform/CCClass.js",
            "cocos2d/core/platform/CCCommon.js",
            "cocos2d/core/cocoa/CCGeometry.js",
            "cocos2d/core/platform/CCSAXParser.js",
            "cocos2d/core/platform/CCLoaders.js",
            "cocos2d/core/platform/CCConfig.js",
            "cocos2d/core/platform/miniFramework.js",
            "cocos2d/core/platform/CCMacro.js",
            "cocos2d/core/platform/CCTypesWebGL.js",
            "cocos2d/core/platform/CCTypesPropertyDefine.js",
            "cocos2d/core/platform/CCTypes.js",
            "cocos2d/core/platform/CCEGLView.js",
            "cocos2d/core/platform/CCScreen.js",
            "cocos2d/core/platform/CCVisibleRect.js",

            "cocos2d/core/platform/CCInputManager.js",
            "cocos2d/core/platform/CCInputExtension.js",

            "cocos2d/core/cocoa/CCAffineTransform.js",
            "cocos2d/core/support/CCPointExtension.js",
            "cocos2d/core/support/CCVertex.js",
            "cocos2d/core/support/TransformUtils.js",
            "cocos2d/core/event-manager/CCTouch.js",

            "cocos2d/core/event-manager/CCEvent.js",
            "cocos2d/core/event-manager/CCEventListener.js",
            "cocos2d/core/event-manager/CCEventManager.js",
            "cocos2d/core/event-manager/CCEventExtension.js",

            "cocos2d/core/renderer/RendererCanvas.js",
            "cocos2d/core/renderer/RendererWebGL.js",

            "cocos2d/core/base-nodes/BaseNodesPropertyDefine.js",
            "cocos2d/core/base-nodes/CCNode.js",
            "cocos2d/core/base-nodes/CCNodeCanvasRenderCmd.js",
            "cocos2d/core/base-nodes/CCNodeWebGLRenderCmd.js",
            "cocos2d/core/base-nodes/CCAtlasNode.js",
            "cocos2d/core/base-nodes/CCAtlasNodeCanvasRenderCmd.js",
            "cocos2d/core/base-nodes/CCAtlasNodeWebGLRenderCmd.js",

            "cocos2d/core/textures/TexturesWebGL.js",
            "cocos2d/core/textures/TexturesPropertyDefine.js",
            "cocos2d/core/textures/CCTexture2D.js",
            "cocos2d/core/textures/CCTextureCache.js",
            "cocos2d/core/textures/CCTextureAtlas.js",

            "cocos2d/core/scenes/CCScene.js",
            "cocos2d/core/scenes/CCLoaderScene.js",

            "cocos2d/core/layers/CCLayer.js",
            "cocos2d/core/layers/CCLayerCanvasRenderCmd.js",
            "cocos2d/core/layers/CCLayerWebGLRenderCmd.js",

            "cocos2d/core/sprites/SpritesPropertyDefine.js",
            "cocos2d/core/sprites/CCSprite.js",
            "cocos2d/core/sprites/CCSpriteCanvasRenderCmd.js",
            "cocos2d/core/sprites/CCSpriteWebGLRenderCmd.js",
            "cocos2d/core/sprites/CCSpriteBatchNode.js",
            "cocos2d/core/sprites/CCSpriteBatchNodeCanvasRenderCmd.js",
            "cocos2d/core/sprites/CCSpriteBatchNodeWebGLRenderCmd.js",
            "cocos2d/core/sprites/CCBakeSprite.js",
            "cocos2d/core/sprites/CCAnimation.js",
            "cocos2d/core/sprites/CCAnimationCache.js",
            "cocos2d/core/sprites/CCSpriteFrame.js",
            "cocos2d/core/sprites/CCSpriteFrameCache.js",
            "cocos2d/core/CCConfiguration.js",

            "cocos2d/core/CCDirector.js",
            "cocos2d/core/CCDirectorWebGL.js",

            "cocos2d/core/CCCamera.js",
            "cocos2d/core/CCScheduler.js",
            "cocos2d/core/CCDrawingPrimitivesCanvas.js",
            "cocos2d/core/CCDrawingPrimitivesWebGL.js",

            "cocos2d/core/labelttf/LabelTTFPropertyDefine.js",
            "cocos2d/core/labelttf/CCLabelTTF.js",
            "cocos2d/core/labelttf/CCLabelTTFCanvasRenderCmd.js",
            "cocos2d/core/labelttf/CCLabelTTFWebGLRenderCmd.js",

            "cocos2d/core/CCActionManager.js"
        ],
        "effects" : [
            "core",

            "cocos2d/effects/CCGrid.js",
            "cocos2d/effects/CCGrabber.js"
        ],
        "kazmath" : [
            "core",

            "cocos2d/kazmath/utility.js",
            "cocos2d/kazmath/vec2.js",
            "cocos2d/kazmath/vec3.js",
            "cocos2d/kazmath/vec4.js",
            "cocos2d/kazmath/ray2.js",
            "cocos2d/kazmath/mat3.js",
            "cocos2d/kazmath/mat4.js",
            "cocos2d/kazmath/plane.js",
            "cocos2d/kazmath/quaternion.js",
            "cocos2d/kazmath/aabb.js",
            "cocos2d/kazmath/gl/mat4stack.js",
            "cocos2d/kazmath/gl/matrix.js"
        ],
        "labels" : [
            "core",

            "cocos2d/labels/CCLabelAtlas.js",
            "cocos2d/labels/CCLabelAtlasCanvasRenderCmd.js",
            "cocos2d/labels/CCLabelAtlasWebGLRenderCmd.js",
            "cocos2d/labels/CCLabelBMFont.js",
            "cocos2d/labels/CCLabelBMFontCanvasRenderCmd.js",
            "cocos2d/labels/CCLabelBMFontWebGLRenderCmd.js"
        ],
        "menus" : [
            "core", "actions",

            "cocos2d/menus/CCMenuItem.js",
            "cocos2d/menus/CCMenu.js"
        ],
        "motion-streak" : [
            "core", "shaders", "kazmath", "labels",

            "cocos2d/motion-streak/CCMotionStreak.js",
            "cocos2d/motion-streak/CCMotionStreakWebGLRenderCmd.js"
        ],
        "node-grid" : [
            "core",

            "cocos2d/node-grid/CCNodeGrid.js",
            "cocos2d/node-grid/CCNodeGridWebGLRenderCmd.js"
        ],
        "parallax" : [
            "core",

            "cocos2d/parallax/CCParallaxNode.js",
            "cocos2d/parallax/CCParallaxNodeRenderCmd.js"
        ],
        "particle" : [
            "core", "compression",

            "cocos2d/particle/CCPNGReader.js",
            "cocos2d/particle/CCTIFFReader.js",
            "cocos2d/particle/CCParticleSystem.js",
            "cocos2d/particle/CCParticleSystemCanvasRenderCmd.js",
            "cocos2d/particle/CCParticleSystemWebGLRenderCmd.js",
            "cocos2d/particle/CCParticleExamples.js",
            "cocos2d/particle/CCParticleBatchNode.js",
            "cocos2d/particle/CCParticleBatchNodeCanvasRenderCmd.js",
            "cocos2d/particle/CCParticleBatchNodeWebGLRenderCmd.js"
        ],
        "physics" : [
            "core", "shape-nodes",

            "cocos2d/physics/CCPhysicsSprite.js",
            "cocos2d/physics/CCPhysicsDebugNode.js",
            "cocos2d/physics/CCPhysicsDebugNodeCanvasRenderCmd.js",
            "cocos2d/physics/CCPhysicsDebugNodeWebGLRenderCmd.js",
            "cocos2d/physics/CCPhysicsSpriteCanvasRenderCmd.js",
            "cocos2d/physics/CCPhysicsSpriteWebGLRenderCmd.js"
        ],
        "progress-timer" : [
            "core", "actions",

            "cocos2d/progress-timer/CCProgressTimer.js",
            "cocos2d/progress-timer/CCActionProgressTimer.js",
            "cocos2d/progress-timer/CCProgressTimerCanvasRenderCmd.js",
            "cocos2d/progress-timer/CCProgressTimerWebGLRenderCmd.js"
        ],
        "render-texture" : [
            "core",

            "cocos2d/render-texture/CCRenderTexture.js",
            "cocos2d/render-texture/CCRenderTextureCanvasRenderCmd.js",
            "cocos2d/render-texture/CCRenderTextureWebGLRenderCmd.js"
        ],
        "shaders" : [
            "core", "kazmath",

            "cocos2d/shaders/CCShaders.js",
            "cocos2d/shaders/CCShaderCache.js",
            "cocos2d/shaders/CCGLProgram.js",
            "cocos2d/shaders/CCGLStateCache.js"
        ],
        "shape-nodes" : [
            "core",

            "cocos2d/shape-nodes/CCDrawNode.js",
            "cocos2d/shape-nodes/CCDrawNodeCanvasRenderCmd.js",
            "cocos2d/shape-nodes/CCDrawNodeWebGLRenderCmd.js"
        ],
        "text-input" : [
            "core",

            "cocos2d/text-input/CCIMEDispatcher.js",
            "cocos2d/text-input/CCTextFieldTTF.js"
        ],
        "tilemap" : [
            "core", "compression",

            "cocos2d/tilemap/CCTGAlib.js",
            "cocos2d/tilemap/CCTMXTiledMap.js",
            "cocos2d/tilemap/CCTMXXMLParser.js",
            "cocos2d/tilemap/CCTMXObjectGroup.js",
            "cocos2d/tilemap/CCTMXLayer.js",
            "cocos2d/tilemap/CCTMXLayerCanvasRenderCmd.js",
            "cocos2d/tilemap/CCTMXLayerWebGLRenderCmd.js"
        ],
        "transitions" : [
            "core", "actions", "render-texture", "progress-timer",

            "cocos2d/transitions/CCTransition.js",
            "cocos2d/transitions/CCTransitionProgress.js",
            "cocos2d/transitions/CCTransitionPageTurn.js"
        ],

        "base4webgl" : ["core", "kazmath", "shaders"],
        "cocos2d" : [
            "core", "kazmath", "shaders", "render-texture", "motion-streak", "node-grid",
            "clipping-nodes", "effects", "shape-nodes", "actions", "actions3d",
            "progress-timer", "transitions", "labels", "compression", "particle",
            "text-input", "menus", "tilemap", "parallax", "audio"
        ],

        "ccbreader" : [
            "core", "audio", "gui", "menus", "particle", "actions", "labels",

            "extensions/ccb-reader/CCNodeLoader.js",
            "extensions/ccb-reader/CCBReaderUtil.js",
            "extensions/ccb-reader/CCControlLoader.js",
            "extensions/ccb-reader/CCSpriteLoader.js",
            "extensions/ccb-reader/CCNodeLoaderLibrary.js",
            "extensions/ccb-reader/CCBReader.js",
            "extensions/ccb-reader/CCBValue.js",
            "extensions/ccb-reader/CCBKeyframe.js",
            "extensions/ccb-reader/CCBSequence.js",
            "extensions/ccb-reader/CCBRelativePositioning.js",
            "extensions/ccb-reader/CCBAnimationManager.js"
        ],
        "editbox" : [
            "core", "gui",

            "extensions/editbox/CCdomNode.js",
            "extensions/editbox/CCEditBox.js"
        ],
        "ccpool" : [
            "core",

            "extensions/ccpool/CCPool.js"
        ],
        "ccui" : [
            "core", "actions", "labels", "text-input","clipping-nodes",
            "extensions/ccui/base-classes/CCProtectedNode.js",
            "extensions/ccui/base-classes/CCProtectedNodeCanvasRenderCmd.js",
            "extensions/ccui/base-classes/CCProtectedNodeWebGLRenderCmd.js",
            "extensions/ccui/system/CocosGUI.js",
            "extensions/ccui/base-classes/UIWidget.js",
            "extensions/ccui/base-classes/UIScale9Sprite.js",
            "extensions/ccui/base-classes/UIScale9SpriteCanvasRenderCmd.js",
            "extensions/ccui/base-classes/UIScale9SpriteWebGLRenderCmd.js",
            "extensions/ccui/layouts/UILayout.js",
            "extensions/ccui/layouts/UILayoutCanvasRenderCmd.js",
            "extensions/ccui/layouts/UILayoutWebGLRenderCmd.js",
            "extensions/ccui/layouts/UILayoutParameter.js",
            "extensions/ccui/layouts/UILayoutManager.js",
            "extensions/ccui/layouts/UIHBox.js",
            "extensions/ccui/layouts/UIRelativeBox.js",
            "extensions/ccui/layouts/UIVBox.js",
            "extensions/ccui/system/UIHelper.js",
            "extensions/ccui/uiwidgets/UIButton.js",
            "extensions/ccui/uiwidgets/UICheckBox.js",
            "extensions/ccui/uiwidgets/UIImageView.js",
            "extensions/ccui/uiwidgets/UILoadingBar.js",
            "extensions/ccui/uiwidgets/UISlider.js",
            "extensions/ccui/uiwidgets/UIText.js",
            "extensions/ccui/uiwidgets/UITextAtlas.js",
            "extensions/ccui/uiwidgets/UITextBMFont.js",
            "extensions/ccui/uiwidgets/UITextField.js",
            "extensions/ccui/uiwidgets/UIRichText.js",
            "extensions/ccui/uiwidgets/scroll-widget/UIScrollView.js",
            "extensions/ccui/uiwidgets/scroll-widget/UIListView.js",
            "extensions/ccui/uiwidgets/scroll-widget/UIPageView.js"
        ],
        "cocostudio" : [
            "core",  "tilemap", "particle", "shape-nodes", "ccui",

            "extensions/cocostudio/components/CCComponent.js",
            "extensions/cocostudio/components/CCComponentContainer.js",
            "extensions/ccui/layouts/UILayoutComponent.js",
            "extensions/cocostudio/CocoStudio.js",

            "extensions/cocostudio/armature/utils/CCArmatureDefine.js",
            "extensions/cocostudio/armature/utils/CCDataReaderHelper.js",
            "extensions/cocostudio/armature/utils/CCSpriteFrameCacheHelper.js",
            "extensions/cocostudio/armature/utils/CCTransformHelp.js",
            "extensions/cocostudio/armature/utils/CCTweenFunction.js",
            "extensions/cocostudio/armature/utils/CCUtilMath.js",
            "extensions/cocostudio/armature/utils/CCArmatureDataManager.js",
            "extensions/cocostudio/armature/datas/CCDatas.js",
            "extensions/cocostudio/armature/display/CCDecorativeDisplay.js",
            "extensions/cocostudio/armature/display/CCDisplayFactory.js",
            "extensions/cocostudio/armature/display/CCDisplayManager.js",
            "extensions/cocostudio/armature/display/CCSkin.js",
            "extensions/cocostudio/armature/display/CCSkinCanvasRenderCmd.js",
            "extensions/cocostudio/armature/display/CCSkinWebGLRenderCmd.js",
            "extensions/cocostudio/armature/animation/CCProcessBase.js",
            "extensions/cocostudio/armature/animation/CCArmatureAnimation.js",
            "extensions/cocostudio/armature/animation/CCTween.js",
            "extensions/cocostudio/armature/physics/CCColliderDetector.js",
            "extensions/cocostudio/armature/CCArmature.js",
            "extensions/cocostudio/armature/CCArmatureCanvasRenderCmd.js",
            "extensions/cocostudio/armature/CCArmatureWebGLRenderCmd.js",
            "extensions/cocostudio/armature/CCBone.js",

            "extensions/cocostudio/action/CCActionFrame.js",
            "extensions/cocostudio/action/CCActionManager.js",
            "extensions/cocostudio/action/CCActionNode.js",
            "extensions/cocostudio/action/CCActionObject.js",

            "extensions/cocostudio/components/CCComAttribute.js",
            "extensions/cocostudio/components/CCComAudio.js",
            "extensions/cocostudio/components/CCComController.js",
            "extensions/cocostudio/components/CCComRender.js",

            "extensions/cocostudio/trigger/ObjectFactory.js",
            "extensions/cocostudio/trigger/TriggerBase.js",
            "extensions/cocostudio/trigger/TriggerMng.js",
            "extensions/cocostudio/trigger/TriggerObj.js",


            "extensions/cocostudio/reader/widgetreader/ButtonReader/ButtonReader.js",
            "extensions/cocostudio/reader/widgetreader/CheckBoxReader/CheckBoxReader.js",
            "extensions/cocostudio/reader/widgetreader/ImageViewReader/ImageViewReader.js",
            "extensions/cocostudio/reader/widgetreader/LabelAtlasReader/LabelAtlasReader.js",
            "extensions/cocostudio/reader/widgetreader/LabelBMFontReader/LabelBMFontReader.js",
            "extensions/cocostudio/reader/widgetreader/LabelReader/LabelReader.js",
            "extensions/cocostudio/reader/widgetreader/LayoutReader/LayoutReader.js",
            "extensions/cocostudio/reader/widgetreader/ScrollViewReader/ScrollViewReader.js",
            "extensions/cocostudio/reader/widgetreader/ListViewReader/ListViewReader.js",
            "extensions/cocostudio/reader/widgetreader/LoadingBarReader/LoadingBarReader.js",
            "extensions/cocostudio/reader/widgetreader/PageViewReader/PageViewReader.js",
            "extensions/cocostudio/reader/widgetreader/SliderReader/SliderReader.js",
            "extensions/cocostudio/reader/widgetreader/TextFieldReader/TextFieldReader.js",
            "extensions/cocostudio/reader/widgetreader/WidgetReaderProtocol.js",
            "extensions/cocostudio/reader/widgetreader/WidgetReader.js",

            "extensions/cocostudio/reader/GUIReader.js",
            "extensions/cocostudio/reader/SceneReader.js",

            "extensions/cocostudio/reader/timeline/ActionTimeline.js",
            "extensions/cocostudio/reader/timeline/ActionTimelineCache.js",
            "extensions/cocostudio/reader/timeline/Frame.js",
            "extensions/cocostudio/reader/timeline/Timeline.js",
            "extensions/cocostudio/reader/timeline/CSLoader.js"
        ],
        "gui" : [
            "core", "clipping-nodes", "render-texture", "actions", "progress-timer",

            "extensions/gui/control-extension/CCControl.js",
            "extensions/gui/control-extension/CCControlButton.js",
            "extensions/gui/control-extension/CCControlUtils.js",
            "extensions/gui/control-extension/CCInvocation.js",
            "extensions/gui/control-extension/CCScale9Sprite.js",
            "extensions/gui/control-extension/CCScale9SpriteCanvasRenderCmd.js",
            "extensions/gui/control-extension/CCScale9SpriteWebGLRenderCmd.js",
            "extensions/gui/control-extension/CCMenuPassive.js",
            "extensions/gui/control-extension/CCControlSaturationBrightnessPicker.js",
            "extensions/gui/control-extension/CCControlHuePicker.js",
            "extensions/gui/control-extension/CCControlColourPicker.js",
            "extensions/gui/control-extension/CCControlSlider.js",
            "extensions/gui/control-extension/CCControlSwitch.js",
            "extensions/gui/control-extension/CCControlStepper.js",
            "extensions/gui/control-extension/CCControlPotentiometer.js",
            "extensions/gui/scrollview/CCScrollView.js",
            "extensions/gui/scrollview/CCScrollViewCanvasRenderCmd.js",
            "extensions/gui/scrollview/CCScrollViewWebGLRenderCmd.js",
            "extensions/gui/scrollview/CCSorting.js",
            "extensions/gui/scrollview/CCTableView.js"
        ],

        "pluginx" : [
            "core",

            "external/pluginx/Plugin.js"
        ],
        "plugin-facebook" : [
            "external/pluginx/platform/facebook_sdk.js",
            "external/pluginx/platform/facebook.js"
        ],

        "spine":[
            "core",

            "extensions/spine/Spine.js",
            "extensions/spine/CCSkeleton.js",
            "extensions/spine/CCSkeletonAnimation.js",
            "extensions/spine/CCSkeletonCanvasRenderCmd.js",
            "extensions/spine/CCSkeletonWebGLRenderCmd.js"
        ],
        "extensions" : ["gui", "ccbreader", "editbox", "cocostudio", "spine", "ccpool"],

        "box2d" : [
            "core", "physics",

            "external/box2d/box2d.js"
        ],
        "chipmunk" : [
            "core", "physics",

            "external/chipmunk/chipmunk.js"
        ],
        "socketio" : [
            "external/socketio/socket.io.min.js"
        ],
        "external" : ["box2d", "chipmunk", "socketio", "pluginx"],
        "custom": [
            "core", "kazmath", "render-texture",
            "shape-nodes", "actions",
            "labels", 'editbox',
            "text-input", "menus", "audio"
        ]
    },
    "bootFile" : "CCBoot.js"
};