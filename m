Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B182A25D274
	for <lists+linux-efi@lfdr.de>; Fri,  4 Sep 2020 09:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgIDHaS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 03:30:18 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:42440 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729847AbgIDHaP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 03:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599204612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzgVshd56Vq9MQ/cQ9RvLUiZRyIZb0RWZt9G+3aDwbY=;
        b=DNQJlbFW96kQ0SH7rQKIwpRO0LfWC7K+7V8oLFA1RxjPU5YF/z/qjuMjWn3GDDIwHcZGOj
        KfTRbhH0L6jd8Z7Vo0VkQTUbcokctnT6WszuLyLgrGxGYWTfC6HWDniCSk1Wc5FecwDO/S
        j/pJNGZrERTGP7KiHJO1utOefIxeKdg=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-GUOXjaPKPk6kprPcsGICTA-1; Fri, 04 Sep 2020 09:30:10 +0200
X-MC-Unique: GUOXjaPKPk6kprPcsGICTA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRMhXDbLv9ZY4OpZTMIxl2m6nQXJeOKfm5Sr90OKpj1PPBVjAXt92VTkZdrQJHolqM4ldRptOgI3VUFkQtvjQrXBpmJlGtPUVXLd72jYqlnVMfH2sVaUNHz14crCEUVWmhaOgbMUZ1En7TPogebrHHJA0+9KKAKkzMQorOAFSRupQRGGjcBoLWsvLvN4Sl+VuVklSCUPNlrtwDP5YvuaZbyZOu45V50vxGmkCwPVTowYuFG0C0vPM43/HhbKfl3LhXO0g/uCiF6YwGJW9ukjrfEV6lZUkuEFpMNMp1AJeCYKT//inh+XsqLECs0jDDkcIw4YOsVnwEo9BagE2/1TVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8AYOZUop5MQL12KNroK6RfIHwwOgtVLCQe+Fc9DQeI=;
 b=G8iHAFHPRdaJwxiHNaXpyvXbDLCDKTmZ6nPT0tCFY1m1jBNctWmUWqb0htYf8o731/F8SYbziFtjmVNVzmo0z6xDa8ASH3Fh+jkwnMxqIZj//QNZTRNvwDubUBvlxbyV2hu5WXtEHnMPSf0UUaqC5PJnjoV75KgAB7X02fFmNZDwLZXE1SRAMjcvB0by/g9I9x1P73BJ7vVePZk9/XnUJ1X4vMbG8YnYsj2Z+RHpVM1p4hrv4TXVOErD5IDAHEQ1q9XZ1mBLHmWoK9t8bglMqNddMHOezISkL37tqCk09cL/v8Wig6iep9aR8kVe88oGDY+U7dMd4efd7DGLWNgMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR04MB5534.eurprd04.prod.outlook.com (2603:10a6:803:d2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 07:30:09 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3%2]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 07:30:09 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, corbet@lwn.net,
        mark.rutland@arm.com, vincenzo.frascino@arm.com,
        samitolvanen@google.com, masahiroy@kernel.org, mingo@kernel.org
CC:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH 5/6] arm64/ima: add ima arch support
Date:   Fri,  4 Sep 2020 15:29:04 +0800
Message-ID: <20200904072905.25332-6-clin@suse.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904072905.25332-1-clin@suse.com>
References: <20200904072905.25332-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0073.eurprd02.prod.outlook.com
 (2603:10a6:208:154::14) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug.suse.de (114.24.10.103) by AM0PR02CA0073.eurprd02.prod.outlook.com (2603:10a6:208:154::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 07:30:04 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [114.24.10.103]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69bebcd5-1a96-4b6f-2587-08d850a45a2c
X-MS-TrafficTypeDiagnostic: VI1PR04MB5534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB553489408F496768ADAAE7A2AD2D0@VI1PR04MB5534.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Epvmhi0mwlKkv2bBmuGUaGZXWUSvGhqypI+XgGdkn2jVOskWba3UPG9Gt3xiBdjcP2E6LlyHazCm6paHeoEmfGBTBz7q0K+2Kama66KtTOe6djeXoA3zAeIAr/tqizl+6GgiIEIBJQBZLDUOmQ2f7+XswHt6eKNzqo2X8HHg+kjfSb9lWAs7oV3eONy2NXYKPGNwdvuEKwLIxkaWcofMkEI7VLSeN2lAn2d3wlUEmXkKPTrHT62HVE7oU9ShMV5YrSQ+PcAG4iF3iyExEl9otx8dmlrLvVif2WGWdApqkKZiiqyowFe3JdJ7jHtvIFcHoyeG1H4BraENZ7k30ToBU46ilKcZtSZdgccWwJXWEEeWx77bEpKh25+6U+5tY67S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(5660300002)(2906002)(956004)(316002)(66476007)(66946007)(107886003)(66556008)(6506007)(36756003)(8676002)(16526019)(52116002)(186003)(7416002)(6512007)(1076003)(4326008)(8936002)(26005)(2616005)(478600001)(86362001)(6486002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZpAGHIATZJl3EHPUm9WTJW7es1zsgM+hYaziCzd99ffFoJt2Pdoh1UsxEE+b7Ec04b9gCnXSMVxcXIiuw7rifWWlij4glaBJ1NNqb8NOUaSJSb0uj0RsTRe3z6z8UWjA0A6uceW8RlDI9iTxwwcBiv7dhVQReF7elMiTctobpIjPMVx7QAVDtk/CESp9yWpEpbWfuulpiDlkXg9vSR4PJc7rbRjHJV2Qv5SV/yT+f7XxY+KjFYwksZLFjj0RfkdaGvtVYYFXcyrjg71zoX+Ciayly9SkFpABRm0I/PD3FvF+Pm1W7E7g+OaPBFjKBJDIgpCHUncyvmxWITy5/C/sFhQGJDB4A5olUQPzcKihKySIWehDttmYTy+I7Gp3rl6HvXW8vrRcdxMzLzXboa5L91Yw6RglZi4pi15M2mLiqlzAyv+ZPn4Iyrxx9MhDtDHq8PfeNu+sFYMk5vAaP6oL6CbEXn64plsAWSauLSVC8qu7XkTh8PrsGq/zDzdiUzsI1s0OyhKmCpMzd6ZuH1q17x7UCHLUyFX28/7p5sYlJ6AO7zm3q2xsDWujKEVnYUY6uX+oH75ZPG5bMYNUdsQOLXklmJGJrWfpme7NPjzVpBm4QaWxo9T9UjA6KIUoYMayPR1GjdCivxFmsG51aT87RQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bebcd5-1a96-4b6f-2587-08d850a45a2c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 07:30:09.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4hEx8LZL7SpAJf6RTbfuwABUODj2X2e9ZxOMhjJ+srO5em3DBsao90HLctiHueB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5534
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add arm64 IMA arch support. The arch policy is inherited from x86.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/kernel/Makefile   |  2 ++
 arch/arm64/kernel/ima_arch.c | 37 ++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/kernel/ima_arch.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..b5518e7b604d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -196,6 +196,7 @@ config ARM64
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	help
 	  ARM 64-bit (AArch64) Linux support.
=20
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index a561cbb91d4d..0300ab60785d 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -71,3 +71,5 @@ extra-y					+=3D $(head-y) vmlinux.lds
 ifeq ($(CONFIG_DEBUG_EFI),y)
 AFLAGS_head.o +=3D -DVMLINUX_PATH=3D"\"$(realpath $(objtree)/vmlinux)\""
 endif
+
+obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+=3D ima_arch.o
diff --git a/arch/arm64/kernel/ima_arch.c b/arch/arm64/kernel/ima_arch.c
new file mode 100644
index 000000000000..46f5641c3da5
--- /dev/null
+++ b/arch/arm64/kernel/ima_arch.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 IBM Corporation
+ */
+#include <linux/efi.h>
+#include <linux/module.h>
+
+bool arch_ima_get_secureboot(void)
+{
+	if (efi_enabled(EFI_SECURE_BOOT))
+		return true;
+
+	return false;
+}
+
+/* secureboot arch rules */
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

