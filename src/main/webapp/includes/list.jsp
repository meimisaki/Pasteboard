<%@ page pageEncoding="UTF-8" %>
<% Object[] list = (Object[])request.getAttribute("list"); %>
<table class="table">
    <tbody>
        <% for (int i = 0 ; i < list.length ; ++i) { %>
            <tr>
                <td>
                    <h3 class="item-header">
                        <a href="#">@TITLE</a>
                        <span class="item-header-addon">
                            <i class="fa fa-star fa-fw"></i>
                            @STARS
                        </span>
                        <span class="item-header-addon">
                            @LANGUAGE
                        </span>
                    </h3>
                    <div class="item-body">
                        @DESCRIPTION
                    </div>
                    <div class="item-footer">
                        Updated on @DATE
                    </div>
                </td>
            </tr>
        <% } %>
    </tbody>
</table>
