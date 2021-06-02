Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD002398B88
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFBOHU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:07:20 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:37216
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230406AbhFBOGq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:06:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXQcgK21VAARBbDTigV280jC5s0+nWgg00B8u0rKFNw+DhBAccjjJCg9DYtHXh2+/Sf2/3DkR4BlJgbIypYoAaYaatSksHpRybIM3k75iKZn08sv/vlLkxiO11DtNjPMJh5gQl862R9LtlT1Lit225Qw9J7L6XHz7ybUdUOW7EbqhlhsWHaRUUJ+fmXre023bdPHgfCdFkWgPfKp5M218TF3wuIxsXJ3SHyI+a6oNxQiatgcN3uWm9zWMITNn3WpjLkj5iSbGPWzR+bn6robfaInkMlUNhsP0vzBW5OoYKLmOqBitmQIi67vAVaFv33N4r4zxVv/+2pnXQpniv+veg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQz/NHTmBVURDJonopcz/LpLFbGaaQMHzzbDWbcW3f0=;
 b=e6o6C/NMnGCQHL+5vdVOx5axiqUyFz53NVQZrA0tFILXOBT69FeAngIXbCF2N1g9eDwDCD+R4I56p3c4LbLF5A5shlZGIqR4itcb1eNBrqZYZvXlLAVSn+06HYUIDak8Ho6+TQrWio2b/GXoZXjYKe5UnblM7ijR6luJXbZlcWBRTXQ9eO68LMMP/T88MMiesmD8Zx41tPuau8JlvxUX10CeWWGt4LgipG+v/FIxpfYmwW+iFGoWpL/zvpXPzzlvCa3K1zOA0qWh7ixVxBxQ/nUCA6wlGD/dJTY4ZgRT5oCsnYye2pe4yUpkyUeLpakyknvpkvafzKdelypksMxHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQz/NHTmBVURDJonopcz/LpLFbGaaQMHzzbDWbcW3f0=;
 b=vkmFTAbSrB6tjPi4ioTeh4rCblIJ5hOa9/eI072E5lNxvfLiLJB/V6Sb9dVXpVD7qIA0usCSaCok58N9uKY6nYczIVr+jJSga5/CyEEbsmtWUDrIgsa7Fw9aWkCEpFDy3qQbRq59tq0eI78OkuOSQdQ8bEpYHrJOwPyYL1T/U8g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 14:04:55 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:54 +0000
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v3 10/22] x86/sev: Register GHCB memory when SEV-SNP is active
Date:   Wed,  2 Jun 2021 09:04:04 -0500
Message-Id: <20210602140416.23573-11-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a9b085b-f7d2-4bc8-9958-08d925cf654f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27667E3D77406A3258C456EFE53D9@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYFphx7kRqM8A4EVlDE8Et4IJ+O8Lk9sHDq1WZ47vQgq7YUwN8XfgV610iWjvx+X1cuElbjlSt9n+Nvihf61A7pHP7W4l7OHNDORe3G+8Y5eg2tN8YKW9UUilxsP1fi0Wdbw2lmYqjRZxbXIkl2UNAcvMRvh2uWclHZoLm+pMtN/KV85yPgCwZSRhDNdMgkZ/SZlRzAuD8KGMrv5VmMEPHsj4MlOGxyASl+NwZ4dSrM0nKvsLJqm+1Mc/A8ovbPGBiY09ys/VdUppBbNF5DeCRj36KwKrxZtOjwHkTZG9Pl+qeklsc37Lm9oVA4pvyXnOZmkpR9UuKrC/iMXSTADI2QVvMogq9fTjWNYg0r/jHVZhukAIGwyLgcfi79Ku4uRqT4/EZn4Nb3+hf1r8HCjTdURYS7h4IhPDJfRJqalEHoTt+GR4LhjRTDohoEassrMFrXqr9jvkLfgcFZR9X3xpJbDhbM3R4ed0pht+0P2hWnBi4bRmvi15r0l2R+KQdsSeYgT6w9EBy0JKcyzAFKzDypshbY+Uw5I4HT9MYLRdP5g+nODeiXEoDym6r3XBjYE3jYoZC0FerxlI0+XIVFS+cuDJgcEDFtmZmW3AGtUtw3j19DaHDCPsS73UgIz5N84wmSTgHYlvUhFVLSP3xf1pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(6486002)(38350700002)(86362001)(66946007)(38100700002)(44832011)(52116002)(36756003)(8676002)(7416002)(26005)(4326008)(2616005)(1076003)(186003)(956004)(16526019)(2906002)(316002)(54906003)(6666004)(66476007)(478600001)(5660300002)(7696005)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OHBtE7DqUutSgqJY33ibzF0w3krYCY5jFUSu0a+wqCqw5COFjMGazijdE+/g?=
 =?us-ascii?Q?r5HSAK6qQbCBoPLQV4dSMJiXza3UaJE2hfuIlglW4fdHqWWlhnbgs4bvIZNM?=
 =?us-ascii?Q?VLeBd9I9k2wqSwQTrxgIbtVW133unjXMAexGgDM3q8MfOwXHsAw2KC/flEn5?=
 =?us-ascii?Q?WOtwDcmhIIqQOVs0LQ1cfJdUiTLDadnhajK26xnrBbJkPEAdAEcbvj6TuZFY?=
 =?us-ascii?Q?aRk/rEJFvPO8nwiZEU6bpviV0PF7IqRb8yKBnDiLalgO4KymjXR5IFKwykM6?=
 =?us-ascii?Q?5wspbUUnBtDGQcx5I8C3dasD2tVvlLs0t0iqwDaD8105t1nGaDAVlZETu5aM?=
 =?us-ascii?Q?gMdZNVioIucck84b0yxaK9iC5bTCqhDq4cFQ0jEXdTRWk4nhWSniagM0VSsH?=
 =?us-ascii?Q?u6AVTlcE6dpyLOsTzQn9dd5jqc37QHtRTQo2H6z4WUy3zYh6OTHHuYi1CU2N?=
 =?us-ascii?Q?/TwOPKP9r0ka6BxDipCAxy5Blh7drtu1kv7XyEQBKu8+mhHUSf7y9UmccY1G?=
 =?us-ascii?Q?nBsig+lQg/POas69c0rcr9VwILKJv6OLNWvNvfC+MnVoBiEOEdC6dLJDZSJ3?=
 =?us-ascii?Q?dBCqyUwMNAe4Yq+yBRuL2sQzhdYtTmNwvUW083t5RA8AeVnCyWOotNOyszkH?=
 =?us-ascii?Q?QT3bEy7ZFxnXTQ8ByL1slvI8QjWsqDk089NS6oxIbzYudZGcKv2hzZyu2hG7?=
 =?us-ascii?Q?HCO9ijYugVYajnBxNzG5pN3PtSljXzu1gVB35y0ZRPslGy4Sy5bl8iSusA/b?=
 =?us-ascii?Q?mvRl3Dleo9vL6LMPfcn9oWgyNc3043Ul4QciwAM/CtS0qUVoJCQGgXiZTjDX?=
 =?us-ascii?Q?HaCAAO3qBOHhPQGIugsjeGAb0nDd0BmEWXciBpr5q0rNhYE8BntbuqYAMbjj?=
 =?us-ascii?Q?S1PAY5ALb4DDuPXYtEBiNRNoUTHpiWQ+4zvJXVkApoVHUDvk8cerFn7ZlUWO?=
 =?us-ascii?Q?1X9xCbeDIxLYvuotOrii4I0c7jZF3X6fQzrry4/qKdApQEUnH1D8iLmPB/yV?=
 =?us-ascii?Q?EPfrc49vN1XYLmLoMQD0XcHC4F648B8NPiKUZnaZNrp6RPkV+BvWC0jJAhTi?=
 =?us-ascii?Q?zDOSt0YnwB8Nft0Df8iNtowdPpV53njS5Um8JRQ+giUWYzHQ/pMJx1p59FIO?=
 =?us-ascii?Q?BHchJ0zIyWTuZOvx96yLDgKoaqgZAoRac5PjmVk/zUyKTZ3s4ZbXvLSk9jkm?=
 =?us-ascii?Q?il6qrpwfrOjF4DsWgzGSTV9UsxvDOI5gPfebwqiHQblajgZAoZdQiFilM5Wh?=
 =?us-ascii?Q?BvI3QpM5rXRKgN+uMJeikd5YCYpP54Du7dCDEFzQ2mIG+8f2MHAK08jFmLsA?=
 =?us-ascii?Q?OG5pZESyUVsWAqfju2k/JWRI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9b085b-f7d2-4bc8-9958-08d925cf654f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:54.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fW0JjAHFndoNQF7MFvB6zGVR7zriT6NVON0HRl/ZcG48Sf+avFAf+Yhw6cohK9njPLg+8BYqyXebKggGw+bzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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
index 000000000000..d23c81013a8e
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
+#ifndef _ARCH_X86_KERNEL_SEV_INTERNAL_H
+
+static void snp_register_ghcb_early(unsigned long paddr);
+
+#endif	/* _ARCH_X86_KERNEL_SEV_INTERNAL_H */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 9b70b7332614..455c09a9b2c2 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -32,6 +32,8 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 
+#include "sev-internal.h"
+
 #define DR7_RESET_VALUE        0x400
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
@@ -88,6 +90,13 @@ struct sev_es_runtime_data {
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
@@ -192,6 +201,16 @@ void noinstr __sev_es_ist_exit(void)
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
 static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -218,6 +237,10 @@ static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
 		data->ghcb_active = true;
 	}
 
+	/* SEV-SNP guest requires that GHCB must be registered. */
+	if (sev_feature_enabled(SEV_SNP))
+		snp_register_ghcb(data, __pa(ghcb));
+
 	return ghcb;
 }
 
@@ -622,6 +645,10 @@ static bool __init sev_es_setup_ghcb(void)
 	/* Alright - Make the boot-ghcb public */
 	boot_ghcb = &boot_ghcb_page;
 
+	/* SEV-SNP guest requires that GHCB GPA must be registered. */
+	if (sev_feature_enabled(SEV_SNP))
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
@@ -711,6 +738,7 @@ static void __init init_ghcb(int cpu)
 
 	data->ghcb_active = false;
 	data->backup_ghcb_active = false;
+	data->snp_ghcb_registered = false;
 }
 
 void __init sev_es_init_vc_handling(void)
-- 
2.17.1

