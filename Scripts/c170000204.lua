--Legendary Knight Hermos
function c170000204.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
    --Absorb Monster effects
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCost(c170000204.ccost)
    e2:SetOperation(c170000204.cop)
    c:RegisterEffect(e2)
    --Redirect attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c170000204.cbcon)
	e3:SetOperation(c170000204.cbop)
	c:RegisterEffect(e3)
	--Divert and multiply
    local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e4:SetCondition(c170000204.pbcon)
	e4:SetCost(c170000204.pbcost)
	e4:SetOperation(c170000204.pbop)
	c:RegisterEffect(e4)
end
function c170000204.ccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170000204.sfilter,tp,LOCATION_GRAVE,0,1,nil) end
    local tc=Duel.SelectMatchingCard(tp,c170000204.sfilter,tp,LOCATION_GRAVE,0,1,1,nil)
    e:SetLabelObject(tc:GetFirst())
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
end
function c170000204.sfilter(c,e,tp,eg,ep,ev,re,r,rp)
	return c:IsType(TYPE_EFFECT) and not c:IsHasEffect(EFFECT_FORBIDDEN) and c:IsAbleToRemoveAsCost()
end
function c170000204.cop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local code=tc:GetOriginalCode()
		local reset_flag=RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END
		c:CopyEffect(code, reset_flag, 1)
	end
end	
function c170000204.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return c~=bt and bt:GetControler()==c:GetControler()
end
function c170000204.cbop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(e:GetHandler())
end
function c170000204.pbcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() and Duel.GetAttacker()~=nil and Duel.IsExistingMatchingCard(c170000204.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c170000204.cfilter(c)
return c:IsType(TYPE_MONSTER)
end
function c170000204.pbcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170000204.cfilter,tp,LOCATION_DECK,0,1,nil) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c170000204.cfilter,tp,LOCATION_DECK,0,1,9999,nil)
	e:SetLabel(g:GetCount())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c170000204.pbop(e,tp,eg,ep,ev,re,r,rp)
 	local c=e:GetHandler()
	if c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(Duel.GetAttacker():GetAttack()*e:GetLabel())
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end