Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B799829FDA1
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 07:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJ3GJg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 02:09:36 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:37619 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgJ3GJe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Oct 2020 02:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604038170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Fv7kjlLaE1ID8TqNkNRfCKTkbSAy2dUe8mwvzgGWgs=;
        b=lXeqEBqwrY8YDUhL1gP6ca75NUxsiSwPgYCcdto2H6rZliAb/Tbrv0f/rpPT21xp1nTQqR
        tu2tnqwDLu0WluDuT5q/f3V85VJtcp/VUsobRKKQz3iYoHKv4nPYcBdr5bE46pAiqN/j8r
        X8spa+IoPu1tD9UeFrdlbH89gXGSQvQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-s8cP6mGeMzS4MQlBZgTtUw-1; Fri, 30 Oct 2020 07:09:28 +0100
X-MC-Unique: s8cP6mGeMzS4MQlBZgTtUw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaUdWbfMtI0P+LNjGpNyKbSFWOxhjFUs0zOYhL1r78xsehC8Sa9qV2yzf33FZ/kGZ9g8v3sr4lxfDo4XZHAedqmhhirc/bx4OzkjYXtU8BIQCrrTzUe1CywaNH5dhaklj1O5LCyPmTWoGSgtjs+kAPPb0l64eXW7U0D2rS/MnhC8u5QlE5MG8E1hYjEctL36xoaCcZgAXHX1ThSq0jHf5Cd7217jLPMhG0edrx4kE9KKYE34ut/MOchFM+OMT12jJHY33zCdmAm5fe9k7K4e7i3WoseOSk3teXUwDWrna5CL4FJv4iAS/465zt63c4LI+JH4/vcyWyIZDhql7dZcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2s5pNb2jKUMdl7cEgIOLMyVaU6avnr8VXDXLQN1KI8=;
 b=ZV/1Llj6A62mR62tnXdZt50vMQhJzbQ8TEBhQ5X06Gzb/OLfViQy9Lrnyxw6uL7AyOE+RLRcRcNElmEzoi14AA4DBUhmNwDm+M9jwZuV41yqo8TPWzqH2sQ1D+oKTT3xgfL1bflQXPmRIkdrDmmSK93jsWfBLEf2GN6sXvcbEzda1cARB5MyceCFFuZkOwObjmLNa+RYc+vYkGu/NPIsno6wqQoa73sQhp14eFraITKEgKGYTarQ/Cu2qgg9u1b3Dzpsv1KaCvGRUdM/hPITY1CMnttihEZHQ/XTr1QJpnRwuZLWgyx9MBjQve1oOOR45gYDxV04TPWYiyP+5X1Juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB4919.eurprd04.prod.outlook.com (2603:10a6:20b:c::23)
 by AS8PR04MB7943.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 06:09:26 +0000
Received: from AM6PR04MB4919.eurprd04.prod.outlook.com
 ([fe80::f063:76fc:db1a:905b]) by AM6PR04MB4919.eurprd04.prod.outlook.com
 ([fe80::f063:76fc:db1a:905b%6]) with mapi id 15.20.3477.035; Fri, 30 Oct 2020
 06:09:26 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
CC:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH v3 3/3] arm64/ima: add ima_arch support
Date:   Fri, 30 Oct 2020 14:08:40 +0800
Message-ID: <20201030060840.1810-4-clin@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030060840.1810-1-clin@suse.com>
References: <20201030060840.1810-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [36.225.26.227]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To AM6PR04MB4919.eurprd04.prod.outlook.com
 (2603:10a6:20b:c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (36.225.26.227) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Fri, 30 Oct 2020 06:09:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8253d210-0609-42e3-bd2e-08d87c9a5ae4
X-MS-TrafficTypeDiagnostic: AS8PR04MB7943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7943E5B99EB78B1313EDF531AD150@AS8PR04MB7943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBxNZPHidJ5iVU5YzXPKxXQ+jG+XTFBy+T6bFGg3LJQbSc4InuT0UVN0n+Qf5fYStA/UtSyXF9DjSflG7uGPJEHQfr/OG5ktVcbhxYo6f8SOyrxIO4CC3tn8ZQPwZ0D/tCfY1MK2UhzAWty68QvPxyDBVQUiwx9MmSTLHYrcK2p575BqfT8dCF+r6Q/7G7JCk++tkEZcUYtecG9sYYvcJEvzJtwvMZp+X6ArZW9kwtrcS+YAo+dmFBcnfhDVmcJmOuVRNrVezw1Rb8+crKCLq4adVvgIRkojCHbIpXf/sid8E37OgOl5w3/9J45mRd0HRzq6/qpNqp+EeqETz9K2BtG3QsxRz66bMGCWHlfWQmiYp0cgV6FjRkSdOllPnezEJRL9SYNDO5nnePao6kcXhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4919.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(186003)(2906002)(7416002)(36756003)(2616005)(16526019)(1076003)(956004)(5660300002)(52116002)(6486002)(8676002)(6512007)(66556008)(66476007)(66946007)(86362001)(6506007)(26005)(69590400008)(8936002)(316002)(478600001)(107886003)(6666004)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fWZIAVkb+eePpvRiUG6vjqF0th33lRsw5HAqhUwaDxdKaSqdkp4lw/tbyykUduw1cOjms8Si0QnEsrY/1OSl0px83DHCh1zCDFLvVoJNkdxJHsJ37HbBpnCLpC/LCtjyWMiM6y8L+fLiV2jX83ZY7E865dqazj/VbnqGlptDUWASbO4jle1ezKM40m3rPbYsu9Cj2uP1lzjY2CcKK8IaYE4vdL6R2szYjP+e+z+qVOjF7ZCz+kE/6LUjZcIUb7b4qPzZy922C4bT+4+r0tkstqdobOFbyDHJjCPra8fjBdAXJcm+YF/ebtukI2E0Z7+kVbnnNU75Ol2xUtBV7N67nmCKLWWN7EBpasBFtOeXDWvZDng3wF9u2TUS71k2GgVNvKfYYYPwlgvGQyfLga+R4HBmYEs+wVGy5dGIyiKRkdbMpQZbg2tCLx0UDUMUJvv5WuK94awQsAxRIKNvh+Y+6ZqhPpllG4aVrH6nAIQ41kfRSUHwvdFD3qDUh9DL3C/9uDUPvNDWmFAWUG1lpjTLerV/1UXsHwRk0nDS1KRcj5oP4tFY2etOzoRuKu93vY6h0Y4a7gx5PG+1AWbP3fM4ON0DUm8UbPQ2Quvg8/Bb8KAF2C+URI7wlXjUq9QuINJJNoqexKrgUUektg1M/b7jbA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8253d210-0609-42e3-bd2e-08d87c9a5ae4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4919.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 06:09:26.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/snX50CcrA1A1vy7A7TwHCIOlNxNlLv3bXAAkr7IFX6gU2u/T+TbOLHNpqr87V6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7943
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add arm64 IMA arch support. The code and arch policy is mainly inherited
from x86.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/kernel/Makefile   |  2 ++
 arch/arm64/kernel/ima_arch.c | 43 ++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 arch/arm64/kernel/ima_arch.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a42e8d13cc88..496a4a26afc6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -201,6 +201,7 @@ config ARM64
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	imply IMA_SECURE_AND_OR_TRUSTED_BOOT if EFI
 	help
 	  ARM 64-bit (AArch64) Linux support.
=20
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index bbaf0bc4ad60..0f6cbb50668c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -69,3 +69,5 @@ extra-y					+=3D $(head-y) vmlinux.lds
 ifeq ($(CONFIG_DEBUG_EFI),y)
 AFLAGS_head.o +=3D -DVMLINUX_PATH=3D"\"$(realpath $(objtree)/vmlinux)\""
 endif
+
+obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+=3D ima_arch.o
diff --git a/arch/arm64/kernel/ima_arch.c b/arch/arm64/kernel/ima_arch.c
new file mode 100644
index 000000000000..564236d77adc
--- /dev/null
+++ b/arch/arm64/kernel/ima_arch.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 IBM Corporation
+ */
+#include <linux/efi.h>
+#include <linux/module.h>
+#include <linux/ima.h>
+
+bool arch_ima_get_secureboot(void)
+{
+	static bool sb_enabled;
+	static bool initialized;
+
+	if (!initialized & efi_enabled(EFI_BOOT)) {
+		sb_enabled =3D ima_get_efi_secureboot();
+		initialized =3D true;
+	}
+
+	return sb_enabled;
+}
+
+/* secure and trusted boot arch rules */
+static const char * const sb_arch_rules[] =3D {
+#if !IS_ENABLED(CONFIG_KEXEC_SIG)
+	"appraise func=3DKEXEC_KERNEL_CHECK appraise_type=3Dimasig",
+#endif /* CONFIG_KEXEC_SIG */
+	"measure func=3DKEXEC_KERNEL_CHECK",
+#if !IS_ENABLED(CONFIG_MODULE_SIG)
+	"appraise func=3DMODULE_CHECK appraise_type=3Dimasig",
+#endif
+	"measure func=3DMODULE_CHECK",
+	NULL
+};
+
+const char * const *arch_get_ima_policy(void)
+{
+	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
+		if (IS_ENABLED(CONFIG_MODULE_SIG))
+			set_module_sig_enforced();
+		return sb_arch_rules;
+	}
+	return NULL;
+}
--=20
2.28.0

