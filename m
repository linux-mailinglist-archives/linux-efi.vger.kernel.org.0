Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72229FD9B
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 07:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgJ3GJX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 02:09:23 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:28662 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgJ3GJX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Oct 2020 02:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604038159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUKxGzan5uWFtK6gBoKg+rjV3lc0R7rkT0PZnUKnzSw=;
        b=MUUSBs7gPBRJGbYrR0m8z+P5ReIci+0OAv5pIwdZR0yWTauFZYmBpWssmf67LjJaydJ6eX
        nr6MqWJ17i0ElFhgB70K69W384hE9yvaJG6SNBU6yoOjRPZI59a3/EY882Qdc+PjUdzLHe
        D8YAbB91cJW8HYRMbg8XHDtWmpEIq8I=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-8t0A9jXjM_i1sZG_HSWBpQ-1; Fri, 30 Oct 2020 07:09:18 +0100
X-MC-Unique: 8t0A9jXjM_i1sZG_HSWBpQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DddbCW51XkDD20IkTA6tvaSWeEt6XK+foSYrYd0fjkfdm/BS7zCByXjy4pQMBKf4wgzvlPYmZ+JlIw1nTmwUd9SJf61uEgRthBMsh+f6JiQR/36EevOjz5z1lDcN+Tz3FjS236ILIuVthCda+zVzJaHz4mm8SfPMpNt9lfvg98Mwl0M0Fz7h9erd5Q6yWD+YNUdt9vORaEMpqG6JOJKoV6iVSSzQA58V9I8G/0sQ/5vDT+/ThbgCFLfHPNSVqVaDyff77MEGefVJPsocPTpefhNDpOx2asb48/G8/FhoAqlqPLX+yuV7JQFfJODZVNvRN6mrRNbdgZot4VaK+JZ0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gepDNqtt+cyRoPs2yyuC7yQGbTAgPkdpD5ThQ+4scD4=;
 b=TGtGMfXu9msZgbAmZifZV8iUYaSAJkr6idI3RYrDZ4KY1M4IVdTuwUXB/BPBnRa+ZHpV0r43k0ZMgngk+cB5/Nm37jktwE8Egt/+rsf67Kb0dOLdfVp55WqhChAaicVFw6Q7IbRRb2+9Si4yDXicVOdEUaxmY6zdlvHO/PsKmBgc1i/qn3MDUpQH7djkfhUbxWSLxpH34iFjU+xakbMFkzxloNHl8yfe4OY0QHzu1p81C4RodzKm/70E7RGlLcmSHO5vKaD3VUYxVD/cOpblZkLghd7oTl4R0Rjiaf14VBFT/Q3QnLGma/G3dpptKUP+dUKGI73Ez8fjojxryigZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB4919.eurprd04.prod.outlook.com (2603:10a6:20b:c::23)
 by AS8PR04MB7943.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 06:09:16 +0000
Received: from AM6PR04MB4919.eurprd04.prod.outlook.com
 ([fe80::f063:76fc:db1a:905b]) by AM6PR04MB4919.eurprd04.prod.outlook.com
 ([fe80::f063:76fc:db1a:905b%6]) with mapi id 15.20.3477.035; Fri, 30 Oct 2020
 06:09:16 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
CC:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH v3 1/3] efi: generalize efi_get_secureboot
Date:   Fri, 30 Oct 2020 14:08:38 +0800
Message-ID: <20201030060840.1810-2-clin@suse.com>
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
Received: from localhost.localdomain (36.225.26.227) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Fri, 30 Oct 2020 06:09:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 720f2a6b-9976-4b7f-2ac4-08d87c9a54e9
X-MS-TrafficTypeDiagnostic: AS8PR04MB7943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB79436DF1610F34ED9DFDCF02AD150@AS8PR04MB7943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PZxF4wZ1A8OoJT3B1AKnUSbgziNEBpuLK0/i2qa1ywDHes2qqax3pT9NxjcwyUy3XUUPMiy9BFIqU3PUVNwZJddRorDtxLTH7inxmiG2H4AqrpNSj+neYcXk+zp/aVcAAbzVsxDxnQ2klyvKpcX3pYPMqHJ6EB31emt9Rg1WQTCJkcvlzcb0usjuZein1ioRnRtWN7zK5y4cr/xwCmp1MV8GMHnIWfm1zE2aql56gtwGjTuGSVbWdigPiaI4jG7XOUGy0lzRJ6uy+QhmAtZ8MnH5tQ8azMRgTkS0V4G7D2u9sFbO6WxJnNiWQ1emx8gc48qikw1hDqdjKDRJmvtmK+fVbOqznqaf2bU2pV58Y4p24iChdI/++q7Uy+PohKLatcw8Bo1n6kMUGMl6JT6gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4919.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(186003)(2906002)(7416002)(36756003)(2616005)(16526019)(1076003)(956004)(5660300002)(52116002)(6486002)(8676002)(6512007)(66556008)(66476007)(66946007)(86362001)(6506007)(26005)(69590400008)(8936002)(316002)(83380400001)(478600001)(107886003)(45080400002)(6666004)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Yh1hF//+NqiKTN6lLqDlF0ZmVAPXf6x8AxHxhCHLRTmitg8R3V4xMnDwH9qxUszQs8jH2IaP2vAtc8CdbNSGJ2jvjMs1mX3yyPOvNOhT6kUpEFZFdiKqL+uAoEafrurQc853jJMHQ/iWaxgqk9l85qrAuFsh4yqBcDEU+qufhmgZCMuKxbeilLW1/JwoTwQEEWHBmAqBC4RBBP+hSuaHrPu4IbMEusHFne9Ao0AdTg1Ad8NU72R8wGZ2pqniCKe0d7aCK1yDPUj9liHFCOOyeFVxHweV9pBwSX0jIq82okHPLkELikfpg2p/IQUqgG7s/+BncN1PLDog44XgpRQ2wIHAUZaNtz3l+blQSgrTOaE6CdFB7UkJ3GuJsnNGIe+iYzRgrZMyhq13dSY2PmBDdNb+y2dsNTaW6bZDKwhY4DaSbllNq1l1ECPERUhq0TUt6s9/ClJCdg/rGs2iE9blmDSFGc9inBcQpZ9EA4hDTQ9uYTsNoNEwhGU9wWQtRP1UMHMtcyS0PA+/DbO9rYsobjXApWsk1ZMCiTUyvptJj9wCqXCiLpIMLNuFOMF9emtua94Wrgpl0yx8f/m/R8iDd8pKHECoa+k4nAfaREqw4OQmAyA60xy6i+7lPn0Cnv/doL3O2l7Bwe46ljAmUJcGcg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720f2a6b-9976-4b7f-2ac4-08d87c9a54e9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4919.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 06:09:16.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: So4VeEc5gSCbSBAeT9lKS0NvaqvY+K86q6FZUelxKUW0FQvJ5sbi7MFipnQQNPCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7943
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Generalize the efi_get_secureboot() function so not only efistub but also
other subsystems can use it.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/firmware/efi/libstub/Makefile     |  2 +-
 drivers/firmware/efi/libstub/efi-stub.c   |  2 +-
 drivers/firmware/efi/libstub/efistub.h    | 22 ++++---
 drivers/firmware/efi/libstub/secureboot.c | 76 -----------------------
 drivers/firmware/efi/libstub/x86-stub.c   |  2 +-
 include/linux/efi.h                       | 41 +++++++++++-
 6 files changed, 57 insertions(+), 88 deletions(-)
 delete mode 100644 drivers/firmware/efi/libstub/secureboot.c

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/l=
ibstub/Makefile
index 8a94388e38b3..88e47b0ca09d 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -49,7 +49,7 @@ OBJECT_FILES_NON_STANDARD	:=3D y
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT			:=3D n
=20
-lib-y				:=3D efi-stub-helper.o gop.o secureboot.o tpm.o \
+lib-y				:=3D efi-stub-helper.o gop.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
 				   alignedmem.o relocate.o vsprintf.o
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi=
/libstub/efi-stub.c
index 914a343c7785..ad96f1d786a9 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -196,7 +196,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation();
=20
-	secure_boot =3D efi_get_secureboot();
+	secure_boot =3D efi_get_secureboot(get_efi_var);
=20
 	/*
 	 * Unauthenticated device tree data is a security hazard, so ignore
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/=
libstub/efistub.h
index 2d7abcd99de9..b1833b51e6d6 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -91,14 +91,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	fdt_setprop((fdt), (node_offset), (name), &(var), sizeof(var))
 #endif
=20
-#define get_efi_var(name, vendor, ...)				\
-	efi_rt_call(get_variable, (efi_char16_t *)(name),	\
-		    (efi_guid_t *)(vendor), __VA_ARGS__)
-
-#define set_efi_var(name, vendor, ...)				\
-	efi_rt_call(set_variable, (efi_char16_t *)(name),	\
-		    (efi_guid_t *)(vendor), __VA_ARGS__)
-
 #define efi_get_handle_at(array, idx)					\
 	(efi_is_native() ? (array)[idx] 				\
 		: (efi_handle_t)(unsigned long)((u32 *)(array))[idx])
@@ -112,6 +104,20 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle=
,
 		((handle =3D efi_get_handle_at((array), i)) || true);	\
 	     i++)
=20
+static inline
+efi_status_t get_efi_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr=
,
+			 unsigned long *size, void *data)
+{
+	return efi_rt_call(get_variable, name, vendor, attr, size, data);
+}
+
+static inline
+efi_status_t set_efi_var(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
+			 unsigned long size, void *data)
+{
+	return efi_rt_call(set_variable, name, vendor, attr, size, data);
+}
+
 static inline
 void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
 {
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/e=
fi/libstub/secureboot.c
deleted file mode 100644
index 5efc524b14be..000000000000
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ /dev/null
@@ -1,76 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Secure boot handling.
- *
- * Copyright (C) 2013,2014 Linaro Limited
- *     Roy Franz <roy.franz@linaro.org
- * Copyright (C) 2013 Red Hat, Inc.
- *     Mark Salter <msalter@redhat.com>
- */
-#include <linux/efi.h>
-#include <asm/efi.h>
-
-#include "efistub.h"
-
-/* BIOS variables */
-static const efi_guid_t efi_variable_guid =3D EFI_GLOBAL_VARIABLE_GUID;
-static const efi_char16_t efi_SecureBoot_name[] =3D L"SecureBoot";
-static const efi_char16_t efi_SetupMode_name[] =3D L"SetupMode";
-
-/* SHIM variables */
-static const efi_guid_t shim_guid =3D EFI_SHIM_LOCK_GUID;
-static const efi_char16_t shim_MokSBState_name[] =3D L"MokSBState";
-
-/*
- * Determine whether we're in secure boot mode.
- *
- * Please keep the logic in sync with
- * arch/x86/xen/efi.c:xen_efi_get_secureboot().
- */
-enum efi_secureboot_mode efi_get_secureboot(void)
-{
-	u32 attr;
-	u8 secboot, setupmode, moksbstate;
-	unsigned long size;
-	efi_status_t status;
-
-	size =3D sizeof(secboot);
-	status =3D get_efi_var(efi_SecureBoot_name, &efi_variable_guid,
-			     NULL, &size, &secboot);
-	if (status =3D=3D EFI_NOT_FOUND)
-		return efi_secureboot_mode_disabled;
-	if (status !=3D EFI_SUCCESS)
-		goto out_efi_err;
-
-	size =3D sizeof(setupmode);
-	status =3D get_efi_var(efi_SetupMode_name, &efi_variable_guid,
-			     NULL, &size, &setupmode);
-	if (status !=3D EFI_SUCCESS)
-		goto out_efi_err;
-
-	if (secboot =3D=3D 0 || setupmode =3D=3D 1)
-		return efi_secureboot_mode_disabled;
-
-	/*
-	 * See if a user has put the shim into insecure mode. If so, and if the
-	 * variable doesn't have the runtime attribute set, we might as well
-	 * honor that.
-	 */
-	size =3D sizeof(moksbstate);
-	status =3D get_efi_var(shim_MokSBState_name, &shim_guid,
-			     &attr, &size, &moksbstate);
-
-	/* If it fails, we don't care why. Default to secure */
-	if (status !=3D EFI_SUCCESS)
-		goto secure_boot_enabled;
-	if (!(attr & EFI_VARIABLE_RUNTIME_ACCESS) && moksbstate =3D=3D 1)
-		return efi_secureboot_mode_disabled;
-
-secure_boot_enabled:
-	efi_info("UEFI Secure Boot is enabled.\n");
-	return efi_secureboot_mode_enabled;
-
-out_efi_err:
-	efi_err("Could not determine UEFI Secure Boot status.\n");
-	return efi_secureboot_mode_unknown;
-}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi=
/libstub/x86-stub.c
index 3672539cb96e..3f9b492c566b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -781,7 +781,7 @@ unsigned long efi_main(efi_handle_t handle,
 	 * otherwise we ask the BIOS.
 	 */
 	if (boot_params->secure_boot =3D=3D efi_secureboot_mode_unset)
-		boot_params->secure_boot =3D efi_get_secureboot();
+		boot_params->secure_boot =3D efi_get_secureboot(get_efi_var);
=20
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation();
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d7c0e73af2b9..cc2d3de39031 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1089,7 +1089,46 @@ enum efi_secureboot_mode {
 	efi_secureboot_mode_disabled,
 	efi_secureboot_mode_enabled,
 };
-enum efi_secureboot_mode efi_get_secureboot(void);
+
+static inline enum efi_secureboot_mode efi_get_secureboot(efi_get_variable=
_t *get_var)
+{
+	efi_guid_t var_guid =3D EFI_GLOBAL_VARIABLE_GUID;
+	efi_guid_t shim_guid =3D EFI_SHIM_LOCK_GUID;
+	efi_status_t status;
+	unsigned long size;
+	u8 secboot, setupmode, moksbstate;
+	u32 attr;
+
+	size =3D sizeof(secboot);
+	status =3D get_var(L"SecureBoot", &var_guid, NULL, &size, &secboot);
+
+	if (status =3D=3D EFI_NOT_FOUND)
+		return efi_secureboot_mode_disabled;
+	if (status !=3D EFI_SUCCESS)
+		return efi_secureboot_mode_unknown;
+
+	size =3D sizeof(setupmode);
+	status =3D get_var(L"SetupMode", &var_guid, NULL, &size, &setupmode);
+
+	if (status !=3D EFI_SUCCESS)
+		return efi_secureboot_mode_unknown;
+	if (secboot =3D=3D 0 || setupmode =3D=3D 1)
+		return efi_secureboot_mode_disabled;
+
+	/*
+	 * See if a user has put the shim into insecure mode. If so, and if the
+	 * variable doesn't have the runtime attribute set, we might as well
+	 * honor that.
+	 */
+	size =3D sizeof(moksbstate);
+	status =3D get_var(L"MokSBState", &shim_guid, &attr, &size, &moksbstate);
+	/* If it fails, we don't care why. Default to secure */
+	if (status =3D=3D EFI_SUCCESS && moksbstate =3D=3D 1
+	    && !(attr & EFI_VARIABLE_RUNTIME_ACCESS))
+		return efi_secureboot_mode_disabled;
+
+	return efi_secureboot_mode_enabled;
+}
=20
 #ifdef CONFIG_RESET_ATTACK_MITIGATION
 void efi_enable_reset_attack_mitigation(void);
--=20
2.28.0

