Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B813F2F2B
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbhHTPXr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:23:47 -0400
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79]:51265
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241452AbhHTPWw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1SasmJZfn0xNDu7KWKcjzQF4qUXYm/4bomCZXDIEUBqNZOOL41KbTLXubBhYlxNnILk3O+sCAvjrLpzVY5zzPEy1oTghno/KEYtCZEL7mDf2QpG9YDFZ8ueMNgvVjbNdf2W+U24MB/3+wrqrKXYo/Pabs3KENuJX3ulRqTK+Ltlg4TR37XY8U/qUBFwIiCgSp7y0wrvzC6HzoRcnwc7Q0pTrrdgl9ia2k2GwLUUqUA3EKzkqtxsNH9DhkCEHUc6mGyJFbm9+LIqH2fI7EEof8pIZORFFwxJhBYgK+XjcJjgJ07FjkftqriZIGCNk5YOTD5xgZq0tBnqJcLsihS1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1biS2P4q7Nu3PZQH9xz0Npb2/yW0YdUtAbzcXh6MTYA=;
 b=ccwi61jrSdwX4IwC3lCo9a6+DUdJfI1Blv8XN11Tl+ApOBNkyUDP7sr7zmQpuGv7rbamoDjJFxZV/2rauGrjK1PPGdarM1XlVmokTdlBlm7g2GWhiMywYUJfuWgZmqwLQICzV27lmUguOdCEr86uVypIx4xHpKzNBHfAZ9pUP8VHeJf6FDXhV8uW78JZM8xHbPcJ9KM3QZ2bpotVh9R4Tfkhu4tioNuzRrc3olxz/dN5fghaISm/b/SqH1YbH/MF11ganHPOTiBQPt5+blZtodapeqEsgGHoOK6dx1YubfQUR0C8U4aYs/Q3BqIfCQYbhPuCsi0Xp+kPcNt2B7NtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1biS2P4q7Nu3PZQH9xz0Npb2/yW0YdUtAbzcXh6MTYA=;
 b=m4tyzTKmmhuX8Fc6Tks6snQhPG9e3D6x1lZXYraZfvhsbw2z5MyLN0OUTk1++xnY2mRZ8NiMeLZGcD8pK9CnO6QTvLOTUaF9J0YpIVldHzyQQg5ifQ+3pMAVRAsqh9R2eYUPEsUNsk06bQQga378gcK5/7Vk+9nph1riFr+TFHc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:21:25 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:23 +0000
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
Subject: [PATCH Part1 v5 28/38] x86/compressed/64: enable SEV-SNP-validated CPUID in #VC handler
Date:   Fri, 20 Aug 2021 10:19:23 -0500
Message-Id: <20210820151933.22401-29-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7e71279-31da-494b-464a-08d963ee2bb7
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2638F61238D4FEB49DA28D89E5C19@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjVggq7yyY13zd8tbM4aKzh2NMF+/LAJSjxnrjdD3OnUnO8SOcNTPlXuLNTu+8z0Z9WUT+WUxljemh/9fBEPDS9t8cVAkcr1ifk8JHSyUqbN+82Tv0nYj6TadXTTU1Y5OFXx4osgMDN7JUXHmOWuF108qk8wmg5bwXlIrwVVB0EsPR9n+V0AeqSL8ID+fmsYXfc++IIFITdF07iy+qg2hq5vCijlSTmMZvl32tan8cbihh1N+gKICBgSFr16u11jVEVBjdpXbSeK9fqZg16WZg88ctiO28JBuffkru3la99cmzQS5ijLZjgCgyfbIuwultElRwg158hiPXKvIGexHoPyO2ofCgx43MAzRTeQdLaF0rjoLzmhL5EGRI2XZzFKbzdeD2lAOYDA7dXZ/U/s1b3wPdmpb2q9ZwWerAGnvtN7/lgk0eAJth2sKCka6+N1wcVhIYawM4oksSyv5OeEY7iPQPbqus6Knwi+Ql/mZUJFFT61CWCDzuWN2RhmVgjl4YGC+0Q7N5LODiBCUpgiWoJgfxpBkxul2KW9PiGREKqqtHlNFFSyi3T8Zao72rIBSQwQMPxf07QNLNDsGp8VtS46LXwkgWztqlwh6olT7N3w1kCwop9jSCePueGs3szJR8iPRKdIVT65jmamw+q5Ma6jNoJsfbyJTAaefC9QqfOdGPjyDglh8Y2cuqj7o/pmzkYPKUBB73+85I/9SgMLBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(8676002)(8936002)(86362001)(83380400001)(30864003)(316002)(54906003)(1076003)(15650500001)(478600001)(2616005)(44832011)(2906002)(4326008)(7406005)(956004)(66556008)(7416002)(66476007)(186003)(66946007)(26005)(5660300002)(36756003)(7696005)(52116002)(38100700002)(6486002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YS7tVZQRYAhUeuDpkZh3m6fYlcM0K3SIwwBTI+3oPoo5u6/pIvtrsh6CX7rf?=
 =?us-ascii?Q?jx+HCAs5JpwiR84wKa7/esRBf2BeuKviaCnVC/BmiQb7gu6aYAl0bztajCkY?=
 =?us-ascii?Q?uIDqggHQ6kpUjxr4aSmGCLWGCQUkca8GLMLYhBfBILHJ6FwKaIVshf9/bjkl?=
 =?us-ascii?Q?JBMUgkko3/6yido6a3Vxe2asSuGh00JPkGZs87SV5iFlo4GwEAcouL6YA7rx?=
 =?us-ascii?Q?2//6Tj8Wcg6VYOuSxhLYcY8q3jfkJZAMSWVy4cA1ZxNHw2jgR+wA1dsoKOad?=
 =?us-ascii?Q?bDqr79V3RkDZqFt8cqqgY+zzamS1cSwA/mWl7RbyU6A+EMy5NmWAqXt+q3E1?=
 =?us-ascii?Q?MPeyP2NNYd7jbMrr8P32eQCAe+JqSYgHZZfZLokc8GxD6DoF5M+6/2PCIkb5?=
 =?us-ascii?Q?SMcb6Ig8hbeju/8x4PwUFQny5V6QX7D8S8uezFUZUEFVccSHruLqGnq/MKg6?=
 =?us-ascii?Q?GeyfTtNlAMJ+AClRH0gZ6aWx8FtN86ZtzCC5STkXdLvVC78d4V6yLRnzBksH?=
 =?us-ascii?Q?e00ktR/MCwqIgB58YXv6/ANmgmPzhqO6A15QL2HGK1A/d+ML8owA7MjsruSk?=
 =?us-ascii?Q?F6tIsi0/GKsMuxFY86vaNV4M/brNnupSMdTxPMpa7LZi5KOK/ywL2Zeyc7V2?=
 =?us-ascii?Q?39kWIEMtOt2phlyXRI/wR58mZFN+TaIZrEj7PpMtTwd3RpevrHAmZeGQbhsV?=
 =?us-ascii?Q?wpQt+6xsO6GVybcAliQmbkUz7/8xwmIMxt/FzRFKufFNle9zbLpgweRoIEM2?=
 =?us-ascii?Q?jXv8PKrCv8EuxbVqsNrZYrtx+y3m0BCo0+RD4Day1RlAQEHZs4QIN7koSQXF?=
 =?us-ascii?Q?roSZEKJFzkP/7xVgt1AJVrNly4NHCv7sqGo4ZZyeI8y48P09GNtZPnPqeFEA?=
 =?us-ascii?Q?Ez3+P+gm+kfo3uXNjlWZSQfrviulOWci6LyENWqoEr0Vy5YbMTgFlfKnpk7d?=
 =?us-ascii?Q?Z8cXlP9/4sS/rmPrVkAzN3Aufrwmf0zGi+Xrk7iGX9NnMmlYPEEYGQH4wtH2?=
 =?us-ascii?Q?eZKm0/Wqaud8QM9kItFoP5SUdrpTr37of18cExZuU2q1Hqkm3AYfjrEoCW/n?=
 =?us-ascii?Q?mDHI/uLW7kcuTmhuIL32bEd1thKchTE07nPDgrrcpI0RyZuV/bhY92N3aXKP?=
 =?us-ascii?Q?6Y40bl9Xup1yEFtDjAWVWPY6UYITaCEPKkpzTF9cgiDJze1Sl5NbXNQs2lzs?=
 =?us-ascii?Q?01Qka3dZgMTIdV4Ugs4ImvG8zHGtupRLCbIEzbdwfqEGzQJM2ywcw8xOYryI?=
 =?us-ascii?Q?dxWfpmO1+uwdHycEHf0EOSQIfCSvVKu0n2vqtgHoFbhcixagrUdURDJ+vl6z?=
 =?us-ascii?Q?mmG6izp0BU5An0/z6Bpy2wUL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e71279-31da-494b-464a-08d963ee2bb7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:23.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/77zIO8alTG4vWRQradJgNPimUSESyc/zSRW3fs/sQ9aAgJcP2upozjVYrFmgLiBCoD4w0PSv2qnPgCoGKofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

CPUID instructions generate a #VC exception for SEV-ES/SEV-SNP guests,
for which early handlers are currently set up to handle. In the case
of SEV-SNP, guests can use a special location in guest memory address
space that has been pre-populated with firmware-validated CPUID
information to look up the relevant CPUID values rather than
requesting them from hypervisor via a VMGEXIT.

Determine the location of the CPUID memory address in advance of any
CPUID instructions/exceptions and, when available, use it to handle
the CPUID lookup.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/efi.c     |   1 +
 arch/x86/boot/compressed/head_64.S |   1 +
 arch/x86/boot/compressed/idt_64.c  |   7 +-
 arch/x86/boot/compressed/misc.h    |   1 +
 arch/x86/boot/compressed/sev.c     |   3 +
 arch/x86/include/asm/sev-common.h  |   2 +
 arch/x86/include/asm/sev.h         |   3 +
 arch/x86/kernel/sev-shared.c       | 374 +++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c              |   4 +
 9 files changed, 394 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 16ff5cb9a1fb..a1529a230ea7 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -176,3 +176,4 @@ efi_get_conf_table(struct boot_params *boot_params,
 
 	return 0;
 }
+
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a2347ded77ea..1c1658693fc9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -441,6 +441,7 @@ SYM_CODE_START(startup_64)
 .Lon_kernel_cs:
 
 	pushq	%rsi
+	movq	%rsi, %rdi		/* real mode address */
 	call	load_stage1_idt
 	popq	%rsi
 
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 9b93567d663a..1f6511a6625d 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -3,6 +3,7 @@
 #include <asm/segment.h>
 #include <asm/trapnr.h>
 #include "misc.h"
+#include <asm/sev.h>
 
 static void set_idt_entry(int vector, void (*handler)(void))
 {
@@ -28,13 +29,15 @@ static void load_boot_idt(const struct desc_ptr *dtr)
 }
 
 /* Setup IDT before kernel jumping to  .Lrelocated */
-void load_stage1_idt(void)
+void load_stage1_idt(void *rmode)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
 
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		sev_snp_cpuid_init(rmode);
 		set_idt_entry(X86_TRAP_VC, boot_stage1_vc);
+	}
 
 	load_boot_idt(&boot_idt_desc);
 }
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 16b092fd7aa1..cdd328aa42c2 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -190,6 +190,7 @@ int efi_get_conf_table(struct boot_params *boot_params,
 		       unsigned long *conf_table_pa,
 		       unsigned int *conf_table_len,
 		       bool *is_efi_64);
+
 #else
 static inline int
 efi_find_vendor_table(unsigned long conf_table_pa, unsigned int conf_table_len,
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 6e8d97c280aa..910bf5cf010e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -20,6 +20,9 @@
 #include <asm/fpu/xcr.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
+#include <asm/cpuid.h>
+#include <linux/efi.h>
+#include <linux/log2.h>
 
 #include "error.h"
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 072540dfb129..5f134c172dbf 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -148,6 +148,8 @@ struct snp_psc_desc {
 #define GHCB_TERM_PSC			1	/* Page State Change failure */
 #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
 #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
+#define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
+#define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 534fa1c4c881..c73931548346 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <asm/insn.h>
 #include <asm/sev-common.h>
+#include <asm/bootparam.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	2ULL
@@ -126,6 +127,7 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
+void sev_snp_cpuid_init(struct boot_params *bp);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -141,6 +143,7 @@ static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz,
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
+static inline void sev_snp_cpuid_init(struct boot_params *bp) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ae4556925485..651980ddbd65 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,25 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+struct sev_snp_cpuid_fn {
+	u32 eax_in;
+	u32 ecx_in;
+	u64 unused;
+	u64 unused2;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+	u64 reserved;
+} __packed;
+
+struct sev_snp_cpuid_info {
+	u32 count;
+	u32 reserved1;
+	u64 reserved2;
+	struct sev_snp_cpuid_fn fn[0];
+} __packed;
+
 /*
  * Since feature negotiation related variables are set early in the boot
  * process they must reside in the .data section so as not to be zeroed
@@ -26,6 +45,15 @@ static u16 __ro_after_init ghcb_version;
 /* Bitmap of SEV features supported by the hypervisor */
 u64 __ro_after_init sev_hv_features = 0;
 
+/*
+ * These are also stored in .data section to avoid the need to re-parse
+ * boot_params and re-determine CPUID memory range when .bss is cleared.
+ */
+static int sev_snp_cpuid_enabled __section(".data");
+static unsigned long sev_snp_cpuid_pa __section(".data");
+static unsigned long sev_snp_cpuid_sz __section(".data");
+static const struct sev_snp_cpuid_info *cpuid_info __section(".data");
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -236,6 +264,219 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 	return 0;
 }
 
+static bool sev_snp_cpuid_active(void)
+{
+	return sev_snp_cpuid_enabled;
+}
+
+static int sev_snp_cpuid_xsave_size(u64 xfeatures_en, u32 base_size,
+				    u32 *xsave_size, bool compacted)
+{
+	u64 xfeatures_found = 0;
+	int i;
+
+	*xsave_size = base_size;
+
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		if (!(fn->eax_in == 0xd && fn->ecx_in > 1 && fn->ecx_in < 64))
+			continue;
+		if (!(xfeatures_en & (1UL << fn->ecx_in)))
+			continue;
+		if (xfeatures_found & (1UL << fn->ecx_in))
+			continue;
+
+		xfeatures_found |= (1UL << fn->ecx_in);
+		if (compacted)
+			*xsave_size += fn->eax;
+		else
+			*xsave_size = max(*xsave_size, fn->eax + fn->ebx);
+	}
+
+	/*
+	 * Either the guest set unsupported XCR0/XSS bits, or the corresponding
+	 * entries in the CPUID table were not present. This is not a valid
+	 * state to be in.
+	 */
+	if (xfeatures_found != (xfeatures_en & ~3ULL))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void sev_snp_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
+			     u32 *ecx, u32 *edx)
+{
+	/*
+	 * Currently MSR protocol is sufficient to handle fallback cases, but
+	 * should that change make sure we terminate rather than grabbing random
+	 * values. Handling can be added in future to use GHCB-page protocol for
+	 * cases that occur late enough in boot that GHCB page is available
+	 */
+	if (cpuid_function_is_indexed(func) && subfunc != 0)
+		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
+
+	if (sev_cpuid_hv(func, 0, eax, ebx, ecx, edx))
+		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
+}
+
+static bool sev_snp_cpuid_find(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
+			       u32 *ecx, u32 *edx)
+{
+	int i;
+	bool found = false;
+
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		if (fn->eax_in != func)
+			continue;
+
+		if (cpuid_function_is_indexed(func) && fn->ecx_in != subfunc)
+			continue;
+
+		*eax = fn->eax;
+		*ebx = fn->ebx;
+		*ecx = fn->ecx;
+		*edx = fn->edx;
+		found = true;
+
+		break;
+	}
+
+	return found;
+}
+
+static bool sev_snp_cpuid_in_range(u32 func)
+{
+	int i;
+	u32 std_range_min = 0;
+	u32 std_range_max = 0;
+	u32 hyp_range_min = 0x40000000;
+	u32 hyp_range_max = 0;
+	u32 ext_range_min = 0x80000000;
+	u32 ext_range_max = 0;
+
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		if (fn->eax_in == std_range_min)
+			std_range_max = fn->eax;
+		else if (fn->eax_in == hyp_range_min)
+			hyp_range_max = fn->eax;
+		else if (fn->eax_in == ext_range_min)
+			ext_range_max = fn->eax;
+	}
+
+	if ((func >= std_range_min && func <= std_range_max) ||
+	    (func >= hyp_range_min && func <= hyp_range_max) ||
+	    (func >= ext_range_min && func <= ext_range_max))
+		return true;
+
+	return false;
+}
+
+/*
+ * Returns -EOPNOTSUPP if feature not enabled. Any other return value should be
+ * treated as fatal by caller since we cannot fall back to hypervisor to fetch
+ * the values for security reasons (outside of the specific cases handled here)
+ */
+static int sev_snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
+			 u32 *edx)
+{
+	if (!sev_snp_cpuid_active())
+		return -EOPNOTSUPP;
+
+	if (!cpuid_info)
+		return -EIO;
+
+	if (!sev_snp_cpuid_find(func, subfunc, eax, ebx, ecx, edx)) {
+		/*
+		 * Some hypervisors will avoid keeping track of CPUID entries
+		 * where all values are zero, since they can be handled the
+		 * same as out-of-range values (all-zero). In our case, we want
+		 * to be able to distinguish between out-of-range entries and
+		 * in-range zero entries, since the CPUID table entries are
+		 * only a template that may need to be augmented with
+		 * additional values for things like CPU-specific information.
+		 * So if it's not in the table, but is still in the valid
+		 * range, proceed with the fix-ups below. Otherwise, just return
+		 * zeros.
+		 */
+		*eax = *ebx = *ecx = *edx = 0;
+		if (!sev_snp_cpuid_in_range(func))
+			goto out;
+	}
+
+	if (func == 0x1) {
+		u32 ebx2, edx2;
+
+		sev_snp_cpuid_hv(func, subfunc, NULL, &ebx2, NULL, &edx2);
+		/* initial APIC ID */
+		*ebx = (*ebx & 0x00FFFFFF) | (ebx2 & 0xFF000000);
+		/* APIC enabled bit */
+		*edx = (*edx & ~BIT_ULL(9)) | (edx2 & BIT_ULL(9));
+
+		/* OSXSAVE enabled bit */
+		if (native_read_cr4() & X86_CR4_OSXSAVE)
+			*ecx |= BIT_ULL(27);
+	} else if (func == 0x7) {
+		/* OSPKE enabled bit */
+		*ecx &= ~BIT_ULL(4);
+		if (native_read_cr4() & X86_CR4_PKE)
+			*ecx |= BIT_ULL(4);
+	} else if (func == 0xB) {
+		/* extended APIC ID */
+		sev_snp_cpuid_hv(func, 0, NULL, NULL, NULL, edx);
+	} else if (func == 0xd && (subfunc == 0x0 || subfunc == 0x1)) {
+		bool compacted = false;
+		u64 xcr0 = 1, xss = 0;
+		u32 xsave_size;
+
+		if (native_read_cr4() & X86_CR4_OSXSAVE)
+			xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
+		if (subfunc == 1) {
+			/* boot/compressed doesn't set XSS so 0 is fine there */
+#ifndef __BOOT_COMPRESSED
+			if (*eax & 0x8) /* XSAVES */
+				if (boot_cpu_has(X86_FEATURE_XSAVES))
+					rdmsrl(MSR_IA32_XSS, xss);
+#endif
+			/*
+			 * The PPR and APM aren't clear on what size should be
+			 * encoded in 0xD:0x1:EBX when compaction is not enabled
+			 * by either XSAVEC or XSAVES since SNP-capable hardware
+			 * has the entries fixed as 1. KVM sets it to 0 in this
+			 * case, but to avoid this becoming an issue it's safer
+			 * to simply treat this as unsupported or SNP guests.
+			 */
+			if (!(*eax & 0xA)) /* (XSAVEC|XSAVES) */
+				return -EINVAL;
+
+			compacted = true;
+		}
+
+		if (sev_snp_cpuid_xsave_size(xcr0 | xss, *ebx, &xsave_size,
+					     compacted))
+			return -EINVAL;
+
+		*ebx = xsave_size;
+	} else if (func == 0x8000001E) {
+		u32 ebx2, ecx2;
+
+		/* extended APIC ID */
+		sev_snp_cpuid_hv(func, subfunc, eax, &ebx2, &ecx2, NULL);
+		/* compute ID */
+		*ebx = (*ebx & 0xFFFFFFF00) | (ebx2 & 0x000000FF);
+		/* node ID */
+		*ecx = (*ecx & 0xFFFFFFF00) | (ecx2 & 0x000000FF);
+	}
+
+out:
+	return 0;
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -244,15 +485,25 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int fn = lower_bits(regs->ax, 32);
+	unsigned int subfn = lower_bits(regs->cx, 32);
 	u32 eax, ebx, ecx, edx;
+	int ret;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
+	ret = sev_snp_cpuid(fn, subfn, &eax, &ebx, &ecx, &edx);
+	if (ret == 0)
+		goto out;
+
+	if (ret != -EOPNOTSUPP)
+		goto fail;
+
 	if (sev_cpuid_hv(fn, 0, &eax, &ebx, &ecx, &edx))
 		goto fail;
 
+out:
 	regs->ax = eax;
 	regs->bx = ebx;
 	regs->cx = ecx;
@@ -552,6 +803,19 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 	struct pt_regs *regs = ctxt->regs;
 	u32 cr4 = native_read_cr4();
 	enum es_result ret;
+	u32 eax, ebx, ecx, edx;
+	int cpuid_ret;
+
+	cpuid_ret = sev_snp_cpuid(regs->ax, regs->cx, &eax, &ebx, &ecx, &edx);
+	if (cpuid_ret == 0) {
+		regs->ax = eax;
+		regs->bx = ebx;
+		regs->cx = ecx;
+		regs->dx = edx;
+		return ES_OK;
+	}
+	if (cpuid_ret != -EOPNOTSUPP)
+		return ES_VMM_ERROR;
 
 	ghcb_set_rax(ghcb, regs->ax);
 	ghcb_set_rcx(ghcb, regs->cx);
@@ -603,3 +867,113 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 
 	return ES_OK;
 }
+
+#ifdef BOOT_COMPRESSED
+static struct setup_data *get_cc_setup_data(struct boot_params *bp)
+{
+	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
+
+	while (hdr) {
+		if (hdr->type == SETUP_CC_BLOB)
+			return hdr;
+		hdr = (struct setup_data *)hdr->next;
+	}
+
+	return NULL;
+}
+
+/*
+ * For boot/compressed kernel:
+ *
+ *   1) Search for CC blob in the following order/precedence:
+ *      - via linux boot protocol / setup_data entry
+ *      - via EFI configuration table
+ *   2) Return a pointer to the CC blob, NULL otherwise.
+ */
+static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info = NULL;
+	struct setup_data_cc {
+		struct setup_data header;
+		u32 cc_blob_address;
+	} *sd;
+	unsigned long conf_table_pa;
+	unsigned int conf_table_len;
+	bool efi_64;
+
+	/* Try to get CC blob via setup_data */
+	sd = (struct setup_data_cc *)get_cc_setup_data(bp);
+	if (sd) {
+		cc_info = (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
+		goto out_verify;
+	}
+
+	/* CC blob isn't in setup_data, see if it's in the EFI config table */
+	if (!efi_get_conf_table(bp, &conf_table_pa, &conf_table_len, &efi_64))
+		(void)efi_find_vendor_table(conf_table_pa, conf_table_len,
+					    EFI_CC_BLOB_GUID, efi_64,
+					    (unsigned long *)&cc_info);
+
+out_verify:
+	/* CC blob should be either valid or not present. Fail otherwise. */
+	if (cc_info && cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		sev_es_terminate(1, GHCB_SNP_UNSUPPORTED);
+
+	return cc_info;
+}
+#else
+/*
+ * Probing for CC blob for run-time kernel will be enabled in a subsequent
+ * patch. For now we need to stub this out.
+ */
+static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
+{
+	return NULL;
+}
+#endif
+
+/*
+ * Initial set up of CPUID table when running identity-mapped.
+ *
+ * NOTE: Since SEV_SNP feature partly relies on CPUID checks that can't
+ * happen until we access CPUID page, we skip the check and hope the
+ * bootloader is providing sane values. Current code relies on all CPUID
+ * page lookups originating from #VC handler, which at least provides
+ * indication that SEV-ES is enabled. Subsequent init levels will check for
+ * SEV_SNP feature once available to also take SEV MSR value into account.
+ */
+void sev_snp_cpuid_init(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	if (!bp)
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cc_info = sev_snp_probe_cc_blob(bp);
+
+	if (!cc_info)
+		return;
+
+	sev_snp_cpuid_pa = cc_info->cpuid_phys;
+	sev_snp_cpuid_sz = cc_info->cpuid_len;
+
+	/*
+	 * These should always be valid values for SNP, even if guest isn't
+	 * actually configured to use the CPUID table.
+	 */
+	if (!sev_snp_cpuid_pa || sev_snp_cpuid_sz < PAGE_SIZE)
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cpuid_info = (const struct sev_snp_cpuid_info *)sev_snp_cpuid_pa;
+
+	/*
+	 * We should be able to trust the 'count' value in the CPUID table
+	 * area, but ensure it agrees with CC blob value to be safe.
+	 */
+	if (sev_snp_cpuid_sz < (sizeof(struct sev_snp_cpuid_info) +
+				sizeof(struct sev_snp_cpuid_fn) *
+				cpuid_info->count))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	sev_snp_cpuid_enabled = 1;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index ddf8ced4a879..d7b6f7420551 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -19,6 +19,8 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/cpumask.h>
+#include <linux/log2.h>
+#include <linux/efi.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -32,6 +34,8 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
+#include <asm/efi.h>
+#include <asm/cpuid.h>
 
 #include "sev-internal.h"
 
-- 
2.17.1

