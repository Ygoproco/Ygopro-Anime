--Z-ONE (Anime)
function c511000279.initial_effect(c)
	--copy effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000279.condition)
	e1:SetTarget(c511000279.target)
	e1:SetOperation(c511000279.operation)
	c:RegisterEffect(e1)
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000279,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c511000279.accon)
	e2:SetOperation(c511000279.acop)
	c:RegisterEffect(e2)
end
function c511000279.accon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
		and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
		and e:GetHandler():IsPreviousPosition(POS_FACEDOWN)
end
function c511000279.acop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.RaiseEvent(c,EVENT_CHAIN_SOLVED,c:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
		local te,eg,ep,ev,re,r,rp=c:CheckActivateEffect(true,true,true)
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		local op=te:GetOperation()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end
	end
end
function c511000279.condition(e,tp,eg,ep,ev,re,r,rp)
	return false
end
function c511000279.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:CheckActivateEffect(false,true,false)~=nil
end
function c511000279.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		local te=e:GetLabelObject()
		local tg=te:GetTarget()
		return tg and tg(e,tp,eg,ep,ev,re,r,rp,1,true)
	end
	if chk==0 then return Duel.IsExistingTarget(c511000279.filter,tp,0x13,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,0x13)
end
function c511000279.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511000279.filter,tp,0x13,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		if g:GetFirst():IsType(TYPE_FIELD+TYPE_CONTINUOUS) or g:GetFirst():IsCode(72302403) or g:GetFirst():IsCode(84808313) or g:GetFirst():IsCode(511000217) then
			local code=g:GetFirst():GetOriginalCode()
			local te,eg,ep,ev,re,r,rp=g:GetFirst():CheckActivateEffect(false,true,true)
			e:SetLabelObject(te)
			Duel.ClearTargetCard()
			local tg=te:GetTarget()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
			local op=te:GetOperation()
			if op then op(e,tp,eg,ep,ev,re,r,rp) end
			c:CancelToGrave()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetCode(EFFECT_CHANGE_CODE)
			e1:SetValue(code)
			c:RegisterEffect(e1)
			c:CopyEffect(code,RESET_EVENT+0x1fe0000)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e2:SetRange(LOCATION_SZONE)
			e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e2)
			if g:GetFirst():IsType(TYPE_FIELD) then
				local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
				local e3=Effect.CreateEffect(c)
				e3:SetCode(EFFECT_ADD_TYPE)
				e3:SetType(EFFECT_TYPE_SINGLE)
				e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
				e3:SetRange(LOCATION_SZONE)
				e3:SetValue(TYPE_SPELL+TYPE_FIELD)
				e3:SetReset(RESET_EVENT+0x1fe0000)
				c:RegisterEffect(e3)
				Duel.MoveSequence(c,5)
			end
		else
			local te,eg,ep,ev,re,r,rp=g:GetFirst():CheckActivateEffect(false,true,true)
			e:SetLabelObject(te)
			Duel.ClearTargetCard()
			local tg=te:GetTarget()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
			local op=te:GetOperation()
			if op then op(e,tp,eg,ep,ev,re,r,rp) end
		end
	end
end
