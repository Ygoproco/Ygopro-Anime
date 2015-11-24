--Xyz Crown
function c511001225.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001225.target)
	e1:SetOperation(c511001225.operation)
	c:RegisterEffect(e1)
	--double xyz material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(511001225)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c511001225.eqlimit)
	c:RegisterEffect(e3)
	--xyz summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetRange(LOCATION_SZONE)	
	e4:SetOperation(c511001225.op)
	c:RegisterEffect(e4)
	--change lv
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_XYZ_LEVEL)
	e5:SetValue(c511001225.lv)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_SYNCHRO_LEVEL)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EFFECT_RITUAL_LEVEL)
	c:RegisterEffect(e7)
	local e8=e5:Clone()
	e8:SetCode(EFFECT_CHANGE_LEVEL)
	c:RegisterEffect(e8)
end
function c511001225.lv(e,c,rc)
	return c:GetRank()
end
function c511001225.eqlimit(e,c)
	return c:IsType(TYPE_XYZ)
end
function c511001225.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001225.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001225.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001225.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511001225.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511001225.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511001225.filterx(c)
	return c:IsType(TYPE_XYZ) and c.xyz_count and c.xyz_count>0
end
function c511001225.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511001225.filterx,c:GetControler(),LOCATION_EXTRA,LOCATION_EXTRA,nil)
	local tc=g:GetFirst()
	while tc do
		local tck=Duel.CreateToken(tp,419)
		if tc:GetFlagEffect(419)==0 then
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetDescription(aux.Stringid(71921856,0))
			e1:SetCode(EFFECT_SPSUMMON_PROC)
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
			e1:SetRange(LOCATION_EXTRA)
			e1:SetValue(SUMMON_TYPE_XYZ)
			e1:SetCondition(c511001225.xyzcon)
			e1:SetOperation(c511001225.xyzop)
			e1:SetLabelObject(tck)
			e1:SetReset(RESET_EVENT+EVENT_ADJUST,1)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(419,RESET_EVENT+EVENT_ADJUST,0,1) 	
		end
		tc=g:GetNext()
	end
end
function c511001225.mfilter(c,rk,xyz)
	return c:IsFaceup() and xyz.xyz_filter(c) and c:IsCanBeXyzMaterial(xyz) and c:IsXyzLevel(xyz,rk)
end
function c511001225.amfilter(c)
	return c:GetEquipGroup():IsExists(Card.IsHasEffect,1,nil,511001175)
end
function c511001225.subfilter(c,rk,xyz,tck)
	return c:IsFaceup() and c.xyzsub and c.xyzsub==rk and not c:IsStatus(STATUS_DISABLED) 
		and xyz.xyz_filter(tck)
end
function c511001225.xyzcon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	local rk=c:GetRank()
	local ct=c.xyz_count
	local mg=Duel.GetMatchingGroup(c511001225.mfilter,tp,LOCATION_MZONE,0,nil,rk,c)
	local tck=e:GetLabelObject()
	local mg2=Duel.GetMatchingGroup(c511001225.subfilter,tp,LOCATION_ONFIELD,0,nil,rk,c,tck)
	mg:Merge(mg2)
	if not mg:IsExists(c511001225.amfilter,1,nil) and not mg:IsExists(Card.IsHasEffect,1,nil,511001225) 
		and not mg:IsExists(c511001225.subfilter,1,nil,rk,c,tck) then return false end
	local g=mg:Filter(c511001225.amfilter,nil)
	local eqg=Group.CreateGroup()
	local tce=g:GetFirst()
	while tce do
		local eq=tce:GetEquipGroup()
		eq=eq:Filter(Card.IsHasEffect,nil,511001175)
		g:Merge(eq)
		tce=g:GetNext()
	end
	local dob=mg:Filter(Card.IsHasEffect,nil,511001225)
	local dobc=dob:GetFirst()
	while dobc do
		ct=ct-1
		dobc=dob:GetNext()
	end
	mg:Merge(g)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and mg:GetCount()>=ct
end
function c511001225.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	local c=e:GetHandler()
	local rk=c:GetRank()
	local ct=c.xyz_count
	local mg=Duel.GetMatchingGroup(c511001225.mfilter,tp,LOCATION_MZONE,0,nil,rk,c)
	local tck=e:GetLabelObject()
	local mg2=Duel.GetMatchingGroup(c511001225.subfilter,tp,LOCATION_ONFIELD,0,nil,rk,c,tck)
	mg:Merge(mg2)
	local g1=Group.CreateGroup()
	g1:KeepAlive()
	local eqg=Group.CreateGroup()
	eqg:KeepAlive()
	while ct>0 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g2=mg:Select(tp,1,1,nil)
		if g2:GetFirst() and c511001225.amfilter(g2:GetFirst()) then
			eq=g2:GetFirst():GetEquipGroup()
			eq=eq:Filter(Card.IsHasEffect,nil,511001175)
			mg:Merge(eq)
		elseif g2:GetFirst() and g2:GetFirst():GetEquipTarget()~=nil then
			eqg:Merge(g2)
		end
		if g2:GetFirst() and g2:GetFirst():IsHasEffect(511001225) and ct>0 and (mg:GetCount()<=1 or Duel.SelectYesNo(tp,aux.Stringid(61965407,0))) then
			ct=ct-1
		end
		mg:Sub(g2)
		g1:Merge(g2)
		ct=ct-1
	end
	local sg=Group.CreateGroup()
	local tc=g1:GetFirst()
	while tc do
		local sg1=tc:GetOverlayGroup()
		sg:Merge(sg1)
		tc=g1:GetNext()
	end
	sg:Merge(eqg)
	Duel.SendtoGrave(sg,REASON_RULE)
	c:SetMaterial(g1)
	Duel.Overlay(c,g1)
end
