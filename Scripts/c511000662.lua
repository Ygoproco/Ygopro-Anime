--Born from Draconis
function c511000662.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000662.cost)
	e1:SetTarget(c511000662.target)
	e1:SetOperation(c511000662.activate)
	c:RegisterEffect(e1)
end
function c511000662.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c511000662.cfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToRemove()
end
function c511000662.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,true,false) and c:IsCode(33093439)
end
function c511000662.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return (Duel.IsExistingMatchingCard(c511000662.cfilter,tp,LOCATION_MZONE,0,1,nil)
		or (Duel.IsExistingMatchingCard(c511000662.cfilter,tp,LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0))
		and Duel.IsExistingTarget(c511000662.filter,tp,0x13,0,1,nil,e,tp)
	end
	local g=Duel.GetMatchingGroup(c511000662.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetCount())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000662.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c511000662.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetReset(RESET_EVENT+0xff0000)
		e1:SetValue(e:GetLabel()*700)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENCE)
		tc:RegisterEffect(e2)
		tc:CompleteProcedure()
	end
end
