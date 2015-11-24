--Dragons Unite
function c511000355.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000355.target)
	e1:SetOperation(c511000355.operation)
	c:RegisterEffect(e1)
	--Atk,def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511000355.value)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_DEFENCE)
	e3:SetValue(c511000355.value)
	c:RegisterEffect(e3)
	--Equip limit
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--to deck
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000355,0))
	e5:SetCategory(CATEGORY_TODECK)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c511000355.tdcon)
	e5:SetCost(c511000355.tdcost)
	e5:SetTarget(c511000355.tdtg)
	e5:SetOperation(c511000355.tdop)
	c:RegisterEffect(e5)
end
function c511000355.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000355.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511000355.value(e,c)
	return Duel.GetMatchingGroupCount(c511000355.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,nil)*400
end
function c511000355.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup()
end
function c511000355.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511000355.cfilter(c,tp)
	return c:IsRace(RACE_DRAGON)
end
function c511000355.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511000355.cfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c511000355.cfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c511000355.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeck() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c511000355.tdop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)
	end
end
