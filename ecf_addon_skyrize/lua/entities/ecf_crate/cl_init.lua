include('shared.lua') 

function ENT:Draw()
	self:DrawModel();

	
	local pos = self:GetPos()
	local ang = self:GetAngles()


	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);

	if LocalPlayer():GetPos():Distance(self:GetPos()) < 256 then
			
		cam.Start3D2D(pos+ang:Up()*19.5+ang:Right()*-22.5, ang, 0.1)


			surface.DrawRect(-100 + 495/2 -330, -50/2  +78, 80, 70)

	
				surface.DrawRect(-100, -95/2  +78 + 35, 495/2 -23, 30)
				surface.SetFont( "Trebuchet24" )
				surface.SetTextColor( 255, 255, 255, 255 )
				surface.SetTextPos(-80, -95/2  +78 + 38)
				surface.DrawText( "Commencer la cuisson" )


		cam.End3D2D()
	end

end;
