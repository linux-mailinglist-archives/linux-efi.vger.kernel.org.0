Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB58831F2E4
	for <lists+linux-efi@lfdr.de>; Fri, 19 Feb 2021 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhBRXSb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Feb 2021 18:18:31 -0500
Received: from mail-bn8nam12on2094.outbound.protection.outlook.com ([40.107.237.94]:21217
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229763AbhBRXSZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Feb 2021 18:18:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9U5PQ1mHxX5uCQLcRlqEkKXVn+j17CLv7/BHRBZLQOIIIT+u2KzPwN6p7rpp4zlAEdI1xkAof255iCEvM1xzGLdGSCZwSscwB4e9fsqx1OsQsnC3G7KXONbsH1hfuS3gVdgVnCQPA7kVfSQb0Z/qcGGP5pbinmOLqfsiX8KM/klLng3+xaFGE+Cd6ylc3CmIxgR97D5PXu6yn8esn3LSKXS/wcFltBsb6wK1+FQ1iOtf43QJbbvB8VuDMCyzT21POKiOQjawAs+HK8HHcr0/4K2nPbrpyDDUCRtTihBCVlcZs/+ef9JBrhkFxoClLvX3Ea0gkQ/1iFr8ERvOseKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHRIObbLnIC7Pg5rsxScQMuf2PF3T8GVylMsrGgifkc=;
 b=REBj+U7S/56izaXI1m/91ARKTsntTsUWcEjBC68I6+Og7oxduG9MBcWFhJoffL+wyaqvtHNYFPXpW0MzH/IIZvSsWFIITG+CUPUMrdXjvr2T+NDSB8aY0AMIy6tTn4C8iN5/cT2TQEklXD9v6NG8q7yO/OrJiRBLb4alWHMWUAZaDVhiGmNcrfld192pKT0cmzpuI+sRl7FdEjynDwUCNEMVTQ3pH+sJJdhJLZxPEVQXrDXP5oQaGBYn3GPw4PeYgMN5g7cPrlN6s90hdP+qGj+aDGTuZZqHUmEJKEXlukYpgddAqhtkLmYEf65rgrZjU6IHMEkNNZGD9ZEWV0cc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHRIObbLnIC7Pg5rsxScQMuf2PF3T8GVylMsrGgifkc=;
 b=G/zGAWJkXagCC32lDiSp7ipJgbV0BTk89SZSNlwQxls+foRYKwDO2mCOLrNaNGoTGHYo+/Z/6BzHQfLaWrB1gFltbr8EeCUSAvWf4NtRtS0I2TjKLyyD+uQ19nKjTM7O0L0LREC4eDZR1v0w5TB8RYPOEawOI7O3UZp+hGylFTs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:5:22d::11) by
 DM5PR2101MB0983.namprd21.prod.outlook.com (2603:10b6:4:a8::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.1; Thu, 18 Feb 2021 23:17:28 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%5]) with mapi id 15.20.3890.002; Thu, 18 Feb 2021
 23:17:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v8 1/6] arm64: hyperv: Add Hyper-V hypercall and register access utilities
Date:   Thu, 18 Feb 2021 15:16:29 -0800
Message-Id: <1613690194-102905-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
References: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.147.144]
X-ClientProxiedBy: MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27)
 To DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.144) by MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 23:17:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c167f813-c26a-440a-3281-08d8d4635bba
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0983:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB098390A8385E9BC8BF7E82D7D7859@DM5PR2101MB0983.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUirR0kwsztLfLFiOmO9SyiDDgG11aDS6UGz1ER2nMPK+7ku8tcXmrTcWhBV64MdwQQuhTa8GmJ24jXfo3CRQ16fm5njS1q2m7jsGxXhp4J0VQO2kFA66a0AM1/FxxlRJLrxKNwpePUWAD2NLJXM6ogVSQk55XXe+18C8OK3+s8TSClQADRT1Esvw2WLaiihTdyu422r25NGT8tLVmWfxXPaefXM7nG0VHmna9l9k9YHteI5YtZMAjo8ffqfAtd0l/Vm10kXgQGzESkPDmC//KFef83Ux3l5I44KScKY+JsXDQQXIJV8Hi7OySKA/KxCFN6AeP9561ZDx/Jc5x8PtDTxZlyBhM3WGQuhDt0wcIT2DsvL9yznJ+K/t2TyHe9h90Gv5meMz6cDJUZqH3AkzQPwbjEns2h2MfCNT+XLbozG32YYVoAr2pT7I6JXR2pKc8X79z8oTeud4nqoVIuCrPgXWpSY8GfIXHUUra7nFbiTRy1PJhgwQORxoooUSUW1Wgl9cBAZNte7x5F/hRzT5rCx7WZ1ZCNNuJjE752A970slyEJ3gaxJ8V+aDK3/oVQZInPB+TadXNY+agT9cnFT9EI8eqyxYAS0Mho00atHhG84Vij0LyHvxk9aoB6iVGuFWZ/HqMKyeI6j+fnze+1OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(966005)(5660300002)(6486002)(921005)(107886003)(8676002)(7416002)(82950400001)(2616005)(4326008)(66476007)(478600001)(2906002)(83380400001)(36756003)(186003)(66556008)(6636002)(66946007)(86362001)(10290500003)(956004)(16526019)(26005)(82960400001)(8936002)(52116002)(7696005)(30864003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Dn2w7TWxDoBMThNW7C1LhTj5Qox4ZsGE+BOrYgB7Ju2bLG/H/RkDt1H2vSvq?=
 =?us-ascii?Q?Kb6Ic5ha3b7ebiBROWSQNqgHqtY/woYAuFUGoK/a2WcEMmMciEj3RCuS17Pn?=
 =?us-ascii?Q?jogtiLKNBYnZ2edjrOXnjvmqzssBTjd4pKeNdFh3C+g56E9eEGAQDd3OMDJ6?=
 =?us-ascii?Q?7f2iR+7CsMTwz2Yizzc0DxS75ZXXVXp7IQdWZdRDhpFBL9jJ58T7SlFQ2Jbr?=
 =?us-ascii?Q?UhaSVV+Hy/ds27PAXRidCLx1maij5tinRRqndOIwlSP/c4wqjQG3uRJKwa5+?=
 =?us-ascii?Q?tioMDn4YQGMMrEDTWUsnoKITFsg+R6xoEtWFNL0KDra8M9lZa3Of6AVhib2Y?=
 =?us-ascii?Q?nMq7RaLzonsKIZkFrZ72TKGqsOphBt/YoTvrkCn1qJOIAJAQ/grUKsYOCa+M?=
 =?us-ascii?Q?9SizO+eHoy/Y+Wsa9bOJhrQFvrP8E2vANzEa2Y0oy5PX7aHlBjY27VJc5R8b?=
 =?us-ascii?Q?hr5WEnzEG+u51rRNUQOx8H0UAOxJIIQbyZyf85hzW3mKNNjgPQWrLIAPP5gq?=
 =?us-ascii?Q?y6Lwo9nv+VSjBTUDM2O8P/QCepuMk959HPbZBeuGpbdKN97CcQB1TgYWIIoJ?=
 =?us-ascii?Q?rvH7dQ3G+Oxfi05irOtlZeI3XsR6GkQxIvFVTcPe1iWsAea0vOoHEOj3dbdy?=
 =?us-ascii?Q?NLh4PN5/Zwf/YrwyfLNHxaZAcTykAPVuSljISoRxD5ZWN8AzcxrFNPhEmvAy?=
 =?us-ascii?Q?adUDVabOPjz6KRHq3flaYPDyR0EaB0R3OeLHSgfL91D3IOj+YdqgylIt7cqK?=
 =?us-ascii?Q?U6ZQPMJZxoP7H/zQ8UM6D1bPxRRGLMupmNzoeNcX8ukTYkdHxkdrLS8fCUxk?=
 =?us-ascii?Q?yGe/UEBn9L7zHEwy0GVar7VpiL1vIri8Lo3WGAMjtDzxcRSstUuheyS8OlDr?=
 =?us-ascii?Q?83kdETAphWJPFBWGOHECxtNAPJtjd4dQpBljneljHGGH1N5VY/FoB0uLmKvW?=
 =?us-ascii?Q?3p8Tk30yKsogXW85Rc7FA4jls2dBhOZOiVSFMi3gsVYlIGtS34ynjyMpmIRh?=
 =?us-ascii?Q?7/pLSDTCReYorVUjFzjUBF9raQu3XPMRTC+xHkuT2MstmDi8fkAJM1FSjmMf?=
 =?us-ascii?Q?4FUorHFUOLIgP/qVyGuqDxaDwA7JutP0wQiC0GirFBgfBzvVxKCanT2ufEeB?=
 =?us-ascii?Q?CdJQvOqmjvSiRxs5CWhq31a/Yjqc2jnLySzT30eTRsA0UkgvP1HIidpqp5hL?=
 =?us-ascii?Q?075k6wN3xpQKEmAb6MZZSfQbkAnl5BTFEGAKdMl0mue3zTzwZ+SC1r/+0ihE?=
 =?us-ascii?Q?x83F+oYihLRKJ9+HnZkSZHULTj7GVq1CltLttae5c6IXKml7ktl7sTSRWbZg?=
 =?us-ascii?Q?sm4V4+3REzhSfdizoKfxcwfE?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c167f813-c26a-440a-3281-08d8d4635bba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 23:17:27.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pqxwg0Xo65QZQgs9gkO3QYzOV1MVthIAFU3KbGw4RlFmBd5FKCOljub9ftxPafgjpnXTKNBkiK43OIS9MHal1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
---
 MAINTAINERS                          |   3 +
 arch/arm64/Kbuild                    |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_core.c          | 167 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++++++
 arch/arm64/include/asm/mshyperv.h    |  55 ++++++++++++
 6 files changed, 297 insertions(+)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66..0a22f3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8235,6 +8235,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
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
index d646582..7a37608 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -3,4 +3,5 @@ obj-y			+= kernel/ mm/
 obj-$(CONFIG_NET)	+= net/
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
index 0000000..9a37124
--- /dev/null
+++ b/arch/arm64/hyperv/hv_core.c
@@ -0,0 +1,167 @@
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
+
+#include <linux/types.h>
+#include <linux/log2.h>
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/hyperv.h>
+#include <linux/arm-smccc.h>
+#include <linux/vmalloc.h>
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
+	u64 input_address;
+	u64 output_address;
+	struct arm_smccc_res res;
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
+	u64 control;
+	struct arm_smccc_res res;
+
+	control = (u64)code | HV_HYPERCALL_FAST_BIT;
+
+	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input, &res);
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
+
+
+/*
+ * Set a single VP register to a 64-bit value.
+ */
+void hv_set_vpreg(u32 msr, u64 value)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(
+		HV_FUNC_ID,
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
+	BUG_ON((res.a0 & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS);
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
+void __hv_get_vpreg_128(u32 msr,
+			struct hv_get_vp_registers_input  *input,
+			struct hv_get_vp_registers_output *res)
+{
+	u64	status;
+
+	input->header.partitionid = HV_PARTITION_ID_SELF;
+	input->header.vpindex = HV_VP_INDEX_SELF;
+	input->header.inputvtl = 0;
+	input->element[0].name0 = msr;
+	input->element[0].name1 = 0;
+
+
+	status = hv_do_hypercall(
+		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_REP_COMP_1,
+		input, res);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * getting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS);
+}
+
+u64 hv_get_vpreg(u32 msr)
+{
+	struct hv_get_vp_registers_input	*input;
+	struct hv_get_vp_registers_output	*output;
+	u64					result;
+
+	/*
+	 * Allocate a power of 2 size so alignment to that size is
+	 * guaranteed, since the hypercall input and output areas
+	 * must not cross a page boundary.
+	 */
+	input = kzalloc(roundup_pow_of_two(sizeof(input->header) +
+				sizeof(input->element[0])), GFP_ATOMIC);
+	output = kmalloc(roundup_pow_of_two(sizeof(*output)), GFP_ATOMIC);
+
+	__hv_get_vpreg_128(msr, input, output);
+
+	result = output->as64.low;
+	kfree(input);
+	kfree(output);
+	return result;
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg);
+
+void hv_get_vpreg_128(u32 msr, struct hv_get_vp_registers_output *res)
+{
+	struct hv_get_vp_registers_input	*input;
+	struct hv_get_vp_registers_output	*output;
+
+	/*
+	 * Allocate a power of 2 size so alignment to that size is
+	 * guaranteed, since the hypercall input and output areas
+	 * must not cross a page boundary.
+	 */
+	input = kzalloc(roundup_pow_of_two(sizeof(input->header) +
+				sizeof(input->element[0])), GFP_ATOMIC);
+	output = kmalloc(roundup_pow_of_two(sizeof(*output)), GFP_ATOMIC);
+
+	__hv_get_vpreg_128(msr, input, output);
+
+	res->as64.low = output->as64.low;
+	res->as64.high = output->as64.high;
+	kfree(input);
+	kfree(output);
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
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
index 0000000..44ee012
--- /dev/null
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -0,0 +1,55 @@
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
+extern void hv_set_vpreg(u32 reg, u64 value);
+extern u64 hv_get_vpreg(u32 reg);
+extern void __hv_get_vpreg_128(u32 reg, struct hv_get_vp_registers_input *input,
+					struct hv_get_vp_registers_output *result);
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

