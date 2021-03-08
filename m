Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EAF3317E2
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 20:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhCHT6Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 14:58:16 -0500
Received: from mail-eopbgr770104.outbound.protection.outlook.com ([40.107.77.104]:16005
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231424AbhCHT6I (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:58:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkZ6K2tLLSDXWteDAKOOHaI0s20ea3t3zYbO4TBTAjzjb5yOo6grD5FE4pS3XvirbdKmXOBXB5N3uWOrDk1MZ/eaqBWObvSfYUF5iVd7weuxlTYOpzSFgSKKtZlo1a9GpJWDhX/SjIUQOFTTWsoV53AGnEos9g1W3f5W2y6ybISpOavibb4YjNP6v1YMz4TSVNPPB0Y+xKtfkWwAJjPaDN9bgkd7ns+9Ryy5hE6lyxZvJE+6rtwpMhHaiYmN/qypX3IyMXssrTksm3Rxa3S4SupfbNzPHdRJRj13EosftB0gl34qliiXpigvchpf0iU1JTb/LXM/D+JsSjQv+dmDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6oClYZdvvXUdvZ/mfIwOcXb0EgRKwM9SJL8rZlT3uo=;
 b=cr3suDDgIqM1ty3zZRg10mQtJ2kwZuJ0JxPMY6M9sAUmpn2O0E9YTnzzMoAJt/toFKdJ0fiBzw96kcGXWeGvOINb2W0VNMahYxEcOrqQoQWspNnkbbuctEJpF8WVszMmYfImsbZM3MneEaWF557jZAP1hdwr3KAIuONxlhxFhAsTiL4929279M5kyk9BCW5Wb+WNd6f4DKNZ49u/p9L86m22YR8iOBCcd/j9Zdu/n95Q1PyGDnj72CCMR52ZiqoPSHc6CzeFoHE0q6NCW3AfD8qwyE44ldjFpDTw7wqX2hhfUxH9aAs1lKsEOXLilh1IAWmomro9TQBm4m3Ed1lUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6oClYZdvvXUdvZ/mfIwOcXb0EgRKwM9SJL8rZlT3uo=;
 b=j4N6vPcOnCmkKypXDdBZCyxlNpWr5dfChpRw7maEfmxYuDdRwDyayl1qNAys1QStPsFxjz6QCZG3LJWY+zpfn06P/iZxrJLufsXgV7wupF6zoa6xsUTM5d/UDhAaAE94os/lGtHRbEEnhreAtO1+QhPc6RmLByi4y4W0LUsVKZg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB1797.namprd21.prod.outlook.com (2603:10b6:4:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.4; Mon, 8 Mar
 2021 19:58:06 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3933.025; Mon, 8 Mar 2021
 19:58:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v9 2/7] arm64: hyperv: Add Hyper-V hypercall and register access utilities
Date:   Mon,  8 Mar 2021 11:57:14 -0800
Message-Id: <1615233439-23346-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 19:58:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c529c428-0e12-45b3-208f-08d8e26c7d5a
X-MS-TrafficTypeDiagnostic: DM5PR21MB1797:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR21MB179739B63E9E061FBCD7E422D7939@DM5PR21MB1797.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+F5R+ac2AZpNa5AnL4CIPdKzoHOzxU4zqnXsHOvnNtT8OExOZwMMrlWR0b7U7nZXhF20kixxxlyXga3Zr+ImuOaftYEuvj3BTgloBgJicvDujNTUH4MlcEE5/y+o9G0Fh0cHcA13ibGJW6QKT31Eye86+1byhPp6c23V9FJ4YHhZoNp1MNdE+qT85tyfIkjjX+DeewttTgVJWjpIu9IzJQ/OpNRlb52B0obGMHskyRS9p2woMyWPfv53j4H+IIE65Cr29k7gmgZZEJKjR3kvmoiwzP1HzvrYa+IpYNj7iifsijwvzgHwdL0rVt+TsyA/W8kLD7OUBtQ6ZAV5e3XO9+23fC5u78wOtyRJT+reb250rFGQbE+7layfXE7j2bNuGw8GFsxTE51BgpvjEP3nuAO3nYI3LSsIHyIOWIYgCiylFgP73CNwgLAMnnGczw+lsNhxxJs+5gFn0OrbpgeEqtbYlEfInfT64PoD7TS2Ji1zGWuZ8wlRyAdR19CZLSjJnvPJRTG7JbrYDtJy7TjGiSpq2xozxqScUMjHbzIitWFprH3AF5pSegva7v00PjbKhctX59a09qL4hTxLt3mA7qxu92MZ/P5PIQT4UkQQLcFJPQ/KZswfTVYbnTUS+hhn4nCRUaAE2O0500jxzXrhH57VAZoUwPhf1hN3gP5BWbyzXd4O/SZKih3y/5rDNeq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(66556008)(186003)(52116002)(66476007)(66946007)(10290500003)(478600001)(26005)(16526019)(966005)(5660300002)(2906002)(36756003)(8936002)(6666004)(316002)(7696005)(8676002)(6486002)(2616005)(82960400001)(4326008)(6636002)(107886003)(82950400001)(7416002)(921005)(956004)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PFVC4Q48rQMYA+XVyJlyQcyTunTYn5Dtu9Zk8DDUQfXA/CUhpaTqMVheHuVk?=
 =?us-ascii?Q?rxZxAkaEqcLkb9NdRRIXxDzXbxL67Ar1kJlD5EW/AA1Hz01qcLsHsRn1LgAu?=
 =?us-ascii?Q?d7CBP14vD9n6rfJBKbtbNxjc3RuZGiVCdMD7/BLqi7BP7xM/GxbxFMRtf2yX?=
 =?us-ascii?Q?JnftRya7wKnjq8Tm12afB5H4NtuGXShs1rgUUnjzYJR0HQZ5L7tBdG0+sAEM?=
 =?us-ascii?Q?PDBXD+F7jR6tJL5MbVA9jX6vxwWWDELkeM7b3nI+fbHD0Ng0qtZya1rXADW2?=
 =?us-ascii?Q?bCiH7mt/NqX5SP2VhVhCnnAaE98H1U23RbOCFSTC2+vHVYdz4xilxqn5uo7K?=
 =?us-ascii?Q?GAAOWGia4kXftLLOaDO43KlZzrMHR6bXiOXyEK2RPmjITBmWtAyp+RLW1oxh?=
 =?us-ascii?Q?Hei//XJRlKnCCsi4B0mo0d5KXEFZq4gA6VEQ50memJ7cISDbKdIwcI6tjy+c?=
 =?us-ascii?Q?87532AXKHcHPrCuBQB3hVPEHUp42ptBpVGdJ3okXoZjhZezKyEzRJgSgMog6?=
 =?us-ascii?Q?WXMkfee7vCO4IklnAWr9o+125xfAvGLE8JLPr/V3WnyK1j9XPwEQoLwekams?=
 =?us-ascii?Q?QMcPgFGzViGLrB7crBZYVansf9wnHPkECf88EPvJOiniPvL+CTsx5OGCzkA+?=
 =?us-ascii?Q?GarE/Q7L9RKZdZn+JJat3kf8N9kg4Hg8HQMbvlcsGsV4JBxNSwRKUujRBSc3?=
 =?us-ascii?Q?Q6Yp0EQNZ7Im9rPvkH1u7mA4zYNGQ+WBOqgfnH82z6HGHV63lw5jQYrZIX/0?=
 =?us-ascii?Q?eu0sPRbmRekLtiv+3nutbyfN1O48CqCNKIfnNq3G5F0QLviRUJx+lF83me/W?=
 =?us-ascii?Q?OA06McaqUtNjiIgtvE3P6FMBbqaxdJtqN/+2mGWme9SQDYObT3rEPFjvTqRW?=
 =?us-ascii?Q?7hLBKCvO6apgC1Wfq6mRi7vzOIaaUOo66o5JyvLwgREMh8b9nPrJ2iQGJmNd?=
 =?us-ascii?Q?T0iNulcC+8nCG6E3OzmjZyXBYvlUHB2b6uS+BGtwIxCX0ggq333U4RRZBuak?=
 =?us-ascii?Q?tjI3wgOZlPDP/K4NFZ+OuQhO9fYgBQTntqaPQvNx/fiz2Wd3uJHG5Ccm+z/j?=
 =?us-ascii?Q?zcBE5CwhTaBztv2vkiXbAhf6R5u/LLGB85QsKOLN7Ny2AjIxF3eOZPhdkoB1?=
 =?us-ascii?Q?Ge/5waacBuoLXu2jRiYCsh8+CRF018AIhQqBHu/H1F74Yak485CDKy6s3JOD?=
 =?us-ascii?Q?Ti3Gx985fudsRQ/rkcgBnipveghqJxheBUi5WxHg8TPgCskg0B4H91qrQZzo?=
 =?us-ascii?Q?+nL/PlWoc4WKmotNs1nYkVxQCaTOHZjqWZAXDYLuOHNQddmPMkrfnZYGbD1b?=
 =?us-ascii?Q?5pfFgR5Uk98bd2DRROutU2WB?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c529c428-0e12-45b3-208f-08d8e26c7d5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:58:06.1543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU/5doOYawQIGk6c1Vl6/fizOMEAlMgj+REUFacruqggDUxgTzXPc+gfVr3F7kOsypbBjNYbcWWU/1N1QvtRpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1797
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
 arch/arm64/hyperv/hv_core.c          | 126 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h    |  54 +++++++++++++++
 6 files changed, 255 insertions(+)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bfc1b86..7a47a90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8232,6 +8232,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
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
index 0000000..d5a8a6e
--- /dev/null
+++ b/arch/arm64/hyperv/hv_core.c
@@ -0,0 +1,126 @@
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
+void hv_get_vpreg_128(u32 msr, struct hv_get_vp_registers_output *result)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc_reg("r5", "r6", "r7",
+		HV_FUNC_ID,
+		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COMP_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		0,
+		&res);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * getting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON((res.a0 & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS);
+
+	result->as64.low = res.a2;  /* r6 */
+	result->as64.high = res.a3; /* r7 */
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

