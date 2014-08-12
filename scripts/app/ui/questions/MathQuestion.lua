local TimeCounter = import('app.ui.TimeCounter')
local BaseQuestion = import('.BaseQuestion')
local Checkbox = import('app.ui.Checkbox')
local WoodSquare = import('app.ui.WoodSquare')
local WoodButton = import('app.ui.WoodButton')

local MathQuestion = class('MathQuestion', function()
    return BaseQuestion.new()
end)

function MathQuestion:ctor()
    self.question = ez.gameScene.currentQuestion
    self:setTip("5秒内计算5个算式的结果！")
    self.tipHeight = self.tip:getContentSize().height

    self.timeCounter = TimeCounter.new{
        total = ez.gameScene.currentQuestion.timeout,
        listener = function()

        end
    }
    self.timeCounter:setPosition(ccp(display.cx, 80))
    self:addChild(self.timeCounter)

    local baseHeight = self.timeCounter:getContentSize().height / 2 + 90
    local height = self:getAvailableHeight() - baseHeight

    self.checkboxes = {}
    for i = 1, 3 do
        local checkbox = Checkbox.new()
        checkbox:setPosition(ccp(display.cx - (3 / 2.0 + 0.5 - i) * 70, baseHeight + height * 0.9))
        self:addChild(checkbox)
        self.checkboxes[i] = checkbox
    end
    self.level = 1

    self.buttons = {}
    for i = 1, 10 do
        local r = 80
        local dis = (display.width - 5 * r) / 6
        local btn = WoodSquare.new{
            title = (i - 1),
            clear = true,
            listener = function()
                print(i - 1)
            end,
            x = ((i - 1) % 5 * 2 + 1) * r / 2 + ((i - 1) % 5 + 1) * dis,
            y = (3.5 - math.ceil(i / 5) * 1.2) * r + baseHeight
        }
        self.buttons[i] = btn
    end
    self.menu = ui.newMenu(self.buttons)
    self.menu:setPosition(ccp(0, 0))
    self:addChild(self.menu)
end

function MathQuestion:newLevel()    
--    self:setButtonEnabled(false)
    self.timeCounter:reset()
end

function MathQuestion:passLevel()
    local checkbox = self.checkboxes[self.level]
    checkbox:setChecked(true)

    self.level = self.level + 1
    if self.level > #self.checkboxes then
        self:gotoNextQuestion()
    else
        self:newLevel()
    end
end

function MathQuestion:onEnterTransitionFinish()
    self:showTip(true, function()
--        self:newLevel()
    end)
end

return MathQuestion