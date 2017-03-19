AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include('shared.lua') 


function ENT:Initialize( ) 
	
	self:SetModel( "models/Humans/Group01/Male_01.mdl" )
	self:SetMoveType(MOVETYPE_NONE)
	self:SetHullType( HULL_HUMAN ) 
	self:SetHullSizeNormal( )
	self:SetNPCState( 0 )
	self:SetSolid(  SOLID_BBOX ) 
	self:CapabilitiesAdd(CAP_ANIMATEDFACE) 
	self:SetUseType( SIMPLE_USE ) 
	self:DropToFloor()
	
	self:SetMaxYawSpeed( 90 ) 
	
end

function ENT:OnTakeDamage()
	return false 
end 

function ENT:AcceptInput( Name, Activator, Caller )	

	if Name == "Use" and Caller:IsPlayer() then
		

		net.Start( "ECF_NPCPNL")
		net.Send(Caller)
		
	end
	
end