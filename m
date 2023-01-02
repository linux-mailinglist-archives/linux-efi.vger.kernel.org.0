Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE8265B80A
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jan 2023 00:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjABXGl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Jan 2023 18:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjABXGk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Jan 2023 18:06:40 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D65FBE;
        Mon,  2 Jan 2023 15:06:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjSBfbrVBT9jtXN5/wCjUXOO9LgWAa6VysXyLDG6d4hVn/gwN2PfnvvEolvVM8d8Q/eC0vlf2n20gBe7m10NWd8FlxGQ8wglKSRQ0Vxte1SM4W5+sZ+XfLLF3S4czLVgcVAHGkLZ+FhDs4eBSEw9sP9NZP3E1vwxw1BAnt6NugtRXAbbbkoVbYTrzyD8rqJVX3lR5DDiuDDXCF+NY40wgPQrp8zOO5xU8TLxHFUJMAcXaqY0wYAJ5wVZMw+evOtkmCi3laYZJLGx+SD9WWDhsF7LR+2COLPuBBsksPsLvFeQ6So1a3Z7sr/vFVyss2sCQei5m6PW9lEgUlVxarjvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjyIKj0Ksaz3uN346tWqc01sdFOsam1MW2i8ZWqwlMI=;
 b=MUlBjvEwgLXZQ8c0nZ/JrT/ySZJT2bM9Z4YkxRLnzvf+lxMqJf5IbY2zJ2iZi55NG+2NqN9dYIhtfoqCaA/jnvrRw584rlFRPgZWRpR1QxFFDVRg8rQEgpR1N058VlF3Fm5YMrxigbgkpG5EKYQLxnocEKhBOb981MhZTqKpB5V/BErBEwlViCcqdzfBmXVoxLx2sBtkyqWqnuu5OKVGcxJTq1KAO0VBLBj31jUfmQHgM8+KdE7wYB9b3Y6x9Yyfd5ALs6fbCIa12Ey4S4d8slqQLWAAQFv8Kokm6b9huuffx7UHqOYCXmJKAfmtM7Js3dbUB4jQISwBGBEA5TNW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=towertech.it smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjyIKj0Ksaz3uN346tWqc01sdFOsam1MW2i8ZWqwlMI=;
 b=U8nLsjSMuzIPwQx3oMai7iR0tU9cDqllhOZ8eMwVe4RhbpoVG3mwRHVw6UAXREX9wHry7y9JNQhJQseB2sugSdfOr+AkDmkF2Sxo+QRuULJhy4PAztOx21C6iFBmmJZEchNkCyDZzAzHalwscyJFAX7Dgxv10XoHV0/U6nZ6DIQvboZiH8fcYUjlovcses/TRK5qfb1GTVZ1BUoc9JHO/T5hlpPKywyc5YpK5c6Qx6d9l0vLoy9LyANt9OwVAspHX7GBK1l114s/7MbFyKIxLGFiWRzcElqYFt4YSOotwnzyVPRsgr+EUJZYANhmTDKgET2UjaWnHN42tvLfYTeBaA==
Received: from DM6PR18CA0012.namprd18.prod.outlook.com (2603:10b6:5:15b::25)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 23:06:34 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::c4) by DM6PR18CA0012.outlook.office365.com
 (2603:10b6:5:15b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Mon, 2 Jan 2023 23:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.18 via Frontend Transport; Mon, 2 Jan 2023 23:06:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 2 Jan 2023
 15:06:33 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 2 Jan 2023
 15:06:32 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 2 Jan 2023 15:06:32 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-efi@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v2] rtc: efi: Enable SET/GET WAKEUP services as optional
Date:   Mon, 2 Jan 2023 17:06:30 -0600
Message-ID: <20230102230630.192911-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: f9aa834f-ec46-4d7b-5caf-08daed15fe25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3JtICK+LfFBkLfJWGL9M1da3f9ArZWCChDcihRCJx3fydHIsxmI7IYNxOAsOwUzrPxOGNXcpSu5suVGRX9rAe6iLRyJi8m2IOBFyF86uNafruk5isZNyMlPptXrAPv5DcwO+tQ8xH3NmUwzA0dCSqakmeJKsrh2K1k5cheKt+PKlzunJkq2mc64Jn+eAsgwfudYf9vOMOvb3YYs28k2QCrptbAPsDsoHR+0/4ws6ll7++OIdF0RXgsZdC4PgyzJO+LecQOXfGa/njRNVYhPwYasNK1TdTIgvsgixKQ/Vmuj2vi2KvR4gFvcqIXe3jzN+0KdRKD5PRqFL9h5gkB4VvqWbcG/xyalDC5AL07xgRqAV97aAMEu9dSF6ZlSRjRGo18/uwk5pdvxyZs+JrOA3WW7jdv5DKPYxuMPdLwBoOEKz87YeQaPfJgOee8Y7tWh6+URVxGYaC/ozCi6KlDtfoIv/yrI+lJQ/N6866r7HYa8f1l+2jBfZS4EbOzZj6XwMtUJU7PVvLUmOL3fsrHxSYbvfzrXwQWJVXBtAnwCSe+WplryOpJ6uUkgdTmzrL/Rgklyz1RG1U//rgeDlLMw8vvMxBt8GpITqb2N186XWwmbMkFSmOsmRZBb+SEqveLbkzSMkbdhAQHE1lU8T1yr8db4cUCglbBfmDswr3P9zXBrf+mGgQX7Jr+nSt5rO4ycyP6rYmWJ+AiEf8mPK6KlCM83Rn7iV/+v7ER2y8KTJH/M93JLHtyNKwM2u/vXKIMM
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(2906002)(8936002)(4326008)(41300700001)(8676002)(478600001)(316002)(54906003)(70586007)(70206006)(110136005)(1076003)(82310400005)(336012)(26005)(40480700001)(7696005)(107886003)(47076005)(83380400001)(426003)(82740400003)(7636003)(356005)(186003)(2616005)(86362001)(40460700003)(36756003)(36860700001)(22166006)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 23:06:33.8898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9aa834f-ec46-4d7b-5caf-08daed15fe25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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
Changes since v1: 
   -Changed subject from "efi: rtc:" to "rtc: efi:"

 drivers/rtc/rtc-efi.c | 48 ++++++++++++++++++++++++-------------------
 include/linux/efi.h   |  3 ++-
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index e991cccdb6e9..1e8bc6cc1e12 100644
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
index 4b27519143f5..98598bd1d2fa 100644
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

