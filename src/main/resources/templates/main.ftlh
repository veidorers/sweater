<#import "parts/common.ftlh" as c>


<@c.page user>
    <div class = "form-row">
        <form method="get" action="/main" class="form-inline">
            <input type="text" name="filter" class="form-control" value="${(filter)!}" placeholder="Search by tag" />
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <#include "parts/messageEdit.ftlh"/>
    <#import "parts/messageList.ftlh" as l>
    <@l.messageList user/>
</@c.page>