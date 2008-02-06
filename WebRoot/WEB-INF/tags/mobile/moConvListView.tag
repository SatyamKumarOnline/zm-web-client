<%@ tag body-content="empty" %>
<%@ attribute name="context" rtexprvalue="true" required="true" type="com.zimbra.cs.taglib.tag.SearchContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="mo" uri="com.zimbra.mobileclient" %>
<%@ taglib prefix="zm" uri="com.zimbra.zm" %>
<mo:handleError>
    <zm:getMailbox var="mailbox"/>
    <mo:searchTitle var="title" context="${context}"/>
    <c:set var="cid" value="${empty param.id ? context.searchResult.hits[0].id : param.id}"/>
    <fmt:message var="unknownRecipient" key="unknownRecipient"/>
    <fmt:message var="unknownSubject" key="noSubject"/>
    <c:set var="useTo" value="${context.folder.isSent or context.folder.isDrafts}"/>
    <c:set var="selectedRow" value="${param.selectedRow}"/>
</mo:handleError>
<c:set var="context_url" value="${requestScope.baseURL!=null?requestScope.baseURL:'mosearch'}"/>
<mo:view mailbox="${mailbox}" title="${title}" context="${context}">
<zm:currentResultUrl var="actionUrl" value="${context_url}" context="${context}"/>
<form id="actions" action="${fn:escapeXml(actionUrl)}" method="post">
<input type="hidden" name="crumb" value="${fn:escapeXml(mailbox.accountInfo.crumb)}"/>
<input type="hidden" name="doMessageAction" value="1"/>

<table class="x_list_container" cellspacing="0" cellpadding="0" border="0" width="100%">
<tr>
    <td>
            <%--table width="100%" cellspacing="0" cellpadding="0">
                <tr class='zo_toolbar<c:out value="${pageContext.request.servletPath=='/m/main'?'1':''}"/>'>
                    <td>
                        <table cellspacing="0" cellpadding="0">
                            <tr>

                                <td><a href="main" class='zo_leftbutton'><fmt:message key="MO_MAIN"/></a></td>
                                    <td>
                                    <mo:searchPageLeft urlTarget="${context_url}" context="${context}" keys="false"/>
                                </td>
                                <td>
                                    <mo:searchPageRight urlTarget="${context_url}" context="${context}" keys="false"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table--%>
        <mo:toolbar context="${context}" urlTarget="${context_url}" isTop="true"/>
    </td>
</tr>
<tr>
    <td>
        <table cellspacing="0" width="100%" cellspaing="0" border="0">
            <c:forEach items="${context.searchResult.hits}" var="hit" varStatus="status">
                <c:set var="chit" value="${hit.conversationHit}"/>

                <c:choose>
                    <c:when test="${chit.isDraft}">
                        <zm:currentResultUrl var="convUrl" value="${context_url}" index="${status.index}"
                                             context="${context}" usecache="true" id="${fn:substringAfter(chit.id,'-')}"
                                             action="compose"/>
                    </c:when>
                    <c:otherwise>
                        <zm:currentResultUrl var="convUrl" value="${context_url}" cid="${chit.id}" action='view'
                                             index="${status.index}" context="${context}" usecache="true"/>
                    </c:otherwise>
                </c:choose>
                <tr id="conv${chit.id}" class="highlight">
                    <td class='zo_m_list_row'>
                        <table cellspacing="0" cellpadding="4" width="100%">
                            <tr>
                                <td class="zo_m_chk" width="1%">
                                    <c:set value=",${chit.id}," var="stringToCheck"/>
                                    <input type="checkbox" ${fn:contains(requestScope._selectedCids,stringToCheck)?'checked="checked"':'unchecked'} name="cid" value="${chit.id}">
                                    <c:forEach items="${chit.matchedMessageIds}" var="mid">
                                        <input type="hidden" name="id_${chit.id}" value="${mid}"/>
                                    </c:forEach>
                                </td>
                                <td width="1%">
                                    <c:if test="${chit.messageCount ge 2}">
                                        <mo:img src="startup/ImgConversationView.gif"/>
                                    </c:if>
                                    <c:if test="${chit.messageCount lt 2}">
                                        <mo:img src="mail/ImgEnvelope${chit.isUnread?'':'Gray'}.gif"/>
                                    </c:if>
                                </td>
                                <td onclick='zClickLink("a${chit.id}")'>
                                    <table cellspacing="0" width="100%">
                                        <tr class='zo_m_list_<c:if test="${chit.isUnread}">un</c:if>read'>
                                            <td class='zo_m_list_sub' width="95%">
                                                <a id="a${chit.id}"
                                                   href="${fn:escapeXml(convUrl)}">${fn:escapeXml(empty chit.subject ? unknownSubject : zm:truncate(chit.subject,50,true))}</a>
                                                   <span class='zo_m_list_<c:if test="${chit.isUnread}">un</c:if>read'>
                                                    <span class='zo_m_list_from'>&nbsp; 
                                                       <c:set var="dispRec" value="${chit.displayRecipients}"/>
                                                        ${fn:escapeXml(empty dispRec ? unknownRecipient : dispRec)}
                                                    </span>
                                                   </span>
                                                   <p class='zo_m_list_frag'>${fn:escapeXml(zm:truncate(chit.fragment,50,true))}</p>
                                            </td>
                                            <td align="center" width="2%" valign="middle" style="padding-top: 5px;padding-left: 4px;">
                                                        <c:if test="${chit.isFlagged}">
                                                            <mo:img src="startup/ImgFlagRed.gif" alt="flag"/>
                                                        </c:if>
                                                        <c:if test="${chit.hasTags}">
                                                            <mo:miniTagImage
                                                                    ids="${hit.conversationHit.tagIds}"/>
                                                        </c:if>
                                                                <c:choose>
                                                                <c:when test="${chit.messageCount gt 1}">(${chit.messageCount}
                                                                    )</c:when>
                                                                <c:otherwise>&nbsp;</c:otherwise>
                                                            </c:choose>
                                                       
                                            </td>
                                        <td class='zo_m_list_date' nowrap="nowrap" width="3%>
                                                <fmt:formatDate timeZone="${mailbox.prefs.timeZone}" var="on_dt"
                                                                pattern="yyyyMMdd" value="${chit.date}"/>
                                                <a
                                                        <c:if test="${uiv == '1' && mailbox.features.calendar}">href="${context_url}?st=cal&view=month&date=${on_dt}"</c:if>>
                                                        ${fn:escapeXml(zm:displayMsgDate(pageContext, chit.date))}
                                                </a>
                                         </td>
                                         <td class="zo_ab_list_arrow" nowrap="nowrap">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <c:if test="${context.searchResult.size == 0}">
            <div class='zo_noresults'><fmt:message key="noResultsFound"/></div>
        </c:if>
            <%--/form--%>
    </td>
</tr>
<c:if test="${context.searchResult.size gt 0}">
    
    <tr>
        <td>
                <a name="action" id="action"/>
                <table cellspacing="2" cellpadding="2" width="100%">
                    <tr class="zo_m_list_row">
                        <td>
                            <input name="actionDelete" type="submit" value="<fmt:message key="delete"/>"/>
                           <select name="anAction">
                               <option value="" selected="selected"><fmt:message key="moreActions"/></option>
                               <optgroup label="Mark">
                                   <option value="actionMarkRead">Read</option>
                                   <option value="actionMarkUnread">Unread</option>
                               </optgroup>
                               <optgroup label="Flag">
                                  <option value="actionFlag">Add</option>
                                  <option value="actionUnflag">Remove</option>
                              </optgroup>
                              <optgroup label="<fmt:message key="moveAction"/>">
                                <zm:forEachFolder var="folder">
                                    <c:if test="${folder.isMessageMoveTarget and !folder.isTrash and !folder.isSpam}">
                                        <option value="moveto_${folder.id}">${fn:escapeXml(folder.rootRelativePath)}</option>
                                    </c:if>
                                </zm:forEachFolder>
                              </optgroup>
                              <zm:forEachFolder var="folder">
                                  <input type="hidden" name="folderId" value="${folder.id}"/>
                              </zm:forEachFolder>
                           </select>
                           <input name="moreActions" type="submit" value="<fmt:message key="actionGo"/>"/>
                        </td>
                    </tr>
                </table>
        </td>
    </tr>
<tr>
        <td>
            <mo:toolbar context="${context}" urlTarget="${context_url}" isTop="false"/>
        </td>
    </tr>
</c:if>
</table>
</form>
<br>
</mo:view>
