--Crystal Flash
function c170000126.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c170000126.target)
	e1:SetOperation(c170000126.activate)
	c:RegisterEffect(e1)
end
function c170000126.filter1(c)
	return c:IsSetCard(0x34) and c:IsType(TYPE_MONSTER)
end
function c170000126.filter2(c)
	return c:IsSetCard(0x34)
end
function c170000126.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c170000126.filter1,tp,LOCATION_MZONE,0,1,nil)
	and Duel.IsExistingTarget(c170000126.filter2,tp,LOCATION_HAND,0,1,e:GetHandler()) 
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	local g1=Duel.SelectTarget(tp,c170000126.filter1,tp,LOCATION_MZONE,0,1,1,nil)
end
function c170000126.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFirstTarget()
	local g2=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_HAND,0,1,1,nil,0x34)
	if g1:IsRelateToEffect(e) then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	g1:RegisterEffect(e1,true)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetValue(1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	g1:RegisterEffect(e2,true)
	Duel.MoveToField(g2:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetCode(EFFECT_CHANGE_TYPE)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetReset(RESET_EVENT+0x1fc0000)
		e3:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		g2:GetFirst():RegisterEffect(e3,true)
		Duel.RaiseEvent(g2:GetFirst(),47408488,e,0,tp,0,0)
		end
	end