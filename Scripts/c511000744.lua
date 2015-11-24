--Harmonic Geoglyph
function c511000744.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000744.target)
	e1:SetOperation(c511000744.activate)
	c:RegisterEffect(e1)
end
function c511000744.filter(c,e,tp)
	local matnum=(c:GetLevel()/2)-1
	return c:IsType(TYPE_SYNCHRO) and (c:GetLevel()==4 or c:GetLevel()==6 or c:GetLevel()==8 or c:GetLevel()==10 or c:GetLevel()==12 or c:GetLevel()==14)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,false) and Duel.IsExistingMatchingCard(c511000744.tunfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c511000744.nontunfilter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,matnum,nil)
end
function c511000744.tunfilter(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:IsType(TYPE_TUNER)
end
function c511000744.nontunfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:GetLevel()>=6 and not c:IsType(TYPE_TUNER)
end
function c511000744.senfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:GetLevel()>=6 and not c:IsType(TYPE_TUNER)
end
function c511000744.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511000744.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000744.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000744.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		local tune=Duel.SelectMatchingCard(tp,c511000744.tunfilter,tp,LOCATION_MZONE,0,1,1,nil)
		local matnum=(tc:GetLevel()/2)-1
		local nontun=Duel.SelectMatchingCard(tp,c511000744.nontunfilter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,matnum,matnum,nil)
		tune:Merge(nontun)
		local tr=tune:GetFirst()
		while tr do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(2)
			e1:SetReset(RESET_CHAIN)
			tr:RegisterEffect(e1)
			tr=tune:GetNext()
		end
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetOperation(c511000744.synop)
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		e1:SetLabelObject(tune)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
		Duel.SynchroSummon(tp,tc,nil)
	end
end
function c511000744.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner)
	local tun=e:GetLabelObject()
	c:SetMaterial(tun)
	Duel.SendtoGrave(tun,REASON_MATERIAL+REASON_SYNCHRO)
end
