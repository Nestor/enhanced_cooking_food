AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()
	self:SetNWInt("selected", 1)
	self:SetModel("models/sickness/stove_01.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetHealth(400);
   
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
   
	self:SetNWInt("distance", 256);
   
	self:SetNWBool("explode", false);

	self:SetNWInt("status", 0);
	self:SetNWInt("time", 0)

	self:SetPos(self:GetPos()+Vector(0, 0, 32));
   
	self:GetPhysicsObject():SetMass(105); 

	local dropitem = false
 end;

function ENT:SpawnFunction(ply, trace)
	local ent = ents.Create("ecf_stove");
	ent:SetPos(trace.HitPos + trace.HitNormal * 8);
	ent:Spawn();
	ent:Activate();
 
	return ent;
end;


function ENT:Use(activator, caller)
	--print(self:GetNWInt("selected")) --and self:GetNWInt("selected") <= table.Count(RecipesFood)
local butPos1 = self:GetPos()+(self:GetUp()*13)+(self:GetForward()*20)+(self:GetRight()*14)
local butPos2 = self:GetPos()+(self:GetUp()*13)+(self:GetForward()*20)+(self:GetRight()*-17)

local butPos3 = self:GetPos()+(self:GetUp()*13)+(self:GetForward()*20)+(self:GetRight()*-2 )

local selected = self:GetNWInt("selected")
	--print(self:GetNWInt("selected"))

	if (activator:GetEyeTrace().Entity == self) then
		if (!self.nextUse or CurTime() >= self.nextUse) then

			--activator:SendLua("local tab = {Color(255,255,255,255), [["..self:GetNWInt("time").."]],} chat.AddText(unpack(tab))");



			if (activator:GetEyeTrace().HitPos:Distance(butPos3)<5 and self:GetNWInt("status") != 1)  then
				for k,v in pairs( FoodRecipes[selected].Ingrediants ) do
					if ( self:GetNWInt(k) < v ) then
						activator:SendLua("local tab = {Color(255,255,255,255), [[Vous n'avez pas tous les éléments ]],} chat.AddText(unpack(tab))");
						break
					else
						self:SetNWInt(k, self:GetNWInt(k) -v)
						self:SetNWInt("status", 1)
					end
				end
			end

			if (activator:GetEyeTrace().HitPos:Distance(butPos2)<3 and self:GetNWInt("status") != 1)  then
				if (self:GetNWInt("selected") < table.Count(FoodRecipes)) then
					self:SetNWInt("selected", self:GetNWInt("selected") +1)
				end

			end

			if (activator:GetEyeTrace().HitPos:Distance(butPos1)<3 and self:GetNWInt("status") != 1) then
				if (self:GetNWInt("selected") > 1) then
					self:SetNWInt("selected", self:GetNWInt("selected") -1)
				end
			end
		self.nextUse = CurTime() + 0.25;
		end;
	end
end

function ENT:Think()
local selected = self:GetNWInt("selected")
if (!self.nextSecond or CurTime() >= self.nextSecond) then
		if(self:GetNWInt("status") == 1) then
			self:SetNWInt("time", self:GetNWInt("time")+1)
		end
		if ( self:GetNWInt("time") >= FoodRecipes[selected].Temps) then
			local foodc = ents.Create("ecf_item");
						foodc:SetModel(FoodRecipes[selected].Model)
						foodc:SetPos(self:GetPos()+self:GetUp()*20);
						foodc:SetAngles(self:GetAngles());
						foodc:SetNWInt("foodenergy", FoodRecipes[selected].FoodGain)
						foodc:SetNWInt("isfood", 1)
						foodc:Spawn();
						foodc:GetPhysicsObject():SetVelocity(self:GetUp()*2);
			self:SetNWInt("time", 0)
			self:SetNWInt("status", 0)
		end;
	self.nextSecond = CurTime() + 1;
	end;
end;

function ENT:PhysicsCollide(data, phys)
local curTime = CurTime(); 		
	if ( (data.DeltaTime > 0) and (data.HitEntity:GetClass() == "ecf_item") and (self:GetNWInt("status") != 1) ) then
			self:SetNWInt(data.HitEntity:GetNWString("name"), self:GetNWInt(data.HitEntity:GetNWString("name")) +1);
			data.HitEntity:Remove();
	end;
end;


function ENT:OnTakeDamage(dmginfo)
	self:SetHealth(self:Health()-dmginfo:GetDamage());
		if self:Health() <= dmginfo:GetDamage() then
			if !self:GetNWBool("explode") then
							self:SetNWBool("explode", true);
							self:Explode();
			end;
		end;
end;

function ENT:Explode() 
	local explosionSize = 100;
   
	local explodeboom = ents.Create("env_explosion");                        
	explodeboom:SetPos(self:GetPos());
	explodeboom:SetKeyValue("iMagnitude", explosionSize);
	explodeboom:Spawn();
	explodeboom:Activate();
	explodeboom:Fire("Explode", 0, 0);
   
	local fireboom = ents.Create("env_shake");
	fireboom:SetPos(self:GetPos());
	fireboom:SetKeyValue("amplitude", (explosionSize*2));
	fireboom:SetKeyValue("radius", explosionSize);
	fireboom:SetKeyValue("duration", "1.5");
	fireboom:SetKeyValue("frequency", "255");
	fireboom:SetKeyValue("spawnflags", "4");
	fireboom:Spawn();
	fireboom:Activate();
	fireboom:Fire("StartShake", "", 0);
   
	self:Remove();
end;