local CrystalButton = class('CrystalButton', function()
    return display.newNode()
end)

-- params: color, title, titleColor, scale, prepare, listener, x, y
function CrystalButton:ctor(params)
    self.bg = display.newSprite("#crystal_" .. params.color .. '.png')
    self:addChild(self.bg)

    self:setScale(params.scale)

    params.sound = 'sound/click.mp3'

    self:setTouchEnabled(true)
    self:addTouchEventListener(function()
        if params.sound then
            ez:playEffect(params.sound)
        end
        if params.prepare then
            params.prepare()
        end

        jumpAnimate(self.bg, function()
            if params.listener then
                params.listener()
            end
        end)
        jumpAnimate(self.label)
    end)

    local x, y = params.x, params.y
    if x and y then self:setPosition(x, y) end

    if params.title then
        local pos = self:getContentSize()
        local label = ez:newLabel{
            text = params.title,
            align = ui.TEXT_ALIGN_CENTER,
            size = 200,
            color = params.titleColor,
            x = pos.width * 0.5,
            y = pos.height * 0.55
        }
        self:addChild(label)
        self.label = label
    end
end

return CrystalButton
