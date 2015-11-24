--クイック・エクシーズ
function c511001200.initial_effect(c)
	--synchro effect
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetTarget(c511001200.tg)
	e1:SetOperation(c511001200.op)
	c:RegisterEffect(e1)
end
function c511001200.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,true,false)
end
function c511001200.filter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOwner()==tp
end
function c511001200.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001200.filter(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511001200.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) 
		and Duel.IsExistingMatchingCard(c511001200.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511001200.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511001200.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001200.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sp=g:GetFirst()
	if sp then
		Duel.SpecialSummon(sp,SUMMON_TYPE_XYZ,tp,tp,true,false,POS_FACEUP)
		local atk=tc:GetTextAttack()
		Duel.Equip(tp,tc,sp,true)
		tc:RegisterFlagEffect(511001200,RESET_EVENT+0x1fe0000,0,0)
		local e1=Effect.CreateEffect(sp)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511001200.eqlimit)
		tc:RegisterEffect(e1)
		if atk>0 then
			local e2=Effect.CreateEffect(sp)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(atk)
			tc:RegisterEffect(e2)
		end
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_EQUIP)
		e3:SetCode(EFFECT_DESTROY_REPLACE)
		e3:SetTarget(c511001200.reptg)
		e3:SetOperation(c511001200.repop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
	end
end
function c511001200.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511001200.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget()
	if chk==0 then return not c:IsStatus(STATUS_DESTROY_CONFIRMED) end
	if Duel.SelectYesNo(tp,aux.Stringid(95395761,1)) then return true
	else return false end
end
function c511001200.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end
