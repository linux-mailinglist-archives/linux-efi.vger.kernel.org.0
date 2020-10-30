Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD8C29FD9E
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 07:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgJ3GJ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 02:09:29 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:23087 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgJ3GJ2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Oct 2020 02:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604038164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQvM2JE+j7/DleT37T611kucF8NlR4G9Y59/gRb7JBk=;
        b=O5TZNfmhK8YQXYQnaAaOLyxSgR6COnZQbQIGBQRXHthd2YQKk2OQPjOy8ZOYknyiAzqia6
        +yEcsaXwL8gkGV8QHiJGzbp44Eh+8+Ps9KW9fMnZsVQZtU9GYpW9/k/GRo40uBP3mB+E1m
        bV5Og9gTXXdpmp0CX2PsczeCyUXXPx8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-MDnEefD4MIGO8vQAJeivZw-1; Fri, 30 Oct 2020 07:09:23 +0100
X-MC-Unique: MDnEefD4MIGO8vQAJeivZw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEOP2Z2lkrUTUVrqLUrWSaFji1eA/tmNtxXPu5zellU/k47Aq/UVi9oQ14mCcVKV9APiJC1iHk/oDp7B34bnsILomEkkrg3Oaokgm5j+T+8NJ4kXA7i9ghz4qAQmcN5IqynmB0wPwhUn8fIPMCss3wxa/FD1SHfjS3bDLRKl4wc62AFkpSadx9SW7t3fod1z91vsnk/epFOqzPvuC5X9xO86UTeadZQcFkN7ntUDwypalWteiYdfSjK77CyjtNu/Yf3JwdsPSOuWYbhEuU0FuPdLQr5/PT4+wCi6O/yeLeVbV56YGmb2gmPaEkgpBqEe82Oz83+uwV4MC0kcxGb3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4iAAMV7x59qmnQJ5iU4xhe/FTnFqg0ZYqSlBHXpBVY=;
 b=BrbE36m1SSapLE5eZy0ey4yZsxPXBDOOd4AIssD5MuTw5SIxYENPgz/RwkLJwikuaoVZ4FBhE74VGI102GvGTHjVXD8nRdhKxkYxEBePGBbzqbUv6iGc0INHYOaEj4rAY1TOyGN4N9Qrv4MjADMQMzjcEoGqbzl8ec5hupCW91/lBSVMOnCsin6dJMJjeETNEdyqeTk/PVXxrdoXWStQB6gd7vsHxQHm89wEfh6NvTdqEbliH9x7bVh80FOCARPwLzizq4aVcgYvByTrk9mYfZzYXagWluT81ogN5syP/sdOaozW7xOM/hYbbzfz4hxMbr+SxvIHx9z/KGwpEglfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB4919.eurprd04.prod.outlook.com (2603:10a6:20b:c::23)
 by AS8PR04MB7943.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 06:09:21 +0000
Received: from AM6PR04MB4919.eurprd04.prod.outlook.com
 ([fe80::f063:76fc:db1a:905b]) by AM6PR04MB4919.eurprd04.prod.outlook.com
 ([fe80::f063:76fc:db1a:905b%6]) with mapi id 15.20.3477.035; Fri, 30 Oct 2020
 06:09:21 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
CC:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH v3 2/3] ima: replace arch-specific get_sb_mode() with a common helper ima_get_efi_secureboot()
Date:   Fri, 30 Oct 2020 14:08:39 +0800
Message-ID: <20201030060840.1810-3-clin@suse.com>
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
Received: from localhost.localdomain (36.225.26.227) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Fri, 30 Oct 2020 06:09:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 421955fd-abee-4680-c635-08d87c9a57e9
X-MS-TrafficTypeDiagnostic: AS8PR04MB7943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7943FB7A97BFA67C67899C1FAD150@AS8PR04MB7943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBLF86StWzcOkwgNzHklYX+4S+xJ8XGNdHcfJxVRNByNjZh/AtUWZm7ynoK+GmiAOFmJGmyAciVJPVYmaySVWkAZIGV2m4m0W4BD/SVOyn83V+eZtma6sqMrqoUInPUt25ZMzc8SajlYRg4OKQDuuRSyE0K9rrXiBPNhbEoJh9B0MoB4SRbZNrLGwFpZO+T05kJc2wx4dd4YOcoxrVuKSqYKGvGXnTNgHze7LnAc5LWMgzLQJVdJsvodcgQozi+9u8tJo11oSFVvrOdCO7sa4Pd0nHlnrDBcfKPEjkUUo0AvR0WTE9n6Clz2VqDSOOv1GUki4zNJoNk2rff9xDQDO68QWzvsV/+MP5mQv4IyViUfl2YNQH/27mynSppziMjVz1UMiNJ9VRD+boDhUIyCww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4919.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(186003)(2906002)(7416002)(36756003)(2616005)(16526019)(1076003)(956004)(5660300002)(52116002)(6486002)(8676002)(6512007)(66556008)(66476007)(66946007)(86362001)(6506007)(26005)(69590400008)(8936002)(316002)(83380400001)(478600001)(107886003)(6666004)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: caMxZmqnK4pZcjkhqeJsVc7YG1rZpMio+ePPac97FeEvwKD43kBhqoZToH0eber3fuausLBpy5kBRuCdjwgDsYJQrc95cdiNvqlv+Z/Mkzdb4eqrtJHgd9feTE7hM5J57m6QnRfgF9xctm4OpHdhvB6zDZ+QQrvB3vN2AXFCJV5OSqjOfrSS4YBn40Q52+vKeZD0w7sA2RJ+60NvLH0pFu41BhYDu0A4Fx7ou43G1sFnQDbygmlj0cjB7EVIbjcuPi8fY85eK9g48r61f221Cm49QLJgM55mSBczN5V4wNsUqxJYamKkEreY0As2Owe7HPb2/snRbbRwFg1GKIIBdmQYKFuSLO/7x7/UkbsKgeyEKAsvflulq/mDnbuuhq5bMO9MY7cV+HFVLrQimZxKRFJix2OMhbrU7T8mFF8vBzWUyqzxBFdidccf23HQI5jmI8T3erTWtyAYDrbgS7PCgqQgivSFXmYuBD2IV0+AtSW5qlhHtSJ/5Wh3DwLxHfVO6nMLKzN40GTM8lnv7Sas8C7bhGQa8E7S9mt5LQXXvVRfMKI7UlKArOSwwiaGXzijdzoZsqU5g4uuzPvPOSWHBGFsQgTQAVeJ1wl8vHqOYwxkOAJOckEUoJxC/t5B9orJOW+vW2iStvDbxL5lZMK6qw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421955fd-abee-4680-c635-08d87c9a57e9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4919.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 06:09:21.6060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiWL43G8d249K9vjR86wwFas52E+6S1o+sN/yXpD9qPsyiWsydaO0/JS5vh1tW9R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7943
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

remove the get_sb_mode() from x86/kernel/ima_arch.c and create a common
helper ima_get_efi_secureboot() in IMA so that all EFI-based architectures
can refer to the same procedure.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/x86/kernel/ima_arch.c       | 69 +++++++-------------------------
 include/linux/ima.h              | 10 +++++
 security/integrity/ima/Makefile  |  1 +
 security/integrity/ima/ima_efi.c | 26 ++++++++++++
 4 files changed, 51 insertions(+), 55 deletions(-)
 create mode 100644 security/integrity/ima/ima_efi.c

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 7dfb1e808928..2c773532ff0a 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -8,69 +8,28 @@
=20
 extern struct boot_params boot_params;
=20
-static enum efi_secureboot_mode get_sb_mode(void)
-{
-	efi_guid_t efi_variable_guid =3D EFI_GLOBAL_VARIABLE_GUID;
-	efi_status_t status;
-	unsigned long size;
-	u8 secboot, setupmode;
-
-	size =3D sizeof(secboot);
-
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
-		pr_info("ima: secureboot mode unknown, no efi\n");
-		return efi_secureboot_mode_unknown;
-	}
-
-	/* Get variable contents into buffer */
-	status =3D efi.get_variable(L"SecureBoot", &efi_variable_guid,
-				  NULL, &size, &secboot);
-	if (status =3D=3D EFI_NOT_FOUND) {
-		pr_info("ima: secureboot mode disabled\n");
-		return efi_secureboot_mode_disabled;
-	}
-
-	if (status !=3D EFI_SUCCESS) {
-		pr_info("ima: secureboot mode unknown\n");
-		return efi_secureboot_mode_unknown;
-	}
-
-	size =3D sizeof(setupmode);
-	status =3D efi.get_variable(L"SetupMode", &efi_variable_guid,
-				  NULL, &size, &setupmode);
-
-	if (status !=3D EFI_SUCCESS)	/* ignore unknown SetupMode */
-		setupmode =3D 0;
-
-	if (secboot =3D=3D 0 || setupmode =3D=3D 1) {
-		pr_info("ima: secureboot mode disabled\n");
-		return efi_secureboot_mode_disabled;
-	}
-
-	pr_info("ima: secureboot mode enabled\n");
-	return efi_secureboot_mode_enabled;
-}
-
 bool arch_ima_get_secureboot(void)
 {
-	static enum efi_secureboot_mode sb_mode;
-	static bool initialized;
-
-	if (!initialized && efi_enabled(EFI_BOOT)) {
-		sb_mode =3D boot_params.secure_boot;
+	static bool sb_enabled, initialized;
=20
-		if (sb_mode =3D=3D efi_secureboot_mode_unset)
-			sb_mode =3D get_sb_mode();
+	if (initialized) {
+		return sb_enabled;
+	} else if (efi_enabled(EFI_BOOT)) {
 		initialized =3D true;
+
+		if (boot_params.secure_boot =3D=3D efi_secureboot_mode_unset) {
+			sb_enabled =3D ima_get_efi_secureboot();
+			return sb_enabled;
+		}
 	}
=20
-	if (sb_mode =3D=3D efi_secureboot_mode_enabled)
-		return true;
-	else
-		return false;
+	if (boot_params.secure_boot =3D=3D efi_secureboot_mode_enabled)
+		sb_enabled =3D true;
+
+	return sb_enabled;
 }
=20
-/* secureboot arch rules */
+/* secure and trusted boot arch rules */
 static const char * const sb_arch_rules[] =3D {
 #if !IS_ENABLED(CONFIG_KEXEC_SIG)
 	"appraise func=3DKEXEC_KERNEL_CHECK appraise_type=3Dimasig",
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8fa7bcfb2da2..9f9699f017be 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -50,6 +50,16 @@ static inline const char * const *arch_get_ima_policy(vo=
id)
 }
 #endif
=20
+#if defined(CONFIG_EFI) && defined(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)
+extern bool ima_get_efi_secureboot(void);
+#else
+static inline bool ima_get_efi_secureboot(void)
+{
+	return false;
+}
+#endif
+
+
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
 {
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makef=
ile
index 67dabca670e2..32076b3fd292 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,3 +14,4 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) +=3D ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) +=3D ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) +=3D ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) +=3D ima_queue_keys.o
+ima-$(CONFIG_EFI) +=3D ima_efi.o
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_=
efi.c
new file mode 100644
index 000000000000..a78f66e19689
--- /dev/null
+++ b/security/integrity/ima/ima_efi.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 SUSE LLC
+ *
+ * Author:
+ * Chester Lin <clin@suse.com>
+ */
+
+#include <linux/efi.h>
+#include <linux/ima.h>
+
+#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
+bool ima_get_efi_secureboot(void)
+{
+	enum efi_secureboot_mode sb_mode;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		pr_info("ima: secureboot mode unknown, no efi\n");
+		return false;
+	}
+
+	sb_mode =3D efi_get_secureboot(efi.get_variable);
+
+	return (sb_mode =3D=3D efi_secureboot_mode_enabled) ? true : false;
+}
+#endif
--=20
2.28.0

