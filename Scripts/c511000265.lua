--Gorlag
function c511000265.initial_effect(c)
	--Gain ATK for Each Fire Monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c511000265.val)
	c:RegisterEffect(e1)
	--Special Summon the monster Destroyed
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000265,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCondition(c511000265.spcon)
	e2:SetTarget(c511000265.sptg)
	e2:SetOperation(c511000265.spop)
	c:RegisterEffect(e2)
	--Cannot Attack Directly
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e3)
	--When Leave the Field, Destroy all Monsters Special Summoned
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetOperation(c511000265.desop)
	c:RegisterEffect(e4)
	end
function c511000265.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_FIRE)
end
function c511000265.val(e,c)
	return Duel.GetMatchingGroupCount(c511000265.filter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*500
end
function c511000265.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if c==tc then tc=Duel.GetAttackTarget() end
	e:SetLabelObject(tc)
	if not c:IsRelateToBattle() or c:IsFacedown() then return false end
	return tc:IsLocation(LOCATION_GRAVE) and tc:IsType(TYPE_MONSTER)
end
function c511000265.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,LOCATION_GRAVE)
end
function c511000265.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(ATTRIBUTE_FIRE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3,true)
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_CANNOT_ATTACK)
		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e4,true)
	end
end
function c511000265.desfilter(c,tp)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_GRAVE,1,nil) and c:IsStatus(STATUS_DISABLED)
end
function c511000265.desop(e)
	local dg=Duel.GetMatchingGroup(c511000265.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		Duel.Destroy(dg,REASON_EFFECT)
end