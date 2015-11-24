--Air Fortress Ziggurat
function c140000083.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c140000083.indes)
	c:RegisterEffect(e1)
        --Tokens
        local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_REPEAT)
	e2:SetCondition(c140000083.spcon)
	e2:SetTarget(c140000083.sptg)
	e2:SetOperation(c140000083.spop)
	c:RegisterEffect(e2)
end
function c140000083.indes(e,c)
	return c:GetAttack()==e:GetHandler():GetAttack()
end
function c140000083.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c140000083.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c140000083.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,140000085,0,0x4011,0,0,1,RACE_MACHINE,ATTRIBUTE_WIND) then return end
	local token=Duel.CreateToken(tp,140000085)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
        --atk limit
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c140000083.tg)
	e1:SetValue(1)
	token:RegisterEffect(e1)
end
function c140000083.tg(e,c)
	return c:GetCode()~=140000085
end