require "/scripts/util.lua"

function init()
    --shellguard dev code. get interaction action and data from the object and overrride them with the one of the parentVendor
  self.iAction = config.getParameter("iAction")
  self.iData = config.getParameter("iData")
  
  local itemConfig = root.itemConfig(config.getParameter("parentVendor"))
  self.iData.paneLayoutOverride = itemConfig.config.interactData.paneLayoutOverride
  self.iData.buyFactor = itemConfig.config.interactData.buyFactor
  self.iData.sellFactor = itemConfig.config.interactData.sellFactor
  self.iData.items = itemConfig.config.interactData.items
  
  object.setInteractive(true)
	-- patch code
  object.setConfigParameter("interactData", self.iData) -- set the interactData of the placed object to iData so that it can be used by the custom vending pane
end

function onInteraction(args) -- replaced entire onInteraction so that the custom vending pane is used instead
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
