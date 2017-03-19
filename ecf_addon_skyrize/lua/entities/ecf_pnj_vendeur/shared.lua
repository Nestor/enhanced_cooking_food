ENT.PrintName = "Vendeur de Produit"
ENT.Author = "Skyyrize"
ENT.Category    = "ECF" 
ENT.Spawnable		= true 
ENT.AdminSpawnable	= true 
ENT.AutomaticFrameAdvance = true
ENT.Type = "ai" 
ENT.Base = "base_ai" 

function ENT:SetAutomaticFrameAdvance( bUsingAnim ) 
	self.AutomaticFrameAdvance = bUsingAnim
end