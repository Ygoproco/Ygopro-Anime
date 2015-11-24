--Blizzard Vision
function c511000534.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000534.target)
	e1:SetOperation(c511000534.activate)
	c:RegisterEffect(e1)
end
function c511000534.filter(c,tp)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and c:IsLevelAbove(1)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),0,0x11,0,0,c:GetLevel(),c:GetRace(),c:GetAttribute())
end
function c511000534.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000534.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000534.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511000534.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:SetLabelObject(g:GetFirst())
end
function c511000534.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0,0x11,0,0,tc:GetLevel(),tc:GetRace(),tc:GetAttribute()) then return end
	c:AddTrapMonsterAttribute(TYPE_EFFECT,tc:GetAttribute(),tc:GetRace(),tc:GetLevel(),0,0)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	c:TrapMonsterBlock()
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(142,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetTarget(c511000534.destg)
	e2:SetOperation(c511000534.desop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(142,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetTarget(c511000534.destg)
	e3:SetOperation(c511000534.desop)
	c:RegisterEffect(e3)
end
function c511000534.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511000534.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end