Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC003F2EE7
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbhHTPWJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:09 -0400
Received: from mail-bn8nam08on2087.outbound.protection.outlook.com ([40.107.100.87]:15585
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241137AbhHTPV6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpvNoUXIgt6QV8mkJtl88qc6/kHtNU4YqCaOI/qAjImQqrVoU1g9SkMnA5ZMfjonvQU6aHEE0JS6Hvj6j9ogUTBwQ4f7kCLlr/bV95p+oA1tNIKox5GyDu08sPjtn4atROOFmWO85vszC/A/jbv9ki+926tvXpqTPfGf/o/Emz3sOPASzCbqhR2GiK8Pme7WZtDWEKNyL1v9f5n6XTfN9BnLg2qXW133BeHVWR5CR1cDEMLxCERJtjvpKXIOUwD08kv+F/B/BvBTEknE9VY1gZDJaVgnvZVvgy81KPBxt0p2slQ1TZrDbl7lPa8BC93Bq2er5AFiR2HTt71LwxIwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ohT+E8f4EhrCs2RnwtdbbVb5eufZtqgxt9Kn03Z/sA=;
 b=eNgxXlUOCP1o+yD4GtS4o54s98/mhhuZ59N9buHxyfHrGhbPkLDV5vtVhKPSumV0WKdciP3qxUJaIXLvtpqP3aVpxsC9wvxeHIIg5K9Xvkpm6DZ4tRuqUoJ5LPebQVgjvpl366NZTK//UzoNMSSEkQ1JuFx8RONQwKUa6L5tjLSRxC85qoTHHOZLzYd6v+2l56WhHP+qrjBR6tKvGdLA5cYkYlmWZWgq3oj4RxTLCKy3OYBJE+5sZEdBTQmwNoKcpSVWyG2d/wKSMB8QroJxpOgZajoTw9uuQr06jrUCCFlOykaBB6y+wPh6pyyTix7ck+D6P4Ah0Z/7F7vxzJmXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ohT+E8f4EhrCs2RnwtdbbVb5eufZtqgxt9Kn03Z/sA=;
 b=MuGKzi3aNxSATuz7kT6zE7l9MfpnS1D7CqKmYq9ONLZht6uY4a7UMxkx7InxrIeUz5lbdHmOgvuSerOgCPtxWc+hjIAqE8I++7cQN7Mc08rIMuEPF53wVMJncIawo7qcVewqpqfIHqDNSxiJymf//UJBWurD2PuizolQNdceRXc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:21:16 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:16 +0000
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
Subject: [PATCH Part1 v5 22/38] x86/sev: Use SEV-SNP AP creation to start secondary CPUs
Date:   Fri, 20 Aug 2021 10:19:17 -0500
Message-Id: <20210820151933.22401-23-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2552da26-7b23-494f-ed1b-08d963ee2711
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB455778B79C8864FCB413CFA6E5C19@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OP9d+IFkVprG2vDPkmj4gLgpZX+9R0K0ZFEobyKz8AL6LaVTEH6g/0miG80LmH4aju9qc72GhSY40hc+gTyLRnSzth1zCQQIiYsRhG0pe7n3jqEzy92LfZVWQx+/Fequy9F/quxjinTboLalZz8qgG+KKpth5xUa2QLV5JZei6/rPkCZAQyeWSItcrbaH/SRyKKnyFtbgpVeBRAW5mft7XOHl8kmfZvkYC+62jDUIzLFVWiPKnFJq10ncyvBLmOg2GN5P2MXdFe1w79A/d+w3Xb5BQVuMI/REIsniQrXXehGPPsD2u5TL07l+PsoWv+dOEonY5VnZ6eEeYBthMS/FGcBVH/Sjf8PlyWZDHSKLYowdAt5YVmP0dpLavhr8infGA3HBYmL8EcN8r54sKSBhDPl84/KY7QGxEbECkuoOW8MsnMzoZxHp7pINOtuQsqTPTR5iqXdcG/RN8K/HYT4zQkxlx52rAB03qhZu9KGPyK1ZS7Sb3G0vFKRf98j6QGKdgc9VgzyvJ1ORmo6Sy8EzMu3ldXwSuJe8fyq/7jpIH+mpVm0Ot/Drzy4Y5Dkf4U9Q02Lc0GD4RIq1uk8REnVGF0ngo00q33e0pnWMNNWLS2Beoa+ijUiyKD4SXcX8enFkrtxqPDPF2X6AkaKwRzXDz00iTYElKiF45CmXohMhwlVONnu1WpY0drxpF6gHP9Ig3KSM6d07GwqqQzGFYqQgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(66476007)(66946007)(4326008)(478600001)(44832011)(956004)(2616005)(7696005)(7406005)(38350700002)(52116002)(66556008)(7416002)(38100700002)(36756003)(186003)(316002)(8936002)(2906002)(83380400001)(86362001)(26005)(54906003)(1076003)(30864003)(6486002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MLGB64g9tjA7to9QH413DHvqd7TRNdbNng4p3GHk5l9i4zL+XWCXn2Sdg8Hk?=
 =?us-ascii?Q?rfkAUEKqhStjPdLrc6OQ5dV6u9mCbDYN24jhnqrjeAbyycavgJDDFm3I26u3?=
 =?us-ascii?Q?XigYqMeWD1OLEYwDu39+Elp+c2e/Fs8PHOGV5h8jvoQjZJTrrSzOfyx2Asuj?=
 =?us-ascii?Q?oxkxmqjCWbv8mDvUUtpoSTUVxbfw4dMxW5BNDr9y10lGN5foHfH98G92+iML?=
 =?us-ascii?Q?J0BQkYyRTXFEOGpIODPJKvEmdBgk7KJjEmPbKipZq+aqDTtLeTVynCTgCkRP?=
 =?us-ascii?Q?qsyDanoq1ip8/YE8KUlPWQJ9hiVAbw+wwYMsk0+DjQgKwzSTpPvGeqcIbzzD?=
 =?us-ascii?Q?YJPk6ReDGwR5/eZ1VXEud3G16eLSiFp3GIPoBsaXtY348B/WdTk+xGrugzEw?=
 =?us-ascii?Q?g87fHzvjA9V7VazMeIY+TQql7MuZCIvaR2bZ3beFyZjXVszSzzMOoj0BnQIq?=
 =?us-ascii?Q?lZd/KGDkezsCbMHgzicUXSt/DTvE4Ep0PxjOSb9MQJfbBApodXSFjW7P66R+?=
 =?us-ascii?Q?qiSQMXRVGjkl8teLc+AwWHv2S0Mc9IaDeLfMvx7HqghMhEe57XMtynJRBQER?=
 =?us-ascii?Q?AXVZ+tO+/y86lS83aSHjA3JOWZkipqUkNbkErRcL2M0WDxA3dv/e+lRPqjQn?=
 =?us-ascii?Q?S9fgUXJdcKDT9nibAcq3gfGiXt2yPfTvJ9Bp8RKtEp8ZdN/WlasPK8XYpTWK?=
 =?us-ascii?Q?JHa7h+zcXHU3XthMUNFDeMKRz3YT21k4l+R+Xb2tYVvZjUeq7YqDh7sYRkoD?=
 =?us-ascii?Q?hjxDMxwj1lw/6Lq52gzR8AW7lKbk7JgtMWUqYnKbKqGDpsEoa51dzh9LEXe9?=
 =?us-ascii?Q?iNe3AFpm8fzRbAXMuP1Z7K/znXYD59PL10xOBJIQ14ssS0/gtVnYY/GBsakT?=
 =?us-ascii?Q?CsJfR1zcI9BXjYszKOaVtCS7x6QehgXARSMoUK6TLEH74/MYtJ08/uXW6eic?=
 =?us-ascii?Q?MGdyXKL+LUqCbl9F6O61RZhhlX/9QFLfszSo46xAgYbggsUWHz4WXz7d4NRW?=
 =?us-ascii?Q?RblC3c//U+UjQXou9q7fiCjZMqCtUoOLNwh0j/ooNWSywRzZktYpzkNBotXT?=
 =?us-ascii?Q?O3A/X9IzgJQFWiw/Xb8/jvPOWlP46SpPqZdv1ZFjtAY1P3F1pnxAw4xy2cvf?=
 =?us-ascii?Q?yscawNzXndqfeYUdUZFRWgUh0g6M00gEdgDJ6eSkL3TSii8ccqmZ+RG5yveA?=
 =?us-ascii?Q?p4JIWD8MCR8FHx4MPOamU1evHQYP5A2oQPSaZCysfEPmWoXZOB6LwS4gB3No?=
 =?us-ascii?Q?yMA3sa8aj/BZUeyW1puE6r3wkv4E3jRhYAi+R1WyTWKAo5FFhOxtP7wPBPvQ?=
 =?us-ascii?Q?th3Zh1ji3jSkIr7bsp4ZRAca?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2552da26-7b23-494f-ed1b-08d963ee2711
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:16.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8KRY7pB/SqLyC7xWxBdBcOairyvyan3F1H4PHcTh0GeL8vRrtriaqOFfXbhG+uuUN2Xlo75nmQ6d/Vxl9e2OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

To provide a more secure way to start APs under SEV-SNP, use the SEV-SNP
AP Creation NAE event. This allows for guest control over the AP register
state rather than trusting the hypervisor with the SEV-ES Jump Table
address.

During native_smp_prepare_cpus(), invoke an SEV-SNP function that, if
SEV-SNP is active, will set/override apic->wakeup_secondary_cpu. This
will allow the SEV-SNP AP Creation NAE event method to be used to boot
the APs. As a result of installing the override when SEV-SNP is active,
this method of starting the APs becomes the required method. The override
function will fail to start the AP if the hypervisor does not have
support for AP creation.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |   1 +
 arch/x86/include/asm/sev.h        |   4 +
 arch/x86/include/uapi/asm/svm.h   |   5 +
 arch/x86/kernel/sev.c             | 205 ++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c         |   3 +
 5 files changed, 218 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 3388db814fd0..072540dfb129 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -100,6 +100,7 @@ enum psc_op {
 	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
+#define GHCB_HV_FT_SNP_AP_CREATION	(BIT_ULL(1) | GHCB_HV_FT_SNP)
 
 /* SNP Page State Change NAE event */
 #define VMGEXIT_PSC_MAX_ENTRY		253
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 005f230d0406..7f063127aa66 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -65,6 +65,8 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
 
+#define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -111,6 +113,7 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
+void snp_set_wakeup_secondary_cpu(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -125,6 +128,7 @@ early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned i
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
+static inline void snp_set_wakeup_secondary_cpu(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 0dcdb6e0c913..8b4c57baec52 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -109,6 +109,10 @@
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
 #define SVM_VMGEXIT_PSC				0x80000010
+#define SVM_VMGEXIT_AP_CREATION			0x80000013
+#define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
+#define SVM_VMGEXIT_AP_CREATE			1
+#define SVM_VMGEXIT_AP_DESTROY			2
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
@@ -221,6 +225,7 @@
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
 	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
+	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 106b4aaddfde..ddf8ced4a879 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/cpumask.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -30,6 +31,7 @@
 #include <asm/svm.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
+#include <asm/apic.h>
 
 #include "sev-internal.h"
 
@@ -105,6 +107,8 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
+static DEFINE_PER_CPU(struct sev_es_save_area *, snp_vmsa);
+
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
@@ -858,6 +862,207 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
 	pvalidate_pages(vaddr, npages, 1);
 }
 
+static int rmpadjust(void *va, bool vmsa)
+{
+	u64 attrs;
+	int err;
+
+	/*
+	 * The RMPADJUST instruction is used to set or clear the VMSA bit for
+	 * a page. A change to the VMSA bit is only performed when running
+	 * at VMPL0 and is ignored at other VMPL levels. If too low of a target
+	 * VMPL level is specified, the instruction can succeed without changing
+	 * the VMSA bit should the kernel not be in VMPL0. Using a target VMPL
+	 * level of 1 will return a FAIL_PERMISSION error if the kernel is not
+	 * at VMPL0, thus ensuring that the VMSA bit has been properly set when
+	 * no error is returned.
+	 */
+	attrs = 1;
+	if (vmsa)
+		attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+	/* Instruction mnemonic supported in binutils versions v2.36 and later */
+	asm volatile (".byte 0xf3,0x0f,0x01,0xfe\n\t"
+		      : "=a" (err)
+		      : "a" (va), "c" (RMP_PG_SIZE_4K), "d" (attrs)
+		      : "memory", "cc");
+
+	return err;
+}
+
+#define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
+#define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
+#define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
+
+#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
+#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
+
+static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
+{
+	struct sev_es_save_area *cur_vmsa, *vmsa;
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int cpu, err, ret;
+	u8 sipi_vector;
+	u64 cr4;
+
+	if ((sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION) != GHCB_HV_FT_SNP_AP_CREATION)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Verify the desired start IP against the known trampoline start IP
+	 * to catch any future new trampolines that may be introduced that
+	 * would require a new protected guest entry point.
+	 */
+	if (WARN_ONCE(start_ip != real_mode_header->trampoline_start,
+		      "Unsupported SEV-SNP start_ip: %lx\n", start_ip))
+		return -EINVAL;
+
+	/* Override start_ip with known protected guest start IP */
+	start_ip = real_mode_header->sev_es_trampoline_start;
+
+	/* Find the logical CPU for the APIC ID */
+	for_each_present_cpu(cpu) {
+		if (arch_match_cpu_phys_id(cpu, apic_id))
+			break;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	cur_vmsa = per_cpu(snp_vmsa, cpu);
+
+	/*
+	 * A new VMSA is created each time because there is no guarantee that
+	 * the current VMSA is the kernels or that the vCPU is not running. If
+	 * an attempt was done to use the current VMSA with a running vCPU, a
+	 * #VMEXIT of that vCPU would wipe out all of the settings being done
+	 * here.
+	 */
+	vmsa = (struct sev_es_save_area *)get_zeroed_page(GFP_KERNEL);
+	if (!vmsa)
+		return -ENOMEM;
+
+	/* CR4 should maintain the MCE value */
+	cr4 = native_read_cr4() & ~X86_CR4_MCE;
+
+	/* Set the CS value based on the start_ip converted to a SIPI vector */
+	sipi_vector		= (start_ip >> 12);
+	vmsa->cs.base		= sipi_vector << 12;
+	vmsa->cs.limit		= 0xffff;
+	vmsa->cs.attrib		= INIT_CS_ATTRIBS;
+	vmsa->cs.selector	= sipi_vector << 8;
+
+	/* Set the RIP value based on start_ip */
+	vmsa->rip		= start_ip & 0xfff;
+
+	/* Set VMSA entries to the INIT values as documented in the APM */
+	vmsa->ds.limit		= 0xffff;
+	vmsa->ds.attrib		= INIT_DS_ATTRIBS;
+	vmsa->es		= vmsa->ds;
+	vmsa->fs		= vmsa->ds;
+	vmsa->gs		= vmsa->ds;
+	vmsa->ss		= vmsa->ds;
+
+	vmsa->gdtr.limit	= 0xffff;
+	vmsa->ldtr.limit	= 0xffff;
+	vmsa->ldtr.attrib	= INIT_LDTR_ATTRIBS;
+	vmsa->idtr.limit	= 0xffff;
+	vmsa->tr.limit		= 0xffff;
+	vmsa->tr.attrib		= INIT_TR_ATTRIBS;
+
+	vmsa->efer		= 0x1000;	/* Must set SVME bit */
+	vmsa->cr4		= cr4;
+	vmsa->cr0		= 0x60000010;
+	vmsa->dr7		= 0x400;
+	vmsa->dr6		= 0xffff0ff0;
+	vmsa->rflags		= 0x2;
+	vmsa->g_pat		= 0x0007040600070406ULL;
+	vmsa->xcr0		= 0x1;
+	vmsa->mxcsr		= 0x1f80;
+	vmsa->x87_ftw		= 0x5555;
+	vmsa->x87_fcw		= 0x0040;
+
+	/*
+	 * Set the SNP-specific fields for this VMSA:
+	 *   VMPL level
+	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
+	 */
+	vmsa->vmpl		= 0;
+	vmsa->sev_features	= sev_status >> 2;
+
+	/* Switch the page over to a VMSA page now that it is initialized */
+	ret = rmpadjust(vmsa, true);
+	if (ret) {
+		pr_err("set VMSA page failed (%u)\n", ret);
+		free_page((unsigned long)vmsa);
+
+		return -EINVAL;
+	}
+
+	/* Issue VMGEXIT AP Creation NAE event */
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_rax(ghcb, vmsa->sev_features);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
+	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
+	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
+	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
+		pr_alert("SNP AP Creation error\n");
+		ret = -EINVAL;
+	}
+
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	/* Perform cleanup if there was an error */
+	if (ret) {
+		err = rmpadjust(vmsa, false);
+		if (err)
+			pr_err("clear VMSA page failed (%u), leaking page\n", err);
+		else
+			free_page((unsigned long)vmsa);
+
+		vmsa = NULL;
+	}
+
+	/* Free up any previous VMSA page */
+	if (cur_vmsa) {
+		err = rmpadjust(cur_vmsa, false);
+		if (err)
+			pr_err("clear VMSA page failed (%u), leaking page\n", err);
+		else
+			free_page((unsigned long)cur_vmsa);
+	}
+
+	/* Record the current VMSA page */
+	per_cpu(snp_vmsa, cpu) = vmsa;
+
+	return ret;
+}
+
+void snp_set_wakeup_secondary_cpu(void)
+{
+	if (!sev_feature_enabled(SEV_SNP))
+		return;
+
+	/*
+	 * Always set this override if SEV-SNP is enabled. This makes it the
+	 * required method to start APs under SEV-SNP. If the hypervisor does
+	 * not support AP creation, then no APs will be started.
+	 */
+	apic->wakeup_secondary_cpu = wakeup_cpu_via_vmgexit;
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 85f6e242b6b4..ca78711620e0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
+#include <asm/sev.h>
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
@@ -1380,6 +1381,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
+
+	snp_set_wakeup_secondary_cpu();
 }
 
 void arch_thaw_secondary_cpus_begin(void)
-- 
2.17.1

