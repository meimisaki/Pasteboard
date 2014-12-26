<%@ page pageEncoding="UTF-8" %>
<div class="container" centering>
    <h2 class="col-sm-4 col-sm-offset-4 text-muted error">
        <i class="fa fa-quote-left"></i>
        <%= request.getParameter("error") %>
        <br />
        <i class="fa fa-quote-right small pull-right"></i>
    </h2>
</div>
