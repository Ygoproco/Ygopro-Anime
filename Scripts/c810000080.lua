--Persona Shutter Layer 1
--scripted by: UnknownGuest
function c810000080.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c810000080.target)
	e1:SetOperation(c810000080.operation)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c810000080.descon)
	e2:SetOperation(c810000080.desop)
	c:RegisterEffect(e2)
end
function c810000080.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c810000080.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:GetControler()==1-tp end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingTarget(c810000080.filter,tp,0,LOCATION_MZONE,1,nil,e,0,tp,false,false) end
	local g=Duel.SelectTarget(tp,c810000080.filter,tp,0,LOCATION_MZONE,1,1,nil,e,0,tp,false,false)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c810000080.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	c:AddTrapMonsterAttribute(TYPE_NORMAL,tc:GetAttribute(),tc:GetRace(),tc:GetLevel(),tc:GetBaseAttack(),tc:GetBaseDefence())
	Duel.SpecialSummonStep(c,0,tp,tp,true,false,POS_FACEUP)
	c:TrapMonsterBlock()
	Duel.SpecialSummonComplete()
	local code=tc:GetOriginalCode()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetValue(code)
	c:RegisterEffect(e1)
	c:SetCardTarget(tc)
end
function c810000080.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c810000080.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
