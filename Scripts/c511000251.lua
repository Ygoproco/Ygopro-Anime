--Polar Star Angel Valkyria
function c511000251.initial_effect(c)
	--Summon Token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000251,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c511000251.cost)
	e1:SetTarget(c511000251.target)
	e1:SetOperation(c511000251.operation)
	c:RegisterEffect(e1)
end
function c511000251.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000251.cfilter,tp,LOCATION_HAND,0,2,2,nil)
	Duel.SendtoGrave(g,POS_FACEUP,REASON_COST)
end
function c511000251.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,40844553,0,0x4011,1000,1000,4,RACE_WARRIOR,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511000251.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,40844553,0,0x4011,1000,1000,4,RACE_WARRIOR,ATTRIBUTE_EARTH) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,40844553)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
	end
	Duel.SpecialSummonComplete()
end