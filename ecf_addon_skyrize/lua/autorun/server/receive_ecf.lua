util.AddNetworkString("ECF_NPCPNL")

util.AddNetworkString("itembuyecf")
net.Receive( "itembuyecf" , function ( len , ply )
	local id =  net.ReadString()
	local count = net.ReadString()
	print(id, count)
	for k,v in pairs (IngrediantFood) do
		if  tostring(k) == id then
			for i=1, tonumber(count) do
				local item =  ents.Create( "ecf_item" )
				item:SetModel( v.Model)
				item:SetPos( ply:GetPos()+ Vector(0,0,8))
				item:Spawn()
				item:SetNWString("name", v.Name)
				ply:addMoney(-v.Price)
			end
		end
	end
end)

