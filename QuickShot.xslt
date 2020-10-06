<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
             	version="2.0">
  <xsl:output method="xml"
          		version="1.0"
          		omit-xml-declaration="no"
          		encoding="UTF-8"
          		indent="yes" />
  <xsl:template match="/">
    <ArrayOfCaptureSequenceList xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                          			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <xsl:for-each select="Mosaic/Position">
        <CaptureSequenceList>
          <xsl:attribute name="TargetName">
            <xsl:value-of select="panelname"/>
          </xsl:attribute>
          <xsl:attribute name="Mode">STANDARD</xsl:attribute>
          <xsl:if test="string(@RAhr)">
            <xsl:attribute name="RAHours">
              <xsl:value-of select="RAhr"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="string(@RAmin)">
            <xsl:attribute name="RAMinutes">
              <xsl:value-of select="RAmin"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="string(@RAsec)">
            <xsl:attribute name="RASeconds">
              <xsl:value-of select="RAsec"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="string(@Decdeg)">
            <xsl:attribute name="DecDegrees">
              <xsl:value-of select="Decdeg"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="string(@Decmin)">
            <xsl:attribute name="DecMinutes">
              <xsl:value-of select="Decmin"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="string(@Decsec)">
            <xsl:attribute name="DecSeconds">
              <xsl:value-of select="Decsec"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="string(@Rotdeg)">
            <xsl:attribute name="Rotation">
              <xsl:value-of select="Rotdeg"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:attribute name="Delay">0</xsl:attribute>
          <xsl:attribute name="SlewToTarget">true</xsl:attribute>
          <xsl:attribute name="AutoFocusOnStart">false</xsl:attribute>
          <xsl:attribute name="CenterTarget">true</xsl:attribute>
          <xsl:attribute name="StartGuiding">true</xsl:attribute>
          <xsl:attribute name="AutoFocusOnFilterChange">false</xsl:attribute>
          <xsl:attribute name="AutoFocusAfterSetTime">false</xsl:attribute>
          <xsl:attribute name="AutoFocusSetTime">30</xsl:attribute>
          <xsl:attribute name="AutoFocusAfterSetExposures">false</xsl:attribute>
          <xsl:attribute name="AutoFocusSetExposures">10</xsl:attribute>
          <xsl:attribute name="AutoFocusAfterTemperatureChange">false</xsl:attribute>
          <xsl:attribute name="AutoFocusAfterTemperatureChangeAmount">5</xsl:attribute>
          <xsl:attribute name="AutoFocusAfterHFRChange">false</xsl:attribute>
          <xsl:attribute name="AutoFocusAfterHFRChangeAmount">10</xsl:attribute>
          <Coordinates>
            <RA>
              <xsl:value-of select="RAdecimal"/>
            </RA>
            <Dec>
              <xsl:value-of select="Decdecimal"/>
            </Dec>
            <Epoch>J2000</Epoch>
          </Coordinates>
          <NegativeDec>false</NegativeDec>
          <CaptureSequence>
            <Enabled>true</Enabled>
            <ExposureTime>6</ExposureTime>
            <ImageType>LIGHT</ImageType>
            <Binning>
              <X>1</X>
              <Y>1</Y>
            </Binning>
            <Gain>-1</Gain>
            <Offset>-1</Offset>
            <TotalExposureCount>1</TotalExposureCount>
            <ProgressExposureCount>0</ProgressExposureCount>
            <Dither>false</Dither>
            <DitherAmount>1</DitherAmount>
          </CaptureSequence>
        </CaptureSequenceList>
      </xsl:for-each>
    </ArrayOfCaptureSequenceList>
  </xsl:template>
</xsl:transform>
