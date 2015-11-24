--Fluffal Crane
--scripted by: UnknownGuest
function c810000099.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DRAW)
	--e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c810000099.target)
	e1:SetOperation(c810000099.activate)
	c:RegisterEffect(e1)
end
function c810000099.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return eg:GetCount()==1 and tc:IsControler(tp) and tc:IsSetCard(0xa9)
		and tc:IsAbleToHand() and Duel.IsPlayerCanDraw(tp,1) end
	tc:CreateEffectRelation(e)
end
function c810000099.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,1,REASON_EFFECT)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
--[[function c810000099.filter(c,e,tp)
	return c:IsCanBeEffectTarget(e) and c:GetPreviousControler()==tp and c:IsSetCard(0xa9)
		and c:IsReason(REASON_BATTLE) and c:IsAbleToHand()
end
function c810000099.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c810000099.filter(chkc,e,tp) end
	if chk==0 then return eg:IsExists(c810000099.filter,1,nil,e,tp) and Duel.IsPlayerCanDraw(tp,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=eg:FilterSelect(tp,c810000099.filter,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c810000099.activate(e,tp,eg,ep,ev,re,r,rp)
	local ex,g=Duel.GetOperationInfo(0,CATEGORY_TOHAND)
	local tc1=g:GetFirst()
	if tc1:IsRelateToEffect(e) and Duel.SendtoHand(tc1,nil,1,REASON_EFFECT)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end]]--
