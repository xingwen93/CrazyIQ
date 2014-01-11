local LogoLayer = require('app.ui.LogoLayer');
local SettingNode = require('app.ui.SettingNode')

local MenuScene = class("MenuScene", function()
    return WoodScene.new()
end)

function MenuScene:ctor()
    -- add the title
    local logoLayer = LogoLayer.new()
    self:addChild(logoLayer)
    logoLayer:setPosition(ccp(display.width * 1.5, display.height * 0.85))
    self.logoLayer = logoLayer

    local titleSprite = display.newSprite("image/title.png")
    self:addChild(titleSprite)
    titleSprite:setPosition(ccp(display.width * 1.5, display.height * 0.67))
    self.titleSprite = titleSprite

    -- add the main menu
    local btnStartGame = WoodButton.new{
        title = "开始游戏",
        listener = function()
            print("Start game")
        end
    }
    local btnInvite = WoodButton.new{
        title = "邀请好友",
        listener = function()
            print("Invite friends")
        end
    }
    local btnCoin = WoodButton.new{
        title = "免费金币",
        listener = function()
            print("Free coins")
        end
    }
    local mainMenu = ui.newMenu{btnStartGame, btnInvite, btnCoin}
    self:addChild(mainMenu)
    mainMenu:setPosition(ccp(display.width * 1.5, display.height * 0.4))
    mainMenu:alignItemsVerticallyWithPadding(display.height * 0.04)
    self.mainMenu = mainMenu

    -- add the bottom button
    local btnFavorite = WoodSquare.new{
        image = 'image/favorite.png',
        imageActive = 'image/favoriteActive.png',
        listener = function()
            print("Favorite")
        end
    }
    local btnSetting = WoodSquare.new{
        image = 'image/setting.png',
        imageActive = 'image/settingActive.png',
        listener = function()
            self:showSettingLayer()
        end
    }
    local settingMenu = ui.newMenu{btnFavorite, btnSetting}
    self:addChild(settingMenu)
    settingMenu:setPosition(ccp(display.width * 1.5, display.height * 0.1))
    settingMenu:alignItemsHorizontallyWithPadding(display.cx)
    self.settingMenu = settingMenu
end

function MenuScene:easeIn(node, delay)
    node:setPositionX(display.width * 1.5);
    transition.execute(node, CCMoveBy:create(0.6, ccp(-display.width, 0)), {
        delay = delay,
        easing = 'exponentialOut'
    })
end

function MenuScene:onEnterTransitionFinish()
    for i,v in ipairs{
        self.logoLayer,
        self.titleSprite,
        self.mainMenu,
        self.settingMenu
    } do
        self:easeIn(v, i * 0.1)
    end
end

function MenuScene:showSettingLayer()
    local node = display:newNode()

    local bgLayer = self:newWoodLayer()
    bgLayer:addTo(node)

    local settingNode = SettingNode.new()
    settingNode:setPosition(display.cx, display.height * 0.85)
    node:addChild(settingNode)

    local backMenu, backButton = self:newBackMenu(function()
        node:removeFromParent()
    end)
    node:addChild(backMenu)

    self:addChild(node)
    self:showBackButton(backMenu, backButton, true)
end

function MenuScene:onExit()
end

return MenuScene
