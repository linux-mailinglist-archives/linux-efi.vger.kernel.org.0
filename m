Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89245B0A7B
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIGQqn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIGQqm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 12:46:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435FC23145;
        Wed,  7 Sep 2022 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662569196; x=1694105196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IhpjY4pXNZR+1OqitHXjkeJ8yaTjjGkFJMIQ6pO2qoI=;
  b=FfgMr2M/db81UhxdlzU/5U29wo/AOH8vnMW5Dd15ij5qWEjrUs/t98Ua
   LVoSlkN0ucUKsfjskaSYEIzBimXpCDExemSfHj+fCFaCmImkH5d6EC+WS
   mojfPtPEhrPlukzn30wqqMC30PB4/Ph1tCEy+Ze/xzxWVvNcV1fVANLp9
   7Pm0P6B8BdUmrT/DyiBSzPLa2cpSDiZWHcCopzbnK/cgPV/3BKyRZDN+4
   +O0CqamjQRLM1TCYajIjEh9eT+QVBWpVxCLo/fyMvl3oryvV0jz78e3ml
   Vwh9o9hEB4P0ix7z5xnZfuNM4MIw6Ka+u2Yb1EYKh9Tw9cC7xlUJAhMXl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295667997"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="295667997"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:46:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="790116153"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Sep 2022 09:46:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 352895E4; Wed,  7 Sep 2022 19:46:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v1 7/8] spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Wed,  7 Sep 2022 19:46:05 +0300
Message-Id: <20220907164606.65742-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
References: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
an integer. Use it instead of custom approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4749dd598ec2..01a513d6c6b0 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1321,30 +1321,6 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-#ifdef CONFIG_ACPI
-
-static int pxa2xx_spi_get_port_id(struct device *dev)
-{
-	struct acpi_device *adev;
-	unsigned int devid;
-	int port_id = -1;
-
-	adev = ACPI_COMPANION(dev);
-	if (adev && adev->pnp.unique_id &&
-	    !kstrtouint(adev->pnp.unique_id, 0, &devid))
-		port_id = devid;
-	return port_id;
-}
-
-#else /* !CONFIG_ACPI */
-
-static int pxa2xx_spi_get_port_id(struct device *dev)
-{
-	return -1;
-}
-
-#endif /* CONFIG_ACPI */
-
 static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
 {
 	return param == chan->device->dev;
@@ -1354,12 +1330,15 @@ static struct pxa2xx_spi_controller *
 pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
 	struct pxa2xx_spi_controller *pdata;
+	struct device *dev = &pdev->dev;
 	struct ssp_device *ssp;
 	struct resource *res;
 	struct device *parent = pdev->dev.parent;
 	u32 value = SSP_UNDEFINED;
 	enum pxa_ssp_type type;
 	const void *match;
+	int status;
+	u64 uid;
 
 	/* Always try to read property */
 	device_property_read_u32(&pdev->dev, "intel,spi-pxa2xx-type", &value);
@@ -1402,7 +1381,12 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 	ssp->type = type;
 	ssp->dev = &pdev->dev;
-	ssp->port_id = pxa2xx_spi_get_port_id(&pdev->dev);
+
+	status = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
+	if (status)
+		ssp->port_id = -1;
+	else
+		ssp->port_id = uid;
 
 	pdata->is_slave = device_property_read_bool(&pdev->dev, "spi-slave");
 	pdata->num_chipselect = 1;
-- 
2.35.1

