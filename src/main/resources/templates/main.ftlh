<#import "parts/common.ftlh" as c>


<@c.page user>
    <div class = "form-row">
        <form method="get" action="/main" class="form-inline">
            <input type="text" name="filter" class="form-control" value="${(filter)!}" placeholder="Search by tag" />
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>
<#--    <span><a href="/user">User list</a></span>-->

    <a class="btn btn-primary mt-2" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
        Add new message
    </a>
<div class="collapse mt-2 <#if message??>show</#if>" id="collapseExample">
    <div class="form-group mt-3">
        <form method="post" action = "/main" enctype="multipart/form-data">
            <div class="form-group">
                <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}"
                    value="<#if message??>${message.text}</#if>" name="text" placeholder="Введите текст"/>
                <#if textError??>
                <div class="invalid-feedback">
                    ${textError}
                </div>
                </#if>
            </div>
            <div class="form-group">
                <input type="text" class="form-control ${(tagError??)?string('is-invalid', '')}"
                       value="<#if message??>${message.text}</#if>" name="tag" placeholder="Тэг"/>
                <#if tagError??>
                <div class="invalid-feedback">
                    ${tagError}
                </div>
                </#if>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file" id="customFile"/>
                    <label class="custom-file-label" for="customFile">Choose file</label>
                </div>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-primary">Add</button>
        </form>
    </div>
</div>
<div class="card-columns">
    <#list messages as message>
        <div class="card my-3" style="width: 18rem;">
            <div>
                <#if message.filename??>
                    <img class="card-img-top" src="/img/${message.filename}">
                </#if>
            </div>
            <div class="m-2">
                <span>${message.text}</span>
                <i>${message.tag}</i>
            </div>
            <div class="card-footer text-muted">
                ${message.authorName}
            </div>
        </div>
    <#else>
        No messages
    </#list>
</div>
</@c.page>