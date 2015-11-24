--Gold Sarcophagus (Anime)
function c511000208.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000208.target)
	e1:SetOperation(c511000208.activate)
	c:RegisterEffect(e1)
end
function c511000208.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c511000208.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	local code=tc:GetCode()
	if not tc then return end
	Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_SZONE)
	e1:SetLabelObject(tc)
	e1:SetLabel(code)
	e1:SetCondition(c511000208.negcon)
	e1:SetTarget(c511000208.negtg)
	e1:SetOperation(c511000208.negop)
	c:RegisterEffect(e1)
end
function c511000208.negcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(e:GetLabel()) and Duel.IsChainDisablable(ev)
end
function c511000208.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511000208.negop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local code=e:SetLabelObject(tc)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		if Duel.Destroy(eg,REASON_EFFECT)>0 then
			if Duel.SelectYesNo(tp,aux.Stringid(511000208,REASON_EFFECT)) then
				if Duel.Destroy(e:GetHandler(),REASON_RULE)>0 then
					Duel.SendtoHand(tc,nil,REASON_EFFECT)
					Duel.ConfirmCards(1-tp,tc)
				end
			end
		end
	end
end
