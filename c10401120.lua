local cm,m,o=GetID()
--被封闭的道路
function cm.initial_effect(c)
	--通过【费用】[计数爆发2]施放！
    --选择对手的1张先导者，这次战斗中，那个单位的☆-1。
	vgd.VgCard(c)
	vgd.SpellActivate(c,m,cm.operation,vgf.DamageCost(2))
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=vgf.SelectMatchingCard(HINTMSG_OPPO,e,tp,vgf.VMonsterFilter,tp,0,LOCATION_MZONE,1,1,nil)
	local e1=vgf.StarUp(c,g,-1,EVENT_BATTLED)
	vgf.EffectReset(c,e1,EVENT_BATTLED)
end