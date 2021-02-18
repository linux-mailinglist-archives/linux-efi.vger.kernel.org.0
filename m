Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053B531F2F3
	for <lists+linux-efi@lfdr.de>; Fri, 19 Feb 2021 00:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBRXTn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Feb 2021 18:19:43 -0500
Received: from mail-bn8nam12on2094.outbound.protection.outlook.com ([40.107.237.94]:21217
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230153AbhBRXTN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Feb 2021 18:19:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxlqAVBcEvfQILMZK0UzjCwBlE7n2tIEqqE1jeXppFcv5Ho0B2cQp3b1foyGyGaNJMpWxbQ9S+8M8fcCFajbFPChLPNN5Lb9wYfzD7nxg7unuBaWPwStJmhCwKZeAjWWBpP52A6xOO7XjdcDUGe43QozDi7VLkSK3FF6lZF+YhkIY8IV+adsVierHzTTp2teg1XINf5hG5HB4fwhtsV6mxBXAbsC/EFXk/CYa9pnbdpl2PHk3JZpctkYN0/3KHz2DItpZXy+7qD0zNZ3rWBHY01mukvbADhtipcL/YM9irAq0zhcPXp4rB7ESgANblfF3+XG++OitGld6Bdb4z+XXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX2YfZSNfDt7JSiF+T/PKQhM6vi/KAM95w7ItZAcaOw=;
 b=QXMfD6KytQ9HjauJcdaWYvqUNUH9mVkMOd+wK4Q4mYMf7Tr+J5z/9TwFE3Ju230Gs5Js/dLEiq5fLAO4Y4pyCCpSu2bU7uwd5BZQH4YxtycN3esXM9UJP8pVNrvssLlfr7f64Ve5qU9aT3nPEfx+2BLIEQY1C4XNGA/HvK8ia5rFrvJ491FkX78yUOQfH9wPP7KYGTQHqApBpm+gIGaKnbAiH2Tl/mdfCsqphChUL+iJ78YYBogGmmTDY6JuV2kvVUtLuC6fx/ZJEWCecOLxDBpxJrN3r8TqmW2t+6+dDSw8Th8GOavl7MPtuS8u8nDq7/Q7la0BWWBptkb6RKOEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX2YfZSNfDt7JSiF+T/PKQhM6vi/KAM95w7ItZAcaOw=;
 b=BOa4JIRSbBIL+5isnf03oDxI6CD97xBLEO5RW/oKbmfjhzGC51Z9rQVzWvtWRx5y+lRH1Sf0tx6c4hZXO2kJJ/S2bH6/sLLX7qkDqO9S2CNkqq8IJs5NYkTeAddqURXMKOUqt2lcPLHU88JevL+Yiuw2vc0kf0D+isDFfea6aUM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:5:22d::11) by
 DM5PR2101MB0983.namprd21.prod.outlook.com (2603:10b6:4:a8::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.1; Thu, 18 Feb 2021 23:17:34 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%5]) with mapi id 15.20.3890.002; Thu, 18 Feb 2021
 23:17:34 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v8 6/6] Drivers: hv: Enable Hyper-V code to be built on ARM64
Date:   Thu, 18 Feb 2021 15:16:34 -0800
Message-Id: <1613690194-102905-7-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
References: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.147.144]
X-ClientProxiedBy: MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27)
 To DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.144) by MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 23:17:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 819c7ccf-fcee-44e8-7ca8-08d8d4635fc9
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0983:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0983A421AAE084E6A498329BD7859@DM5PR2101MB0983.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiCWgA5SSV1Phi3qN9GWrdQuaKoDwKY0OBYO/ZxL9dj6Cna86jnWPBCWOsbPDgBy7lJzRlIK5G36E/469kCCs3ARcF7alTnimWIehqJSMZwm5cade2FmlEbUanlaxR8dYYzPnipWfDtSzCkQraCK/8keUyMpGoWMRSTBKSnH/U9NWI9Pf2+XzTvho+G4ouZf/w4//9cu5cEJfZQjUPPsYxGnEtSE4RIDZ6FYBJyznqj9BjyWjqyMsVDC5McwWRxt1W2Bwqr/u9zXVp96NSo8itjHoT49x5lWt1CSIu83Ein4xli5L7uC7XASr4vA6OpdFm88aa5fSNX82WkLr7PRUQlrERc3OGDtB/MEG69OjqQKBF4EV3EbuVncWb3RTRQqHGRqs8YT8tS3lNrE2bLTv/Ck24k13Gi5Hqr36JA6EkhAiKl2OC1F/IIIRmWbdHkEXoEDtEa+revi1MwX9uh087ZLcHBIBbEasiB6ZKppUcPalNpWdCDo/5c1VbZvVlmwk9Xf9QhYRLd8V036dgBHlv8LCObCk9fDM1a1rp0CCZOdBxd/c3i73Eo8Y121KLPS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(5660300002)(6486002)(921005)(107886003)(8676002)(7416002)(82950400001)(2616005)(4326008)(66476007)(478600001)(2906002)(83380400001)(36756003)(186003)(66556008)(6636002)(66946007)(86362001)(10290500003)(956004)(16526019)(26005)(4744005)(82960400001)(8936002)(52116002)(7696005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B74bl6yUBl5fcUwJQJRJoc5G85Kw8Qn7/fg9m1OiLNsrSR9mRsdxWW/4VLqh?=
 =?us-ascii?Q?oPPrJpzvfrzFJLByoh+jSOZ2KrSwnzwWOBSXTEFC3AM7ugFMnPN6CibyUOFu?=
 =?us-ascii?Q?75VN5CqJCAJzDE5Rm2J8hT4eRBbO12WRf7LrvKrMTNulEdH3ZFeZzYNJOCyD?=
 =?us-ascii?Q?vKTiiJZiJq6wS19lNVqtdUFIgQQIstSx8p3f2uy9qa7dvNvYCjncVmRY8GUo?=
 =?us-ascii?Q?kC5Rb8Q6OEZncK9JAWcBa+yELHVlsfiLFvrTPNvrcZgHc2uJUQj8QvIpHZkG?=
 =?us-ascii?Q?OR1jg25pMilzGpJVHnQDVLg8osAOkqY/kyI+pa7pYygPhUdaZ5zk/J7f2dzK?=
 =?us-ascii?Q?DHEht8HA5vkZED7fzUZFpYtc7M16QS+4OWtyHVLodmQqL1gVLymoYQnDmRuF?=
 =?us-ascii?Q?vG6gcNt0BML0rhjWNRYXcHn66pjHkNbhCUI7rkoF7lFZFjWhY1s2w3Wn7Okh?=
 =?us-ascii?Q?zR9yyNsak0u3vGLH0ituVC894JuwHtiMrkqZWJXCp99I68oCd4pku6mMHuI3?=
 =?us-ascii?Q?y7dr+RBHkgNIskoQLbRCYDRwVhZLUHG9I/K8sXQVEpYZsmeE8DDkyZkOmcpB?=
 =?us-ascii?Q?/MjGJtCvSrkDWtjMSYSJ8eAF/1f7BIikqbiRqqJZdz0Jr2zoy97QtBleDmLb?=
 =?us-ascii?Q?P6Ko4wUnAcj3DadgrVuX9bUHVY8FrENRuHxE+rGDdJ860fCLKclf5L6cOdiX?=
 =?us-ascii?Q?PdSs5UjT0LSWcgRLpUrM7Kx2FHzDXDoASrkfqmIgjEN3IKlfgeFPpe41Le7G?=
 =?us-ascii?Q?yEHnNxRgblEd61dd5QK2C7ZeW6Rkx0MkJHdzpX1/ZSDJ5wb3uJWhPk7Cg5bg?=
 =?us-ascii?Q?nZhk6Vzhv0CuRsw4V5IC4TOlu2/rW4S+HvHF9dT5BH99VJTGYn1ZhP0KEuOb?=
 =?us-ascii?Q?DKrPtJYOce5u4TSjetXT/VaQTboHWHHNTNj4AXL0yhfMKJcxBAkC3DgzjlPm?=
 =?us-ascii?Q?1S89QiW9kaIvWPpHxI6UJdMxuMX/uoOFA/EKc75jMqb5giO0jQmz1BESU0UZ?=
 =?us-ascii?Q?oqjlIXhqafpQwqwu0r41PdiE5kjB2MEuR/opMYO3x3Xz3mqinswipF5tJkHC?=
 =?us-ascii?Q?LL5g2UL5iHSdauZDjEYKGiPvTisf1NPaRKp2CKPXdR4zASqMgNWLb3z//GQ9?=
 =?us-ascii?Q?IxRUC2mk+A1huXOKe0dSBtLK/K2xqkD3LrWr8YJgYNxBnkvppEeyGg8HnHBw?=
 =?us-ascii?Q?cUAgqxR5p5ucAKqy0uNknz23rToo7/KXKl4tcadG3JkB3ligP7r0whN/8Rqo?=
 =?us-ascii?Q?PtGL2Dcx2gQhEMcTfdPaTfLzlnTOknC5Z7v2NU6G/H3/G8zvOakVfx9FFt0j?=
 =?us-ascii?Q?Lp8fBc7di3/wYrVd0XQ8GTf3?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819c7ccf-fcee-44e8-7ca8-08d8d4635fc9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 23:17:34.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W29Jng/iSOibDvEHPm7M43RduaRTMP5JKdBiN+p/1n3kzy6RNATEzxvIE9lqafKpgDoOaXTrNM+GaLEKl2Bcdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
ARM64, causing the Hyper-V specific code to be built.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 79e5356..d492682 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
+		|| (ARM64 && !CPU_BIG_ENDIAN))
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR
 	help
-- 
1.8.3.1

