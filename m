Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E7C37EB47
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbhELTXz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 15:23:55 -0400
Received: from mail-dm6nam12on2138.outbound.protection.outlook.com ([40.107.243.138]:63361
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348916AbhELRjn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 13:39:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0X4arHEliW0gMUzSuOP2jDYSiQiEFL/XsmdzzBRFv5NzS/52YdFN2gLLW0YwxJVcaZPTzE/eLtrA79M5Exzbouo1wPXv4qF/kuU+5OQrZAo0m5cJJXCYkqZ2Icy6xNftUYnoVwXuHRihEqE80QKOyCVYxcyJjDQi+qZovNvN8LaFhhFgpuwhEW1tQIwCS4XFLdAOZb0ZU0cTBIvNI6xCVFJqhFN1OXfaIT5Nvef6J7i1pPoOpGMG2ORI90ky1JTeWarg98Sx032wGg7TTBBGUpFF/c9+4mfNqTkU6fcnatfZWxaZyds0cpXXWKVwZWu9B4W3gjQo7Ma3jKsOykSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOFtTvVdAPoQYxAu5wckDjgjGdJnlvSVdvj0HU35bJA=;
 b=TJkMT4PZYxDDQgCq22T6gYMjAQ3FsxBGa8ddjBA65OVA+HeigrJ6H1CSm4NXL4PEugSePz9NVWmR+vNNbexM6+/Lo62pyayomTwL28INs4V8qu/ktQcajcsfifhpwWIo9VYyd8QMoaXmP2S2DTvhEfraxxRCrMgAEMEO/Wueh1SvfoF0gHGkxN70+Yuhy2OCrDUtnCSzp44u2BOhlsxpqp6DdUDecF3FiICRMZmJ4HTDUqcdDq5b/g6sge+T9At2DWcF9yIskUnzH29z0pvKnx0TIdtv9BT6j4EHw9pgkpoN3CSrVi+qg+J20PMlZIzyLaq0BWAZryUAyDQzfB30dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOFtTvVdAPoQYxAu5wckDjgjGdJnlvSVdvj0HU35bJA=;
 b=h3jTSynH/zN0vqSpENcurjM6jPIKI4mDj4qyDl/lccj8oqAdsAyBaXJvxhz2P9hRZVMHRQi5CVHI403bE133fnIm2infzjcr6F9763e7Yq2+JqhYi9PrlLzITUfUagm3oEZcuEn+9icSh+GcCkHk+eOQjdSdKXTea6ziMYkAuKI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1483.namprd21.prod.outlook.com (2603:10b6:5:25c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.5; Wed, 12 May
 2021 17:38:28 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%5]) with mapi id 15.20.4150.011; Wed, 12 May 2021
 17:38:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v10 1/7] asm-generic: hyperv: Fix incorrect architecture dependencies
Date:   Wed, 12 May 2021 10:37:41 -0700
Message-Id: <1620841067-46606-2-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.1.144) by CO2PR04CA0102.namprd04.prod.outlook.com (2603:10b6:104:6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 17:38:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b1c32b8-ba6f-4742-dfac-08d9156cc07d
X-MS-TrafficTypeDiagnostic: DM6PR21MB1483:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR21MB148356D554155C3E10E341FFD7529@DM6PR21MB1483.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrhoLd9OwqUhFewwQ7VQtApqK/hzbKF8vVjXb0zyHI3asuU/8KZu4FxcuwE531iW9v1nixMG9u0QsGlsYkruxYerPpqHhgteqJHAT0BgkqDY4TIRg1t1BWFfjLGf3upGTfFsSdTopkBxziN0UnUMxhWfU6wJhklWK6vvhu1USoBbv5b+8NwQhYhxdoVI4KM1Z/Nda7PeDDefKZxBCbgFW8tK3N05s2pFKS0OaJeWsPQlhWnHvp4iu9zWSHKIh/AzPyxVxL1AH8oGpM1Dzzc4QzgSrEqqRl2MXotl9/V/6rWY5pWWIHcOIf518Q/pqu464G+KE0AFhR9raGy9YzTubDdj3noSuVzFejsM7pwzcjkmMFQyiI3luu4pxJQTZ57N1Xk/fo5vp1VwVMmO8FpAREYV+u0WpPsZOprLh9QILHcI03vsWZz5cqCKantf7Wnk46olnW6fWZNye+LSDKVJ9J13S7LULeqNFUvjbNpK91Nd2HI4f9A1RjWL+vujphO6QiJKD28GwmBVAnSZ+IVBDex9RkBKCgT6YRTdPsNQbvkFVkcCnCV6dH4r+Xkm0MtyTK0Es5zi22Gi4uMfjOZpyOHvm/84rQgTV4jGRFqBXUbglws7/jaJfNwC2FnriHAUEac/uLARCkAe/ym308q7XdPYdx2EztV8DO8hc3yE2aIvrWJbPXl/14IvYMimyhGE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6636002)(316002)(478600001)(8676002)(86362001)(66556008)(921005)(16526019)(10290500003)(7696005)(52116002)(7416002)(2906002)(186003)(66476007)(4326008)(82960400001)(2616005)(82950400001)(956004)(66946007)(6486002)(6666004)(38100700002)(38350700002)(5660300002)(107886003)(36756003)(26005)(83380400001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j2X+bKhSzleFXJp757pZ1UpeY2FyW1mmK2VtZ3lwzGEpxrK3PuX5XLODYKyo?=
 =?us-ascii?Q?L6xf1pikyqLCQPlN6oeDlD037HgCBrjAx9jRgoXL9WyjZqVLAPUzd/RM7Exe?=
 =?us-ascii?Q?1WvMPLAKUobLfiN9m6wKUR152zf1LQwqpzCaISUYYx7jMh4NEJEHNh9YSAST?=
 =?us-ascii?Q?OaH0gTjrVuWRcUAV5KRfHu3r2caNmdCJDUMRdocI8WF10kQJ5ywBDyduEYG7?=
 =?us-ascii?Q?Ob0CTBguI3NT/0OAhLLfSmp5VWtLab8+3TXb/Q0RvEXwRZNIGAzGFrogoe6g?=
 =?us-ascii?Q?S4yf3DIoJg4JI12QkBD8bMPnCqyNZAUmTDGWVsANGDgX69MsQyBhk0Y/2O7J?=
 =?us-ascii?Q?CeiU2D7WHhM7i51PIyuObulaerWXxpgQkTadQI+MNaEgt/JFat6uX/cO3r87?=
 =?us-ascii?Q?oflEjj++oqpRa91eHzUxS0MDNvNtpWhNbYynilB1xR2MercrzqMQERYWQt9T?=
 =?us-ascii?Q?MiwcxWVQz0Jtetpk7e4Gl3giL0T2ZAc/NaoKskzfvu245PD5qA5tEc4MA6i/?=
 =?us-ascii?Q?Lv5po4hK0ZpjfaLFaH0rk8CIaPP6R8HB9yxCtWQKG9DC0aMVEqvo8zRVmv5Q?=
 =?us-ascii?Q?7+gXK0qX3lR5EMtwN17CvvrhLj0ZZ9z+u0vynCBzLggrxmQOuyd8zgr/Yx7O?=
 =?us-ascii?Q?WXvDbmMDJIH1UABKuFc67Aywwy70f2WX5/ZlcPzrEXCPZ6W0UGui4Kw+Y7gH?=
 =?us-ascii?Q?DywZ4bY78YqMLlsHyPSNcxPOFFlC5HpXmIaq9EdR52rN54QTEeXIl1M024b5?=
 =?us-ascii?Q?A9L+oMUAPnWzhVkPcJF2ZhYnxebDW+Me8T7tCbf4RECUZHMOcVynMjq0GpAV?=
 =?us-ascii?Q?3Bfe9tej26wir7MFwbV4HSkkfAf10wtjAYjWAGSzm/2Ltej8Bqf8aWApNHOS?=
 =?us-ascii?Q?hrIXywfgpOElHi87l3gjNhf5UKuHyN4NAtXWDWVMI+0MZG3jWmbbSt8QsDqT?=
 =?us-ascii?Q?NcPiMeyPVBreN9b543f3Zn2w6eoJHyMfKzVhC02r?=
X-MS-Exchange-AntiSpam-MessageData-1: 5JiYXywbWQMkBk0Hf9gMgTJuaKvDggquAVy68aYG0r849yrjBYiHic93wXXzy8qDgq9aklU1yd9oY+RV7aTSaLNo6IUpooXs1Ggexiw7lGDjnrUqNEtBiJI0KetORl0GpQeivlQpP4vBT/+S2BUjXVQZGwGL17kPLRpFu/fylZ8as7pKEQhti8suPl+d95wg+lOUlDfsq1VmcuvYXzd/H1pi/UIhmGgkGUkeP9VfuTnAm1DG7jQmlv7yFK3CAolQBsxmx7KX/ga/MUpZF5P5vVmBPAC+ub2tHJ+jpllNrYav7SuQakoEjjJLg+OXvTezC958Nazvz3cKGYThGmwpQK1r
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1c32b8-ba6f-4742-dfac-08d9156cc07d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:38:28.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6eTdiZb29W9x2v7+UsXH0Bv/V+7FVEbZDShmbHLvoldQLy/FVh3FzzXqO6mYKUMuwnmn6FDvgw6ZWea1JRhzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1483
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the declaration of hv_root_partition and hyperv_pcpu_input_arg
from the x86-specific mshyperv.h to the arch independent mshyperv.h
since they are used by arch independent code.  While here, add a
missing #include needed to compile correctly on ARM64.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 3 ---
 include/asm-generic/mshyperv.h  | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 67ff0d6..45c48b0 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -36,7 +36,6 @@ static inline u64 hv_get_register(unsigned int reg)
 extern int hyperv_init_cpuhp;
 
 extern void *hv_hypercall_pg;
-extern void  __percpu  **hyperv_pcpu_input_arg;
 extern void  __percpu  **hyperv_pcpu_output_arg;
 
 extern u64 hv_current_partition_id;
@@ -170,8 +169,6 @@ int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
 
-extern bool hv_root_partition;
-
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9a000ba..22c92b8 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -22,6 +22,7 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/cpumask.h>
+#include <linux/nmi.h>
 #include <asm/ptrace.h>
 #include <asm/hyperv-tlfs.h>
 
@@ -151,6 +152,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 extern int vmbus_interrupt;
 extern int vmbus_irq;
 
+extern bool hv_root_partition;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
  * Hypervisor's notion of virtual processor ID is different from
@@ -161,6 +164,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 extern u32 *hv_vp_index;
 extern u32 hv_max_vp_index;
 
+extern void  __percpu  **hyperv_pcpu_input_arg;
+
 /* Sentinel value for an uninitialized entry in hv_vp_index array */
 #define VP_INVAL	U32_MAX
 
-- 
1.8.3.1

