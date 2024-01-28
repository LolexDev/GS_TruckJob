-- ▀█▀ █░█ ▄▀█ █▄░█ █▄▀ █▀   █▀▀ █▀█ █▀█   █▀▀ █░█ █▀█ █▀█ █▀ █ █▄░█ █▀▀   █░█ █▀ █
-- ░█░ █▀█ █▀█ █░▀█ █░█ ▄█   █▀░ █▄█ █▀▄   █▄▄ █▀█ █▄█ █▄█ ▄█ █ █░▀█ █▄█   █▄█ ▄█ ▄

Config = {}

Config.Locale = 'en' -- Jezik // Language

Config.Blipovi = {
    {
        Ime = "Truck Job", -- Ime blipa // Name of blip
        Velicina = 0.7, -- Velicina blipa // Size of blip
        Boja = nil, -- Boja blipa // Color of blip
        Ikonica = 67, -- Blip sprite // Blip sprite
        Kordinate = vector3(-121.2368, -2524.0042, 11.1582), -- Kordinate blipa // Coords of blip
        Pokazuj = 2, -- Display
    }
}

Config.Peds = {
    ['boss'] = {
        coords = vector4(-121.2368, -2524.0042, 11.1582, 238.3269),
        icon = 'fas fa-clipboard',
        hash = 'cs_fbisuit_01',
    }
}

Config.Garage = {
    {
        vehicleModel = 'rallytruck',
        coordstospawn = vector4(-109.3058, -2518.9912, 6.0000, 237.7850),
        coordstopark = vector3(-109.9633, -2518.5278, 6.0000)
    }
}

Config.DeliveryLocations = {
    ['1'] = {
        coords = vector3(-1585.1854, -838.4924, 9.9554),
        reward = math.random(500,1000), -- How much will they earn from this delivery
        delivered = false
    },
    ['2'] = {
        coords = vector3(-153.7166, -41.1549, 54.3962),
        reward = math.random(500,1000), -- How much will they earn from this delivery
        delivered = false
    },
    ['3'] = {
        coords = vector3(814.4518, -93.5292, 80.5989),
        reward = math.random(500,1000), -- How much will they earn from this delivery
        delivered = false
    },
    ['4'] = {
        coords = vector3(1301.0675, -574.2391, 71.7322),
        reward = math.random(500,1000), -- How much will they earn from this delivery
        delivered = false
    },
    ['5'] = {
        coords = vector3(873.4280, -2200.7380, 30.5193),
        reward = math.random(500,1000), -- How much will they earn from this delivery
        delivered = false,
        last = true -- Add this to last location u want to be
    }
}