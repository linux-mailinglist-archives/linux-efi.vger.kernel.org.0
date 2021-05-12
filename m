Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1328937EB46
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 00:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359689AbhELTXt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 15:23:49 -0400
Received: from mail-dm6nam12on2136.outbound.protection.outlook.com ([40.107.243.136]:63366
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348917AbhELRjn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 13:39:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW8g/XJr4/gU6iTCmPPcZSFDyta9tfiAx3B6VfR9w5BmpIO0FrOcjDN1uW9pWK+DzqDNMPB3hJXtRJBRDGI6lzz3Btv197/xWBV5ZpL1hP+gYaJaQoBFLAXPlnOoqbp7JsO1KNOokHAbT0nGnWNA5DRWnv/9vdXXZAf8rj09YFyXTciKgrkI2LCRqkNkORqQQDA2ZHSWcNcDAt9o5X8aqDBb4/4drbmZlrOlJW63UoV0YPKCijxfl9GWJv3ateY88yqpV72qdyCRQV//7LWXvQd+/bGbli9y6vHv7MYiWV4zE1J0opj66XhczjBUMKOmlxCL/Yswxe0gn67rrzxR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqIPv0gxINU3YVrkid8XxqccAzcJvP0FQSOwsZ70UGw=;
 b=Tp3GLGZcAvxb2p1xtxXmcF5Smpf8SIgBPzntkmyYaiptDDi4H3juS6fhPrJIiiyTxCZgrA3TgVbxItPCTOVNj6/eTJFh2yIu59JjCbwdPc363GVNTWRHFaQ1+8fywTX7GGgENLJOPjMmITeYyu8N38XZ0wxJ+Y4Mx0kwudHN32fHXYWKOrjNupWEMwCOSvR5XiUz2Py+L/+SMnnfq+TTCNISoAcr/jjSZ3+P5m33aMaCYBbxs56+CK9dqijqddDPsOndQvZnmNiGSY9mXr2ueqV+6YH1oIFrtk4iwdEuRPQyezMBYtRN8KbazzslZQVm4b2m4sGHQfO0ZB14WRnKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqIPv0gxINU3YVrkid8XxqccAzcJvP0FQSOwsZ70UGw=;
 b=I4Wft/UdwXmDFbk4vXIgt8BHcxdzWKAp8/tYZYPZCrkiemMRcQRy/RxJJTjsnxRtlPh7Q+vOC6R1vPK53ti3AAbSLLL0DgrkP6aKwPAkkonEbNf5uHHrPcrnH/f6j7/Lxup/8faPVJ5KP1nL1y8rUP+b/+SReja0NIREMeFQkHo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1483.namprd21.prod.outlook.com (2603:10b6:5:25c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.5; Wed, 12 May
 2021 17:38:29 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%5]) with mapi id 15.20.4150.011; Wed, 12 May 2021
 17:38:29 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v10 2/7] arm64: hyperv: Add Hyper-V hypercall and register access utilities
Date:   Wed, 12 May 2021 10:37:42 -0700
Message-Id: <1620841067-46606-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.1.144]
X-ClientProxiedBy: CO2PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:104:6::28) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.1.144) by CO2PR04CA0102.namprd04.prod.outlook.com (2603:10b6:104:6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 17:38:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdc7830b-c353-4c1c-640a-08d9156cc11d
X-MS-TrafficTypeDiagnostic: DM6PR21MB1483:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR21MB14831F7CF20F7491FED65594D7529@DM6PR21MB1483.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhjq8xhvWXrRMOJKqtVKqOo2D8E/kaml8aT7J6T6M0CZO94xJMjAhFVXk5Pv6C7eJEmnwQIVble1GFdoARYzMDJvtluWC7cgfshZKT8xE+jICKq5rkAD6Vve4mCYG/P/6iaNLiF+Wj/3knKZTTyCzjwbWCuClYOET4blY7hkSF3KpjFv9s6xfSkwmt17Z7m8oFHObBLXOkyMQMw8N4Crtb9u2UxgCm3zvNLWqk7ogd+z5LDtbMJuL5mnntowxH1w4KGhGMk/DLX2zbttL7LISCMze1iU+cDN7V7s5OKbk4ox7wnOkjbH4rUmrDaHEaxKc7TtM6ly2fkdq6lzNxBjXcGSLQ6XmXUFHQ+bTSOV73xf3GDxsqfkfTuLzjjFrVSzuuWcssn2On67T64vlw1l9nvIO704EKHRuq5wGLzJPzmtARZmQ73Mt/8ECmH6TlWzuGewDr9B4D3AZ2uZN/Xq3Vx8Q/gakp37oaRLg5iLgpxuQbxnC68ximKBBA/5Yrk4OpumuYEhqkGEXdrGVzW2TGaxQbA/5pOG4/ME+V9HvoV5NGLk+7EnXDJRKkzdcD5QOE3Dmzgm4gYedrFax5cnPhG4VLeOmSDTjLwEZcycNp/ruoeCTmBidJm9ooSCfJsum7SCiDPukmEutoG7c6P0s7d42sHBI49X9M4QhHADR+1/abKVUUfSLZbuSrbt76hvKn1tQnvFN9lmlx98FaKGgFb5FdFNbM3X0hQUauC61pk2yF2sxE0H4B+2wCv12gqkJbyHWOmV5YSXwmuyw+2jL6PKplzTLb+WZ/wDOk7Kjmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6636002)(316002)(478600001)(8676002)(86362001)(66556008)(921005)(16526019)(10290500003)(7696005)(52116002)(7416002)(2906002)(186003)(966005)(66476007)(4326008)(82960400001)(2616005)(82950400001)(956004)(66946007)(6486002)(6666004)(38100700002)(38350700002)(5660300002)(107886003)(36756003)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RclYAMHG4pCuTftJctqF6EXfOL07avVcoRf0tNCoIFEwJmJPqRJRYna334Fh?=
 =?us-ascii?Q?89hNKAbTzLICJlF75UMMpWm8MUXRNYuKvY8QUt4ahqgVjCOLPR7W1S8ocCTO?=
 =?us-ascii?Q?BDFzR2a/I855nCBanKXQS48DZe2l6C9/cPBJd/t3xMzj3+7ansi9Cnrh4UPz?=
 =?us-ascii?Q?1cH79nsR19QQ0pJN8Fw8aJSDAX84dP9I3pkypbikwaq09N7aodglymym0jQs?=
 =?us-ascii?Q?OB6INl/YsxmqYCnMyImdJY/dddwPAs8e1v3E0A4xJSsCs1M6ju87gX9cYVau?=
 =?us-ascii?Q?sL5XlZmgIbZ7cHXE4aE5aAuVYgM8EfUEBGWSrM8nrI8ePOsgyzsyHB19uY4F?=
 =?us-ascii?Q?1bMk5Eu4uCzpZlVsxQuer3JC2d0Bl06FchFlOm59Gr6xaN/+vm/i5mvOs5aV?=
 =?us-ascii?Q?R41wi6qnVkreuR8EzHts3MhX1Dz/dU1CfahtNhpsxsYYSAuH9VFYMqWVrrwT?=
 =?us-ascii?Q?1u2iaEKrnrmRKRc2O+nrGUN3Ky1wZV5yNi2pAgwcVTTbJ0spz93NP7Tt1sHe?=
 =?us-ascii?Q?YO1k90abXT1N7j+gTeLNJA5nEjXr2U5Sfpn8E6Gq0gN85RJYw4yCJxVCSuVF?=
 =?us-ascii?Q?TYJHNmphuF+fl6GRYgQ26azFxrBQi5ZaI3/bd12TwbxZqX40Uz6cAG5Spd6x?=
 =?us-ascii?Q?mCp1Wiv8ugRA0caXYVQt5pNSN63kz6PqeHPVelLMFOF0rIfG7rw0hnTwkFfq?=
 =?us-ascii?Q?e7DN82licirHwc3I0v2tPDfrgzGXMY9AV+GqLs8OI9wC3nelhLMyuHTwL4CW?=
 =?us-ascii?Q?CwnXOIv1uIiJjL7KbJHvR7En0qGA2OwAHcfuOqOQMnVgW5FdpZzQqd6MS3GF?=
 =?us-ascii?Q?EUKhJ55zVNBhK2TyCwYQpKj+jx8O054cWjBSg7d9Vtv3cpTYg2Zu7eN62pdo?=
 =?us-ascii?Q?okU84qF23F14j+DjrxNNqsLxLsggLx/gr0GV7B8nG3/EoXmK4itCj8IRAlY5?=
 =?us-ascii?Q?9bw41nR3ywss0I/6MsyMf8UBkdCqmCpdHMhzPqHX?=
X-MS-Exchange-AntiSpam-MessageData-1: yR2tV7Bqp1eILeyGXWdcP1wM9acNHMdEGec94nQzBfaJuaLzvOJFZoAMNsFfTb+oply1p1FC7w6T8VYrNw9ChjPh/KfJoDxMd+/YXc5EyxU6FAtZysyzkFb3mP5P7Z3Mb/RhSUPXlz2wdKcPT/pf+HNkSK017plfhHO9ziLHN/QoFDhrbPEfUWyQ09fU3oXDAmwcynCU8shAE59Afb7tE5qRgvRLujkXcHUwHnjR9JCp6ocnjr224vovCKvQbCczr6lw2ZQs/YsaEBCZOWe7mtHN580TSJc8O/isBFjxLXZNqxGPXUU1RnqwnkpU9nKYTfypCV65KplBpjoFOZzD3j64
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc7830b-c353-4c1c-640a-08d9156cc11d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:38:29.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39CWTEqRwDjohgwViYARlOkQxTmaCyKTPIjaGcjIDiBEEe3yZj3/7M/aHEFhMdfAm1rZX0kq8AxFZiAj3lXERg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1483
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
---
 MAINTAINERS                          |   3 +
 arch/arm64/Kbuild                    |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_core.c          | 130 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h    |  54 +++++++++++++++
 6 files changed, 259 insertions(+)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c..6c650cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8437,6 +8437,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
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
index 0000000..34004a5
--- /dev/null
+++ b/arch/arm64/hyperv/hv_core.c
@@ -0,0 +1,130 @@
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
index 0000000..c448704
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
+extern void hv_set_vpreg(u32 reg, u64 value);
+extern u64 hv_get_vpreg(u32 reg);
+extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_registers_output *result);
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

