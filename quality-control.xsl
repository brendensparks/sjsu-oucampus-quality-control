<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>

<xsl:stylesheet version="3.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	xmlns:fn="http://omniupdate.com/XSL/Functions"
	xmlns:ouc="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="xs ou fn ouc">

	<!-- QC checks! -->
    <xsl:template name="meta-qc">
    	<xsl:param name="document" />
        <xsl:if test="($ou:action != 'pub') and ($page-type != '')">
            <xsl:variable name="metadesc">
			<xsl:value-of select="normalize-space(/document/ouc:properties[@label='metadata']/meta[@name='Meta Description']/@content)"/>
			</xsl:variable>
            <xsl:choose>
                <xsl:when test="string-length($metadesc) lt 1">
                    <div class="o-wrap--content alert-box alert qc-check">
                        <p><strong>Quality Control Check:</strong> It looks like the Description in the 'Title and Metadata' section is missing. This field is important to help search engines find and understand what pages are about. Adding a description not only helps this page, but pages that are linked to and from it. Please add a short sentence that describes the page and its purpose. <br/>[<a href="http://a.cms.omniupdate.com/10/#sjsu/sjsu/{$ou:site}/pageparameters{replace($ou:path, '.php','.pcf')}" target="_parent">Go to the parameters of the page</a>]</p>
						<p>Your current description: <xsl:value-of select="$metadesc"/></p>
                    </div>
                </xsl:when>
                <xsl:when test="string-length($metadesc) lt 50">
                    <div class="o-wrap--content alert-box warning qc-check">
                        <p><strong>Quality Control Check:</strong> Thank you for adding a Description in the 'Title and Metadata' section. However, the description is only <strong><xsl:value-of select="string-length($metadesc)" /> characters</strong>, which is short of the recommendation of at least 50 characters. Please expand your meta description with a few more words that describe what this page is about. <br/>[<a href="http://a.cms.omniupdate.com/10/#sjsu/sjsu/{$ou:site}/pageparameters{replace($ou:path, '.php','.pcf')}" target="_parent">Go to the parameters of the page</a>]</p>
						<p>Your current description: <xsl:value-of select="$metadesc"/></p>						
                    </div>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
			<xsl:if test="ou:textual-content($page-title) = ''">
                <div class="o-wrap--content alert-box warning qc-check">
                   <p><strong>Quality Control Check:</strong> It looks like the Title in the 'Title and Metadata' section is missing. The page's Title is the text that appears in search engines and is very important in helping users find you. <br/>[<a href="http://a.cms.omniupdate.com/10/#sjsu/sjsu/{$ou:site}/pageparameters{replace($ou:path, '.php','.pcf')}" target="_parent">Go to the parameters of the page</a>]</p>
                </div>
			</xsl:if>							
        </xsl:if>
    </xsl:template>
	
	<xsl:template match="span[not(contains(@class,'ou-span-allowed'))]">
		<xsl:apply-templates select="node()"/>
	</xsl:template>	
	
	<xsl:template match="p[node() = '&amp;nbsp;'][not(*)]"></xsl:template>
	
	<xsl:template match="a[contains(lower-case(node()), 'click here')]">
		<xsl:if test="$ou:action != 'pub'">
			<span data-tooltip="data-tooltip" aria-haspopup="true" class="has-tip code-error" title="'click here' is not appropriate link text. Please re-write the text using direct language that describes the destination of link.">
			<span style="background-color:#ff0000;color:#ffffff;"><xsl:value-of select="node()"/></span>
			</span>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="a[contains(lower-case(node()), 'read more')]">
		<xsl:if test="$ou:action != 'pub'">
			<span data-tooltip="data-tooltip" aria-haspopup="true" class="has-tip code-error" title="'read more' is not appropriate link text. Please re-write the text using direct language that describes the destination of link.">
			<span style="background-color:#ff0000;color:#ffffff;"><xsl:value-of select="node()"/></span>
			</span>
		</xsl:if>
	</xsl:template>	
	
	<xsl:template match="a[contains(lower-case(node()), 'learn more')]">
		<xsl:if test="$ou:action != 'pub'">
			<span data-tooltip="data-tooltip" aria-haspopup="true" class="has-tip code-error" title="'learn more' is not appropriate link text. Please re-write the text using direct language that describes the destination of link.">
			<span style="background-color:#ff0000;color:#ffffff;"><xsl:value-of select="node()"/></span>
			</span>
		</xsl:if>
	</xsl:template>		
	
	<xsl:template match="a[ends-with(lower-case(@href), '.pdf')]">
		<xsl:element name="a">
			<!-- copy all link attributes -->
			<xsl:for-each select="@*">
				<xsl:attribute name="{name()}">
					<xsl:value-of select="." />					
				</xsl:attribute>
			</xsl:for-each>
			<!-- get link text and add pdf -->
			<xsl:value-of select="concat(., ' [pdf]')" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="a[ends-with(lower-case(@href), '.ppt')]">
		<xsl:element name="a">
			<!-- copy all link attributes -->
			<xsl:for-each select="@*">
				<xsl:attribute name="{name()}">
					<xsl:value-of select="." />					
				</xsl:attribute>
			</xsl:for-each>
			<!-- get link text and add pdf -->
			<xsl:value-of select="concat(., ' [ppt]')" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="a[ends-with(lower-case(@href), '.pptx')]">
		<xsl:element name="a">
			<!-- copy all link attributes -->
			<xsl:for-each select="@*">
				<xsl:attribute name="{name()}">
					<xsl:value-of select="." />					
				</xsl:attribute>
			</xsl:for-each>
			<!-- get link text and add pdf -->
			<xsl:value-of select="concat(., ' [pptx]')" />
		</xsl:element>
	</xsl:template>	

	<xsl:template match="a[ends-with(lower-case(@href), '.docx')]">
		<xsl:element name="a">
			<!-- copy all link attributes -->
			<xsl:for-each select="@*">
				<xsl:attribute name="{name()}">
					<xsl:value-of select="." />					
				</xsl:attribute>
			</xsl:for-each>
			<!-- get link text and add pdf -->
			<xsl:value-of select="concat(., ' [docx]')" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="a[ends-with(lower-case(@href), '.doc')]">
		<xsl:element name="a">
			<!-- copy all link attributes -->
			<xsl:for-each select="@*">
				<xsl:attribute name="{name()}">
					<xsl:value-of select="." />					
				</xsl:attribute>
			</xsl:for-each>
			<!-- get link text and add pdf -->
			<xsl:value-of select="concat(., ' [doc]')" />
		</xsl:element>
	</xsl:template>	
	
</xsl:stylesheet>
