--Numeron Direct
function c511000276.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_REPEAT)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000276.con)
	e1:SetTarget(c511000276.target)
	e1:SetOperation(c511000276.activate)
	c:RegisterEffect(e1)
end
function c511000276.confilter(c)
	return c:IsFaceup() and c:IsCode(511000275)
end
function c511000276.con(e)
	return Duel.IsExistingMatchingCard(c511000276.confilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(511000275)
end
function c511000276.filter(c,e,tp)
	return c:IsAttackBelow(1000) and c:IsSetCard(0x1FF) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000276.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>3 
		and Duel.IsExistingMatchingCard(c511000276.filter,tp,LOCATION_EXTRA,0,4,nil,e,tp) end
end
function c511000276.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<4 then return end
	if not Duel.IsExistingMatchingCard(c511000276.filter,tp,LOCATION_EXTRA,0,4,nil,e,tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000276.filter,tp,LOCATION_EXTRA,0,4,4,nil,e,tp)
	local fid=e:GetHandler():GetFieldID()
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(511000276,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
	g:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabel(fid)
		e1:SetLabelObject(g)
		e1:SetOperation(c511000276.rmop)
		Duel.RegisterEffect(e1,tp)
end
function c511000276.rmfilter(c,fid)
	return c:GetFlagEffectLabel(511000276)==fid
end
function c511000276.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511000276.rmfilter,nil,e:GetLabel())
	g:DeleteGroup()
	Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
end
