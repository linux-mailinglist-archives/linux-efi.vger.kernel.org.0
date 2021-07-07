Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119EF3BEE02
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhGGSTI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:08 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:17601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231622AbhGGSSx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ9BNAcAXBVK4604AyGc+OQABXIIDveAe4Nxbrap/T+lpNdeIkiqnz5YQkKQiao/Fi7MDLkugp6l6bUQj9sW3EAl5I4yus3jwunqsOSLhV3Z6OACz/TdAaQnNZot2Te15DittEG6I31flGEQW0wf17h5yG7W1M/bKSVL6h/Q9NiLidxhtkdgZeBGFZt1TTV5RmLHthomtfi2NhcmSBTuxQjikB8k4CbCjkYtD7eE6CJJEPkrngF8WPGP5UaK6bENQrwLvLMtd//J5UrgRnG71kQ5iONs+MQWf6CONOa2pjWMplXccoShNTVOS0GIaD01H4M9kgDzwNsL3+xEPzTOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKHWGmmrOFM6/pOcwpWAUoepIw5HeaBFOBYCQZOJYOs=;
 b=aDw5/NrxFm2vspLn7aHzIu0TPpMp7LbU+JS8WsuX4gx057jSuGgiqJnTjsZVSeCSNQBpoKOlhoVRfob3XYIniWy09wYaiWP93eSvGO84eiGMsU7tkBlbO8+ZSnqMDS4ljR2kVOVhIeKbNrQuE84wZpnonyGbGfG6PQMHyNYlLVLysUMZ51+efGFOISKlwEkkqp7cyY9Byyyc7qetJqIpRe5HZGn9L5I3oZInwLykSPl79JRCsZzcr7DamrwcEOZGFOiq68j9H2dRSopyMft5YnFUV6Vie0jYfnIStMGrcJbR5FTRTfgth6K07lNllSMj2GYshAfg/f18sY1wajYEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKHWGmmrOFM6/pOcwpWAUoepIw5HeaBFOBYCQZOJYOs=;
 b=c9jNIflm2vpHVJeTORdzCp1D7D1KeKo/UXAiScJHUQvGZjDM6F4Dmq4zxz1S8GlhQxGBRT4E4YVgEIM875EdNRCrIQeyA0d7ffzBBgWfT8m5TtyiiBKI4dsfRBaMkUrxXvmYiInCPc+D++Xk9GAG+8yNPa7FF5BRMSe6nSusXXk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4644.namprd12.prod.outlook.com (2603:10b6:a03:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 18:15:55 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:55 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v4 11/36] x86/sev: Register GHCB memory when SEV-SNP is active
Date:   Wed,  7 Jul 2021 13:14:41 -0500
Message-Id: <20210707181506.30489-12-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78d13c3b-c626-40ef-4186-08d9417342e7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4644B02F0E00D47456B2C5EEE51A9@BY5PR12MB4644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJhWkP8dMg8F2RVhhvpqAovyXMnrrlbmcjocb6VQy7nrWJVIr0MojNP80yEym0d8cFwFjF5Wn3Ww7p8BDQpCgjf5hnOQR7VqXVS9tOvkOVM50D8uklDk9PR4VxDAIelt1EqWadT7SD+lxWpG+otKDF8wGbqFVH+H33uCyjUDGBNr+N/FUTSee5MlHxe9JWknD+dXqXAI0M7tCl1ami/srunXMEB/SupoLdy6U4+jeL77QSy1V5M1MlTjMTG4PRtj90X6OQ4rGwPWXD61eU9/6yLXeOXZDFf1mhIPAbibOQRnpmJKirOgB5AVFISrjNGLsIl1d+ZcyQHvQCeNLpF8b3r9vxZJil4RjmbRN5ZEUDI24BLsJ7ihXmsBtOc2v0huwHyKyPBaUqLFwoZcmJWNgiDT/F2JDPLJt7okaTubFSM7e0NhH7Xay5yKyerRLrcS52EdjAb4H6HGcTs9yBxgZW0CjZZ/VAfUmgQUO1+BUmCvpGkPOj0seQZ0jGXlkoJJuQRM5ts1M2wqaV2ENu6t+jiwFj7tAwZ7QwKSmc/0g9FjAUfOc4gAwNi8Fko61XZADDInCO0Qb6kHlnVETHKX5waYf54SynNqnacKPQbM+rt22zhcWfgk6j2KCEImGul26jloZLVzovd1QXEESc1lGHpsIBMAhLj/KRqWRNjQoQGtStUuBBU+vbazAKtts6VJCO5Rru9s0K1v+jqhid+JFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(186003)(6666004)(2906002)(1076003)(4326008)(316002)(6486002)(7406005)(26005)(52116002)(7416002)(66556008)(8936002)(38350700002)(5660300002)(956004)(36756003)(38100700002)(478600001)(66476007)(44832011)(7696005)(2616005)(8676002)(66946007)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vz6u+h+ylX4ZhJWP1yBGV8wgsSumBe7oPbIQKSl+MD92hC2vKizU5arQ5CeU?=
 =?us-ascii?Q?cfjfX1VCyVZhNWZZmtxOvYJuUHgnbVq4svhpFNMPrHehQ0nrbGN+AAJiALxO?=
 =?us-ascii?Q?HYlk65hk0Fq5RzUKh25Q3JaLhcczuCBSm1Qw/l0cRAwxMVXiLdZDI/YTrQUj?=
 =?us-ascii?Q?qOHp1ZoEfmjhn3STnaFYsCGkhzXRUos97LACKjvMDeD1TabuHOyrlNx4wrXK?=
 =?us-ascii?Q?h9qK9dCAPfWoRRlfNpVogxFUMH9QiwkNcYvFCGkQ/MZs1+yFCiE6DnJqRnSY?=
 =?us-ascii?Q?UK2GhJOT0/y6dNo07EKd1zX8Pei3ZJRFqxnY+xCO1j9yEFSbgL+KUCSIFv/3?=
 =?us-ascii?Q?gDiQ90unoKbUe8e2uJzGm8aNcH3o0mns8exKH5xoyD8WXzIvXytM/2YrfN45?=
 =?us-ascii?Q?/gMnXKpTpv+cS0Bc0Fmz1ryBQFdAY91kayiNydgGERUMmjg9Pi9nSCDPvrX7?=
 =?us-ascii?Q?AI3o9O5Jt9YegWyOqxfZzyciomyKGukT/YgFKciA1RnHDF02RmM6XNluS21B?=
 =?us-ascii?Q?ZtcXDxFNLPeW1qeaOhXZMn5IQnEiGs0S/u3Q3iw5+WYLfrojSn0ob8k2uHvc?=
 =?us-ascii?Q?GAuP1WgHLBJKJY8JnS2Xzs5piZYZZvTU8L5bN3FvSlXvLOXCqqn6xMbPQuGu?=
 =?us-ascii?Q?V9JriIO715iKqejj/cYRaeHEKTwMVHxGPxVIDKwnPO9tLaTAu8m8AgwQ//h8?=
 =?us-ascii?Q?wwVQp9ZZUBXGqp/ziVyGrIRBgGAtSyCahDgvOLWoozeFAGVZ9q+S/uQoBUsg?=
 =?us-ascii?Q?ItQhXTbgunOlL5Zzvb52ywmYVmycD1NSjQnUqqIHyO6pQZQRDxSimSxU/Opc?=
 =?us-ascii?Q?BIBVJLDaf/dey80RhMqkxB0IXLzXqrUTCpC0fQPb44bc1LY3JyFk3amUDdMR?=
 =?us-ascii?Q?tqDfdYLTAPYdA6hXa/9pTjURnxR8Sfu1kNQz8LTe4UJuZQdWDnpCLBXCzZqt?=
 =?us-ascii?Q?Uxel+nd8hXnw9BVC1AVUMZTK8eIdSMHwQH1aaEQGB1Nbn4f6WlYzNGOELZTe?=
 =?us-ascii?Q?3Zw5E6oVnsvi23Rm4IgxD/u/9hJ7zqlD6MbHk3OD6HpYR2HkGk/RpxJxxlwO?=
 =?us-ascii?Q?JK76F9XeRw8lTEzSOF4gWesxk9bc6d7MRCI/oVs2H5HOGgwWaQcgkhV1FZl1?=
 =?us-ascii?Q?io3U71gKHbRhAZYECN4WN4M6iJDBViNE8Hzazjmun6oNvQab/WUldBPhUHCw?=
 =?us-ascii?Q?XyICO2fJ+WOlLfy2YJyyxEF3D6h3KU4D6MrpadqgdgmNMqlpOd2UWV7IZR4o?=
 =?us-ascii?Q?NF8xialj9QjtmgcXaTE9Bk1AGnC6Kdq2D0nW8dXwDgHqZHBJv5h2LW5U7pTn?=
 =?us-ascii?Q?ms/704ifJZCHY8ET9ywgT61Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d13c3b-c626-40ef-4186-08d9417342e7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:55.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4+vuxkNtcxu0CLcRzmoAG6blLEH1+i7d3RkAm0azy8DdWj0IDuxR4TuiLby3ClPRU3Xmpfgg9mXeYDYjZ7xpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4644
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP guest is required to perform GHCB GPA registration. This is
because the hypervisor may prefer that a guest use a consistent and/or
specific GPA for the GHCB associated with a vCPU. For more information,
see the GHCB specification section GHCB GPA Registration.

During the boot, init_ghcb() allocates a per-cpu GHCB page. On very first
VC exception, the exception handler switch to using the per-cpu GHCB page
allocated during the init_ghcb(). The GHCB page must be registered in
the current vcpu context.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev-internal.h | 12 ++++++++++++
 arch/x86/kernel/sev.c          | 29 +++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 arch/x86/kernel/sev-internal.h

diff --git a/arch/x86/kernel/sev-internal.h b/arch/x86/kernel/sev-internal.h
new file mode 100644
index 000000000000..0fb7324803b4
--- /dev/null
+++ b/arch/x86/kernel/sev-internal.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Forward declarations for sev-shared.c
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ */
+
+#ifndef __X86_SEV_INTERNAL_H__
+
+static void snp_register_ghcb_early(unsigned long paddr);
+
+#endif	/* __X86_SEV_INTERNAL_H__ */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 504169f1966b..c7ff60b55bde 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -31,6 +31,8 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 
+#include "sev-internal.h"
+
 #define DR7_RESET_VALUE        0x400
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
@@ -87,6 +89,13 @@ struct sev_es_runtime_data {
 	 * is currently unsupported in SEV-ES guests.
 	 */
 	unsigned long dr7;
+
+	/*
+	 * SEV-SNP requires that the GHCB must be registered before using it.
+	 * The flag below will indicate whether the GHCB is registered, if its
+	 * not registered then sev_es_get_ghcb() will perform the registration.
+	 */
+	bool snp_ghcb_registered;
 };
 
 struct ghcb_state {
@@ -194,6 +203,17 @@ void noinstr __sev_es_ist_exit(void)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
 }
 
+static void snp_register_ghcb(struct sev_es_runtime_data *data, unsigned long paddr)
+{
+	if (data->snp_ghcb_registered)
+		return;
+
+	snp_register_ghcb_early(paddr);
+
+	data->snp_ghcb_registered = true;
+}
+
+
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
@@ -240,6 +260,10 @@ static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 		data->ghcb_active = true;
 	}
 
+	/* SEV-SNP guest requires that GHCB must be registered. */
+	if (sev_feature_enabled(SEV_SNP))
+		snp_register_ghcb(data, __pa(ghcb));
+
 	return ghcb;
 }
 
@@ -684,6 +708,10 @@ static bool __init setup_ghcb(void)
 	/* Alright - Make the boot-ghcb public */
 	boot_ghcb = &boot_ghcb_page;
 
+	/* SEV-SNP guest requires that GHCB GPA must be registered. */
+	if (sev_feature_enabled(SEV_SNP))
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
@@ -773,6 +801,7 @@ static void __init init_ghcb(int cpu)
 
 	data->ghcb_active = false;
 	data->backup_ghcb_active = false;
+	data->snp_ghcb_registered = false;
 }
 
 void __init sev_es_init_vc_handling(void)
-- 
2.17.1

