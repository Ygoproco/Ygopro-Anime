--Tachyon Drive
function c511001486.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001486.target)
	e1:SetOperation(c511001486.activate)
	c:RegisterEffect(e1)
end
function c511001486.filter(c)
	return c:IsFaceup() and (c:IsCode(88177324) or c:IsCode(68396121))
end
function c511001486.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001486.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001486.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001486.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001486.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(tp) then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e2:SetValue(c511001486.evalue)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
function c511001486.evalue(e,re,rp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and aux.tgval(e,re,rp)
end
