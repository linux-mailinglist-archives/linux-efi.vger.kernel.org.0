Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21C82669A5
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgIKUmk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 16:42:40 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:55307
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbgIKUmc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Sep 2020 16:42:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJQ0eKDMkAzM93oHb697w5BZzqcIMMhfaLKV94M9WIcL4om0lUJGQlBTTcfj9HYwmeU3jSyuQ4yWQZFQ3CGtPzshEitICftMq4Z8cLPrI9w8b5LMszSi4M2fe+G1QTnB4yC/lXeyeu1roRz77OwvOkVSNFD0UPY1aAFnGk2vqg3tcYA7LUjCxpVngi6yySRQXw5tgtJ9PwAxEI0l/aPdbm0Wv/B+GGc5u0R7EK2i/QhZAbtSttDCjqULEr+gfkE9uuf7ao0cUBdTVKpioPeG+S5BlSMSz5wiDZzCq3y2haY6hdXo32Pq9doXDkJfdcmJc/qPnjUcVb/aV+Tm847PjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5cERzMLA4/mMcPHMAkiTBzy/yigsylhEkkymh/VPqU=;
 b=GX6cblXRailG1b4CKcd6fmRsypiO68asiTlHYGenaKlK2uzmebv3ySbtL5yZU2jVKFOcLKtpXGxrubJZ8fVKz0q6EYX72XdhIo9kMTT3pL/iL4z8n23vvuQkaeKKByMQQ8WuDh7EjO9NchpwQ9CW0ohhVd9FAQinUtWMTyUzQOyvXKPOD2UO5hTCgJh/cBQcEzOUpZp5HWvXA5gReesQpwxc0VTR0vwNBHCOBk1eNT8T0MAWRcOHG+iwiT0DpVD0sdvXtAGmk4I6hbTsEoCGjbZ3ztkuPOSTtq2CoNR1aJjDURb5j/ByAMR6MVaFhac1a/3KD4Z8wi2xkVMH4oL0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5cERzMLA4/mMcPHMAkiTBzy/yigsylhEkkymh/VPqU=;
 b=eR8211hDxNbBpE2OWgchf9U3F2Xnfb9iO/NKZ9vUnb3mmtdZcjNL7r+RIEYoynMN9DLfveWZDQK/Ijy/qW8Uo1JiRJQmk+tS4tO9OizqYQkLGUOQatKll7Qm6kq5EYX07I/HkGTWhDzyAd5dr7e9WwKMMSDuaegxIL9nUJrIF+Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 20:42:27 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409%5]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 20:42:26 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 1/2] cper, apei, mce: Pass x86 CPER through the MCA handling chain
Date:   Thu,  3 Sep 2020 18:45:30 -0500
Message-Id: <20200903234531.162484-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903234531.162484-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20200903234531.162484-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) To
 SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx024ehost.amd.com (165.204.78.2) by DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 20:42:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f312960-7800-4dff-d496-08d8569331a2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4431A1CF483D7BE0C6143D5E90240@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Gv3he/jpgP8ZovKr/FrW7LuOiwGiaKdAKAkOWcHfHDYJ7e3qYfstN2lYB9mpGK+YOjsWx288bUdxx5sEZVp/Y6AJ0NoncDuIbKjlOr8xEjluVE6o1k21R+/jrHlWCbeLTnKIRO2Ile2O4xQnl00JBgFfUVYpqlJqrNfUJponPn9BN06wInRxhmCnRi4exqtbebCQ1ihnErI230F0tnSaq/blKJpDX4IrW0fwES0iiVaXkd1MvNR4hRiyCSov05DCxdLiQ20B9GmlDEzLl7TtqbaUgBlQgmVI0o9vZdQS9LrgLJWzdfi9ID2DM6PAxiC8f3XVAhPSvzT/pTNHfX2TticcybdHjjHTqBg4fX9ORu89/JT5RXEmQ0j3Ap2AGyqW8L/2gsuRMDWi9ysnq0RrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(8936002)(316002)(2616005)(8676002)(5660300002)(6666004)(956004)(54906003)(83380400001)(66946007)(1076003)(66476007)(52116002)(66556008)(36756003)(7696005)(7416002)(6486002)(966005)(16526019)(4326008)(2906002)(26005)(86362001)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xkR7G2HWl/sBBORstuIYWYv+FJWy5/wrKQ72AN5BxtNDOJ1ML2JVGYC/L78FaEZZla//K+mRR1koGwG0j/Xfi7++OUCbvMWq8YXJbMk0F1xdPcCHjS1sg8x4XtakpGWu0G3ZVG3cyoJEOH1QA2PXrAH9jLpjfiKWhU0fZ0Oyt8Fkpx1K5t7LCbHp2BnLApcxbpJzPcgdmuvR2xNotM9EgmZpGU8o5yD1i+NNTtEuzuYMbrxpiLatMlBc7oFXNT05r1wxyBf3Ot86Bu1bcAQCOQwQQhGykUoSp/lFDfO0/3DUaYZGNsVOgQjlRBLbQoN5tkKiejDOX/W+TIux2pvY9Vwc42PZ1HAtI92sovL2Mifk18h9YSD/qoqUzO78LzFA9v6N4Fms9a4s2GzYs21/Q1I6UIQWeHtL58z8TGhShsjT+G5LoBh3WdbFY7IqzbcWCUi6aKF+i5P2ABJ6x+oKgIX5eKS5n4NJef+oqu6uZJZfkrW5G2RznTR8M+3PdG6yNtHuWypeP+xS5nCQmAi8KT5E3a9keVVvO069Lyxm6PHDvmq76W13cHez6mVV5WAE8Q3W1PTi9cbEq+zVz2FrvGGIadHJg4cyTemL1W8xWEHKaJ75ZNBmiVXRUZX4k6aemKnZj9ptbq86r0MfiJ0tEA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f312960-7800-4dff-d496-08d8569331a2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 20:42:26.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOtEfreI7gTmcZodehSa6iVFULxxsm/KLroYQl8ay4dNMfsUe94OcgsCLy0zjF4/H/kcQbbA8+vStCB3C6jw8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linux Kernel uses ACPI Boot Error Record Table (BERT) to report fatal
errors that occurred in a previous boot. The MCA errors in the BERT are
reported using the x86 Processor Error Common Platform Error Record (CPER)
format. Currently, the record prints out the raw MSR values and AMD relies
on the raw record to provide MCA information.

Extract the raw MSR values of MCA registers from the BERT and feed it into
the standard mce_log() function through the existing x86/MCA RAS
infrastructure. This will result in better decoding from the EDAC MCE
decoder or the default notifier.

The implementation is SMCA specific as the raw MCA register values are
given in the register offset order of the MCAX address space.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
Link:
https://lkml.kernel.org/r/20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com

v3:
	Moved arch specific declarations from generic header file to arch
	specific header file.
	Cleaned additional declarations which are unnecessary.
	Included the check for context type.
	Added a check to verify for the first MSR address in the register
	layout.
v2:
	Fixed build error reported by kernel test robot.
	Passed struct variable as function argument instead of entire struct
---
 arch/x86/include/asm/acpi.h     | 11 +++++++++
 arch/x86/include/asm/mce.h      |  3 +++
 arch/x86/kernel/acpi/apei.c     |  9 +++++++
 arch/x86/kernel/cpu/mce/apei.c  | 42 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper-x86.c | 10 +++++---
 5 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index ca0976456a6b..fb8404f65ab4 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -161,6 +161,8 @@ extern int x86_acpi_numa_init(void);
 
 #define acpi_unlazy_tlb(x)	leave_mm(x)
 
+struct cper_ia_proc_ctx;
+
 #ifdef CONFIG_ACPI_APEI
 static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 {
@@ -179,6 +181,15 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 	 */
 	return PAGE_KERNEL_NOENC;
 }
+
+int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+			       u64 lapic_id);
+#else
+static inline int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+					     u64 lapic_id)
+{
+	return -EINVAL;
+}
 #endif
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS (max_low_pfn_mapped << PAGE_SHIFT)
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 109af5c7f515..c4e055d45905 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -287,6 +287,9 @@ struct cper_sec_mem_err;
 extern void apei_mce_report_mem_error(int corrected,
 				      struct cper_sec_mem_err *mem_err);
 
+struct cper_ia_proc_ctx;
+int apei_mce_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id);
+
 /*
  * Enumerate new IP types and HWID values in AMD processors which support
  * Scalable MCA.
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index c22fb55abcfd..13d60a91eaa0 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -43,3 +43,12 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	apei_mce_report_mem_error(sev, mem_err);
 #endif
 }
+
+int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
+{
+	int err = -EINVAL;
+#ifdef CONFIG_X86_MCE
+	err = apei_mce_report_x86_error(ctx_info, lapic_id);
+#endif
+	return err;
+}
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index af8d37962586..65001d342302 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -26,6 +26,8 @@
 
 #include "internal.h"
 
+#define MASK_MCA_STATUS 0xC0002001
+
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
 	struct mce m;
@@ -51,6 +53,46 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 }
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
+int apei_mce_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
+{
+	const u64 *i_mce = ((const void *) (ctx_info + 1));
+	unsigned int cpu;
+	struct mce m;
+
+	if (!boot_cpu_has(X86_FEATURE_SMCA))
+		return -EINVAL;
+
+	if ((ctx_info->msr_addr & MASK_MCA_STATUS) != MASK_MCA_STATUS)
+		return -EINVAL;
+
+	mce_setup(&m);
+
+	m.extcpu = -1;
+	m.socketid = -1;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu_data(cpu).initial_apicid == lapic_id) {
+			m.extcpu = cpu;
+			m.socketid = cpu_data(m.extcpu).phys_proc_id;
+			break;
+		}
+	}
+
+	m.apicid = lapic_id;
+	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
+	m.status = *i_mce;
+	m.addr = *(i_mce + 1);
+	m.misc = *(i_mce + 2);
+	/* Skipping MCA_CONFIG */
+	m.ipid = *(i_mce + 4);
+	m.synd = *(i_mce + 5);
+
+	mce_log(&m);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(apei_mce_report_x86_error);
+
 #define CPER_CREATOR_MCE						\
 	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
 		  0x64, 0x90, 0xb8, 0x9d)
diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 2531de49f56c..2f2b0c431c18 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2018, Advanced Micro Devices, Inc.
 
 #include <linux/cper.h>
+#include <linux/acpi.h>
 
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
@@ -347,9 +348,12 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 			       ctx_info->mm_reg_addr);
 		}
 
-		printk("%sRegister Array:\n", newpfx);
-		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
-			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+		if (ctx_info->reg_ctx_type != CTX_TYPE_MSR ||
+		    arch_apei_report_x86_error(ctx_info, proc->lapic_id)) {
+			printk("%sRegister Array:\n", newpfx);
+			print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
+				       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+		}
 
 		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
 	}
-- 
2.17.1

