Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA085B7824
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 19:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiIMRkI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Sep 2022 13:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiIMRjh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Sep 2022 13:39:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293497CB59;
        Tue, 13 Sep 2022 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663086728; x=1694622728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CiO6PmLujLv+q2QkMd8sXk4rBLMmTRjebquRk+BpmSg=;
  b=XPvsXezholVo/YomJb6ycO+Hh0FLgZ2rOW6NHqIi8zPvHsCCL1YlwAmJ
   Cq6T3N01x5GrRc8adcfwyRO0AuMJ4lAA8Y9mEJ2jMJn/4rJKRixm9a8Qq
   KOSPZof67vIo/0+buF7YMGOEAxpLoqFvGMVBy49Rj2SATFtazACxD6rJ1
   324sE4LVvEyFAQGLbspAxT7gIv6GnZ5Mx7JmOOZbjB5tYOQVWihDTIVqZ
   hY8f5Mq1rKrK73T+Ax7EeyW9IScJDofEbKNS0NjfzYdVDsXMhtkCzF4gO
   u3uPGiQcIKjeXVnSrv+ONrS+CCdJ1E+9PuwaxJFF4xhp+d07aJx+HTlrW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="296920508"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="296920508"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="945130362"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Sep 2022 09:31:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 45E15238; Tue, 13 Sep 2022 19:31:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
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
        Robert Moore <robert.moore@intel.com>
Subject: [PATCH v3 2/8] ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
Date:   Tue, 13 Sep 2022 19:31:41 +0300
Message-Id: <20220913163147.24258-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
References: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_lpss.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 7a73528aa9c2..f08ffa75f4a7 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -167,10 +167,10 @@ static struct pwm_lookup byt_pwm_lookup[] = {
 
 static void byt_pwm_setup(struct lpss_private_data *pdata)
 {
-	struct acpi_device *adev = pdata->adev;
+	u64 uid;
 
 	/* Only call pwm_add_table for the first PWM controller */
-	if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
+	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
 		return;
 
 	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
@@ -180,14 +180,13 @@ static void byt_pwm_setup(struct lpss_private_data *pdata)
 
 static void byt_i2c_setup(struct lpss_private_data *pdata)
 {
-	const char *uid_str = acpi_device_uid(pdata->adev);
 	acpi_handle handle = pdata->adev->handle;
 	unsigned long long shared_host = 0;
 	acpi_status status;
-	long uid = 0;
+	u64 uid;
 
-	/* Expected to always be true, but better safe then sorry */
-	if (uid_str && !kstrtol(uid_str, 10, &uid) && uid) {
+	/* Expected to always be successfull, but better safe then sorry */
+	if (!acpi_dev_uid_to_integer(pdata->adev, &uid) && uid) {
 		/* Detect I2C bus shared with PUNIT and ignore its d3 status */
 		status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
 		if (ACPI_SUCCESS(status) && shared_host)
@@ -211,10 +210,10 @@ static struct pwm_lookup bsw_pwm_lookup[] = {
 
 static void bsw_pwm_setup(struct lpss_private_data *pdata)
 {
-	struct acpi_device *adev = pdata->adev;
+	u64 uid;
 
 	/* Only call pwm_add_table for the first PWM controller */
-	if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
+	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
 		return;
 
 	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
-- 
2.35.1

