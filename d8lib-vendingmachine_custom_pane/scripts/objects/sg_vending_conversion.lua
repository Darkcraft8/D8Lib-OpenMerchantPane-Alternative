require "/scripts/util.lua"
require "/objects/sgvending/sgvending.lua"
ShellguardInit = init
function init()
  --shellguard dev code. get interaction action and data from the object and overrride them with the one of the parentVendor
  ShellguardInit()
	-- patch code
  object.setConfigParameter("interactData", self.iData) -- set the interactData of the placed object to iData so that it can be used by the custom vending pane
end

function onInteraction(args) -- replaced entire onInteraction so that the custom vending pane is used instead of the vanilla OpenMerchantPane
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
