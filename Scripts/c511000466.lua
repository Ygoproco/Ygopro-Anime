--Cursebreaker
function c511000466.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000466.condition)
	e1:SetTarget(c511000466.target)
	e1:SetOperation(c511000466.activate)
	c:RegisterEffect(e1)
end
function c511000466.condition(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()<0 then return false end
	for i=1,ev do
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local tc=te:GetHandler()
		if tc:IsType(TYPE_SPELL) then return true end
	end
	return false
end
function c511000466.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ng=Group.CreateGroup()
	local dg=Group.CreateGroup()
	for i=1,ev do
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local tc=te:GetHandler()
		ng:AddCard(tc)
		if tc:IsType(TYPE_SPELL) and tc:IsDestructable() and tc:IsRelateToEffect(te) then
			dg:AddCard(tc)
		end
	end
	Duel.SetTargetCard(dg)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,ng,ng:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c511000466.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Group.CreateGroup()
	for i=1,ev do
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local tc=te:GetHandler()
		if tc:IsType(TYPE_SPELL) then
			Duel.NegateActivation(i)
		end
		if tc:IsType(TYPE_SPELL) and tc:IsRelateToEffect(e) and tc:IsRelateToEffect(te) then
			dg:AddCard(tc)
		end
	end
	Duel.Destroy(dg,REASON_EFFECT)
end
