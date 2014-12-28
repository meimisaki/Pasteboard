<%@ page pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table class="table">
    <tbody>
        <c:forEach items="${list}" var="item">
            <tr>
                <td>
                    <h3 class="item-header">
                        <a href="view.jsp?id=${item.id}">
                            <c:out value="${item.title}" />
                        </a>
                        <span class="item-header-addon">
                            <i class="fa fa-star fa-fw"></i>
                            @STARS
                        </span>
                        <span class="item-header-addon">
                            <c:out value="${item.language}" />
                        </span>
                    </h3>
                    <div class="item-body">
                        <c:out value="${item.description}" />
                    </div>
                    <div class="item-footer">
                        Updated on <c:out value="${fn:substring(item.modified_time, 0, 10)}" />
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
