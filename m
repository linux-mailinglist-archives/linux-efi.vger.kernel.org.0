Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C286B37EB4E
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 00:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhELTYJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 15:24:09 -0400
Received: from mail-dm6nam12on2138.outbound.protection.outlook.com ([40.107.243.138]:63361
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348935AbhELRjq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 13:39:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xihgg/Pp6FyQarAzURkku8x66cdUvJpeScNSDzd3mUI29HTIpMd1NdLDhngYGOLA3tBFZmVRonhyC4uksyIrGcj0sZpTef7O11Ulg2d7O1N7EneKx3DEUHNLs0Vza+YNiEidNxg82uLIyt+RIbgyKGqTDQKhSp10uMwIf0/XZRpNIW1qIAy0eOVbVjGtBw2v5yN9U5+bxRzmZZJwWCjwtz5SCmxZYlx5hGgSBuzxGghkQWsuHYPGv2d0e9+QcLgvsf6dJjV7qTTc6t/3KyNIx0RgusPL1nHZ2OKgwH08ZpooIyp+UqP1o331NtS8aKL++VndkxuIDX9eH9vOGaRmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT2Ypqct7f4vBCa8b8tJLDx27rUACwUFEiRcKXQ95Sg=;
 b=D8betxYkfPvnCaivBjDnWZlRqV5YkMuv7zL8ovNekbTrh0t8KX1Hy77o/8EysEaGp6WNZFyRQcD/3QvJIHGTsCvXURMUe1NUHzGkuRo+hmQdcUowR9Wz9XVGpoCIotffe3SrgDcoh04vxztpsU3JN6LtHUlHgpXgqpFPSK9RN4M3QMcyyEefFo65Uxiydmy9ICZvzh/VhnzfCBFidiwEMwucnQwbQfRyt5bkXjV1Z32S2bHyOYG68B8KbYHzpsPLl/LD2KVqcJz65HD0tzw3PZQJGsg21d4LEkF9CUFPeE7LqW5BepPtGknblNvC6Wsm7Y825ta0u64q3PZG8gbPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT2Ypqct7f4vBCa8b8tJLDx27rUACwUFEiRcKXQ95Sg=;
 b=EEhGfUa5mlVtGp48cdM5OYf4DE5GBRitbYNesxtgaZ9aEhdgQb5BkcibOInnX3Pht1ExzJbX8xtnfc+MMVW/o2kED6jvvykXe5YqBWDEpNo70ZREmYbyHPjYpT3xUOW7ijB0lEmnHLoFmrXrzREdENQEGXWbfKFRT2ScoPVsUco=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1483.namprd21.prod.outlook.com (2603:10b6:5:25c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.5; Wed, 12 May
 2021 17:38:34 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%5]) with mapi id 15.20.4150.011; Wed, 12 May 2021
 17:38:34 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v10 7/7] Drivers: hv: Enable Hyper-V code to be built on ARM64
Date:   Wed, 12 May 2021 10:37:47 -0700
Message-Id: <1620841067-46606-8-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.1.144]
X-ClientProxiedBy: CO2PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:104:6::28) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.1.144) by CO2PR04CA0102.namprd04.prod.outlook.com (2603:10b6:104:6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 17:38:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23cb3666-cc4b-4657-8290-08d9156cc44d
X-MS-TrafficTypeDiagnostic: DM6PR21MB1483:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR21MB148360014184D8D326340D06D7529@DM6PR21MB1483.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWBiJmvlLnQ9UJ4cOr9cmUErlbmicZq4SEmnvmAxbsrREWhz2ew45zwZdDYyZUMCP0Y7+4DN48YOT5FO5jp5wfCRzQZneljpKNOOhkgBDDSCEt+GUvE8lE20XKVhLM9NpF/rt6U1UOlhL3lkSVX+o4oAHyxAq7ZJT/RT7ks7I9BYB3Ri6+snGPzd9aXIZoBMPeHKXi1nWYGhjGQDKgIoF1RVAP3ChB3GYPkxYtgUD2F7YolWuIVGqae9LEGMIbL2vHFRGtdHhFLmnIJc3CCy3na3sPXCo31CiFGAqeXpDaiZz0D79jTSYmNtdeNoP3nzHXFPI8/JNe8xkjGhyWJabDihabRIuAjfMJp+n+78t1ei5Fcco9UzW74MTMmxDPU9jsMMVvPmVtQBVZjZezTdyMHYa4cj9ZghGxMXe+ltTeBZ2B+k42YDrJQd4rsJfwZqkxSg9KtiuQrzyHaTv1ZiwH+0gkEjDX/DRe0mM0e84AMxIa9C72UwkYyL1D8mgYiwk7rlXH8uYPvnTTk5i9YBxI6gj7LsI125BVphp45OoY4CZWyLInMAUIzzdO9vAJMnWDu8fWsyxCU1HHXbF0iRHn+5GBsOjuWt1PTJb/bBm2hrxVc0ZDf7t0kzfJ8rhyB3BpPtyAInEpHlCXLwgtAqKQfOw2kmVimXcJO8E1TosRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6636002)(316002)(478600001)(8676002)(86362001)(66556008)(921005)(16526019)(10290500003)(7696005)(52116002)(7416002)(2906002)(186003)(4744005)(66476007)(4326008)(82960400001)(2616005)(82950400001)(956004)(66946007)(6486002)(6666004)(38100700002)(38350700002)(5660300002)(107886003)(36756003)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t4ZwbJ2bGzR/lJ1lXszfSQOFHcAFR9QIQo7wUzCVvUgUu+KIrnk4MCKRGdT2?=
 =?us-ascii?Q?2Kq1y07GJId8BOlMlwOmz69fqJP/GBqE06yxi1BkpjMZId+S3//gqFh/gfaH?=
 =?us-ascii?Q?qgwdKH0cpWywWcU4Tb+er5/vnUBJHCW5pPviZPX48BwJCC+zhWt8pavv/jXy?=
 =?us-ascii?Q?2b6Xb4Z46fbc0VLDdz4LD3p8woI1b601RXXAt5xBpnnJIrIg+0k6bwIGhFMp?=
 =?us-ascii?Q?OuuEiciggocCj8vf6sIR57Jlq+fDXQovs+7S8gSnkAmtyHyc0bhI3YriJA6P?=
 =?us-ascii?Q?1xY5P//BBEOrHJqe3Pw172Ts37yp6IctISJevJomNriWyYuH6DHPd7nk+n5n?=
 =?us-ascii?Q?dJ8CwpXnDk6GiBR7B7jCMFO5+aU+UW3wi0PEaw4gsUhFlETiZknZ3iX65a7k?=
 =?us-ascii?Q?8TA15+pyVDQiEwF8a0Vw4SvWkO62oQLdz2uyteh72V9stjDWbkPoURih5pW0?=
 =?us-ascii?Q?enOzCQozpAWObT9I5SkUYrsJwVTGjsoQvKR8Uf84N3UWN55AFG9h6RPjQGBS?=
 =?us-ascii?Q?2tZAiewnxvZxf7wvihTmuK7l0c0ffY4/JJ6Vnc2rYP+TlhxSpoLyNua/LJ86?=
 =?us-ascii?Q?aC83a8stP3Zb7uDMS/KI3MrT4MRQoXG6zb86o+gQGbbJa+vbh7P0Tpo1eWjg?=
 =?us-ascii?Q?21FiTALjoFPH8KjE9LCoWPXlYnuAJyIGOqKqOGDgq/owfHzhw8MuQwYNHV3J?=
 =?us-ascii?Q?JtCA0MHnRG0cApg5ddDRpr1Pswnnj4GlHm2/wkN6D4tATOTE1TVUas2VSwg4?=
 =?us-ascii?Q?L140JusLvbR28KCuLC+qyVcct+DZeqj4blAHPD/AJU/yWJmsP7bRJqSXahm6?=
 =?us-ascii?Q?8tCXHlR5Wy/xLCNfupqMG7fHA/FAnWHprojmRHpsnUsNnCLRrViJwccEJA8F?=
 =?us-ascii?Q?spGljIQQmkbR5DLQ1L1A0W2H0EKsbR/SnvWeVCNcEyUHMuoI9IftTQx0dnCr?=
 =?us-ascii?Q?PHHl3OQ+ileBTfDwtjz5qc2jxXk+2EmeZNnOcKzc?=
X-MS-Exchange-AntiSpam-MessageData-1: 5c7qf4XUrlA5F6yEIChdoD9shYKIU35QAhvjQ4ofHdlgCTa17EBOyl1xgb68vJ6XWvW5cRz/OMeWFbunKqQC7w8sZkjBoE23f3WqgBuavVQHIShp6Pt0Ibnm5XyECmtXGEMj96NvKesr2k95lARcHV0ktua/XG+vHdkFhFCTX9aO/Lj0EHiRo9bmlTog10YRZhyR+zQ1jKZfWbXk6ifBHIUSSw1qHo2pIWYGXGvQXbm+oldJQ0dzqMFzP81n2UHpdoINVQeQ5TxfFJj7SCEOOFVkkPODrdVHoW+PlSjJ1GT1ziE45u60DyLLL4ORosYvttLtx2mCniSbWAfNSHSDtFHi
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cb3666-cc4b-4657-8290-08d9156cc44d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:38:34.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVype/z9wW7HClirB3YOJLOf7RzDCalfohQDuk8NWOgi0PRO8AgMUCfcziN+4rF/Rgr8ygCcKPGKV3mywIdf0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1483
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
ARM64, causing the Hyper-V specific code to be built.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 drivers/hv/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 66c794d..efb7585 100644
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

