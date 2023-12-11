require "/scripts/util.lua"

function init()
    --shellguard dev code
  self.iAction = config.getParameter("iAction")
  self.iData = config.getParameter("iData")
  
  local itemConfig = root.itemConfig(config.getParameter("parentVendor"))
  self.iData.paneLayoutOverride = itemConfig.config.interactData.paneLayoutOverride
  self.iData.buyFactor = itemConfig.config.interactData.buyFactor
  self.iData.sellFactor = itemConfig.config.interactData.sellFactor
  self.iData.items = itemConfig.config.interactData.items
  
  object.setInteractive(true)
    -- conversion code
  object.setConfigParameter("interactData", self.iData)
end

function onInteraction(args)
  self.config = nil
  self.interactData = config.getParameter("interactData")
  if self.interactData.config == "/interface/windowconfig/merchant.config" then
      self.config = "/d8lib-vendingmachine_custom_pane/scripts/interface/scriptedcraftpane/Config/merchant.config"
  elseif self.interactData.config == "/interface/windowconfig/vendingmachine.config" then
      self.config = "/d8lib-vendingmachine_custom_pane/scripts/interface/scriptedcraftpane/Config/vendingmachine.config"
  end
  
  if self.config ~= nil then
    return { "ScriptPane", self.config}
  end
  if self.config == nil then
    return { "ScriptPane", self.interactData}
  end
end