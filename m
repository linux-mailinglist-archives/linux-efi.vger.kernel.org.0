Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6A3CFCE8
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhGTOX1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 10:23:27 -0400
Received: from mail-dm3nam07on2093.outbound.protection.outlook.com ([40.107.95.93]:15200
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237619AbhGTORx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 10:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms+paxf24hgUlzkreFyJrvRJnBVvkYoTU24V/iJFHglkY1CjObTVCFumz95v9ImnBnexfY0pdfDUEoYIeSeMF/F+DqpsEevicfiuCvacg7/x7tFojEMPfhwGZGVDqpgqoxUcxc5ZM/mB5uE1TK7W9j2f1FaytYrkHdYhiic7NN6BnBgwbUpEg0cp1OUIuKk19wLw0Xxo/bt3xxHfYrCoIqygE7znVUVrKOsbd3/C2n2ohnnE/ir4Cg9PtJ++HAKxO31mUkvrT8iYjqUo7EPXss0mNJhbiiKaxdDujVcgJfFoVgD8HnHlBp0TN41L3ls8xXIWzUqMnH4rEiVOykT74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k3Ys3j7pl+EJOrdl6xyQvWnZV/fNj4nZKuAtVR9hJI=;
 b=R3Jdo2IoAG43t9/KPYEfA2sc/JwbRAwmZK8VdobPFnKpS7Dv3CEY5eA4EfTTpvv3MZHoMoWSfuAiJ53KecwX8dEy2oE6JyfDFSc80lwnKi6x9RwUNzdkNupGfBuQM6pdUyalvvfAGOJs1ideKhb+NeCCbNBleVjSgV6PtyCiv4o+JLopdgsNwizTf+YxnZ1K4viScTFs89mpq/XxeD9dCrneSt7/MCNOZS/ufP2fh60oLDQ3DZCj6/Xv7hmrst25olK13lzPkkcUrxL7i/fwH4WTBsNFh8MmCJF1OUjBpY3V33EhE4SYR+oeNHqe41HhKQPagdIOo1KzpT43ZGxBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k3Ys3j7pl+EJOrdl6xyQvWnZV/fNj4nZKuAtVR9hJI=;
 b=QM4DPQDqiBHSGkjzxQbEYBlaDUitc6mKQchAmUBF4RO0ScqpDB3J/gKz//0iH6XI+oq1yo8RveF6zeaHD5jNAmVyqy/p9gwDCT1XJbL27sdIqEZth/nDeIcbER5vC9VoIX1c6vluQkWEqMRwEJoqI48nx85srcXp2kuccjKDBJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.4; Tue, 20 Jul
 2021 14:57:23 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5%9]) with mapi id 15.20.4373.005; Tue, 20 Jul 2021
 14:57:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v11 1/5] arm64: hyperv: Add Hyper-V hypercall and register access utilities
Date:   Tue, 20 Jul 2021 07:56:59 -0700
Message-Id: <1626793023-13830-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:300:116::33) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by MWHPR07CA0023.namprd07.prod.outlook.com (2603:10b6:300:116::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 14:57:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b9ed2cc-0726-41be-8a51-08d94b8eae68
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0981AE50B1F9F7A48A25A680D7E29@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uf5QZyw+oDtyPWEj87YWtNdgQqYy+5ignClnPWfk+pO5TzybPX5E75jLmdr/Z0Q7H1RXNhB6iG+Ju9tK9eZp6d+wpaqAMUbZFyJEbQNqqkQAvKe5RpqeauIzHh7IZB1ePqbctSTHK6pcNUtfXyNkP2SHCMOgS5IG48CKLntuKqN7uiyzuqEqs1fh+3K9xp0gRL2VbXRT0GPsR9xS2KBVQGzSQrLTA6HDnAiZa//bibF5bZb1nR00S+fn5zeD1d+N4wHQfO/ygZBPlqGngPI6rOOdBsMUbOimowFySmn1FNU+QktlRV+Ea7jlyajUUyAv+7h/J0H3lc46q6XDtnK0LG9DWi9RdCT50FRHkldOKPazmrHtlMUCk+h3bK3dhYe58OqTzDfZmBYyqwPOaKfGLExE9PLcPjbdfOy545j/lDwcruADpmkTErVbQzUQJG2MjzaPPUqBp0Rypt56SRWgVeFnBKrX22I5jtIv8Jd1YS1+nB5op/nJ1iud+qiqdYPxK0DDc2LWpH+FKr3HNUrvwlFjN4iEIcxHO/WaWcT3OCiXls17uw9v/3IGphAIvaEukFIZp5izn3ekO06JNzchJxnIK3GWET34hHKYJVit29DzQMyRIknWQ6o7eqO3mkk+qRoOHXWIm7R1Ez50L+l2ZGwW0jo0HRxnCq7U4ZQfmarGZ9Sx27sa6qjD2dv+gDfkNrXNzsgAfEU6eeDXq8yHJ+4RyF7o84vfCXKeeeDIJZZ3vFcgKMCoBNXlkW2Tz6ErdOa7qmN0YDcOCCNvmtxVTeoQafKw/3W3p4QqtNhvrRq6aiTpMDuEWcge9H1mIY8X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(26005)(6666004)(36756003)(508600001)(966005)(956004)(10290500003)(66476007)(5660300002)(38350700002)(4326008)(8676002)(38100700002)(66946007)(2616005)(82950400001)(186003)(52116002)(7696005)(107886003)(6486002)(8936002)(82960400001)(316002)(921005)(66556008)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1egMN0wHDgjdTObQT2CVmp6EExsHYeKykyra9oA/0ExncDfsW9DTYJ0HN07c?=
 =?us-ascii?Q?7D/SDkt/tkQYqV9GGDuEIl5Ov6FMUasnGecSne5Oop8mEumrCFt7Lip3n0Jw?=
 =?us-ascii?Q?GCyq6GkZsO8HJm4fhEenrr3dlgvyJao5lEWaAas1GOaRUWExKQMwHklGpiq1?=
 =?us-ascii?Q?3SEpPLxJjDLyvIaurhunpW4LBY8rMKplgLUyKHdJw8VAcbX0480lAnumyefK?=
 =?us-ascii?Q?8exPvi7ZxxxHKCt1TV5G1CofWkYggWPUcmpD04ncAZSVgj24uiLEyj7+QGVX?=
 =?us-ascii?Q?ybFfEZTTh6O69LW5wJA2fVwht1qSF0JF4Wm0BAurMWwR10QMd1tXHL054N3G?=
 =?us-ascii?Q?RZShUE1sXfP2wIc8fc6z7r98wFN7pZCCC/x447TIvIV2zFWITFpe5afNKos0?=
 =?us-ascii?Q?iMyWrqGecHsb1adHc4VyHsjr7j5hH3YdoxVag8BOPrlVGDVVxzI+8Nn45lXT?=
 =?us-ascii?Q?C6Ph42iljvWjuZW6Z7n8n4Hn3VR/L9baOgvoUbjEIG9NWfbXYzON2OTGZk8S?=
 =?us-ascii?Q?LEM+5d6G/XQBwxy/nGMDJCevlVuDWaOHDeTdko/JPJg/t4bxUfBv0bTXffXg?=
 =?us-ascii?Q?Zdl1/mZaNW5Kd6EYEs7nVDXtbeRJ+qCENHk7kCXj1qXuvT6ExV0kUCqvKe6R?=
 =?us-ascii?Q?Uhznvy3HFDs8VFpvQ5M9FKekl7uhXtZjJsDoxD92+a8NMhE6d5ubCFgnuObW?=
 =?us-ascii?Q?lAVLe/5oiAT/FfttHIZDDdxle+pemQpXk3IwUsEWo96YZsgN96LKrEM93ACY?=
 =?us-ascii?Q?n9KgPk497cwhKbEv2E3Coe5pb+N3NvE+M2vqf+TgBvydlQhe0JU/++xbWUpd?=
 =?us-ascii?Q?iFQcLCk31H98aJjBUkC5M1KVLGS18eV9S8DPobq7VZq+rrxr33UZ7F5Rcdtj?=
 =?us-ascii?Q?d/RKI9Kmjgbz2uMtLru7LOOoEz+5db1Kbe1eRuRh3SUmu7qaZ+HhjaifQm5S?=
 =?us-ascii?Q?015b9oVJqrb38NMtq2W/VqTouv6l8auTZ+UV6SVZQSJkD3xYgSTUwtDsIewM?=
 =?us-ascii?Q?0kfKoIL5pFfGTnHXpBP/ppQoYP5+XXtvY593cZ5mbQsjEkJ8kYqqj0W8VGFW?=
 =?us-ascii?Q?7xcTgphJ2cSMBAF7M8majJSITSIXZm8g6NWY9h1WGnOEjfjaUR+GIiuP7Nzo?=
 =?us-ascii?Q?39TnplhA6PdUDPpVYUpFb0XAnSwUIjITkaZyGsThjR2aEsnQs4fknjmx6r4d?=
 =?us-ascii?Q?WzLgupwM3L47AWItjokqcVr2rYzOseZCP0xRWQ2ecybH27wgRFTypkT/55QM?=
 =?us-ascii?Q?eqT1G5NGdXnf5jvIDVRaGDF67RutPCuKzC2Rl8PGeqV5FGCF/ck3BHFuhhHI?=
 =?us-ascii?Q?MI9attQEBE7kMCopMw5mUt0k?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9ed2cc-0726-41be-8a51-08d94b8eae68
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 14:57:23.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHMtEYjAb1h3afndk+4XirpTRdt5efsAW7RVnNNvQsOj+FkxMNmCsgLHKcW+RsHLSgZ603oSBsduGs257b9blA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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

