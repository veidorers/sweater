<#import "parts/common.ftlh" as c>

<@c.page user>

<#if isCurrentUser>
    <#include "parts/messageEdit.ftlh"/>
</#if>

<#import "parts/messageList.ftlh" as l>
<@l.messageList user/>

</@c.page>
