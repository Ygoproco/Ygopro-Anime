-- Multiply (Anime)
-- scripted by: UnknownGuest
function c810000034.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	-- special summon tokens
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000034,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c810000034.target)
	e1:SetOperation(c810000034.activate)
	c:RegisterEffect(e1)
end
function c810000034.filter(c,e,tp)
	return c:IsFaceup() and c:IsAttackBelow(500)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),0,c:GetType(),c:GetAttack(),c:GetDefence(),c:GetLevel(),c:GetRace(),c:GetAttribute())
end
function c810000034.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c810000034.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c810000034.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c810000034.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ft,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ft,0,0)
end
function c810000034.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0,0x4011,tc:GetAttack(),tc:GetDefence(),tc:GetLevel(),tc:GetRace(),tc:GetAttribute()) then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	for i=1,ft do
		local token=Duel.CreateToken(tp,tc:GetCode())
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,tc:GetPosition())
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENCE)
		e2:SetValue(tc:GetDefence())
		token:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(tc:GetLevel())
		token:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CHANGE_RACE)
		e4:SetValue(tc:GetRace())
		token:RegisterEffect(e4)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e5:SetValue(tc:GetAttribute())
		token:RegisterEffect(e5)
		local e6=Effect.CreateEffect(e:GetHandler())
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e6:SetReset(RESET_EVENT+0x1fe0000)
		e6:SetCode(EFFECT_CHANGE_CODE)
		e6:SetValue(tc:GetOriginalCode())
		token:RegisterEffect(e6)
	end
	Duel.SpecialSummonComplete()
end
