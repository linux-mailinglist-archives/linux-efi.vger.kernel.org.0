Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2053F2EE2
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbhHTPWH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:07 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:40033
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241121AbhHTPV5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iywTcCqj8/5Sh1v94g4BXO74+6OR51rFjlCXMp6wvnP7DxK2ZAG2DziJJdFcuZzjrRSnJu6SQSDMJxkGSpocIMsh7lqtSBzaXHZKs9zEQOcw/Wz2g7P/A3xSI7m1XyQcSEsBCPW2dOCJ6X8u7RB4Te2r3tf7mSZisG9SA8nZChSvER2jLqy3y40kRW6ztyhmcaV2ixellUupxEiTE7+EhQOGVNvHwPMzI/yGLcQtKmeYmJx6c1YnwUjUgfLwASvEbTP83oajlF7MQPZCO3PL3dFE8UF78A9NXOWufPBAcB9FUjYmzMvOCh777aP4QyUc8jpfsgPCbw270lbQ6SgV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKyQ+gWQfBbI3I9S3HR4XseBcat27P14nxDmfzCS4nI=;
 b=XFIHaqhy72eiXe9BiDWoxZeAD5qAk70KeZBgQJWxO9sRPPHnFaYw5CICRhpNIfMXd5CoLCXJ126uTPP+nChVllBbdotD2SyZo60IbPhJQn6Hr2Z+5Q3+h3KxFdeMrlS1L0IIE10ZjYdfCxNW/Yet30oUao8Jm3+R8dex289BGxoPfNX9VG7ms+F6BYtFIgd4ZeyGQ+dtmzPkXE39w/K700fVwb9yeurRtbqaqOprZoHWPlFrYdRUIxiqUk8+x5ErkPKDdYSxHiE6DGp6SkxF6lXZL4CKfJju+nHGdlGJ0F6R+3ppcxDC2j0bToQ3eabiPRzZJoYFwsFSQal7/OL0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKyQ+gWQfBbI3I9S3HR4XseBcat27P14nxDmfzCS4nI=;
 b=vrXGEYZfl3zP7fv12pjMcoNsJauXH48QZC53tS4g/esBFPMA9SrOHtQW/KNrWeNo1zwLBLFIMA0FKBAowsRq+qi8lEhMWsb01QYG13lHsxp3BjQ9uLx+qd0WPcFUAbwGO1q+CKRwBlTeImUqwv8XkVBUzcUa1PhuQHfAHkXAAEQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 15:21:04 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:04 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 13/38] x86/sev: Register GHCB memory when SEV-SNP is active
Date:   Fri, 20 Aug 2021 10:19:08 -0500
Message-Id: <20210820151933.22401-14-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 936d1282-b43f-40a3-87b1-08d963ee1ffe
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24461A1E01F5D5919CB72E4DE5C19@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30qxTmp0aGm7cNAQO0fY1xu4ByQy+Oydx+MUCUPrAQypsKqdmVJNmkSBhSJJPmLGQl6fH3AWLlfqQkfEj88wMpNQSErY0DLFG2+RBT/X107PBcGpyqIvVtYX01nDeHLsN/bXXif2UuESnJsu58vE0vlDsJJUuBaqS1dljuc60FgaxoKJn8hd46lQCF+a8LL7p7zgNnE3vS67mQtUMijII43jWabHx5mw9iA+ZsrduW8kjFThbzHiq2yNlyKHYUWNh9b9quwMjbBB4VaPsiQHjEccG9o/meg5hf58ars5gmEkVRiOyUEJtBzR6X4MvmDeCf+k5an2kEGfjfr+Bpi3eV3GxyWgLhW1ko1IZs4sohQv87+58U38tsvWhTmjTYCe+mJmp5l0OC0dPgLXtz7mQRnJ+HH59hs5ZmhrzfeKZhE5PmyZNIKdOtzpofiKXn38jr1hNkUYke44Ir+kfrpsBZ30X5NI+uiBwoFZIf3HlR2EgYT/ExG6qLhex7+UP2+MgH2XobcYOA6AJeoS5Le+nJpDP6jCEyEuZ8vwLBoEFn5wK3tUCCSlyQeB1MpkWEOgj+5eSP07qhOew8RVJoWUu1FAS9OQUC8CdO6M/pJAMF6Kchoz2/x6vasL3c1yhYmE0wfSXg7TVbchHjGDZF5SM31hlISwewUCXPWA0w2ZZECv1vr4n5YPgMGyrZXvvG7TsumQ7BUcRJ/EvlX58GG5DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(478600001)(54906003)(4326008)(1076003)(6486002)(7416002)(38350700002)(52116002)(2616005)(7696005)(38100700002)(8676002)(26005)(8936002)(2906002)(316002)(66946007)(86362001)(66476007)(44832011)(36756003)(956004)(5660300002)(7406005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQnMU7tp+LdRRr0ummxsFi/gZGY5CDhG31plA5NyorHMjAVzw5CdGHc8wEH0?=
 =?us-ascii?Q?v84rpElvxATEAlYKZ4L/dvjGjuMPJdLln47HZ90Acqyn+tBGSmcghAx2PZEL?=
 =?us-ascii?Q?lioST/kosCQdeDzx9eprDICd5aAL3/P73yM0GDJAmUkYNPQJS1NoML/drm9d?=
 =?us-ascii?Q?4KfPSlAVPP+e8iqs++ZKWErxRihOOVKKzAJ31CZC0AiMhNZxBPM/BrHFkuu2?=
 =?us-ascii?Q?GAyR+SyQXFsnPVbafbw53UuApzH7cIvivtnhZxK3uLuNRNEMukW0FeSM3bZ9?=
 =?us-ascii?Q?YyD0DKuC1DW3D77rMkhyjTQo8B601D9LDflxfrBiDZ36NAEq26ozcqSDmYe6?=
 =?us-ascii?Q?gUEf4VTw/vj6TBnKrgWciHfBstqLAcsR5NKTc1yeQUeHEdH7PiAkaOs0SOxd?=
 =?us-ascii?Q?SWwKwdRscZuXxO+X9vNXXWzvgvaMe0xUjXG3DnKpqPyAuq8qadGtajxG3WSy?=
 =?us-ascii?Q?y1GMd8kwL3RGT8HMv955ITnMIot9VbAPT4btzDyPh7FMyoZKu85XbtIfmANj?=
 =?us-ascii?Q?FV3eD9xCY0ZmLbpaglWhOjwSzEOmdPD7+SmzlseyMln8mclUn+wfoIE6QAJq?=
 =?us-ascii?Q?UYFvQXjv+FDieV6+AZSmKPtYLcSrFf7EskKqEDS7W3PuqK3VDb9xZzDg4DWR?=
 =?us-ascii?Q?5iFwWHLnLPfosTRITRWUkVO1164XTESuqbnTeA4A196yfkJMsywnSpFx3wM0?=
 =?us-ascii?Q?lla3ixJGf4OmlaPlEnS/1Hm0aYJDjHk6zB1NzeSTfHQbdS3TYsZ3x17YMFNa?=
 =?us-ascii?Q?PYyYGiRW0vDQH6TxrePVeGCHGEOsSFHih8H3h0YCCuPt6GPq7YZ3XV9Hiu+i?=
 =?us-ascii?Q?qk0LRFbkShU+WCkffg934A156h+Z3nqL9GqZr+0WkTAwhUebbsQr+ltNENtG?=
 =?us-ascii?Q?stB/zvuYH1bE0Q/qxuxBWJDrp9h74nunPSJrCfD0n0uO6quBu8Oqf+VpzDwh?=
 =?us-ascii?Q?JpEQPpPekLHJycpjrZFWzerlO2hy0tO5NS1XA0sdNrXi1HOFc6eQNoEVT2fk?=
 =?us-ascii?Q?QfQCFuYvwxtUifhAEr38O2zaVJZehm1gZi3vQ6e0YLuXS3FzYPbphLrfv8NG?=
 =?us-ascii?Q?tXkF7BtHyhj4Pf23YTpYKYYytNkpDXeNiVtIIq3iB4+jH/pKj9sLT8+nCLX+?=
 =?us-ascii?Q?kSs20kUK3sal38orJayEIPKJ8eK/LEYvw9fXo/JlAFqqvoHVY/snmSYUqDj/?=
 =?us-ascii?Q?WI4FAJiLibtqVQarVHaR/oUEeolJcc/ouyYvz9YODkDDhBq8/qY/MqTSB8pB?=
 =?us-ascii?Q?cCD9G32Lj8LAmeWJKH/Qfw7VX1OjL5eh2MLD6I0/rvnBgLbrKAXWdv4WzGMz?=
 =?us-ascii?Q?8gSzi8p1p0kcFkooPPnRck4Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936d1282-b43f-40a3-87b1-08d963ee1ffe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:04.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLAJACpIXEDWgxYhduRFrIWMASu+CBzZ/AJlFYcuC4RXt+5XYkIJ8ZqTIeXFskvA+3R0n+61xGCXl8ennViplg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
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
 arch/x86/kernel/sev.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
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
index 06e6914cdc26..9ab541b893c2 100644
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
@@ -191,6 +200,16 @@ void noinstr __sev_es_ist_exit(void)
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
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
@@ -237,6 +256,10 @@ static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 		data->ghcb_active = true;
 	}
 
+	/* SEV-SNP guest requires that GHCB must be registered. */
+	if (sev_feature_enabled(SEV_SNP))
+		snp_register_ghcb(data, __pa(ghcb));
+
 	return ghcb;
 }
 
@@ -681,6 +704,10 @@ static bool __init setup_ghcb(void)
 	/* Alright - Make the boot-ghcb public */
 	boot_ghcb = &boot_ghcb_page;
 
+	/* SEV-SNP guest requires that GHCB GPA must be registered. */
+	if (sev_feature_enabled(SEV_SNP))
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
@@ -770,6 +797,7 @@ static void __init init_ghcb(int cpu)
 
 	data->ghcb_active = false;
 	data->backup_ghcb_active = false;
+	data->snp_ghcb_registered = false;
 }
 
 void __init sev_es_init_vc_handling(void)
-- 
2.17.1

