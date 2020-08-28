Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10D1256215
	for <lists+linux-efi@lfdr.de>; Fri, 28 Aug 2020 22:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgH1UeJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Aug 2020 16:34:09 -0400
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:27873
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbgH1UeG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Aug 2020 16:34:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFNBuw5JlNVFpf3MsALe3+3I2xiXhWvuNG6niAsxx24UxWJiUpQONespx5Fr5pHsTMCj5YSCJWDP1rMHixwxYQaHS/20cX8kuTp5psQlGM4iHuU45SjKOd5p1Jhs7Qv4Izt/5pzwmIosM9IitEqYJ0YD6W1MXKIfyAFEVxeSK7Qxi4krsgRFAYgd9vs4UOq7pOOxhb3OMlfayPt++uIpMCEk5s3C4leB3Ag9wx2aZKM21i64xHzhZCvUULo9nPs85BcyhcMhBKSO3yHWBawcv6kFHw22g83mzU0FwqXTxUKR2eyhni4DTmy+skdxtCapLZK8l0X8ylHKbe7xEEYfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dD83NgoTYGK25plA5Tacc/caHrUopAWDiE/e3paX7rM=;
 b=l02DaqN0mGDJ5Ux6yLOFPWs9dteKJPllOrlcxt8KPDl3PupaQvYUE9/Ticu1WgBq0fHlqRjdi5oGoF0cWB30lHKHyW55AxUatgmscyE3hJZglNfh5F3748fYMZaPxgOyc4NLdo8cdrqzP8coaPlT1sttIQS+BrrRoIe9AGN2hpN9D8JYewAvqFJo07qw2BhmCiWfNxbhYly6k5xJq89zS/ZnOhr2cqEvXZs9md7wKPyh/4o3R6pSzHMvocB1VpFQLtpP7Y8GBN0Jp3ev2AZ8dbJfGNCB2tEFQ8qDcT4bADHMuKCqoOpMyv1din9T4x2SQNwHMXpYISjT1pPZt0KUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dD83NgoTYGK25plA5Tacc/caHrUopAWDiE/e3paX7rM=;
 b=2dgdfL1sajnXFdMF+ImWQglwKsh8rjSGpaJM/IcgkkIiS7C3hx1qDAFN0htyJA52GlZZVVnIgAEI55VMO7Kj3nSoIakkExTB/TZHMw4fSd8qbr5Zmn4qlWrDw6a1wXwYlgioxWVZKFd9L+VmdXk6+Qq8xlueP/rxb7ISApjJqoI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 20:33:57 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86%5]) with mapi id 15.20.3326.019; Fri, 28 Aug 2020
 20:33:57 +0000
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
Subject: [PATCH v2 1/2] cper, apei, mce: Pass x86 CPER through the MCA handling chain
Date:   Fri, 28 Aug 2020 15:33:31 -0500
Message-Id: <20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0143.namprd05.prod.outlook.com
 (2603:10b6:803:2c::21) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0143.namprd05.prod.outlook.com (2603:10b6:803:2c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend Transport; Fri, 28 Aug 2020 20:33:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 775f67de-1b02-4671-7344-08d84b91b02e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45113E7BFC928022C72BA03F90520@SA0PR12MB4511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugGZO/bTDqlm5X3MOzeLT9/7jxt+Z24cu7ekbUkB1Pzh5HQ53Mz5g5FqXG2v261sf2rY1AdF5xXD09puvAlTFuucWoJJ9pMT0OhI0vHnDnQlC8Jw/mIIsXZIeVnwW4FSACFSSfZPF3uefVRR8hVmL42N2/bR/N84Feh5/1z77dTGaNYxc+Luz5xxqevoFbuQBqSc1F+VeFkhB8jH5+e305Jpow+cd+kEpDARBClPopc3unkwAqQkBUgc+w7iyCtKa+MnYdSXw//Abs+Mt5EPIJK7vZ6LFoc2HMFOSP4pAMN2pnFWSjdeXoatOy9V4jQEdqqeyvGlEAPwOGHe9pWqtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(5660300002)(8936002)(8676002)(6486002)(956004)(6666004)(2616005)(66556008)(1076003)(4326008)(7416002)(66946007)(66476007)(86362001)(83380400001)(26005)(36756003)(2906002)(186003)(52116002)(54906003)(478600001)(316002)(16576012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7IfvqxFDMOa3Nzf5WtLO8fh5WXdwyJW1q/8hYa4acISGFgBKPBWlbpdkdgPGQfg4h+X3QyYC+g/o+YgHq3+mxzZyj2n3k71Ne1XatlsrFMW1vmz3ANH/ds6VfulPuBOG7DDW0f7EAPhPlUqdQPa1rZ7dNfgmngr3ZTGMZA+F5B0YG1HBrKg0LQO5OFmNGZhuj2GELo7vCmJ9TFekUSsRB6ixasVxNuNGGi+MmlH4+GBqIFvg3gTzQk5zjdh1t7OXj9o1H5Ia0Oh2Jk0KIIo5CRjV0zpsxeIm+IvuiBzKqSAxVvCvC+5Zsla6t70Dcui/+ItTB2kv1zHzd+rX/jIkYWrDWOQfvma+kimTBAqsCYRtSYOl+Mqcw/4+WTQJmTZx+rcSxsFLIl4f8x/LoH1dS0AkXg4I1SkElBHpgm/RMAQnuA/DSrqToqcX5Hp3hM4qZdIEAilZRO+Isgs05VZOZOQ/4EL2hoTRU5KoqiawSd8DBZiwy9gvtEDNNIlkmfiAidPDhcSm1OPetwAh8scewijTXK77D5rocN1xHlEfiFZUyti/kNep/C31i4AxT5WNFB6qXwJumzW9cbm/Wcbwg96+/6BJ9TJJX99jsMjCvMkXCOiV46OXKoxkK3x6xH2PX779yp3CIUACIoOG3Zo/FQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775f67de-1b02-4671-7344-08d84b91b02e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 20:33:57.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECTiMWUcmT+NVY+if8eNo0k1W1UoA63SvE3/BMbYH1EeyDSd4OOQ2Ez/eg2SdKZWgB+9kS+poiFfywR8tbATjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
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
v2:
	Fixed build error reported by kernel test robot.
	Passed struct variable as function argument instead of entire struct

 arch/x86/include/asm/mce.h      |  3 +++
 arch/x86/kernel/acpi/apei.c     |  9 ++++++++
 arch/x86/kernel/cpu/mce/apei.c  | 37 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper-x86.c | 10 +++++----
 include/acpi/apei.h             |  9 ++++++++
 5 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cf503824529c..139a89945225 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -291,6 +291,9 @@ struct cper_sec_mem_err;
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
index af8d37962586..836bd9296116 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -51,6 +51,43 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
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
index 2531de49f56c..374b8e18552a 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2018, Advanced Micro Devices, Inc.
 
-#include <linux/cper.h>
+#include <acpi/apei.h>
 
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
@@ -347,9 +347,11 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 			       ctx_info->mm_reg_addr);
 		}
 
-		printk("%sRegister Array:\n", newpfx);
-		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
-			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+		if (arch_apei_report_x86_error(ctx_info, proc->lapic_id)) {
+			printk("%sRegister Array:\n", newpfx);
+			print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
+				       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+		}
 
 		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
 	}
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index 680f80960c3d..44d4d08acce0 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -33,8 +33,15 @@ extern bool ghes_disable;
 
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
+int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+			       u64 lapic_id);
 #else
 static inline void acpi_hest_init(void) { return; }
+static inline int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+					     u64 lapic_id)
+{
+	return -EINVAL;
+}
 #endif
 
 typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
@@ -51,6 +58,8 @@ int erst_clear(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
 void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
+int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+			       u64 lapic_id);
 
 #endif
 #endif
-- 
2.17.1

