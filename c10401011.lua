local cm,m,o=GetID()
function cm.initial_effect(c)
	vgd.VgCard(c)
	vgd.OverDress(c,10101009)
	vgd.EffectTypeTrigger(c,m,nil,EFFECT_TYPE_SINGLE,EVENT_SPSUMMON_SUCCESS,cm.op,vgf.DamageCost(1),cm.con)
end
function cm.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetFlagEffectLabel(FLAG_CONDITION)==201 and vgf.RSummonCondition(e)
end
function cm.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Draw(tp,2,REASON_EFFECT)
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		vgf.AtkUp(c,c,5000)
	end
end