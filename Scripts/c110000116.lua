--Armored Gravitation
function c110000116.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c110000116.condition)
	e1:SetTarget(c110000116.target)
	e1:SetOperation(c110000116.activate)
	c:RegisterEffect(e1)
end
function c110000116.cfilter(c)
	return c:IsFaceup() and c:IsCode(110000104)
end
function c110000116.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c110000116.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c110000116.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x3A2E) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c110000116.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c110000116.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c110000116.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft>4 then ft=4 end
	if not Duel.IsExistingMatchingCard(c110000116.cfilter,tp,LOCATION_MZONE,0,1,nil) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c110000116.filter,tp,LOCATION_DECK,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end