# Vera-Lua

Various Micasaverde Vera Lua/Luup scene scripts.

## Ubidots

Scene script to write sensor readings to Ubidots. This requires a Ubidots subscription (www.ubidots.com).
The script reads all populated Vera sensor readings and writes the to the Ubisoft service using curl.

On the Ubidot page create a new datasource as well as all variables to be recorded. Make a note of:

* The account token.
* All varible ID tokens.

To map out all Vera service identifiers refer to http://<Vera IP address>:3480/data_request?id=status&output_format=xml.
Alternatively also refer to http://wiki.micasaverde.com/index.php/Luup_UPnP_Variables_and_Actions.

Populate the Ubidots scene script with:

* Service ID number.
* Chosen name for each mapped point - this is purely used to populate the Vera logs.
* The Ubidots variable IDs.
* The service identifier for each sensor to be mapped.
* The variable to be read - CurrentLevel, CurrentTemperature, etc.
* Note the metric lookup fail value - *local FAILVAL = 0* - the default nil value on lookup failure may not be suitable as the default value for every lookup, especially when using security sensors.

Create a new Vera scene to run every X minutes (keep in mind the maximum number of dots in your subscription) and copy the script into the Luup code section.

---
