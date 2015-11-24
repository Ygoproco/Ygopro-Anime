--Legend of Heart
function c170000201.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCost(c170000201.cost)
    e1:SetTarget(c170000201.target)
    e1:SetOperation(c170000201.operation)
	c:RegisterEffect(e1)
end
function c170000201.costfilter(c,code)
	return c:GetCode()==code and c:IsAbleToRemoveAsCost()
end
function c170000201.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckLPCost(tp,1000) and Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_WARRIOR) and 
    Duel.IsExistingMatchingCard(c170000201.costfilter,tp,0x1F,0,1,nil,1784686)
 	and Duel.IsExistingMatchingCard(c170000201.costfilter,tp,0x1F,0,1,nil,46232525)
	and Duel.IsExistingMatchingCard(c170000201.costfilter,tp,0x1F,0,1,nil,11082056) end
    Duel.PayLPCost(tp,1000)
	local rg=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_WARRIOR)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOREMOVE)
	local g1=Duel.SelectMatchingCard(tp,c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,1,nil,1784686)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,1,nil,46232525)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g3=Duel.SelectMatchingCard(tp,c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,1,nil,11082056)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
	Duel.Release(rg,REASON_COST)
end
function c170000201.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c170000201.filter(c)
	return c:IsCode(48179392) or c:IsCode(110000100) or c:IsCode(110000101)
end
function c170000201.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c170000201.spfilter,tp,0x33,0,1,nil,e,tp,80019195)
		and Duel.IsExistingMatchingCard(c170000201.spfilter,tp,0x33,0,1,nil,e,tp,85800949)
		and Duel.IsExistingMatchingCard(c170000201.spfilter,tp,0x33,0,1,nil,e,tp,84565800) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,3,0,0)
end
function c170000201.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c170000201.spfilter,tp,0x33,0,1,1,nil,e,tp,80019195)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c170000201.spfilter,tp,0x33,0,1,1,nil,e,tp,85800949)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g3=Duel.SelectMatchingCard(tp,c170000201.spfilter,tp,0x33,0,1,1,nil,e,tp,84565800)
	g1:Merge(g2)
	g1:Merge(g3)
	if g1:GetCount()>2 then
		Duel.SpecialSummon(g1,0,tp,tp,true,true,POS_FACEUP)
	end
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(c170000201.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
	Duel.SendtoGrave(g,REASON_EFFECT)
end