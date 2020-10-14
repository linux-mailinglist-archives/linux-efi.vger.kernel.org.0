Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EA828DF1C
	for <lists+linux-efi@lfdr.de>; Wed, 14 Oct 2020 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbgJNKle (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Oct 2020 06:41:34 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:47311 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387779AbgJNKl3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Oct 2020 06:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1602672086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DX1ZK3/1sTmoPzvnoNhBiQWKtM8tWGS4p6JMf2/xZwY=;
        b=PcoGuYWfc/csUnCNtsKumhIgvJWtVkwKdFUG6u8OpJKiCgENvXdlU3M65ffHiRskjdBS3H
        sYzeoBjgf3D6yaDw17uxWY4gaaC4E0mz7a1U1K0/RZGWuGyH3ZZuIhuL00ZmiNJt9PBtZT
        603m6h6VsonvAGWI1q9P5fo9mzCAdq8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-30-AeUS50VUOPWU93jj9CvnXQ-1; Wed, 14 Oct 2020 12:41:25 +0200
X-MC-Unique: AeUS50VUOPWU93jj9CvnXQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkyIoOh6hnC7y7hl8d9nqyv8tVK+NzH1efYsr467nqibXxLrE8ftKqoCEQxhU6OJD8NyY9mnrkK7pRIwLT7kvPHFiTRvREkdiMtpDAvFcG4o49nmTJ2Wux3s3K8zbRSa2kpU7YMwFvpCA2wXXiRcBeCcng+PR4nUqqLnzrGts5C89yB5ThHliL84CYFqNOGlc3y5XTp8vsL9Ri0p5Mdpb7yuSybaBkNC+RJ3/vX92o1JOc7ZhPkiGxSTNrOGn/wQ8+e9aec/g1gVLFzn83usyl74JyN2Y0v74D4CA+UK6e6tEr6PmhlWRmKL9VnvndvnfcNtMvm6hvvR/462Uk9DaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzQTPQkBdGFKOP5+s4UUfeGv1eDzjOXLoRlcEAHF4ww=;
 b=OvWaDpJWVneFL+9tO75HerqH5b5KVSBRMm19ounyvfl1cgR55i5X1+OgewBlhEPETUuq73JvfPd24rBx4V82QghOsIFzix0nUj78RjIyNePvIIJ745kXZJ5hLAepD7cDIgOuJx341DxiNsTFtsDwtoxjYgSXwO2SpuKA7MSGNbDkXlbE4AuApJDk7HhueUBSecuFBmExmajPonrQvblh4TMR1zrY0eUiv2g6Ug0tQq7gpQO+pbyGFqKzSINUkM1LWNG4bRJtzOMTBzeShZ3riqC0u1LiEbSORJ2V1FofGmbz3VeHvVBruKo4tLorKOJPcfG5aIDtpewiv8nICfEjSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR0402MB3600.eurprd04.prod.outlook.com (2603:10a6:803:7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 10:41:24 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0%6]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 10:41:24 +0000
From:   Chester Lin <clin@suse.com>
To:     zohar@linux.ibm.com, ardb@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, samitolvanen@google.com, masahiroy@kernel.org
CC:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-efi@vger.kernel.org, jlee@suse.com, clin@suse.com
Subject: [PATCH v2 1/2] efi: add secure boot get helper
Date:   Wed, 14 Oct 2020 18:40:31 +0800
Message-ID: <20201014104032.9776-2-clin@suse.com>
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
Received: from linux-8mug.suse.cz (118.166.52.150) by AM0PR01CA0074.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 10:41:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55aab5a2-b9d1-4d72-ced9-08d8702db285
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB360039D31E274FF7FC4A9ACCAD050@VI1PR0402MB3600.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqJgbaCVtfKsC4XzDmfV5SQxrp68IJ2NWUTXNwn1MFzMysnm+NAozoUXwy/3xqlsl1Azy/qHfdcHRunlrPNvvWJUlqdN4HbKXHJRLpaUNBaQPmg45aSobuQ0MOIdenkT6zwQ9whrsnrqHY/03tWMDs6E57+0eZCKlKPiRLtdZYe33ip3aDBvUJ57ffAPuzH0VbDG2Gq/D8w0sXKHCZ9Ar3Ax/blhe7id72EmuQJRxcwJn3mQXg9pFi5Ye6myJjt4SQjAFqgD6mvfBM3jBZHSHNYaVzA9UVbPPiWKQZIYaWHJBTy2v5qsn6JoxJuqO4sBIj1DMakV6kSTuFmgnhSWabU/t9uQk6/dj0gDQP/6hoIx+EUgmrddKmxx75q5O3RB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(26005)(66556008)(5660300002)(2906002)(6666004)(4326008)(66476007)(66946007)(16526019)(186003)(1076003)(83380400001)(316002)(2616005)(956004)(55236004)(86362001)(6486002)(6506007)(36756003)(107886003)(478600001)(8936002)(6512007)(7416002)(8676002)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: v40dyIburKf5ZXKIlf2nPcDZz4jCwjn6ds6DdzPO66oslwxxCn9mKryDE7FazD//Fh5Vt5TOxxa7z6vYjS6N8ihv+UN/6OM5nJ2PqSFhoj8ydK5TKV8/fDYBPvwdYSKy2Juet8AWI/ghwGsdKLc1dRbMPGGmun9hPxFtKOTP1ax1px/fGvSF82CyaNhl7I0gvFnsNDQ5fr2y9W9dtejKJXeEx2UlzsEAb6eJ5uJyUJay7iucFZXyTgTO2onUAGA2Whz52CipLlFFG/wahl1+suWSf7Bn6cCDUIYwvbgNDbPsZZUOJRPmrml48uQXiH/E4uh2CAdht0bGchVRzPIDln12QLpfJrRwL5jE2Wsp8WTcXAwoDfIzF/dxCFAMeKeYwoz6590mHVlt8ZG4e4CBZ2H+eLOxp0m6D7rh+2EegmyB1EeeTehfbKl1x2veowkzrZxGXCl4CfJ9D8ifeW7iUfEwc8BrI/OKQ6HMDp9zA2mEjSMZqIsg/LOtGHe9l1EhfpvdRcKiHvOglSOw2LDD4Ee+tUxVbN1DnOlXBFbabwkFad/dnBtRMXkg4gopDv1V72m0Uu0i+3NKl2Wwt4l01qnG9SBXtihjVEMoiU2M9i2aOs0vvobeb78yLvmgbni7dP7Kh9Pn6Cw7shK23ODqBA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55aab5a2-b9d1-4d72-ced9-08d8702db285
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 10:41:24.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRaqifrhK93lK3E0ScLbWudPlFF0zcbthqn65iARrB5VLEozWXx9xIKXpX+E0woh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3600
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Separate the get_sb_mode() from arch/x86 and treat it as a common function
[rename to efi_get_secureboot_mode] so all EFI-based architectures can
reuse the same logic.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/x86/kernel/ima_arch.c | 47 ++------------------------------------
 drivers/firmware/efi/efi.c | 43 ++++++++++++++++++++++++++++++++++
 include/linux/efi.h        |  5 ++++
 3 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 7dfb1e808928..ed4623ecda6e 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -8,49 +8,6 @@
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
 	static enum efi_secureboot_mode sb_mode;
@@ -60,7 +17,7 @@ bool arch_ima_get_secureboot(void)
 		sb_mode =3D boot_params.secure_boot;
=20
 		if (sb_mode =3D=3D efi_secureboot_mode_unset)
-			sb_mode =3D get_sb_mode();
+			sb_mode =3D efi_get_secureboot_mode();
 		initialized =3D true;
 	}
=20
@@ -70,7 +27,7 @@ bool arch_ima_get_secureboot(void)
 		return false;
 }
=20
-/* secureboot arch rules */
+/* secure and trusted boot arch rules */
 static const char * const sb_arch_rules[] =3D {
 #if !IS_ENABLED(CONFIG_KEXEC_SIG)
 	"appraise func=3DKEXEC_KERNEL_CHECK appraise_type=3Dimasig",
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5e5480a0a32d..68ffa6a069c0 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -1022,3 +1022,46 @@ static int __init register_update_efi_random_seed(vo=
id)
 }
 late_initcall(register_update_efi_random_seed);
 #endif
+
+enum efi_secureboot_mode efi_get_secureboot_mode(void)
+{
+	efi_guid_t efi_variable_guid =3D EFI_GLOBAL_VARIABLE_GUID;
+	efi_status_t status;
+	unsigned long size;
+	u8 secboot, setupmode;
+
+	size =3D sizeof(secboot);
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		pr_info("ima: secureboot mode unknown, no efi\n");
+		return efi_secureboot_mode_unknown;
+	}
+
+	/* Get variable contents into buffer */
+	status =3D efi.get_variable(L"SecureBoot", &efi_variable_guid,
+				  NULL, &size, &secboot);
+	if (status =3D=3D EFI_NOT_FOUND) {
+		pr_info("ima: secureboot mode disabled\n");
+		return efi_secureboot_mode_disabled;
+	}
+
+	if (status !=3D EFI_SUCCESS) {
+		pr_info("ima: secureboot mode unknown\n");
+		return efi_secureboot_mode_unknown;
+	}
+
+	size =3D sizeof(setupmode);
+	status =3D efi.get_variable(L"SetupMode", &efi_variable_guid,
+				  NULL, &size, &setupmode);
+
+	if (status !=3D EFI_SUCCESS)	/* ignore unknown SetupMode */
+		setupmode =3D 0;
+
+	if (secboot =3D=3D 0 || setupmode =3D=3D 1) {
+		pr_info("ima: secureboot mode disabled\n");
+		return efi_secureboot_mode_disabled;
+	}
+
+	pr_info("ima: secureboot mode enabled\n");
+	return efi_secureboot_mode_enabled;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d7c0e73af2b9..a73e5ae04672 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1076,8 +1076,13 @@ static inline int efi_runtime_map_copy(void *buf, si=
ze_t bufsz)
=20
 #ifdef CONFIG_EFI
 extern bool efi_runtime_disabled(void);
+extern enum efi_secureboot_mode efi_get_secureboot_mode(void);
 #else
 static inline bool efi_runtime_disabled(void) { return true; }
+static inline enum efi_secureboot_mode efi_get_secureboot_mode(void)
+{
+	return efi_secureboot_mode_disabled;
+}
 #endif
=20
 extern void efi_call_virt_check_flags(unsigned long flags, const char *cal=
l);
--=20
2.26.1

