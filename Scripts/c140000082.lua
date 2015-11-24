--Sky Union
function c140000082.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c140000082.cost)
	e1:SetTarget(c140000082.target)
	e1:SetOperation(c140000082.activate)
	c:RegisterEffect(e1)
end
function c140000082.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,75559356)
            and Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,67532912)
            and Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,79853073) end
	local g1=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,75559356)
        local g2=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,67532912)
        local g3=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,79853073)
        g1:Merge(g2)
        g1:Merge(g3)
	Duel.Release(g1,REASON_COST)
end
function c140000082.filter(c,e,tp)
	return c:IsCode(140000083) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c140000082.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c140000082.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c140000082.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c140000082.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)>0 then
                local e1=Effect.CreateEffect(e:GetHandler())
                e1:SetType(EFFECT_TYPE_SINGLE)
                e1:SetCode(EFFECT_IMMUNE_EFFECT)
                e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
                e1:SetRange(LOCATION_MZONE)
                e1:SetValue(c140000082.efilter)
                g:GetFirst():RegisterEffect(e1)
		Duel.SpecialSummonComplete()
	end
end
function c140000082.efilter(e,te)
	return (te:IsActiveType(TYPE_SPELL) or te:IsActiveType(TYPE_TRAP)) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end