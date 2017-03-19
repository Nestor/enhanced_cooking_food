include("shared.lua");

surface.CreateFont("methFont", {
	font = "Arial",
	size = 30,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

surface.CreateFont("methFont1", {
	font = "Arial",
	size = 15,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

function ENT:Draw()
	self:DrawModel();

	
	local pos = self:GetPos()
	local ang = self:GetAngles()

local butPos2 = self:GetPos()+(self:GetUp()*13)+(self:GetForward()*20)+(self:GetRight()*14)
local butPos1 = self:GetPos()+(self:GetUp()*13)+(self:GetForward()*20)+(self:GetRight()*-17)
local butPos3 = self:GetPos()+(self:GetUp()*13)+(self:GetForward()*20)+(self:GetRight()*-2 )


	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);

	if LocalPlayer():GetPos():Distance(self:GetPos()) < 256 then
			
		cam.Start3D2D(pos+ang:Up()*19.5+ang:Right()*-22.5, ang, 0.1)
		--cam.Start3D2D(pos+Angg:Up()*-40.1+Angg:Right()*21.4 , Angg, 0.2)
			
			surface.SetDrawColor(Color(10, 10, 10, 200));
			surface.DrawRect(-185, -140, 395, 360)

			-- surface.SetDrawColor(Color(55, 55, 55, 255));
			-- surface.DrawRect(-185, -95, 495/2, 200)

		
			surface.SetDrawColor(Color(55, 55, 55, 255));
			surface.DrawRect(-185, -110, 810/2 -10, 140)
		
			surface.SetDrawColor( Color(58,133,177) );
			surface.DrawRect(-180, -105, 800/2 -15, 130)
		

			-- surface.SetDrawColor(Color(50, 50, 50, 255));
			-- surface.DrawRect(-200 + 495/2, -95, 180, 200)

			-- surface.SetDrawColor(Color(200, 55, 55, 255));
			-- surface.DrawRect(-200 + 495/2 +5, -90, 170, 115)


			if (LocalPlayer():GetEyeTrace().HitPos:Distance(butPos1)<3) then
				surface.SetDrawColor(Color(75, 75, 75, 200));
			else
				surface.SetDrawColor(  Color(58,133,177) );
			end;	

			surface.DrawRect(-120 + 495/2, -50/2  +78, 80, 70)

			if (LocalPlayer():GetEyeTrace().HitPos:Distance(butPos2)<3) then
				surface.SetDrawColor(Color(75, 75, 75, 200));
			else
				surface.SetDrawColor(  Color(58,133,177));
			end


			surface.DrawRect(-100 + 495/2 -330, -50/2  +78, 80, 70)

			surface.SetDrawColor(Color(50, 50, 50, 255));
			surface.SetMaterial( Material("icon16/bullet_arrow_down.png"))
			surface.DrawTexturedRectRotated( -100 + 600/2 + -35, -75/2 +114, 85, 75, 90 )

			surface.SetDrawColor(Color(50, 50, 50, 255));
			surface.SetMaterial( Material("icon16/bullet_arrow_down.png"))
			surface.DrawTexturedRectRotated( -160 + 35/2, -75/2 +120, 85, 75, -90 )
			--ssurface.DrawTexturedRect(-100 + 495/2 -5, -95/2 +78, 85, 75)
			--surface.SetTexture( surface.GetTextureID("user16/bullet_arrow_down.png" ))


			local selected = self:GetNWInt("selected")
			if not selected then return false end

			for k,v in pairs (FoodRecipes) do
			
				surface.SetFont( "Trebuchet24" )
				surface.SetTextColor( 255, 255, 255, 255 )
				surface.SetTextPos( -175 , -100 )
				surface.DrawText( "Péparation:" )

					surface.SetFont( "Trebuchet24" )
					surface.SetTextColor( 255, 255, 255, 255 )
					surface.SetTextPos( -50 , -100 )
					surface.DrawText( FoodRecipes[selected].Name )
				
				surface.SetFont( "Trebuchet24" )
				surface.SetTextColor( 255, 255, 255, 255 )
				surface.SetTextPos( -175 , -75 )
				surface.DrawText( "Ingrédients: " )
	
				surface.SetFont( "Trebuchet24" )
				surface.SetTextColor( 255, 255, 255, 255 )
				surface.SetTextPos( -175 , -25 )
				surface.DrawText( "Temps de cuisson:" )
				
				surface.SetFont( "Trebuchet24" )
				surface.SetTextColor( 255, 255, 255, 255 )
				surface.SetTextPos( -15 , -25 )
				surface.DrawText( FoodRecipes[selected].Temps )

				if (LocalPlayer():GetEyeTrace().HitPos:Distance(butPos3)<10) then
					surface.SetDrawColor(Color(80, 80, 80, 255));
				else
					surface.SetDrawColor(Color(50, 50, 50, 255));
				end;	
				surface.DrawRect(-100, -95/2  +78 + 35, 495/2 -23, 30)
				surface.SetFont( "Trebuchet24" )
				surface.SetTextColor( 255, 255, 255, 255 )
				surface.SetTextPos(-80, -95/2  +78 + 38)
				surface.DrawText( "Commencer la cuisson" )
			end

			local yaxis = 0
			for k , v in pairs (FoodRecipes[selected].Ingrediants ) do
				surface.SetFont( "Trebuchet24" )
				surface.SetTextColor( 255, 255, 255, 255 )
				local lengttext = k..": "..self:GetNWInt(k).."/"..v
				surface.SetTextPos( -175+85*yaxis, -50 )
				surface.DrawText( lengttext )


				yaxis = yaxis +1.5
			end

		cam.End3D2D()


	local pos = self:GetPos() 

	local Angg = self:GetAngles()


	local butPos1 = self:GetPos()+(self:GetUp()*-6)+(self:GetForward()*13)+(self:GetRight()*-10)
	local butPos2 = self:GetPos()+(self:GetUp()*-6)+(self:GetForward()*13)+(self:GetRight()*-17)

    Angg:RotateAroundAxis(Angg:Up(), 90)
	Angg:RotateAroundAxis(Angg:Forward(), -180)--ici
	Angg:RotateAroundAxis(Angg:Right(), 0)
		

		cam.Start3D2D(pos+Angg:Up()*-40.1+Angg:Right()*21.4 , Angg, 0.2)
		--cam.Start3D2D(pos+Angg:Up()*19.5, Angg, 90.1)
         
		 --noir
			surface.SetDrawColor(Color(10, 10, 10, 200));
			surface.DrawRect(-90, -200, 192, 50)
		--vert	
			surface.SetDrawColor(Color(22, 227, 42, 255));
			surface.DrawRect(-85, -192,self:GetNWInt("time") * 181 / FoodRecipes[selected].Temps, 38)

        cam.End3D2D()



	end;
end;
