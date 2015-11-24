--Extra Fusion
function c511000814.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,511000814)
	e1:SetTarget(c511000814.target)
	e1:SetOperation(c511000814.activate)
	c:RegisterEffect(e1)
end
function c511000814.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c511000814.filter2(c,e,tp,m)
	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,PLAYER_NONE,false,false)
		and c:CheckFusionMaterial(m)
end
function c511000814.cfilter(c)
	return (c:IsCode(24094653) or c:IsSetCard(0x46)) and not c:IsPublic() and c:GetCode()~=511000814
end
function c511000814.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetMatchingGroup(c511000814.filter1,tp,0x4F,0,nil,e)
		local rv=Duel.GetMatchingGroup(c511000814.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
		return Duel.IsExistingMatchingCard(c511000814.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg) and rv:GetCount()>0
	end
end
function c511000814.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local mg=Duel.GetMatchingGroup(c511000814.filter1,tp,0x4F,0,nil,e)
	local sg=Duel.GetMatchingGroup(c511000814.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg)
	if sg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.ConfirmCards(1-tp,tc)
		local mat=Duel.SelectFusionMaterial(tp,tc,mg)
		Duel.ConfirmCards(1-tp,mat)
		local rv=Duel.GetMatchingGroup(c511000814.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local rvc=rv:Select(tp,1,1,nil)
		Duel.ConfirmCards(1-tp,rvc)
		tc:SetMaterial(mat)
		Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		tc:SetTurnCounter(0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END+RESET_SELF_TURN,tc:GetMaterialCount())
		e1:SetOperation(c511000814.retop)
		tc:RegisterEffect(e1)
		tc:CompleteProcedure()
	end
end
function c511000814.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetTurnPlayer()~=tp then return end
	local time=c:GetMaterialCount()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==time then
		if c:IsLocation(LOCATION_MZONE) then
			Duel.SendtoDeck(c,nil,0,REASON_EFFECT)
		end
	end
end
