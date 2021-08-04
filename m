Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAAE3E04EE
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 17:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhHDPx2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 11:53:28 -0400
Received: from mail-bn8nam08on2132.outbound.protection.outlook.com ([40.107.100.132]:57601
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239206AbhHDPx2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 11:53:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnJVA7qMPt0Z5YkUwUfEm9wccedyf57eIoGhdVcU2O93K0xFgPdD+01bRvHU8aIC14k+cUezCdU9+Pe6nJH4rOBGCHkV3+YctWSMYn5HPteBjTEs5EO8KL/V5w6fWAhefLwb44sfKiI8HefnW+OtpFHJ6fqU9X311o2/0LOtpdi78Njz6TYEC2pc1EUeGjBTBdbcmOZRF6ZDYvjbs++On0t9dWea7Hy4eSXV8msnKhfsWg3O68oeo4nPwT/nuBrLu7+Ia/physMSW6qhZMPXakBBtjYBH1XdtShE1sqbvxDhRxqx9u5E9CdggvHFI9ekwdNAiyNBT59C5REHxnGAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvNCojoRZoE+wNtnejsTm8UK5OmTGOwqzFoxNWA7a7Q=;
 b=D6rb+S41sgsgCTWTy8q4q75Ubet2cYME0DtBPOGKvjccrw8vJ0kgUf84WG8mjbEmIsSDpaW+711OBkvQp/cGmQGTRU23kqr83njGAXZE7gyNYZ+XlBqoJc+Pt+yMz8BNihm4xfiZT9VvELbPPql9nTlxyxQOqOf00hpol0qQMh5j2N+IqY5MOLyPTgNWSvBOzjR/Yjeg9aukfuh/+iqr2Ngp7zshBatjURgI7xRDr0XZB5YIVNTP/cbOgkM7NyPPuLxPNQpJVo6Aner9aLb5ODmczraHWRU0VexqhSNrTieW1NpTfco1MI48k5AlpiQE+EBBeHehK/IMAc1Jy6UlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvNCojoRZoE+wNtnejsTm8UK5OmTGOwqzFoxNWA7a7Q=;
 b=joITtJiMaXadnfOQ1yX3DPXYSrdVESr3yb+C6WQ78g0gqA/lUsGMxs9gkJHqUiiYVIOSH8hpCvynAbd26BgrJziET4DEHWDaVvg8paUA5D0zd+H2ldlK98VBvBeWeHyQu1udN20I1t3MoyL448LGcHKdAkcGiLi1LF8rmQKgWgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1094.namprd21.prod.outlook.com (2603:10b6:4:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Wed, 4 Aug
 2021 15:53:10 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670%9]) with mapi id 15.20.4415.005; Wed, 4 Aug 2021
 15:53:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v12 1/5] arm64: hyperv: Add Hyper-V hypercall and register access utilities
Date:   Wed,  4 Aug 2021 08:52:35 -0700
Message-Id: <1628092359-61351-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:104:4::29) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by CO2PR04CA0175.namprd04.prod.outlook.com (2603:10b6:104:4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 15:53:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b15b44c-28ab-4f23-83f6-08d9575ff5c0
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1094:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB10941C782EC31091B1235E93D7F19@DM5PR2101MB1094.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jc7IyzLfv7eqMnAqPGzQQRBZx32krDM7OcGnUMitG8IcXWoXuEglgpsF2xC3PHORln6qko9iGq900Qd8KK5gw3uT5cwpqiCyW3R/YZm7peEe+EBQcbuGhpqTkYJuk40undgT6NB3lp+WaQznqmhbXZQDfznaldat7waY3UF1Iq3C3zzK0yan/q5RM5QOcVbevy9B7bi4+7LzmpyO41f+UYyrEdi2ZgC/psD2LpabyyR7UdIS9rZeFb6D7Ky3xOi+OPyAKVwj+0mE3AycM3/qDcnBu/J211p0bAMnHdktl5GbAG/8mY1In+BfGfq/7PGnzuQglirl2AXbX4EayokF4MnkFFxVzykBRqGh7tntPejCweLoTd3TdC1hRSjG8sc7ZVyHdG++uEBtKUNJfkB4r8+qJdWFtRCyIvqUnBZ4VOQ0Vjz+5Oli1fsYCtsK+EVQLtVG4CbWwvsYIxw/jn1Piv8J2FtQHvLHy+eMG4+1YBYzAHSQDRSgX0VeuMKcsQ1OIvN5xEOtyOsXK/iXPXwNpNxCF4anLPFCThivCFznop9pPgnbFzkDqFEsn2FCYJUVjzRXAf+JTQH+zWPfMLRbgqpmbeVrCwU25K4fewRQQEZZSWNECS8HuG/8ObAOoUFUxFZ4/kjmozDoanCWuFHsP4ifzAIc/WLxA2QuFdZR6c8XCntDZRJBY9K59XC/lIuxrPmn71NgSEW4CBxFk0nrsP7dhTxKgsx4aofbCdBulkZfGRvUTBN6utm6G7LXMjBckQFjKbXQrIOdsRVjXYOc0qbZE8Lf8Ood8MjmMEWqR3p9pFNaNv4GSw8EJ41ft6pI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(52116002)(6666004)(186003)(7696005)(86362001)(82950400001)(82960400001)(508600001)(10290500003)(921005)(38100700002)(38350700002)(83380400001)(2906002)(66476007)(36756003)(2616005)(66556008)(107886003)(8676002)(66946007)(956004)(966005)(4326008)(8936002)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XgYnihePhWfXosJG2UZtvuNXrUG/l0ADXmHABKyedQf2TJ2jSzw6drtGcBN9?=
 =?us-ascii?Q?upn1Cfm2eKY2yyr18prn79uOLYZo8611qAAklJTgZFLK1RLjaU0ogql8pdYN?=
 =?us-ascii?Q?NX4yo7l/VBR4vB0lbBh8TBKI87zSeIdG9UIRYxQbjSL+1QaAuqW/nAs46ppU?=
 =?us-ascii?Q?oPwwnoljRzBWuxBfBMOU/m8PR9EzWaanxlcfnup89pNw2frlvom21eVqDEFD?=
 =?us-ascii?Q?B2ZJY/SgdS6ikDvYwjXDeQwDCcW/So8PD0Fer4jGQtn0AMiSjWLzH6WSbyYY?=
 =?us-ascii?Q?RkOlTVSlcJL94CFM6kGSnUmUTvtJEbj71/GEe2el+lHX2s/gEbUyP+cC0jBT?=
 =?us-ascii?Q?U41Pp5qcFN2EsLFhOCO8pCWB7ezvoD4fsey49hvRkGAT2GT5cQjOkhoi1bdo?=
 =?us-ascii?Q?Y0LF/uHwPGHjOSs2fYmyJMnxRVdSs3M0gZHJrduV1/o0RRCmXxGpyh+/qgtV?=
 =?us-ascii?Q?ilNSnAoffYEX925lLbipO0aBNvfTqeQ7SmXhi1tw1gLqwE1wHEU1KiEOE+VA?=
 =?us-ascii?Q?ctfcsJugOeonWoaYFCyf738kAY7RvvUQcAwUJMsI4pOlF0uJKjKwKmUBS3kA?=
 =?us-ascii?Q?08Y8+o+8QFkeab78a2sqxgFG0ibRrudTn3Qo3duFhMiLdKOfN54ob2Y+SRtV?=
 =?us-ascii?Q?54NaCTNVnVch/ddIUWSOuusLu/oPu44wWZ5+6W2TIbhIsUwaGw5nagF+Tb/P?=
 =?us-ascii?Q?HRKyv7zf+kafVM9z9nByFXg0YYujTz4aZB3T8KiHVSLiOQ/ysVNNzD1auMu3?=
 =?us-ascii?Q?Nkelxit5owZt0kKDwBN6BmoncXZaPl/Q9YvNio9qJvcfSH5YY/QFtnVVLjOg?=
 =?us-ascii?Q?zleFoHdEqRzteTp8ELgZkt50bIJEi++eSOBxkbLu8jtfg2pfLWUDGDQ2YHL8?=
 =?us-ascii?Q?llHx+c1VHPthp/qXcUFNFlqhyX5dKn0SfDhmlI8g/1sUXvQ6mTU4lL2JvJit?=
 =?us-ascii?Q?LPkAmMhLUn1b0CspmoVdYZdXPqauNPom+SkGjwWRJKo3G4vMijPzrqdXLry4?=
 =?us-ascii?Q?Sors2WHbed7KIuODsNixoEct/i0pL1NSEYT9QAJOPEV4NAO/h1za1afnNWG6?=
 =?us-ascii?Q?N8bY1ulZqf/zvGnzLdWdqwhDtjr8F0T3R4dz+1iPFwxd1w1xNN9qZ6XoFJF3?=
 =?us-ascii?Q?L69PSxXMWi04Bhyt2iViU/2+dBLCQMhJgX8eb4yh00IweEjSN+v4zpOQJeuH?=
 =?us-ascii?Q?qIqVcJKqYUYuIf5o6TjlR+/xBK/tdM/Co3iraNwDtAW4KUD6JgBTgqcmZi3g?=
 =?us-ascii?Q?X063a793M3NKFIloVmko7SWo6bgrTLnz0zdcnWjuLZ+EDVYs5zA8vDngm4ab?=
 =?us-ascii?Q?32Xq4cKARjhadte0CMGq9iIe?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b15b44c-28ab-4f23-83f6-08d9575ff5c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 15:53:10.7315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhQspp8D1nZWrY5pZnOkXf43grDQTlGX5gAvIAsgxSjZTCpaXpDDleLs1skms4o1gHL9EcCaRxY1Q3azFHGk8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

hyperv-tlfs.h defines Hyper-V interfaces from the Hyper-V Top Level
Functional Spec (TLFS), and #includes the architecture-independent
part of hyperv-tlfs.h in include/asm-generic.  The published TLFS
is distinctly oriented to x86/x64, so the ARM64-specific
hyperv-tlfs.h includes information for ARM64 that is not yet formally
published. The TLFS is available here:

  docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs

mshyperv.h defines Linux-specific structures and routines for
interacting with Hyper-V on ARM64, and #includes the architecture-
independent part of mshyperv.h in include/asm-generic.

Use these definitions to provide utility functions to make
Hyper-V hypercalls and to get and set Hyper-V provided
registers associated with a virtual processor.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>

---
 MAINTAINERS                          |   3 +
 arch/arm64/Kbuild                    |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_core.c          | 129 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h    |  54 +++++++++++++++
 6 files changed, 258 insertions(+)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6993219..8f6f429 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8608,6 +8608,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 F:	Documentation/ABI/testing/debugfs-hyperv
 F:	Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
+F:	arch/arm64/hyperv
+F:	arch/arm64/include/asm/hyperv-tlfs.h
+F:	arch/arm64/include/asm/mshyperv.h
 F:	arch/x86/hyperv
 F:	arch/x86/include/asm/hyperv-tlfs.h
 F:	arch/x86/include/asm/mshyperv.h
diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index 7b393cf..ea7ab4c 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -2,4 +2,5 @@
 obj-y			+= kernel/ mm/ net/
 obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/
+obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
 obj-$(CONFIG_CRYPTO)	+= crypto/
diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
new file mode 100644
index 0000000..1697d30
--- /dev/null
+++ b/arch/arm64/hyperv/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y		:= hv_core.o
diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
new file mode 100644
index 0000000..4c5dc0f
--- /dev/null
+++ b/arch/arm64/hyperv/hv_core.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Low level utility routines for interacting with Hyper-V.
+ *
+ * Copyright (C) 2021, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/hyperv.h>
+#include <linux/arm-smccc.h>
+#include <linux/module.h>
+#include <asm-generic/bug.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+
+/*
+ * hv_do_hypercall- Invoke the specified hypercall
+ */
+u64 hv_do_hypercall(u64 control, void *input, void *output)
+{
+	struct arm_smccc_res	res;
+	u64			input_address;
+	u64			output_address;
+
+	input_address = input ? virt_to_phys(input) : 0;
+	output_address = output ? virt_to_phys(output) : 0;
+
+	arm_smccc_1_1_hvc(HV_FUNC_ID, control,
+			  input_address, output_address, &res);
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(hv_do_hypercall);
+
+/*
+ * hv_do_fast_hypercall8 -- Invoke the specified hypercall
+ * with arguments in registers instead of physical memory.
+ * Avoids the overhead of virt_to_phys for simple hypercalls.
+ */
+
+u64 hv_do_fast_hypercall8(u16 code, u64 input)
+{
+	struct arm_smccc_res	res;
+	u64			control;
+
+	control = (u64)code | HV_HYPERCALL_FAST_BIT;
+
+	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input, &res);
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
+
+/*
+ * Set a single VP register to a 64-bit value.
+ */
+void hv_set_vpreg(u32 msr, u64 value)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(HV_FUNC_ID,
+		HVCALL_SET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COMP_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		0,
+		value,
+		0,
+		&res);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * setting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(!hv_result_success(res.a0));
+}
+EXPORT_SYMBOL_GPL(hv_set_vpreg);
+
+/*
+ * Get the value of a single VP register.  One version
+ * returns just 64 bits and another returns the full 128 bits.
+ * The two versions are separate to avoid complicating the
+ * calling sequence for the more frequently used 64 bit version.
+ */
+
+void hv_get_vpreg_128(u32 msr, struct hv_get_vp_registers_output *result)
+{
+	struct arm_smccc_1_2_regs args;
+	struct arm_smccc_1_2_regs res;
+
+	args.a0 = HV_FUNC_ID;
+	args.a1 = HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COMP_1;
+	args.a2 = HV_PARTITION_ID_SELF;
+	args.a3 = HV_VP_INDEX_SELF;
+	args.a4 = msr;
+
+	/*
+	 * Use the SMCCC 1.2 interface because the results are in registers
+	 * beyond X0-X3.
+	 */
+	arm_smccc_1_2_hvc(&args, &res);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * getting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(!hv_result_success(res.a0));
+
+	result->as64.low = res.a6;
+	result->as64.high = res.a7;
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
+
+u64 hv_get_vpreg(u32 msr)
+{
+	struct hv_get_vp_registers_output output;
+
+	hv_get_vpreg_128(msr, &output);
+
+	return output.as64.low;
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg);
diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/hyperv-tlfs.h
new file mode 100644
index 0000000..4d964a7
--- /dev/null
+++ b/arch/arm64/include/asm/hyperv-tlfs.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This file contains definitions from the Hyper-V Hypervisor Top-Level
+ * Functional Specification (TLFS):
+ * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
+ *
+ * Copyright (C) 2021, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+#ifndef _ASM_HYPERV_TLFS_H
+#define _ASM_HYPERV_TLFS_H
+
+#include <linux/types.h>
+
+/*
+ * All data structures defined in the TLFS that are shared between Hyper-V
+ * and a guest VM use Little Endian byte ordering.  This matches the default
+ * byte ordering of Linux running on ARM64, so no special handling is required.
+ */
+
+/*
+ * These Hyper-V registers provide information equivalent to the CPUID
+ * instruction on x86/x64.
+ */
+#define HV_REGISTER_HYPERVISOR_VERSION		0x00000100 /*CPUID 0x40000002 */
+#define HV_REGISTER_FEATURES			0x00000200 /*CPUID 0x40000003 */
+#define HV_REGISTER_ENLIGHTENMENTS		0x00000201 /*CPUID 0x40000004 */
+
+/*
+ * Group C Features. See the asm-generic version of hyperv-tlfs.h
+ * for a description of Feature Groups.
+ */
+
+/* Crash MSRs available */
+#define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE	BIT(8)
+
+/* STIMER direct mode is available */
+#define HV_STIMER_DIRECT_MODE_AVAILABLE		BIT(13)
+
+/*
+ * Synthetic register definitions equivalent to MSRs on x86/x64
+ */
+#define HV_REGISTER_CRASH_P0		0x00000210
+#define HV_REGISTER_CRASH_P1		0x00000211
+#define HV_REGISTER_CRASH_P2		0x00000212
+#define HV_REGISTER_CRASH_P3		0x00000213
+#define HV_REGISTER_CRASH_P4		0x00000214
+#define HV_REGISTER_CRASH_CTL		0x00000215
+
+#define HV_REGISTER_GUEST_OSID		0x00090002
+#define HV_REGISTER_VP_INDEX		0x00090003
+#define HV_REGISTER_TIME_REF_COUNT	0x00090004
+#define HV_REGISTER_REFERENCE_TSC	0x00090017
+
+#define HV_REGISTER_SINT0		0x000A0000
+#define HV_REGISTER_SCONTROL		0x000A0010
+#define HV_REGISTER_SIEFP		0x000A0012
+#define HV_REGISTER_SIMP		0x000A0013
+#define HV_REGISTER_EOM			0x000A0014
+
+#define HV_REGISTER_STIMER0_CONFIG	0x000B0000
+#define HV_REGISTER_STIMER0_COUNT	0x000B0001
+
+#include <asm-generic/hyperv-tlfs.h>
+
+#endif
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
new file mode 100644
index 0000000..20070a8
--- /dev/null
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Linux-specific definitions for managing interactions with Microsoft's
+ * Hyper-V hypervisor. The definitions in this file are specific to
+ * the ARM64 architecture.  See include/asm-generic/mshyperv.h for
+ * definitions are that architecture independent.
+ *
+ * Definitions that are specified in the Hyper-V Top Level Functional
+ * Spec (TLFS) should not go in this file, but should instead go in
+ * hyperv-tlfs.h.
+ *
+ * Copyright (C) 2021, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+#ifndef _ASM_MSHYPERV_H
+#define _ASM_MSHYPERV_H
+
+#include <linux/types.h>
+#include <linux/arm-smccc.h>
+#include <asm/hyperv-tlfs.h>
+
+/*
+ * Declare calls to get and set Hyper-V VP register values on ARM64, which
+ * requires a hypercall.
+ */
+
+void hv_set_vpreg(u32 reg, u64 value);
+u64 hv_get_vpreg(u32 reg);
+void hv_get_vpreg_128(u32 reg, struct hv_get_vp_registers_output *result);
+
+static inline void hv_set_register(unsigned int reg, u64 value)
+{
+	hv_set_vpreg(reg, value);
+}
+
+static inline u64 hv_get_register(unsigned int reg)
+{
+	return hv_get_vpreg(reg);
+}
+
+/* SMCCC hypercall parameters */
+#define HV_SMCCC_FUNC_NUMBER	1
+#define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
+				ARM_SMCCC_STD_CALL,		\
+				ARM_SMCCC_SMC_64,		\
+				ARM_SMCCC_OWNER_VENDOR_HYP,	\
+				HV_SMCCC_FUNC_NUMBER)
+
+#include <asm-generic/mshyperv.h>
+
+#endif
-- 
1.8.3.1

