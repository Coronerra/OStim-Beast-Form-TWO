Scriptname OBF_OCRCompat Hidden
; 0.2: no OCR forms are stored in plugin properties or the save.
; SKSE GetModByName gate avoids missing-plugin GetFormFromFile errors.
Function RestoreKeywords() Global
    if Game.GetModByName("OCreatures.esp") == 255
        return
    endif
    Race ww = Game.GetFormFromFile(0x000CDD84, "Skyrim.esm") as Race
    Race vl = Game.GetFormFromFile(0x0000283A, "Dawnguard.esm") as Race
    Keyword wwKeyword = Game.GetFormFromFile(0x00005C58, "OCreatures.esp") as Keyword
    Keyword vlKeyword = Game.GetFormFromFile(0x00005C57, "OCreatures.esp") as Keyword
    if ww && wwKeyword
        if !ww.HasKeyword(wwKeyword)
            PO3_SKSEFunctions.AddKeywordToForm(ww, wwKeyword)
        endif
    endif
    if vl && vlKeyword
        if !vl.HasKeyword(vlKeyword)
            PO3_SKSEFunctions.AddKeywordToForm(vl, vlKeyword)
        endif
    endif
EndFunction
