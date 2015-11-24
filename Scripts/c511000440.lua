--Guardian Formation
function c511000440.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511000440.condition)
	e1:SetTarget(c511000440.target)
	e1:SetOperation(c511000440.activate)
	c:RegisterEffect(e1)
end
function c511000440.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	local seq=d:GetSequence()
	return d:IsControler(tp) and d:IsFaceup() and d:IsSetCard(0x52) and (seq>0 and Duel.CheckLocation(tp,LOCATION_MZONE,seq-1))
		or (seq<4 and Duel.CheckLocation(tp,LOCATION_MZONE,seq+1))
end
function c511000440.filter(c)
	return c:IsType(TYPE_SPELL) and c:CheckActivateEffect(false,false,false)~=nil
end
function c511000440.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ta=Duel.GetAttacker()
	local td=Duel.GetAttackTarget()
	if chkc then return chkc==ta end
	if chk==0 then return ta:IsOnField() and ta:IsCanBeEffectTarget(e)
		and td:IsOnField() and td:IsCanBeEffectTarget(e) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c511000440.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil) end
	local eg=Group.FromCards(ta,td)
	Duel.SetTargetCard(eg)
end
function c511000440.activate(e,tp,eg,ep,ev,re,r,rp)
	local ta=Duel.GetAttacker()
	local td=Duel.GetAttackTarget()
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=0
	if s==1 then nseq=0
	elseif s==2 then nseq=1
	elseif s==4 then nseq=2
	elseif s==8 then nseq=3
	else nseq=4 end
	Duel.MoveSequence(td,nseq)
	if ta:IsRelateToEffect(e) and ta:IsFaceup() and ta:IsAttackable() and Duel.NegateAttack() and td:IsFaceup() and td:IsRelateToEffect(e) then
		local tc=Duel.SelectMatchingCard(tp,c511000440.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil):GetFirst()
		local tpe=tc:GetType()
		local te=tc:GetActivateEffect()
		local tg=te:GetTarget()
		local co=te:GetCost()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		if bit.band(tpe,TYPE_FIELD)~=0 then
			local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
			if of then Duel.Destroy(of,REASON_RULE) end
			of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.Hint(HINT_CARD,0,tc:GetCode())
		tc:CreateEffectRelation(te)
		if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
			tc:CancelToGrave(false)
		end
		if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
		if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		if g then
			local etc=g:GetFirst()
			while etc do
				etc:CreateEffectRelation(te)
				etc=g:GetNext()
			end
		end
		if op then op(te,tp,eg,ep,ev,re,r,rp) end
		tc:ReleaseEffectRelation(te)
		if etc then	
			etc=g:GetFirst()
			while etc do
				etc:ReleaseEffectRelation(te)
				etc=g:GetNext()
			end
		end
	end
end
