Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DD728DF1F
	for <lists+linux-efi@lfdr.de>; Wed, 14 Oct 2020 12:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgJNKln (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Oct 2020 06:41:43 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:23622 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388004AbgJNKlg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Oct 2020 06:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1602672094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BBItUcPEBwXGi//ddCPz3H7K+gQOWlFfdylaPsz7GA=;
        b=SdsFpH39ihlyqRLkcFeu+hdiMvetCy6OQXxpIuHzoIMYz07JnP2zsnPqcC7E6shBklq+dr
        uHBzqtBEqmxw++gm41DDYA2Z9lMSdDwVPhn9IFH9mBtkJu2RA1IPTLYNpItg3YPo/3y6h/
        yBRPx1CEWdwFWsRHpoYSI+6EeblmXS8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-38-2lk8D948Mbm9weTaqeL9vA-1; Wed, 14 Oct 2020 12:41:32 +0200
X-MC-Unique: 2lk8D948Mbm9weTaqeL9vA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDD+rmUK4Dlun/z1Ul2srHcXcHmc50Sxy4iE7GwnYaTD9dTJX6craUk4CYa9tZndGS2mSdMlNLmFpDG/upMVNYc1hfJYiEo3RZ5ZMDl1ElMnfAPI1jWrKmOZrcJfPx2n7QPJxa2OPI14PmBuIUXnW/BmsCa0qhi3qVMkLBhGKHzsGNQIRzo24IQCvTGNFPjCNP8fEymAer2LlNzE/I7RoIATSQb9cmUFGLcwF7p9taP6TLm3PhI/Eh8TClBpJnp1zWrcBLBB49oqCMVeNDESrR1CJPmLP2u+8Hp2+XpId5ngLNf2TVM0F5pnH4K1X8Vz8BcEADGKWNV0kq9B7enOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEJy2cfW0nHSDc/ccRkwbCKNK82k9/qPYrIHj4xgT+8=;
 b=TZi3kleHXbeOpZ43+Q1c+xBVpaOegjshBnxr6CUs8bMShlO36t5PPm+3tLV+zUPWv8RzSEil/va5LGcwsz8E5nGS7nEvTY6vJ/fnftdUStpW5fx/kBp/NQYBDkNqUj7cgiG1JlyUHdWmJSH4uTs5T6Oc+99YbR9YNdf6hddWS1cZQxV4QmZZOqCaxG8SR6FnQNm5PobrvVLdVubB4tUHymLk0PiRepCnL/rsvAo0C4L4YHQ0pobtzhy135NEX3oQGKBYcplXNLBtJE/XYX6MIAD531cUgDNQzS3Un7mZmzqvlPpzG8bMnZPzGwlVC539qBxWbUO4fKXtGZb2cV44Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR0402MB3600.eurprd04.prod.outlook.com (2603:10a6:803:7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 10:41:31 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0%6]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 10:41:31 +0000
From:   Chester Lin <clin@suse.com>
To:     zohar@linux.ibm.com, ardb@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, samitolvanen@google.com, masahiroy@kernel.org
CC:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-efi@vger.kernel.org, jlee@suse.com, clin@suse.com
Subject: [PATCH v2 2/2] arm64/ima: add ima_arch support
Date:   Wed, 14 Oct 2020 18:40:32 +0800
Message-ID: <20201014104032.9776-3-clin@suse.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201014104032.9776-1-clin@suse.com>
References: <20201014104032.9776-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [118.166.52.150]
X-ClientProxiedBy: AM0PR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::15) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug.suse.cz (118.166.52.150) by AM0PR01CA0074.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 10:41:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0c2b70a-03f2-442f-565f-08d8702db684
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3600EAB68C4291D91C488DE0AD050@VI1PR0402MB3600.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9o51FEUhxiGXJp/sIkwxx4JqZaM1VktV9odTkbx2yBDqwsDtSDwSb5plfpuR3G0h+eUjlaXZZCAsun75RdMZMvbvK2z90e2OSWENJgqcqVA8thVqmaUv8t6ciOF22TR0ynLuMD9egU3VDfIV5cu+9PIgzGkuDzCVe4RI/tuB6/DwzYAmlqAu9xdpYpoPkF2FsA9eiql0MXpOZxR4eyF7R6+KQmLSNDiThunkoYY/OrIuLQWe6V6T/ly1ufyyhmip57X8Xf2DGDfZVxmwe3QITrcpzafjzIe1AK6Y+x3IP6QtiYl5KKRFIOZ4YL57ViBdZ4S8Am14y3OPtEFmxSxokJZSbwoqgeSLbObsnWu2Imw2g78GwvQiOemPX8rTWFdm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(26005)(66556008)(5660300002)(2906002)(6666004)(4326008)(66476007)(66946007)(16526019)(186003)(1076003)(316002)(2616005)(956004)(55236004)(86362001)(6486002)(6506007)(36756003)(107886003)(478600001)(8936002)(6512007)(7416002)(8676002)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1YPfwdCaVfd69iPFriUNW49LI1jDLplKhM26jAvB+OGPDbqfRI2vwGs2cl8rDRZ8p9PvPN7M2a2ll7rhDFHECvd6+4RNjNnaRXb9+g3X1wM4lNGErEl8LMXBUG2yDn8U8oUWE1XqZEBz31u2sLAkSbx1Ou25GIYAwJ/VtBq0NprNzHgTnhouRB+9C0wlu9Fcw81xoq21YuLoaOhY3ta1Fa1YBQ9xDlGEglh+SR5yHUsS5Sc1UrFqylR1xulQcBcTljkO7nwDe1a/y9JQL6Cfsk02ZVykia0nEXo/IU0RLknGOUolew7RcfZocAR3Nugq42ISg8mbG7DBj68r7Wj83d3QPk+XHvKHXCFdUz6rjzvgfvaIpXJktFhdnYn5tEpWNfpgvjGMUIzjhEl2TNl3L8QCZrlMJv+BXcffbl6AjcEQ+7OBeIsoK74H1TslYjVq3LiLaGcZaowz+d7/wOpVRDpVpsN2t+j+27zWrJcY5deOTO3OZHYQS7+jrLcp6vejlTAtfAByudSROrUYtVfw9jHwKEhOHTmwUSMwpUVWNVFCai2cWHKem1EY8XZ9EfgE2XjoOxlIh6UKWZVwuvGRRBXSEIR2IAaj0k4Q+/oy4zcih3mvA2UIoa+kFERxLdCgq7JCwFEE+9wgbudp0OKZNg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c2b70a-03f2-442f-565f-08d8702db684
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 10:41:31.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5aV0xjoJyWrxROzG6DhFdgaLrupKxrzTixKAeKJlyeuRU5z8pVrm+2zhdXP00Pg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3600
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add arm64 IMA arch support. The code and arch policy is mainly inherited
from x86.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/kernel/Makefile   |  2 ++
 arch/arm64/kernel/ima_arch.c | 46 ++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 arch/arm64/kernel/ima_arch.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 08fa3a1c50f0..15b7a3bbb7e5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -199,6 +199,7 @@ config ARM64
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
index 000000000000..f3103c8a2cab
--- /dev/null
+++ b/arch/arm64/kernel/ima_arch.c
@@ -0,0 +1,46 @@
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
+	static enum efi_secureboot_mode sb_mode;
+	static bool initialized;
+
+	if (!initialized && efi_enabled(EFI_BOOT)) {
+		sb_mode =3D efi_get_secureboot_mode();
+		initialized =3D true;
+	}
+
+	if (sb_mode =3D=3D efi_secureboot_mode_enabled)
+		return true;
+	else
+		return false;
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
2.26.1

