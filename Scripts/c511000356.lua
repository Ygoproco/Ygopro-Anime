--Duality
function c511000356.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000356.target)
	e1:SetOperation(c511000356.operation)
	c:RegisterEffect(e1)
end
function c511000356.filter1(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000356.filter2(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000356.filter3(c,e,tp)
	return c:IsCode(47297616) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000356.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local trlight=Duel.CheckReleaseGroup(tp,Card.IsAttribute,1,nil,ATTRIBUTE_LIGHT)
	local trdark=Duel.CheckReleaseGroup(tp,Card.IsAttribute,1,nil,ATTRIBUTE_DARK)
	local splight=Duel.IsExistingMatchingCard(c511000356.filter1,tp,LOCATION_HAND,0,1,nil,e,tp)
	local spdark=Duel.IsExistingMatchingCard(c511000356.filter2,tp,LOCATION_HAND,0,1,nil,e,tp)
	local ldd=Duel.IsExistingMatchingCard(c511000356.filter3,tp,LOCATION_HAND,0,1,nil,e,tp)
	if chk==0 then return (trlight and spdark) or (trdark and splight) end
	local op=0
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000356,0))
	if (trlight and spdark) and (trdark and splight) and ldd then
		op=Duel.SelectOption(tp,aux.Stringid(511000356,1),aux.Stringid(511000356,2),aux.Stringid(511000356,3))
	elseif (trlight and spdark) and (trdark and splight) then
		op=Duel.SelectOption(tp,aux.Stringid(511000356,1),aux.Stringid(511000356,2))
	elseif trlight and (trdark and splight) and ldd then
		op=Duel.SelectOption(tp,aux.Stringid(511000356,2),aux.Stringid(511000356,3))
		op=op+1
	elseif (trlight and spdark) and trdark and ldd then
		op=Duel.SelectOption(tp,aux.Stringid(511000356,1),aux.Stringid(511000356,3))
		if op==1 then
			op=op+1
		end
	elseif trlight and trdark and ldd then
		Duel.SelectOption(tp,aux.Stringid(511000356,3))
		op=2
	elseif 	trlight and spdark then
		Duel.SelectOption(tp,aux.Stringid(511000356,1))
		op=0
	else
		Duel.SelectOption(tp,aux.Stringid(511000356,2))
		op=1
	end
	if op==0 then
		local g=Duel.SelectReleaseGroup(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_LIGHT)
		Duel.Release(g,REASON_COST)
	elseif op==1 then
		local g=Duel.SelectReleaseGroup(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_DARK)
		Duel.Release(g,REASON_COST)
	else
		local g1=Duel.SelectReleaseGroup(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_LIGHT)
		local g2=Duel.SelectReleaseGroup(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_DARK)
		g1:Merge(g2)
		Duel.Release(g1,REASON_COST)
	end
	e:SetLabel(op)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000356.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	if e:GetLabel()==0 then
		local g=Duel.SelectMatchingCard(tp,c511000356.filter2,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	elseif e:GetLabel()==1 then
		local g=Duel.SelectMatchingCard(tp,c511000356.filter1,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		local g=Duel.SelectMatchingCard(tp,c511000356.filter3,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
		end
	end
end
