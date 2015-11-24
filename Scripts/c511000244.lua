--Ultimate Ritual of the Forbidden Lord
function c511000244.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c511000244.condition)
	e1:SetTarget(c511000244.target)
	e1:SetOperation(c511000244.activate)
	c:RegisterEffect(e1)
	--"Forbidden One" card(s) is sent to the Graveyard by another card effect, return the card(s) to the Deck.
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c511000244.forbcon)
	e2:SetTarget(c511000244.forbtg)
	e2:SetOperation(c511000244.forbop)
	c:RegisterEffect(e2)
end
function c511000244.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,8124921)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,44519536)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,70903634)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,7902349)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,33396948)
end
function c511000244.filter(c,e,tp)
	return c:IsCode(511000243) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c511000244.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c511000244.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511000244.dfilter(c)
	return c:IsSetCard(0x40) and c:IsAbleToGraveAsCost()
end
function c511000244.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000244.dfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000244.dfilter,tp,LOCATION_HAND,0,2,2,nil)
	Duel.SendtoGrave(g,REASON_COST)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c511000244.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
function c511000244.fbfilter(c)
	return c:IsSetCard(0x40) and c:IsPreviousLocation(LOCATION_DECK)
end
function c511000244.exodiusfilter(c)
	return c:IsFaceup() and c:IsCode(511000243)
end
function c511000244.forbcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return eg:IsExists(c511000244.fbfilter,1,nil) and not rc:IsCode(511000243) 
	and Duel.IsExistingMatchingCard(c511000244.exodiusfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c511000244.forbtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
end
function c511000244.fb2filter(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsSetCard(0x40) and c:IsPreviousLocation(LOCATION_DECK)
end
function c511000244.forbop(e,tp,eg,ep,ev,re,r,rp)
	local sg=eg:Filter(c511000244.fb2filter,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	end
end