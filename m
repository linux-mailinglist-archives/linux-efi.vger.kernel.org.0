Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130446545F7
	for <lists+linux-efi@lfdr.de>; Thu, 22 Dec 2022 19:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiLVSar (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Dec 2022 13:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLVSao (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Dec 2022 13:30:44 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79F9DD;
        Thu, 22 Dec 2022 10:30:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frerjaMUG6s9VP3xjbuhhqPGMTDWO5qA0V3uQ3Z7tFJt1q0YWz504dA58+90VgD/L/YZRb46hfWVTH2TlT6vRCAcHXKzkwCz4GhkGJUDoQNLKXJPbE+irXiLUKxUVV2LHPrbOvruWeYIydf4luvhgOdgkqbJ/6SieoA+z2slVgErbdRh3owQlm0fBnRTAdhTHy9gtPFgW4HAgKgI/GhIv8GCMN1Ll9F9RtmOYKPYn6fmFltqO8SR3grQ80+BtDX3YzVpL8CdtzIib3086ghGwqD2N8HKcwcXNr+2FJZSwVdgzy66rE5pbOWuMdhhLeflnETkB1gMcm8fz5oPGJJPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq0e4oNG7njf83chmhbaJQI5EkdxF2YMq4q3F2jEOl8=;
 b=RNHW+XMIqhtTt6OAkFuYYtE9/dendYY69O28Xquu1TEquOh1uSEvQ6ezttztwYCwrwvi7p529r0HCc+VP8xGtglOa+D7LbgaRxH8zHrHO3ieI2xXq+YiEhDKhn9oGU+8VSQEinUY52v/vqec2SN/+t4Lz3zyZ99wOJmH/qiMX8yAjPmsFZYh6OlGYmnSwFvNVCR8YkOaSkkzr+aYLrSgormT4NlbSkJAZayHPs0YF4AB8oXmFIkzVsMfLGQBxdTgVQL/+U1PmBc5KXiV3seBxu2v3Mc1CNy1wBBFyvhZPjknTd5QiYrk9MOuKFBI97eDUUs8BtJ+oq44KVQAx4HthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq0e4oNG7njf83chmhbaJQI5EkdxF2YMq4q3F2jEOl8=;
 b=4bOL74HnQm0A/DIZhUq11En6VsVVkpPd51C91CbvaaGhmq3lFv6rbHAoDjYWitCbgJ5rgcA1spz8P40C03zt0HToKGq193+8JkHiRz2BEO83JHcwARUUaUkoygBc8JFo6M8Wo51Z8NBSQe3eeuqeQUyin357Wv1g6xJQOgeMwRA=
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 18:30:37 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::52) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Thu, 22 Dec 2022 18:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Thu, 22 Dec 2022 18:30:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 12:30:35 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Carlos Soriano Sanchez <csoriano@redhat.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        "David Airlie" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] firmware: sysfb: Allow re-creating system framebuffer after init
Date:   Thu, 22 Dec 2022 12:30:10 -0600
Message-ID: <20221222183012.1046-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222183012.1046-1-mario.limonciello@amd.com>
References: <20221222183012.1046-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: bc03415b-680c-4e48-9429-08dae44a9f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vr7gvCWJrfY0+6h1S8mXJpSBMhS/Drt9Xd5d178LrkUbfG0V7ZnpAC9Xl3Yyf/rq6OJKO4eCZbZT9HZI9KE6moMJt0eVeWPQAEI7FiYCLxi6xIAy5ogkhrFPM739bDYs/d0G5fVSukAFg4bd21dAiXL1GZ6gieFKvlOI0mmuSViBudJeqBWUoP9t2TlPWjcu9Fgv23BdNAgPHqCtNSckUTmc1KRoXu5ZZGm9Y4HdR7tpalxgZ04RCpqvaVGWQdy1gmvuUeKX7dWL2mwYWnN6vP5yYlGBM/aNtwLxwVJI4bWtPuue6cj1owdCJK2P4RrAWbRUb7HxlfdIVX/mb2LN7lQgWqr0km7pQL9NGgf6NhY1kKyE00UuThkfQOJD5umFDInjs+qB+Jwcmth873XWoBKAC86MXkjMWHJfcmjxNsrzpZHTFGN1F/HXKOQLF4FFSpMa/ivEkr4fLMGfHe1hXadZcP/d7/Fvq2nKWr5k/ebITHthtqyoC9SdDhgszGKJe0wYLOcvBeU+mwvjCzdrypq4ncP3cQ7N3U3LKJTFsqLIcoePlMOkTEUmYbQ8qPqE1wpIQY9PC/RB+3eloN22li+uaBSjhEMLs6Q9NjdcxGfXPKbEvRT1YW6YAVOSI9zdJ7oo/1GcZfvgHxsEjSluqfTOb4y8yrV2S0sf3clh9qo0VmnKQR6BOk8ixgcjhw7JQhFeJI5becfZLoM5mX4a7f06HE+ZSexf4MlSnSs2E14=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(6666004)(478600001)(66899015)(7696005)(70206006)(70586007)(316002)(40480700001)(2616005)(16526019)(26005)(186003)(110136005)(86362001)(54906003)(1076003)(8676002)(4326008)(2906002)(44832011)(81166007)(336012)(41300700001)(47076005)(83380400001)(426003)(5660300002)(356005)(82740400003)(36860700001)(82310400005)(8936002)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 18:30:37.1833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc03415b-680c-4e48-9429-08dae44a9f0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When GPU kernel drivers have failed to load for any reason the
current experience is that the screen is frozen.  This is because
one of the first things that these drivers do is to call `sysfb_disable`.

For end users this is quite jarring and hard to recover from.  Allow
drivers to request the framebuffer to be re-created for a failure cleanup.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/firmware/efi/sysfb_efi.c  |  6 +++---
 drivers/firmware/sysfb.c          | 15 ++++++++++++++-
 drivers/firmware/sysfb_simplefb.c |  4 ++--
 include/linux/sysfb.h             |  5 +++++
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 7882d4b3f2be..a890cb6d44fa 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -185,7 +185,7 @@ static int __init efifb_set_system(const struct dmi_system_id *id)
 		&efifb_dmi_list[enumid]				\
 	}
 
-static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
+static const struct dmi_system_id efifb_dmi_system_table[] = {
 	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac4,1", M_I17),
 	/* At least one of these two will be right; maybe both? */
 	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac5,1", M_I20),
@@ -235,7 +235,7 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
  * pitch). We simply swap width and height for these devices so that we can
  * correctly deal with some of them coming with multiple resolutions.
  */
-static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
+static const struct dmi_system_id efifb_dmi_swap_width_height[] = {
 	{
 		/*
 		 * Lenovo MIIX310-10ICR, only some batches have the troublesome
@@ -333,7 +333,7 @@ static const struct fwnode_operations efifb_fwnode_ops = {
 #ifdef CONFIG_EFI
 static struct fwnode_handle efifb_fwnode;
 
-__init void sysfb_apply_efi_quirks(struct platform_device *pd)
+void sysfb_apply_efi_quirks(struct platform_device *pd)
 {
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
 	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 3fd3563d962b..7f2254bd2071 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -69,7 +69,7 @@ void sysfb_disable(void)
 }
 EXPORT_SYMBOL_GPL(sysfb_disable);
 
-static __init int sysfb_init(void)
+static int sysfb_init(void)
 {
 	struct screen_info *si = &screen_info;
 	struct simplefb_platform_data mode;
@@ -124,6 +124,19 @@ static __init int sysfb_init(void)
 	mutex_unlock(&disable_lock);
 	return ret;
 }
+/**
+ * sysfb_enable() - re-enable the Generic System Framebuffers support
+ *
+ * This causes the system framebuffer initialization to be re-run.
+ * It is intended to be called by DRM drivers that failed probe for cleanup.
+ *
+ */
+int sysfb_enable(void)
+{
+	disabled = false;
+	return sysfb_init();
+}
+EXPORT_SYMBOL_GPL(sysfb_enable);
 
 /* must execute after PCI subsystem for EFI quirks */
 device_initcall(sysfb_init);
diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index a353e27f83f5..82735ff81191 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -24,7 +24,7 @@ static const char simplefb_resname[] = "BOOTFB";
 static const struct simplefb_format formats[] = SIMPLEFB_FORMATS;
 
 /* try parsing screen_info into a simple-framebuffer mode struct */
-__init bool sysfb_parse_mode(const struct screen_info *si,
+bool sysfb_parse_mode(const struct screen_info *si,
 			     struct simplefb_platform_data *mode)
 {
 	const struct simplefb_format *f;
@@ -57,7 +57,7 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 	return false;
 }
 
-__init struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
+struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
 						     const struct simplefb_platform_data *mode)
 {
 	struct platform_device *pd;
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index 8ba8b5be5567..14d447576e57 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -58,6 +58,7 @@ struct efifb_dmi_info {
 #ifdef CONFIG_SYSFB
 
 void sysfb_disable(void);
+int sysfb_enable(void);
 
 #else /* CONFIG_SYSFB */
 
@@ -65,6 +66,10 @@ static inline void sysfb_disable(void)
 {
 }
 
+static int sysfb_enable(void)
+{
+}
+
 #endif /* CONFIG_SYSFB */
 
 #ifdef CONFIG_EFI
-- 
2.34.1

