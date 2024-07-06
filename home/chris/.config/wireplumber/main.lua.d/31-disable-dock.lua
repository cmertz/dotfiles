rule = {
	matches = {
		{
			{ "device.name", "matches", "alsa_card.usb-Lenovo_ThinkPad_Thunderbolt_3_Dock_USB_Audio_*" },
		},
	},
	apply_properties = {
		["device.disabled"] = true,
	},
}

table.insert(alsa_monitor.rules, rule)
