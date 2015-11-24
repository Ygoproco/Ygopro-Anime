--Zero Blade
function c511000190.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000190.target)
	e1:SetOperation(c511000190.activate)
	c:RegisterEffect(e1)
end
function c511000190.filter(c)
	return c:IsFaceup()
end
function c511000190.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000190.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000190.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000190.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511000190.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e1)
		if Duel.IsExistingTarget(c511000190.filter,tp,0,LOCATION_MZONE,1,nil) then
			local g=Duel.SelectTarget(tp,c511000190.filter,tp,0,LOCATION_MZONE,1,1,nil)
			local tg=g:GetFirst()
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(-1000)
			tg:RegisterEffect(e2)
		end
	end
end
