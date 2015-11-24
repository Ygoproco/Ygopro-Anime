--Nightmare Xyz
function c511000700.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511000700.activate)
	c:RegisterEffect(e1)
	if not c511000700.global_check then
		c511000700.global_check=true
		c511000700[0]=false
		--check
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c511000700.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c511000700.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511000700.cfilter(c,tp)
	return c:IsSetCard(0x48) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP) and c:IsControler(tp) 
		and bit.band(c:GetReason(),REASON_DESTROY)==REASON_DESTROY
end
function c511000700.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c511000700.cfilter,1,nil,tp) then
		c511000700[0]=true
	end
end
function c511000700.clear(e,tp,eg,ep,ev,re,r,rp)
	c511000700[0]=false
end
function c511000700.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511000700.con)
	e1:SetTarget(c511000700.tg)
	e1:SetOperation(c511000700.op)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511000700.con(e,tp,eg,ep,ev,re,r,rp)
	return c511000700[0]
end
function c511000700.filter(c,e,tp)
	local ct=c.xyz_count
	return c:GetRank()<=4 and c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_FIEND) and c:IsType(TYPE_XYZ) 
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>ct-1 
		and Duel.IsExistingMatchingCard(c511000700.filter2,tp,LOCATION_GRAVE,0,ct,nil,e,tp)
end
function c511000700.filter2(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:GetLevel()>0 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000700.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_EXTRA) and c511000700.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511000700.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000700.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000700.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local ct=tc.xyz_count
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=ct-1 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511000700.filter2,tp,LOCATION_GRAVE,0,ct,ct,nil,e,tp)
		if g:GetCount()>0 then
			local tcx=g:GetFirst()
			while tcx do
				Duel.SpecialSummonStep(tcx,0,tp,tp,false,false,POS_FACEUP)
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CHANGE_LEVEL)
				e1:SetValue(tc:GetRank())
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tcx:RegisterEffect(e1)
				tcx=g:GetNext()
			end
			Duel.SpecialSummonComplete()
		end
		Duel.BreakEffect()
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_SPSUMMON_PROC)
		e2:SetRange(LOCATION_EXTRA)
		e2:SetOperation(c511000700.xyzop)
		e2:SetReset(RESET_CHAIN)
		e2:SetValue(SUMMON_TYPE_XYZ)
		e2:SetLabelObject(g)
		tc:RegisterEffect(e2)
		Duel.XyzSummon(tp,tc,nil)
	end
end
function c511000700.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	local mat=e:GetLabelObject()
	c:SetMaterial(mat)
	Duel.Overlay(c,mat)
end
