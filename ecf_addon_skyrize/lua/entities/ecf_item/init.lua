AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()
	self:SetModel("");
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
			if (self:GetNWInt("isfood") == 1) then
				caller:setSelfDarkRPVar("Energy", math.Clamp((caller:getDarkRPVar("Energy") or 0) + self:GetNWInt("foodenergy"), 0, 100))

				self:Remove()
				activator:EmitSound("vo/sandwicheat09.mp3", 100, 100)
			end
		end;
		self.nextUse = CurTime() + 1;	
	end;
end;