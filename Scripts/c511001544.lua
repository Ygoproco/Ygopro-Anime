--Ancient Gear Triple Bite Hound Dog
function c511001544.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	c511001544.material_count=2
	c511001544.material={511001539,511001540}
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c511001544.fcon)
	e0:SetOperation(c511001544.fop)
	c:RegisterEffect(e0)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(c511001544.atkop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(2)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e3:SetCondition(c511001544.dircon)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_ATTACK)
	e4:SetCondition(c511001544.atkcon)
	c:RegisterEffect(e4)
end
function c511001544.ffilter(c,sub)
	if sub then
		return c:IsCode(511001540) or c:IsCode(511001539)
	else
		return c:IsCode(511001540) or c:IsCode(511001539) or c:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)
	end
end
function c511001544.fcon(e,g,gc,chkf)
	if g==nil then return true end
	if gc then
		local sub=gc:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)
		return (sub and g:IsExists(c511001544.ffilter,1,gc,sub)) 
			or (gc:IsCode(511001540) and (g:IsExists(Card.IsCode,1,gc,511001539) or g:IsExists(Card.IsHasEffect,1,gc,EFFECT_FUSION_SUBSTITUTE))) 
			or (gc:IsCode(511001539) and g:IsExists(Card.IsHasEffect,1,gc,EFFECT_FUSION_SUBSTITUTE))
			or (gc:IsCode(511001539) and g:IsExists(Card.IsCode,2,gc,511001539)) end
	local g1=g:Filter(Card.IsCode,nil,511001539)
	local g2=g:Filter(Card.IsHasEffect,nil,EFFECT_FUSION_SUBSTITUTE)
	local g3=g:Filter(Card.IsCode,nil,511001540)
	local ct1=g1:GetCount()
	local ct2=g2:GetCount()
	local ct3=g3:GetCount()
	if chkf~=PLAYER_NONE then
		return (g1:FilterCount(Card.IsOnField,nil)~=0 or g2:FilterCount(Card.IsOnField,nil)~=0 or g3:FilterCount(Card.IsOnField,nil)~=0)
			and ((ct2==0 and ct1>=3)
			or (ct2==0 and ct1>=1 and ct3>=1)
			or (ct2>=1 and ct1>=1 and ct1+ct2>=2)
			or (ct2>=1 and ct3>=1 and ct2+ct3>=2))
	else
		return (ct2==0 and ct1>=3)
			or (ct2==0 and ct1>=1 and ct3>=1)
			or (ct2>=1 and ct1>=1 and ct1+ct2>=2)
			or (ct2>=1 and ct3>=1 and ct2+ct3>=2)
	end
end
function c511001544.ffilter1(c,sub)
	if sub then
		return c:IsCode(511001539)
	else
		return c:IsCode(511001539) or c:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)
	end
end
function c511001544.ffilter2(c,sub)
	if sub then
		return c:IsCode(511001540)
	else
		return c:IsCode(511001540) or c:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)
	end
end
function c511001544.fop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	local str=_G["Required Materials have been met, select more?"]
	if gc then
		local sub=gc:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=eg:FilterSelect(tp,c511001544.ffilter,1,1,gc,sub)
		local tc1=g1:GetFirst()
		local g=eg
		g:RemoveCard(tc1)
		g:RemoveCard(gc)
		sub=gc:IsHasEffect(EFFECT_FUSION_SUBSTITUTE) or tc1:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)
		if (gc:IsCode(511001539) or gc:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)) 
			and (tc1:IsCode(511001539) or tc1:IsHasEffect(EFFECT_FUSION_SUBSTITUTE))
			and g:IsExists(c511001544.ffilter1,1,nil,sub)
			and (not sub or Duel.SelectYesNo(tp,str)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local g2=g:FilterSelect(tp,c511001544.ffilter1,1,1,nil,sub)
			g1:Merge(g2)
		end
		Duel.SetFusionMaterial(g1)
		return
	end
	local sg=eg
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=sg:FilterSelect(tp,c511001544.ffilter,1,1,nil,false)
	local tc1=g1:GetFirst()
	local sub=tc1:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=sg:FilterSelect(tp,c511001544.ffilter,1,1,tc1,sub)
	local tc2=g2:GetFirst()
	g1:Merge(g2)
	sg:RemoveCard(tc1)
	sg:RemoveCard(tc2)
	sub=tc1:IsHasEffect(EFFECT_FUSION_SUBSTITUTE) or tc2:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)
	if (tc1:IsCode(511001539) or tc1:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)) 
		and (tc2:IsCode(511001539) or tc2:IsHasEffect(EFFECT_FUSION_SUBSTITUTE))
		and sg:IsExists(c511001544.ffilter1,1,nil,sub)
		and (not sub or Duel.SelectYesNo(tp,str)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g3=sg:FilterSelect(tp,c511001544.ffilter1,1,1,nil,sub)
		g1:Merge(g3)
	end
	Duel.SetFusionMaterial(g1)
end
function c511001544.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c511001544.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511001544.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c511001544.dircon(e)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end
function c511001544.atkcon(e)
	return e:GetHandler():IsDirectAttacked()
end
