<#macro navbar user>
<#import "login.ftlh" as l>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">Sweater</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/main">Messages</a>
            </li>
            <#if user?has_content>
                <li class="nav-item">
                    <a class="nav-link" href="/user-messages/${user.id}">My messages</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/user/profile">Profile</a>
                </li>

                <#if user.admin>
                <li class="nav-item">
                    <a class="nav-link" href="/user">User list</a>
                </li>
                </#if>

            </#if>

        </ul>

        <#if user?has_content>
            <div class = "navbar-text mr-3">${user.username}</div>
            <@l.logout/>
            <#else>
                unknown
        </#if>

    </div>
</nav>
</#macro>