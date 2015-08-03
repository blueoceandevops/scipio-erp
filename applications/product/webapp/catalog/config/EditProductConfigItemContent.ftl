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
<script language="JavaScript" type="text/javascript">
function insertNowTimestamp(field) {
  eval('document.productForm.' + field + '.value="${nowTimestamp?string}";');
}
function insertImageName(size,nameValue) {
  eval('document.productForm.' + size + 'ImageUrl.value=nameValue;');
}
</script>

<#if fileType?has_content>
    <h3>${uiLabelMap.ProductResultOfImageUpload}</h3>
    <#if !(clientFileName?has_content)>
        <div>${uiLabelMap.ProductNoFileSpecifiedForUpload}.</div>
    <#else>
        <div>${uiLabelMap.ProductTheFileOnYourComputer}: <b>${clientFileName!}</b></div>
        <div>${uiLabelMap.ProductServerFileName}: <b>${fileNameToUse!}</b></div>
        <div>${uiLabelMap.ProductServerDirectory}: <b>${imageServerPath!}</b></div>
        <div>${uiLabelMap.ProductTheUrlOfYourUploadedFile}: <b><a href="<@ofbizContentUrl>${imageUrl!}</@ofbizContentUrl>">${imageUrl!}</a></b></div>
    </#if>
<br />
</#if>

<#if !(configItem??)>
    <h3>${uiLabelMap.ProductCouldNotFindProductConfigItem} "${configItemId}".</h3>
<#else>
    <table cellspacing="0" class="basic-table">
       <thead>
        <tr class="header-row">
            <th>${uiLabelMap.ProductContent}</th>
            <th>${uiLabelMap.ProductType}</th>
            <th>${uiLabelMap.CommonFrom}</th>
            <th>${uiLabelMap.CommonThru}</th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>
        </tr>
        </thead>
        <#assign rowClass = "2">
        <#list productContentList as entry>
        <#assign productContent=entry.productContent/>
        <#assign productContentType=productContent.getRelatedOne("ProdConfItemContentType", true)/>
        <tr valign="middle"<#if rowClass == "1"> class="alternate-row"</#if>>
            <td><a href="<@ofbizUrl>EditProductConfigItemContentContent?configItemId=${productContent.configItemId}&amp;contentId=${productContent.contentId}&amp;confItemContentTypeId=${productContent.confItemContentTypeId}&amp;fromDate=${productContent.fromDate}</@ofbizUrl>" class="${styles.button_default!}">${entry.content.description?default("[${uiLabelMap.ProductNoDescription}]")} [${entry.content.contentId}]</td>
            <td>${productContentType.description?default(productContent.confItemContentTypeId)}</td>
            <td>${productContent.fromDate?default("N/A")}</td>
            <td>${productContent.thruDate?default("N/A")}</td>
            <td><a href="<@ofbizUrl>removeContentFromProductConfigItem?configItemId=${productContent.configItemId}&amp;contentId=${productContent.contentId}&amp;confItemContentTypeId=${productContent.confItemContentTypeId}&amp;fromDate=${productContent.fromDate}</@ofbizUrl>" class="${styles.button_default!}">${uiLabelMap.CommonDelete}</a></td>
            <td><a href="/content/control/EditContent?contentId=${productContent.contentId}&amp;externalLoginKey=${requestAttributes.externalLoginKey!}" class="${styles.button_default!}">${uiLabelMap.ProductEditContent} ${entry.content.contentId}</td>
         </tr>
         <#-- toggle the row color -->
         <#if rowClass == "2">
             <#assign rowClass = "1">
         <#else>
             <#assign rowClass = "2">
         </#if>
         </#list>
    </table>
    <br />
    <#if configItemId?has_content && configItem?has_content>
        <div class="screenlet">
            <div class="screenlet-title-bar">
                <h3>${uiLabelMap.ProductCreateNewProductConfigItemContent}</h3>
            </div>
            <div class="screenlet-body">
                ${prepareAddProductContentWrapper.renderFormString(context)}
            </div>
        </div>
        <div class="screenlet">
            <div class="screenlet-title-bar">
                <h3>${uiLabelMap.ProductAddContentProductConfigItem}</h3>
            </div>
            <div class="screenlet-body">
                ${addProductContentWrapper.renderFormString(context)}
            </div>
        </div>
    </#if>
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <h3>${uiLabelMap.ProductOverrideSimpleFields}</h3>
        </div>
        <div class="screenlet-body">
            <form action="<@ofbizUrl>updateProductConfigItemContent</@ofbizUrl>" method="post" style="margin: 0;" name="productForm">
                <input type="hidden" name="configItemId" value="${configItemId!}" />
                <table cellspacing="0" class="basic-table">
                <tr>
                    <td width="20%" align="right" valign="top">${uiLabelMap.CommonDescription}</td>
                    <td>&nbsp;</td>
                    <td width="80%" colspan="4" valign="top">
                        <textarea name="description" cols="60" rows="2">${(configItem.description)!}</textarea>
                    </td>
                </tr>
                <tr>
                    <td width="20%" align="right" valign="top">${uiLabelMap.ProductLongDescription}</td>
                    <td>&nbsp;</td>
                    <td width="80%" colspan="4" valign="top">
                        <textarea name="longDescription" cols="60" rows="7">${(configItem.longDescription)!}</textarea>
                    </td>
                </tr>
                <tr>
                    <td width="20%" align="right" valign="top">
                        ${uiLabelMap.ProductSmallImage}
                        <#if (configItem.imageUrl)??>
                            <a href="<@ofbizContentUrl>${configItem.imageUrl}</@ofbizContentUrl>" target="_blank"><img alt="Image" src="<@ofbizContentUrl>${configItem.imageUrl}</@ofbizContentUrl>" class="cssImgSmall" /></a>
                        </#if>
                    </td>
                    <td>&nbsp;</td>
                    <td width="80%" colspan="4" valign="top">
                    <input type="text" name="imageUrl" value="${(configItem.imageUrl)?default(imageNameSmall + '.jpg')}" size="60" maxlength="255" />
                    <#if configItemId?has_content>
                        <div>
                        <span>${uiLabelMap.ProductInsertDefaultImageUrl}: </span>
                        <a href="javascript:insertImageName('small','${imageNameSmall}.jpg');" class="${styles.button_default!}">.jpg</a>
                        <a href="javascript:insertImageName('small','${imageNameSmall}.gif');" class="${styles.button_default!}">.gif</a>
                        <a href="javascript:insertImageName('small','');" class="${styles.button_default!}">${uiLabelMap.CommonClear}</a>
                        </div>
                    </#if>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                    <td><input type="submit" name="Update" value="${uiLabelMap.CommonUpdate}" /></td>
                    <td colspan="3">&nbsp;</td>
                </tr>
                </table>
            </form>
        </div>
    </div>
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <h3>${uiLabelMap.ProductUploadImage}</h3>
        </div>
        <div class="screenlet-body">
            <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>UploadProductConfigItemImage?configItemId=${configItemId}&amp;upload_file_type=small</@ofbizUrl>" name="imageUploadForm">
                <input type="file" size="50" name="fname" />
                <input type="submit" class="smallSubmit" value="${uiLabelMap.ProductUploadImage}" />
            </form>
        </div>
    </div>
</#if>
