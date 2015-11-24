--Solid Overlay
function c511000189.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--xyz summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetRange(LOCATION_SZONE)	
	e3:SetOperation(c511000189.op)
	c:RegisterEffect(e3)
end
c511000189.xyzsub=4
function c511000189.filterx(c)
	return c:IsType(TYPE_XYZ) and c.xyz_count and c.xyz_count>0
end
function c511000189.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511000189.filterx,c:GetControler(),LOCATION_EXTRA,LOCATION_EXTRA,nil)
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
			e1:SetCondition(c511000189.xyzcon)
			e1:SetOperation(c511000189.xyzop)
			e1:SetLabelObject(tck)
			e1:SetReset(RESET_EVENT+EVENT_ADJUST,1)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(419,RESET_EVENT+EVENT_ADJUST,0,1) 	
		end
		tc=g:GetNext()
	end
end
function c511000189.mfilter(c,rk,xyz)
	return c:IsFaceup() and xyz.xyz_filter(c) and c:IsCanBeXyzMaterial(xyz) and c:IsXyzLevel(xyz,rk)
end
function c511000189.amfilter(c)
	return c:GetEquipGroup():IsExists(Card.IsHasEffect,1,nil,511001175)
end
function c511000189.subfilter(c,rk,xyz,tck)
	return c:IsFaceup() and c.xyzsub and c.xyzsub==rk and not c:IsStatus(STATUS_DISABLED) 
		and xyz.xyz_filter(tck)
end
function c511000189.xyzcon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	local rk=c:GetRank()
	local ct=c.xyz_count
	local mg=Duel.GetMatchingGroup(c511000189.mfilter,tp,LOCATION_MZONE,0,nil,rk,c)
	local tck=e:GetLabelObject()
	local mg2=Duel.GetMatchingGroup(c511000189.subfilter,tp,LOCATION_ONFIELD,0,nil,rk,c,tck)
	mg:Merge(mg2)
	if not mg:IsExists(c511000189.amfilter,1,nil) and not mg:IsExists(Card.IsHasEffect,1,nil,511001225)
		and not mg:IsExists(c511000189.subfilter,1,nil,rk,c,tck) then return false end
	local g=mg:Filter(c511000189.amfilter,nil)
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
function c511000189.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	local c=e:GetHandler()
	local rk=c:GetRank()
	local ct=c.xyz_count
	local mg=Duel.GetMatchingGroup(c511000189.mfilter,tp,LOCATION_MZONE,0,nil,rk,c)
	local tck=e:GetLabelObject()
	local mg2=Duel.GetMatchingGroup(c511000189.subfilter,tp,LOCATION_ONFIELD,0,nil,rk,c,tck)
	mg:Merge(mg2)
	local g1=Group.CreateGroup()
	g1:KeepAlive()
	local eqg=Group.CreateGroup()
	eqg:KeepAlive()
	while ct>0 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g2=mg:Select(tp,1,1,nil)
		if g2:GetFirst() and c511000189.amfilter(g2:GetFirst()) then
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
