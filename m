Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF2442703C
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbhJHSIr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:08:47 -0400
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:64544
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240524AbhJHSIB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgkCETqtrN8gnugS9HL+sWeylKQcJn0sj9cfaX+8cRX2Pj88lHqmF1dgiUSOt9HcCE3rIcM4Nsr/0Jn40MZqslrKZvLwKZmCjbXWpFJvHxtFH9vq9K2eAIiSE4G5X2d9krPOvLWF0mm6UOkqOLkOCgHKM6V2fwUWVot7DvGv/nRz0X7rOjKT0qNalfVaDZKuEAxqU3WdtUBwwhSZzyKGiSe5YNKb7KZG2FbfdC+zezjS4FDr0o+u/QfEv8FCjjiL3q4oRrDe+DCkq4TqnJMfzcinXWyAbdmFmHHH2kjcqo5ncKsQiObNT9tDM7qEX70/HXv18ysYWEJhr1r7g2aG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym8hO/njHUADg4Aihq1W5EWH7KnAoPWZEsHldi7upsg=;
 b=Xc8iKE84co2U/s/sBGs6dmZwptYtMyJws9oQzR7vWy6zOAvdsB34VSbn0gXr5v3ODSbLkANEWv9psCi95tNJgF2WgXZhD/OIVm8SkchHBGVS13RzmgxmgfjWswLKArTWBYNXW5ntJGkjgm2BzYXrWNXKqfgSuRDTg3xy4DE2fslDeEdBPRjFTNGflWobozxTUSqMYV3nSh39jQzvkLoc3ZOJNawVVrWr+EMoZkZTI6T+dCcKGgkdWEVV9ljB3fppMZPsQXx43zMu4uxR+gQJseEyrm8GL8vroZmsn/WOp/029hasug53/YkFi/S46f0JNHTnS/d7wyZgnr2ILl9gHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym8hO/njHUADg4Aihq1W5EWH7KnAoPWZEsHldi7upsg=;
 b=ZVa96w6/31UsMA9y7kZdkOX40aebphzZHUTnR+2jnvO0Ttkv7nX7ps91KuiuvY8arJ6p8/EEvl8GT7unmzudajcqEnbcWFVxE+hvFe2+e5EMIgFuA/A2UY3fMISIyyEKFhucthjUqDQRSdi89fg9DOzZQtQnBxe/WmYHWzxesyY=
Received: from MWHPR20CA0033.namprd20.prod.outlook.com (2603:10b6:300:ed::19)
 by CH2PR12MB3656.namprd12.prod.outlook.com (2603:10b6:610:15::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 18:06:01 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::a2) by MWHPR20CA0033.outlook.office365.com
 (2603:10b6:300:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:00 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:58 -0500
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v6 28/42] x86/compressed/acpi: move EFI system table lookup to helper
Date:   Fri, 8 Oct 2021 13:04:39 -0500
Message-ID: <20211008180453.462291-29-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3cfeeb2-7062-40de-3338-08d98a864903
X-MS-TrafficTypeDiagnostic: CH2PR12MB3656:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3656C3ADBD82C716840AE260E5B29@CH2PR12MB3656.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eylEkm0Sm1yOWm7Iu3haZjwclq95UGdaMvu3AVqkipaBcLJxK3pc50KjoPOIFBWXMthiOYBPHRct6FXSDK8v51gGmbNL/B3OKAOy6sJVbSB5nzGyYuhBLObHNJAFLvb4uGRC0m5RhZqn2Xo7U8VJkRZYIxE0vkYYO4bt3/16aIbKjhbfZIyXge3oEjDKHCn8pnpsbxeldtXIfISvNg8kwfH0vpwbuSsoFU/4aw/Ta33wcttHQey9Bw7EngVxRcb4hmxugr6fniSIOBRsRBPCqiOmF9LN3J0RkU2rzkeYAxflnkXacUQyaLusMG75jb+XxQHoaYCtM/k4jXrbUh4uSyXbkRKJWcqKiovAV5FPE2K4ty7o4DDggLQufRlEO1a6mQpbmPFwVKR5zjFSsS6XYHUAVpCWbG33/4S12TLupOeGCV5u0dPY8cSv+yxi3fnxq3Ati6012aL9L4y3YF/Pd5wCnPOhYJSfmVm+Gv+wvS7WEbL9fqGrH7yFEpIp7XS2jF0HxWbGiNw1pn21D8XdDVEBrvBZjXFRjfhbY47GUEMXhrJj3zTik7jChzMzVbcFG4jDYlU4YlP1BpZgO0NaVBWW6sFTXJ3H+u/EMGBkPugU2l8VMahlZudhgpJztQ7/IgVGqKhyXgj4BmnJ10Q7cSA5gTqy+H/gvqhxJNKa79/AQu6r3M4nCUldfpJ+NpYv2khWyICSlJYjySFnXkhDEKbOs5ROX8HCQtf9l+wW0kZtCwMCwoazK3AvJyHtYj0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(81166007)(36860700001)(110136005)(70206006)(26005)(508600001)(16526019)(7406005)(316002)(47076005)(356005)(1076003)(86362001)(7416002)(426003)(44832011)(336012)(5660300002)(36756003)(83380400001)(8676002)(186003)(8936002)(54906003)(4326008)(2616005)(82310400003)(70586007)(6666004)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:00.3303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cfeeb2-7062-40de-3338-08d98a864903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3656
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Future patches for SEV-SNP-validated CPUID will also require early
parsing of the EFI configuration. Incrementally move the related code
into a set of helpers that can be re-used for that purpose.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/acpi.c   | 18 ++++-----
 arch/x86/boot/compressed/efi.c    | 64 +++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h   | 14 +++++++
 4 files changed, 87 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f846c3..d364192c2367 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -100,6 +100,7 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
+vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 8bcbcee54aa1..255f6959c090 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -86,8 +86,8 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 {
 	efi_system_table_64_t *systab;
 	struct efi_setup_data *esd;
-	struct efi_info *ei;
-	char *sig;
+	bool efi_64;
+	int ret;
 
 	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
 	if (!esd)
@@ -98,18 +98,16 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
 		return 0;
 	}
 
-	ei = &boot_params->efi_info;
-	sig = (char *)&ei->efi_loader_signature;
-	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+	/* Get systab from boot params. */
+	ret = efi_get_system_table(boot_params, (unsigned long *)&systab, &efi_64);
+	if (ret)
+		error("EFI system table not found in kexec boot_params.");
+
+	if (!efi_64) {
 		debug_putstr("Wrong kexec EFI loader signature.\n");
 		return 0;
 	}
 
-	/* Get systab from boot params. */
-	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
-	if (!systab)
-		error("EFI system table not found in kexec boot_params.");
-
 	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables, true);
 }
 #else
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
new file mode 100644
index 000000000000..306b287b7368
--- /dev/null
+++ b/arch/x86/boot/compressed/efi.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers for early access to EFI configuration table
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Michael Roth <michael.roth@amd.com>
+ */
+
+#include "misc.h"
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+/**
+ * Given boot_params, retrieve the physical address of EFI system table.
+ *
+ * @boot_params:        pointer to boot_params
+ * @sys_tbl_pa:         location to store physical address of system table
+ * @is_efi_64:          location to store whether using 64-bit EFI or not
+ *
+ * Returns 0 on success. On error, return params are left unchanged.
+ */
+int efi_get_system_table(struct boot_params *boot_params, unsigned long *sys_tbl_pa,
+			 bool *is_efi_64)
+{
+	unsigned long sys_tbl;
+	struct efi_info *ei;
+	bool efi_64;
+	char *sig;
+
+	if (!sys_tbl_pa || !is_efi_64)
+		return -EINVAL;
+
+	ei = &boot_params->efi_info;
+	sig = (char *)&ei->efi_loader_signature;
+
+	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+		efi_64 = true;
+	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
+		efi_64 = false;
+	} else {
+		debug_putstr("Wrong EFI loader signature.\n");
+		return -ENOENT;
+	}
+
+	/* Get systab from boot params. */
+#ifdef CONFIG_X86_64
+	sys_tbl = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
+#else
+	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
+		debug_putstr("Error: EFI system table located above 4GB.\n");
+		return -EINVAL;
+	}
+	sys_tbl = ei->efi_systab;
+#endif
+	if (!sys_tbl) {
+		debug_putstr("EFI system table not found.");
+		return -ENOENT;
+	}
+
+	*sys_tbl_pa = sys_tbl;
+	*is_efi_64 = efi_64;
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 822e0c254b9a..f86ff866fd7a 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -21,6 +21,7 @@
 #include <linux/screen_info.h>
 #include <linux/elf.h>
 #include <linux/io.h>
+#include <linux/efi.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
@@ -174,4 +175,17 @@ void boot_stage2_vc(void);
 
 unsigned long sev_verify_cbit(unsigned long cr3);
 
+#ifdef CONFIG_EFI
+/* helpers for early EFI config table access */
+int efi_get_system_table(struct boot_params *boot_params,
+			 unsigned long *sys_tbl_pa, bool *is_efi_64);
+#else
+static inline int
+efi_get_system_table(struct boot_params *boot_params,
+		     unsigned long *sys_tbl_pa, bool *is_efi_64)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_EFI */
+
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.25.1

