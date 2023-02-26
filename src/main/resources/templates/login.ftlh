<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page user!>
<#if loginError??>
    <div class="alert alert-danger" role="alert">
        User name or password is not correct
    </div>
</#if>

<#if message??>
<div class="alert alert-${messageType}" role="alert">
    ${message}
</div>
</#if>

<@l.login "/login" false/>
</@c.page>