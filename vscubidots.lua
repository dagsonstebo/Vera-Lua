--[[
Vera Lua scene for reading sensor variables and writing to Ubidots.

Configure Ubidots token in variables as well as all sensor readings in the
VERAVARS array, and use code in the Luup section of the Vera scene.
--]]

-- Variables
local UBIURL = "http://things.ubidots.com/api/v1.6/variables/"
local HEADER = "\"Content-Type: application/json\""
local UBITOKEN = "UbidotsTokenHere"
local FAILVAL = 0

-- Populate all variables to be read.
local VERAVARS = {
  { ID=12, NAME="KTTEMP", VARID="UbidotsVariableID1", SVC="urn:upnp-org:serviceId:TemperatureSensor1",  VAL="CurrentTemperature" },
  { ID=17, NAME="LRTEMP", VARID="UbidotsVariableID2", SVC="urn:upnp-org:serviceId:TemperatureSensor1",  VAL="CurrentTemperature" },
  { ID=14, NAME="KTHUMID", VARID="UbidotsVariableID3", SVC="urn:micasaverde-com:serviceId:HumiditySensor1",  VAL="CurrentLevel" },
  { ID=19, NAME="LRHUMID", VARID="UbidotsVariableID4", SVC="urn:micasaverde-com:serviceId:HumiditySensor1",  VAL="CurrentLevel" },
  { ID=13, NAME="KTLIGHT", VARID="UbidotsVariableID5", SVC="urn:micasaverde-com:serviceId:LightSensor1",  VAL="CurrentLevel" },
  { ID=18, NAME="LRLIGHT", VARID="UbidotsVariableID6", SVC="urn:micasaverde-com:serviceId:LightSensor1",  VAL="CurrentLevel" }
}

for k,v in pairs(VERAVARS) do
  -- Read each value.
  local RETVAL = luup.variable_get(v["SVC"], v["VAL"], v["ID"]) or FAILVAL
  -- Build curl command
  local UPDATEURL = UBIURL..v["VARID"].."/values/?token="..UBITOKEN
  local POSTDATA = "\'{\"value\":"..RETVAL.."}\'"
  -- Execute curl command.
  COMMAND = "curl -X POST -H "..HEADER.." -d "..POSTDATA.." "..UPDATEURL
  os.execute(COMMAND)
  -- Log each reading.
  luup.log("Ubidots: "..v["NAME"].." = "..RETVAL)
end

luup.log("Ubidots: update complete")

return true