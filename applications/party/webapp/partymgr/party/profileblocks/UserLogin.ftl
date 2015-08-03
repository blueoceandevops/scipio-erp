<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

  <#assign menuHtml>
    <#if security.hasEntityPermission("PARTYMGR", "_CREATE", session)>
      <li><a href="<@ofbizUrl>ProfileCreateNewLogin?partyId=${party.partyId}</@ofbizUrl>" class="${styles.button_default!}">${uiLabelMap.CommonCreateNew}</a></li>
    </#if>
  </#assign>
  <@section id="partyUserLogins" title="${uiLabelMap.PartyUserName}" menuHtml=menuHtml>
      <#if userLogins?has_content>
        <table class="basic-table" cellspacing="0">
          <#list userLogins as userUserLogin>
            <tr>
              <td>${uiLabelMap.PartyUserLogin}</td>
              <td>${userUserLogin.userLoginId}</td>
              <td>
                <#assign enabled = uiLabelMap.PartyEnabled>
                <#if (userUserLogin.enabled)?default("Y") == "N">
                  <#if userUserLogin.disabledDateTime??>
                    <#assign disabledTime = userUserLogin.disabledDateTime.toString()>
                  <#else>
                    <#assign disabledTime = "??">
                  </#if>
                  <#assign enabled = uiLabelMap.PartyDisabled + " - " + disabledTime>
                </#if>
                ${enabled}
              </td>
              <td class="button-col">
                <#if security.hasEntityPermission("PARTYMGR", "_CREATE", session)>
                  <a href="<@ofbizUrl>ProfileEditUserLogin?partyId=${party.partyId}&amp;userLoginId=${userUserLogin.userLoginId}</@ofbizUrl>" class="${styles.button_default!}">${uiLabelMap.CommonEdit}</a>
                </#if>
                <#if security.hasEntityPermission("SECURITY", "_VIEW", session)>
                  <a href="<@ofbizUrl>ProfileEditUserLoginSecurityGroups?partyId=${party.partyId}&amp;userLoginId=${userUserLogin.userLoginId}</@ofbizUrl>" class="${styles.button_default!}">${uiLabelMap.SecurityGroups}</a>
                </#if>
              </td>
            </tr>
          </#list>
        </table>
      <#else>
        ${uiLabelMap.PartyNoUserLogin}
      </#if>
  </@section>