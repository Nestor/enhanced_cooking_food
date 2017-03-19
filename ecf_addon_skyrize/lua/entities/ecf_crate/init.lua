AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()
	self:SetModel("models/props_junk/wood_crate001a.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self:GetPhysicsObject():SetMass(50);
end;

function ENT:SpawnFunction(ply, trace, entt)
	local ent = ents.Create(entt);
	ent:SetPos(trace.HitPos + trace.HitNormal * 8);
	ent:Spawn();
	ent:Activate();    
	return ent;
end;

function ENT:Use(activator, caller)
	if (!self.nextUse or CurTime() >= self.nextUse) then
		if (activator:GetEyeTrace().Entity == self) and (activator:GetPos():Distance(self:GetPos())< 100) then
			
		end;
		self.nextUse = CurTime() + 1;	
	end;
end;