Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66530656738
	for <lists+linux-efi@lfdr.de>; Tue, 27 Dec 2022 05:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiL0EJr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Dec 2022 23:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiL0EJp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Dec 2022 23:09:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E5818D;
        Mon, 26 Dec 2022 20:09:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB/7uF8tDIGasnyos2EVv03GLDrE0PMkNV/pxcQ+VPoY6SXR3dILUPBfSlZyQUUvZT6FCiu8+9yY5kM3dySjKTzA01hfr1hcdaFoHEpDflWxj+QNcTR2L4tpP9u1YDBAa2hlbqsNjcqJPbb+4KLaHvvzFNY5VTFa4o11i+Y2TrsvBfKgSKLnXMPMwlQ1y6pk1SrmDkleCLpPW29varz1GUiRq0xzxlgOlKsHgNscxmaCs1aHHu8MI+tQLaaHazb/yne5wonpz0zzxYsbej/bjLSIaI4FaxmDIDReAkZDJjkkZ+qMu6QBkbeh6PePrg6+WdTUF3rXtwnHg235XODJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/R01rDToqHiSjSvHPeekiz0B9V1avaMY/0gRM4Yxkr4=;
 b=d9y2Yui+nSb3Zooi4kzYgDVAGXdsgW+/65Kw6lOeZ0/KJfkxLD8fZOU4GQMof6mVdisFxjNDP5t9NWKhMH0CtboacLQ4TpAJeNRXEkUzh9Wq9fgE2pUrglzw2F39nuipdQXG9lcE1G+Cs7PRMHOwPrTvXCavZKje7MLBMDCRyXoyK2e6DCGv7V9x88IaIJ1Dad1r5SpywrvM5wDV2oarvX034qSpZgIu601wR7gihs0t2rTMxpJ7Z4i02KOdDJA6rMcGaHCoAsbqQD2aJKn7daPIjy/4vj74WFafyE/CxO9whpk5CLSIPTOCsiZ4zn/ZeB97ZBxleo+ooKH+7i6NAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=towertech.it smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/R01rDToqHiSjSvHPeekiz0B9V1avaMY/0gRM4Yxkr4=;
 b=Lvwa1yPonZx+udeyCvW3lOtWUN+MrWYlOtB8FucdLrqCqa/9y1nfYIxW0Mtl88xKNxDal1ahxvQoOwD/HWAKtvlS7tcsjn/9FwK1ThoKt1I/BgV/GL09fGO/xFWxKE4kbI/jejPjm4EaAq8aF8ddh+E9Qa02LBj8aXlx9ZmEwhSoPIaMj+klkyQFi5iYAsw6+swWbTFhcc+VZb5kTSa0E7JZxKDdqnvmbnUAggEqy3exKHazUAgJmPtvf4inckUaH6RUsg9mhpPJ6aBM93pUIRKj94rNYQ3E2Us2q1WBQglRD4VqemxznvvAbVu4XG8cdEajU2YymR176H/7fubamw==
Received: from BN9PR03CA0350.namprd03.prod.outlook.com (2603:10b6:408:f6::25)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 04:09:40 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::73) by BN9PR03CA0350.outlook.office365.com
 (2603:10b6:408:f6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.17 via Frontend
 Transport; Tue, 27 Dec 2022 04:09:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.8 via Frontend Transport; Tue, 27 Dec 2022 04:09:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 26 Dec
 2022 20:09:29 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 26 Dec
 2022 20:09:28 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 26 Dec 2022 20:09:28 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-efi@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH 1/1] efi: rtc: Enable SET/GET WAKEUP services as optional
Date:   Mon, 26 Dec 2022 22:09:25 -0600
Message-ID: <20221227040925.1619833-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: eff97f59-a71d-4f77-301a-08dae7c02d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOe6CznVYOR4J4BdqtWe6V3Ni8TSDh6JFil8pJ5RPpzYvMe2a1MFkRBr9es8NuA8DU6ovBEOBDLCcGi+drCT1j/TIUuCmvhRi3MFDCLEYdtByMml6O5aSCgUZcl7B6vcCvauQiqwKjvpiehCn0aZU6bh2Xo03HxgFqGri0gR9VeAuqSGMIyeWMRV6+jIyVxmx7LlJrCdu4ni0971E3pifTDKImGLksS7qedbzoLp2XdOc8rPxm7qJyrnaVhlpg3F7vBuom2Asv4Xq31tF9CZWjXnPjnHucVO+utgswSsEtdFMJjAUVj58k/rk1+FabFIPUMbcgqecV8iCnEWNFiCIYA6Yp2ppXdZC3X3XmhGg8ZGdBFAOtJ6N96jrH+sScVt+PMwt3wqgGPA6pljtSG8I9tUSQFyQNrjcDUpExfQmyZ4r5bVN3FfLzCWNaRlOk+ol1+H5nfnY0qH1bRqzBQUBr1GKtt6LWakzMbNF1uRFyx29Pf88ikPprNOo41mR/j9rJslp5xDg60taR9uU20l93gMPROlZhGForChJnfV9a9GVs5jdbNLOcdSFc2heoV9vHqT06OvKWck0GXIs49tKx6/2AqYycBLgiLesefwVLnZ8w0Km95tdFoYyIh+GgggZu83q/mVYulav2FcjttD2kDjVgQKnKRL1aum9ZDOV+wlRL2A6FS9WwBnvAQp2q1+p3Vm6s0JnieRBoUXxmzdm/bcRQ5DiNONlgEauKf3K6g=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(107886003)(4326008)(478600001)(2906002)(54906003)(36860700001)(316002)(36756003)(6666004)(110136005)(82310400005)(83380400001)(7636003)(82740400003)(356005)(40460700003)(2616005)(336012)(26005)(7696005)(186003)(1076003)(86362001)(40480700001)(47076005)(426003)(8676002)(8936002)(70586007)(70206006)(5660300002)(41300700001)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 04:09:40.0677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff97f59-a71d-4f77-301a-08dae7c02d19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The current implementation of rtc-efi is expecting all the 4
time services GET{SET}_TIME{WAKEUP} must be supported by UEFI
firmware. As per the EFI_RT_PROPERTIES_TABLE, the platform
specific implementations can choose to enable selective time
services based on the RTC device capabilities.

This patch does the following changes to provide GET/SET RTC
services on platforms that do not support the WAKEUP feature.

1) Relax time services cap check when creating a platform device.
2) Clear RTC_FEATURE_ALARM bit in the absence of WAKEUP services.
3) Conditional alarm entries in '/proc/driver/rtc'.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/rtc/rtc-efi.c | 48 ++++++++++++++++++++++++-------------------
 include/linux/efi.h   |  3 ++-
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index e991cccdb6e9c..1e8bc6cc1e12d 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -188,9 +188,10 @@ static int efi_set_time(struct device *dev, struct rtc_time *tm)
 
 static int efi_procfs(struct device *dev, struct seq_file *seq)
 {
-	efi_time_t      eft, alm;
-	efi_time_cap_t  cap;
-	efi_bool_t      enabled, pending;
+	efi_time_t        eft, alm;
+	efi_time_cap_t    cap;
+	efi_bool_t        enabled, pending;
+	struct rtc_device *rtc = dev_get_drvdata(dev);
 
 	memset(&eft, 0, sizeof(eft));
 	memset(&alm, 0, sizeof(alm));
@@ -213,23 +214,25 @@ static int efi_procfs(struct device *dev, struct seq_file *seq)
 		/* XXX fixme: convert to string? */
 		seq_printf(seq, "Timezone\t: %u\n", eft.timezone);
 
-	seq_printf(seq,
-		   "Alarm Time\t: %u:%u:%u.%09u\n"
-		   "Alarm Date\t: %u-%u-%u\n"
-		   "Alarm Daylight\t: %u\n"
-		   "Enabled\t\t: %s\n"
-		   "Pending\t\t: %s\n",
-		   alm.hour, alm.minute, alm.second, alm.nanosecond,
-		   alm.year, alm.month, alm.day,
-		   alm.daylight,
-		   enabled == 1 ? "yes" : "no",
-		   pending == 1 ? "yes" : "no");
-
-	if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
-		seq_puts(seq, "Timezone\t: unspecified\n");
-	else
-		/* XXX fixme: convert to string? */
-		seq_printf(seq, "Timezone\t: %u\n", alm.timezone);
+	if (test_bit(RTC_FEATURE_ALARM, rtc->features)) {
+		seq_printf(seq,
+			   "Alarm Time\t: %u:%u:%u.%09u\n"
+			   "Alarm Date\t: %u-%u-%u\n"
+			   "Alarm Daylight\t: %u\n"
+			   "Enabled\t\t: %s\n"
+			   "Pending\t\t: %s\n",
+			   alm.hour, alm.minute, alm.second, alm.nanosecond,
+			   alm.year, alm.month, alm.day,
+			   alm.daylight,
+			   enabled == 1 ? "yes" : "no",
+			   pending == 1 ? "yes" : "no");
+
+		if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
+			seq_puts(seq, "Timezone\t: unspecified\n");
+		else
+			/* XXX fixme: convert to string? */
+			seq_printf(seq, "Timezone\t: %u\n", alm.timezone);
+	}
 
 	/*
 	 * now prints the capabilities
@@ -269,7 +272,10 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 
 	rtc->ops = &efi_rtc_ops;
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
-	set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES))
+		set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
+	else
+		clear_bit(RTC_FEATURE_ALARM, rtc->features);
 
 	device_init_wakeup(&dev->dev, true);
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4b27519143f56..98598bd1d2fa5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -668,7 +668,8 @@ extern struct efi {
 
 #define EFI_RT_SUPPORTED_ALL					0x3fff
 
-#define EFI_RT_SUPPORTED_TIME_SERVICES				0x000f
+#define EFI_RT_SUPPORTED_TIME_SERVICES				0x0003
+#define EFI_RT_SUPPORTED_WAKEUP_SERVICES			0x000c
 #define EFI_RT_SUPPORTED_VARIABLE_SERVICES			0x0070
 
 extern struct mm_struct efi_mm;
-- 
2.25.1

