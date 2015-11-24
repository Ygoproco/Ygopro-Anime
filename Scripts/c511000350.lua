--Dragonic Unit Ritual
function c511000350.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000350.cost)
	e1:SetCondition(c511000350.condition)
	e1:SetTarget(c511000350.target)
	e1:SetOperation(c511000350.activate)
	c:RegisterEffect(e1)
end
function c511000350.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c511000350.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsType(TYPE_NORMAL) and c:IsFaceup()
end
function c511000350.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000350.filter,tp,LOCATION_MZONE,0,2,nil)
end
function c511000350.spfilter(c,e,tp)
	return c:IsCode(38109772) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511000350.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000350.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	local g=Duel.SelectTarget(tp,c511000350.filter,tp,LOCATION_MZONE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c511000350.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ov=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000350.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Overlay(ov:GetFirst(),ov:GetNext())
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		local mg=ov:GetFirst():GetOverlayGroup()
		local tc=g:GetFirst()
		Duel.Overlay(tc,mg)
		Duel.Overlay(tc,ov:GetFirst())
		--destroy
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(511000350,0))
		e1:SetCategory(CATEGORY_DESTROY)
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCost(c511000350.descost)
		e1:SetTarget(c511000350.destg)
		e1:SetOperation(c511000350.desop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc:CompleteProcedure()
	end
end
function c511000350.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) and c:GetAttackAnnouncedCount()==0 end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1,true)
end
function c511000350.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511000350.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
