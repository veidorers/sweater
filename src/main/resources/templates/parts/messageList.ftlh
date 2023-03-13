<#macro messageList user>
<div class="card-columns">
    <#list messages as message>
    <div class="card my-3" style="width: 18rem;">
        <div>
            <#if message.filename??>
                <img class="card-img-top" src="/img/${message.filename}">
            </#if>
        </div>
        <div class="m-2">
            <span>${message.text}</span><br/>
            <i>#${message.tag}</i>
        </div>
        <div class="card-footer text-muted">
            <a href="/user-messages/${message.author.id}">${message.authorName}</a>
            <#if message.author.id == user.id>
                <a class="btn btn-primary" href="/user-messages/${message.author.id}?message=${message.id}">Edit</a>
            </#if>

        </div>
    </div>
    <#else>
    No messages
    </#list>
</div>
</#macro>