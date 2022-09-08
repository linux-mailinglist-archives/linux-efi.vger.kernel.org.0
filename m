Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E4C5B1F17
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiIHN3r (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiIHN3M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 09:29:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D3411CD6A;
        Thu,  8 Sep 2022 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643751; x=1694179751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5t/rSrTSMrpnmEJH125mjQ9wOh0q05aSVg3PYbIczNc=;
  b=JMlY0lij0nCw7uHGFLpGheSXJAg6c8lkxK1/bc6WBuVJSNasZeoFaVUf
   dFZRaM4FjYPUe/VHm5fS+pZXgXndNZiKXA8nbm4X1vvRg9X0X6JMtn0J2
   tDCWtrhMPdBhfTsFTBAOXM6BNMQ2czEMEHuhsE/fgKCTLM46WeynD8OiH
   odLbmh9Cx6ot3ngTCxkxo2a1twV1TiT/t+ReW7/qJsKO1pZ9FWfL8JIi8
   hHmRYsh/OC9rZYLvR8NukbF5ZEPWtR6juBcN/jReXMTvIwqnEtCWRutGF
   c2V2x0wwkAhWTBItznCutF8lLztDIdAeY2Hw3CrwjA9hcd5EL3luN7cbZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280196190"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="280196190"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="718558678"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 08 Sep 2022 06:29:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 101A06CD; Thu,  8 Sep 2022 16:29:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Elie Morisse <syniurge@gmail.com>,
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
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v2 7/8] spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Thu,  8 Sep 2022 16:29:09 +0300
Message-Id: <20220908132910.62122-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
an integer. Use it instead of custom approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 986ffc4bf1ed..024730dae8eb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1441,31 +1441,6 @@ static const struct of_device_id pxa2xx_spi_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
 
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
-
 #ifdef CONFIG_PCI
 
 static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
@@ -1479,6 +1454,7 @@ static struct pxa2xx_spi_controller *
 pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
 	struct pxa2xx_spi_controller *pdata;
+	struct device *dev = &pdev->dev;
 	struct ssp_device *ssp;
 	struct resource *res;
 	struct device *parent = pdev->dev.parent;
@@ -1486,6 +1462,8 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	const struct pci_device_id *pcidev_id = NULL;
 	enum pxa_ssp_type type;
 	const void *match;
+	int status;
+	u64 uid;
 
 	if (pcidev)
 		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
@@ -1529,7 +1507,12 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
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

