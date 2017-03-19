include('shared.lua') 

function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()+ Vector(0, 0, 72)
	local ang = self:GetAngles()

	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 300 then
		cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.25)
				draw.SimpleTextOutlined("Vendeur d'aliments", "HUDNumber5", 0, -45, Color(255, 255, 255, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, Color(25, 25, 25, 100));
		cam.End3D2D()	
	end;
end;

net.Receive( "ECF_NPCPNL", function( len, pl )

local Main = vgui.Create( "DFrame" )
	Main:SetSize( 420, 500 )
	Main:Center()
	Main:MakePopup()
	Main:SetTitle( "" )
	Main:ShowCloseButton( false )
	function Main:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 200 ) )
		draw.RoundedBox( 0, 0, 0, w, 50, Color( 50, 50, 50, 240 ) )
		draw.SimpleText( "Vendeur de Produits Frais", "HUDNumber5", w/2, 50/2, Color( 255, 255, 255 ), 1, 1 )
	end

local CloseButton = vgui.Create("DButton",Main)
	CloseButton:SetText("")
	CloseButton:SetPos( 395, 5 )
	CloseButton:SetSize(20, 20)
	CloseButton.Paint = function( self, w, h )
		draw.SimpleText( "X", "HUDNumber5", w/2, h/2, Color( 255, 0, 0 ), 1, 1 )
	end
	
	CloseButton.DoClick = function()
		Main:Remove()
	end
local idselect = 0
local selected = ""
local numcount = 1
local MainAccept = vgui.Create( "DFrame" )
	MainAccept:SetSize( 250, 150 )
	MainAccept:Center()
	MainAccept:MakePopup()
	MainAccept:SetTitle( "" )
	MainAccept:ShowCloseButton( false )
	MainAccept:SetVisible(false)
	function MainAccept:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 200 ) )
		draw.RoundedBox( 0, 0, 0, w, 15, Color( 50, 50, 50, 240 ) )
		draw.SimpleText( "Achat de "..selected, "HudSelectionText", w/2, 15/2, Color( 255, 255, 255 ), 1, 1 )
	end

local DLabel = vgui.Create( "DLabel", MainAccept )
DLabel:SetPos( 10, 25 )
DLabel:SetFont( "HudHintTextLarge" )
DLabel:SetText( "Combient voulez-vous en acheter ?" )
DLabel:SizeToContents()


local DermaButton = vgui.Create( "DButton", MainAccept ) 
DermaButton:SetText( "" )					
DermaButton:SetPos( 25, 150-30-10 )					
DermaButton:SetSize( 200, 30 )					
DermaButton.DoClick = function()
	net.Start("itembuyecf")
		net.WriteString(idselect)
		net.WriteString(numcount)
	net.SendToServer()
	MainAccept:Remove()
end
DermaButton.Paint = function( self, w, h )
		draw.SimpleText( "Confirmer", "CenterPrintText", w/2, h/2, Color( 255, 255, 255 ), 1, 1 )
		draw.RoundedBox( 0, 0, 0, w, h, Color(200, 55, 55, 155) )
end
local DLabelCount = vgui.Create( "DLabel", MainAccept )
DLabelCount:SetPos( 250/2-4, 150/2-4 )
DLabelCount:SetFont( "HudHintTextLarge" )
DLabelCount:SetText( numcount )
DLabelCount:SizeToContents()


local DownButton = vgui.Create( "DButton", MainAccept ) 
DownButton:SetText( "" )					
DownButton:SetPos( 25, 50+25/2 )					
DownButton:SetSize( 50, 25 )					
DownButton.DoClick = function()
	if numcount > 1 then
		numcount = numcount -1
		DLabelCount:SetText( numcount )
		DLabelCount:SizeToContents()
	end
end
DownButton.Paint = function( self, w, h )
		draw.SimpleText("<---", "CenterPrintText", w/2, h/2, Color( 255, 255, 255 ), 1, 1 )
		draw.RoundedBox( 0, 0, 0, w, h, Color(200, 55, 55, 100) )
end

local UpButton = vgui.Create( "DButton", MainAccept ) 
UpButton:SetText( "" )					
UpButton:SetPos( 150+25, 50+25/2 )					
UpButton:SetSize( 50, 25 )					
UpButton.DoClick = function()
	if numcount < 25 then
		numcount = numcount +1	
		DLabelCount:SetText( numcount )
		DLabelCount:SizeToContents()
	end
end
UpButton.Paint = function( self, w, h )
		draw.SimpleText("--->", "CenterPrintText", w/2, h/2, Color( 255, 255, 255 ), 1, 1 )
		draw.RoundedBox( 0, 0, 0, w, h, Color(200, 55, 55, 100) )
end

local CloseButtonAccept = vgui.Create("DButton",MainAccept)
	CloseButtonAccept:SetText("")
	CloseButtonAccept:SetPos( 230, -4 )
	CloseButtonAccept:SetSize(25, 25)
	CloseButtonAccept.Paint = function( self, w, h )
		draw.SimpleText( "X", "CenterPrintText", w/2, h/2, Color( 255, 0, 0 ), 1, 1 )
	end
	
	CloseButtonAccept.DoClick = function()
		MainAccept:Remove()
	end

local DScroll = vgui.Create( "DScrollPanel", Main )
	DScroll:SetSize( 410, 400 )
	DScroll:SetPos( 0, -100 )
	DScroll:Center()
	local sbar = DScroll:GetVBar()
	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
	end
	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(200, 55, 55, 155) )
	end
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(200, 55, 55, 155) )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(200, 55, 55, 255) )
	end
local chaulut = 80
local sautelignetext = 0
local count = 0
for k, v in pairs(IngrediantFood) do

	local si = vgui.Create( "SpawnIcon" , DScroll )
	si:SetPos( 0+chaulut*count, 0+chaulut*sautelignetext )
	si:SetModel( IngrediantFood[k].Model )
	si:SetTooltip( IngrediantFood[k].Name.."\n"..IngrediantFood[k].Desc.."\n".."Prix: $"..IngrediantFood[k].Price )
	si.DoClick = function()				
		MainAccept:SetVisible(true)
		Main:Remove()
		selected = IngrediantFood[k].Name
		idselect = k

	end

	local lbl = vgui.Create( "DLabel", DScroll )
	lbl:SetPos( 0+chaulut*count, 65+chaulut*sautelignetext )
	lbl:SetFont( "HudHintTextLarge" )
	lbl:SetText( "Prix: $"..IngrediantFood[k].Price )
	lbl:SizeToContents()

	count = count+1
	if count%5 == 0 then
		sautelignetext = sautelignetext +1
		count = 0
	end
end
end)
