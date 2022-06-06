function user_setup()

	include('Common/BRD_UserSetup_Common.lua')

end

function init_gear_sets()

	include('Common/BRD_Common.lua')
	
end

function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DT')
    state.CastingMode:options('Normal','Resistant','AoE')
    state.IdleMode:options('Normal','DT')
	state.Weapons:options('None','Naegling','DualNaegling')
--	state.Weapons:options('None','Naegling','Aeneas','DualWeapons','DualNaegling','DualTauret','DualAeolian')
-- new function to define preset songs
	state.SongMode = M{['description'] ='SongMode','Melee','Cleave','Mage',' Minnone'}
	state.SongMode:options('Melee','Minne','Cleave','Mage','Odyssey','Minnone')

	gear.melee_jse_back = {name="Intarabus's Cape",augments={'Accuracy+20 Attack+20'}}
	gear.magic_jse_back = {name="Intarabus's Cape",augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Terpander'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 1
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
--	send_command('bind !r gs c weapons None;gs c update')
--	send_command('bind !q gs c weapons NukeWeapons;gs c update')
--	send_command('bind ^q gs c weapons Swords;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Genbu Shield"}
	sets.weapons.DualWeapons = {main="Aeneas",sub="Blurred Knife +1"}
	sets.weapons.DualNaegling = {main="Naegling",sub="Blurred Knife +1"}
	sets.weapons.Naegling = {main="Naegling",sub="Genbu Shield"}
	sets.weapons.DualTauret = {main="Tauret",sub="Blurred Knife +1"}
	sets.weapons.DualAeolian = {main="Tauret",sub="Malevolence"}

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main="Kali",sub="Genbu Shield",ammo="Impatiens",
		head="Nahtirah Hat",neck="Jeweled Collar",ear1="Loquac. Earring",ear2="Etiolation Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",
		back=gear.magic_jse_back,waist="Witful Belt",legs="Aya. Cosciales +2",feet="Telchine Pigaches"}
		
	sets.precast.FC.DT = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head="Inyanga Tiara +2",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back=gear.magic_jse_back,waist="Witful Belt",legs="Aya. Cosciales +2",feet="Bihu Slippers +1"}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genbu Shield"})
	
	sets.precast.FC.BardSong = 
		{
		main="Kali",sub="Genbu Shield",range="Gjallarhorn",ammo=empty,
		head="Fili Calot +1",neck="Aoidos' Matinee",ear1="Loquac. Earring",ear2="Etiolation Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Defending Ring",ring2="Stikini Ring +1",
		back=gear.magic_jse_back,waist="Aoidos' Belt",legs="Ayanmo Cosciales +2",feet="Telchine Pigaches"
	}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC.Lullaby = {range="Gjallarhorn"}
	sets.precast.FC.Lullaby.Resistant = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby'] = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby II'] = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Gjallarhorn"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
	sets.precast['Goblin Gavotte'] = sets.precast.FC.Daurdabla
	sets.precast['Gold Capriccio'] = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps +1"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Mache Earring +1",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Grunfeld Rope",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
		
	sets.precast.WS.Acc = {ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Moonshade Earring",ear2="Mache Earring +1",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
		
	sets.precast.WS['Savage Blade'] = {ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Karieyh Ring",
		back=gear.melee_jse_back,waist="Sailfi Belt +1",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
		
	sets.precast.WS['Aeolian Edge'] = {ammo="Aurgelmir Orb +1",
		head="Cath Palug Crown",neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Friomisi Earring",
		body="Chironic Doublet",hands=gear.chironic_enfeeble_hands,ring1="Metamorph Ring +1",ring2="Shiva Ring +1",
		back=gear.melee_jse_back,waist="Refoccilation Stone",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Bunzi's Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back=gear.magic_jse_back,waist="Witful Belt",legs="Aya. Cosciales +2",feet="Bihu Slippers +1"}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
	sets.midcast.Lullaby = {range="Gjallarhorn"}
	sets.midcast.Lullaby.Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'] = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'].AoE = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby II'] = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Gjallarhorn"}
	sets.midcast.Madrigal = {head="Fili Calot +1"}
	sets.midcast.Paeon = {}
	sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Gjallarhorn"})
	sets.midcast.Minuet = {body="Fili Hongreline +1"}
	sets.midcast.Minne = {}
	sets.midcast.Carol = {}
	sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
	sets.midcast['Magic Finale'] = {range="Gjallarhorn"}
	sets.midcast.Mazurka = {range="Gjallarhorn"}
	
 	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
		main="Kali",
		head="Fili Calot +1",
		neck="Moonbow Whistle",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		back=gear.magic_jse_back,
		waist="Flume Belt",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"}
		
	sets.midcast.SongEffect.DW = {main="Kali",sub="Kali"}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {main="Kali",sub="Ammurapi Shield",range="Gjallarhorn",ammo=empty,
		head="Inyanga Tiara +2",neck="Mnbw. Whistle +1",ear1="Regal Earring",ear2="Digni. Earring",
		body="Fili Hongreline +1",hands="Inyan. Dastanas +2",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
		back=gear.magic_jse_back,waist="Acuity Belt +1",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
		
	sets.midcast.SongDebuff.DW = {main="Kali",sub="Kali"}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Gjallarhorn",ammo=empty,
		head="Inyanga Tiara +2",neck="Mnbw. Whistle +1",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
		back=gear.magic_jse_back,waist="Acuity Belt +1",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",range="Gjallarhorn",ammo=empty,
		head="Inyanga Tiara +2",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back=gear.magic_jse_back,waist="Witful Belt",legs="Fili Rhingrave +1",feet="Aya. Gambieras +2"}
		
	sets.midcast.SongDebuff.DW = {}

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})
	sets.midcast['Goblin Gavotte'] = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})
	sets.midcast['Gold Capriccio'] = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})
	
	-- Other general spells and classes.
	sets.midcast.Cure = {main="Serenity",sub="Curatio Grip",ammo="Pemphredo Tathlum",
        head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Mendi. Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Janniston Ring",ring2="Menelaus's Ring",
        back="Tempered Cape +1",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] = {main="Serenity",sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Voltsurge Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=gear.magic_jse_back,waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
		
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	-- Resting sets
	sets.resting = {
		main="Daybreak",sub="Genbu's Shield",ammo="Staunch Tathlum",
		head=empty,neck="Twilight Torque",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Respite Cloak",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Assid. Pants +1",feet="Nyame Sollerets"
	}
	
	sets.idle = {
		main="Daybreak",sub="Genbu's Shield",ammo="Staunch Tathlum",
		head=empty,neck="Twilight Torque",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Respite Cloak",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Assid. Pants +1",feet="Nyame Sollerets"
	}
		
	sets.idle.NoRefresh = {main="Daybreak",sub="Genbu Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.idle.DT = {main="Daybreak",sub="Genbu Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	
	-- Defense sets

	sets.defense.PDT = {main="Terra's Staff", sub="Umbra Strap",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MDT = {main="Terra's Staff", sub="Umbra Strap",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.Kiting = {feet="Fili Cothurnes +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {main="Aeneas",sub="Genbu Shield",ammo="Seeth. Bomblet +1",
		head="Aya. Zucchetto +2",neck="Bard's Charm +1",ear1="Trux Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Rajas Ring",
		back=gear.melee_jse_back,waist="Windbuffet Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
	sets.engaged.DT = {main="Aeneas",sub="Genbu Shield",ammo="Aurgelmir Orb +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Windbuffet Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.engaged.Acc = {main="Aeneas",sub="Genbu Shield",ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
	sets.engaged.DW = {main="Aeneas",sub="Blurred Knife +1",ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +2",feet="Battlecast Gaiters"}
	sets.engaged.DW.DT = {main="Aeneas",sub="Blurred Knife +1",ammo="Aurgelmir Orb +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Brutal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Reiki Yotai",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.engaged.DW.Acc = {main="Aeneas",sub="Blurred Knife +1",ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Suppanomimi",ear2="Telos Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
	sets.engaged.DW.Acc.DT = {main="Aeneas",sub="Blurred Knife +1",ammo="Aurgelmir Orb +1",
		head="Nyame Helm",neck="Combatant's Torque",ear1="Suppanomimi",ear2="Telos Earring",
		body="Ayanmo Corazza +2",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Reiki Yotai",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.engaged.Naegling = set_combine(sets.engaged,{})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(10, 10)
end

state.Weapons:options('None','Naegling','Aeneas','DualWeapons','DualNaegling','DualTauret','DualAeolian')

autows_list = {['Naegling']='Savage Blade',['Aeneas']="Rudra's Storm",['DualWeapons']="Rudra's Storm",['DualNaegling']='Savage Blade',['DualTauret']='Evisceration',
     ['DualAeolian']='Aeolian Edge'}	

	-- autosong modified to account for the selection up there. Very rough. Can do 4 songs if adjusted, obviously. No JAs, no fancy stuff.
	function check_song()
		if state.AutoSongMode.value then
			if state.SongMode.value == "Melee" then
				
					if not buffactive.march then
						windower.chat.input('/ma "Victory March" <me>')
						tickdelay = os.clock() + 2
					return true
					elseif not buffactive.minuet then
						windower.chat.input('/ma "Valor Minuet V" <me>')
						tickdelay = os.clock() + 2
					return true
					elseif not buffactive.madrigal then
						windower.send_command('gs c set ExtraSongsMode FullLength;input /ma "Blade Madrigal" <me>')
						tickdelay = os.clock() + 2
					return true
					else	
					return false
					end

				elseif state.SongMode.value == "Minne" then
				
					if not buffactive.march then
						windower.chat.input('/ma "Victory March" <me>')
						tickdelay = os.clock() + 2
					return true
					elseif not buffactive.minuet then
						windower.chat.input('/ma "Valor Minuet V" <me>')
						tickdelay = os.clock() + 2
					return true
					elseif not buffactive.minne then
						windower.send_command('gs c set ExtraSongsMode FullLength;input /ma "Knights Minne V" <me>')
						tickdelay = os.clock() + 2
					return true
					else	
					return false
					end
				
			elseif state.SongMode.value == "Cleave" then
				
					if not buffactive.march then
						windower.chat.input('/ma "Victory March" <me>')
						tickdelay = os.clock() + 2
					return true
					elseif not buffactive.minne then
						windower.chat.input('/ma "Knights Minne V" <me>')
						tickdelay = os.clock() + 2
					return true
					elseif not buffactive.mambo then
						windower.send_command('gs c set ExtraSongsMode FullLength;input /ma "Dragonfoe Mambo" <me>')
						tickdelay = os.clock() + 2
					return true
					else	
					return false
					end
				
			elseif state.SongMode.value == "Mage" then
				
					if not buffactive.march then
						windower.chat.input('/ma "Victory March" <me>')
						tickdelay = os.clock() + 2
					return true
					elseif not buffactive.ballad then
						windower.chat.input('/ma "Mages Ballad III" <me>')
						tickdelay = os.clock() + 2
					return true
					elseif not buffactive.mambo then
						windower.send_command('gs c set ExtraSongsMode FullLength;input /ma "Mages Ballad II" <me>')
						tickdelay = os.clock() + 2
					return true
					else	
					return false
					end

				elseif state.SongMode.value == "Odyssey" then
				
					if not buffactive.march then
						windower.chat.input('/ma "Victory March" <me>')
						tickdelay = os.clock() + 2
					return true
					elseif not buffactive.madrigal then
						windower.chat.input('/ma "Blade Madrigal" <me>')
						tickdelay = os.clock() + 2
					return true
					elseif not buffactive.mambo then
						windower.send_command('gs c set ExtraSongsMode FullLength;input /ma "Dragonfoe Mambo" <me>')
						tickdelay = os.clock() + 2
					return true
					else	
					return false
					end

				elseif state.SongMode.value == "Minnone" then
				
					if not buffactive.minne then
						windower.send_command('input /ma "Knights Minne V" <me>;pause 7.0;input /ma "Knights Minne IV" <me>;pause 7.0;gs c set ExtraSongsMode FullLength;input /ma "Advancing March" <me>')
						tickdelay = os.clock() + 2
					return true
					else	
					return false
				end
				
			else
			return false
			end
		else
		return false
		end
	end


	function user_job_lockstyle()
		windower.chat.input('/lockstyleset 03')
end