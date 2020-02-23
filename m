Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96FD1696D8
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2020 09:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgBWIg0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 Feb 2020 03:36:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:60001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBWIg0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 23 Feb 2020 03:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582446942;
        bh=WcANPpQWohym4JgU2Mv+t1Lv7qPTD9zB5cEjQZYcpPQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PMMUlrTLnTNrUBECdxq8743qyOTcKm602yYZcwOUb2WMCJkokhp4AdtMCGnSVLjGZ
         ebi9zpKIsoNqFbcEJfpPqEberaCPLDNrhgaSC7zNPUBwUpThh9fMGaO/gV0Dn+js+Z
         DkzyUVnCnLN2gd7DkAEQdDrCLpxBxdoNnD1H4kBw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KYb-1jUP6F1q4v-016foT; Sun, 23
 Feb 2020 09:35:42 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-efi@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi: capitalize enum efi_secureboot_mode labels
Date:   Sun, 23 Feb 2020 09:34:46 +0100
Message-Id: <20200223083446.15817-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6MWGPGwUIoMd7vT38AP752PI5Diuuj8H5BlBxHIdF24mzVvdTTF
 pcGX7S1f75iNx1iI9jihjTQmwaPURiZ0uTQZAMZEZ+a03RNDlvhFrYidqRH8UsPHhgpGgkJ
 X6d8Ot7T3TbDhZfwtRRkqx8Eydv/271z35tKOIfG1Me73Jph/pz7R6mgdyuEp8HMUYHyqvQ
 AqPiiVVd7vSv5hGxssS+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+QxYoQlLo94=:bkaK5hGQcHvyOJhGBFMr7Y
 W5p/zyj6XOW750/EpS8p7gpnciOoW/n+D5sMAZGEjWsn4LnirsQJa3RfaRwlPwDXRRjCtk34N
 8fKbXy3TQZQ7YMvz3C7f5mnoL7vvwtdtw0KE71yI7YKey409oUjnjyGqMBQGfl5JX5YSDnb74
 07CHfXwnKVp30WEEHHSCdl2nFsNf6VLDGoviqr+xVN34vUFDKyMQRrDZHH84uFPPPsyhe5JNv
 XwOU6Sbr0kqeq5IyU7927MuXCLuVm1cBPM73a+WA3yl82VLERxPR1KGyt4vZyiVR6mWoVKWe0
 R3nsGD5O/AQkNblMUVk2Bx1WKuleExTPWFssL0Q5rpja3/hyrvkKOlDNuNrrDOZRKrrwhVEyR
 CHzbSLjlSAXQxDe5x9ijyjxlhaXwlbOUye+ddBbE+zHxD90Brc39rbrcTccXNZhkrygTygp9+
 gcBPYgCSROE4ZjrJDocHNjbKeFvHDu83A8Jyw/ZPf6HjLdD1hPzwH1EGmL4wBBjD3PoJABRTE
 Tk6RLiAF/OaUEp2tTh81cIByAIVbbPEbjW4XmfqsTPviHrsn1WRCog7ikmcS1KqLAwicB7ZdX
 0819oA62PyVXuFSdo2Q55o90GMWnaNfT91zxNvpUP/sAfkayW+d2sKsQpkcxtbcIpcYzlovM+
 +MEyfcgtFxdqD14cZU8DGNTGepa5zmg2lmiCndW1F7hZh84IRLjTj6U2dSIsWV/pelMr0kSjy
 zpmQTVuTGPsKkHx6Vg6nbjrSkKSWVsqG0yKbNzUla7Xp+9SX9+ZhqVk7fm76rPHSX2v8xIZsk
 wbPwtyiiU6n5jdP+s/GUzHE+TsqcCKInMjLOQDLfXwaPVebfKmDtsi88T9LqqrVuabPx6EaZc
 uLw6XdLFNGBubWW3Xoq+1hSrzSdgRwHcQscw0jLDTdazH65iTMkpI6wGDYQSgv6jNulSw0NZs
 yhZjaDFn/r+IMNjjE0xGJG311KEikR4INOosdxlnfAccR/gBChQzDhooQt/SpwdqA8GXSbLVr
 jmrk792CKUGmxdoNyEFtZfZERlBLZqCYZ/XKYT4qIyUKxHzbW4u2fdL9uMlPsOcc6YG9fiAbo
 um2A20XnkN5DkJW3dqdHLdOD2qoauFxKGo/6YN2KVerd9aOPFNeAbDBp1hIgSXO6PcD3tJe1i
 01N819NOPP5z9fUAQ2WQpCTiKX/LXkiQ8UO5Lu8/+FHM5g123Ymx+wsDHCVTrJTFoyzRHaPJ4
 JJosPkjdU75TG4TgX
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

According to the "Linux kernel coding style" labels in enums are
capitalized.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
The patch is applicable to the efi/next git branch.
=2D--
 arch/x86/kernel/ima_arch.c                | 14 +++++++-------
 arch/x86/kernel/setup.c                   |  4 ++--
 arch/x86/xen/efi.c                        | 10 +++++-----
 drivers/firmware/efi/libstub/arm-stub.c   |  2 +-
 drivers/firmware/efi/libstub/secureboot.c | 10 +++++-----
 drivers/firmware/efi/libstub/x86-stub.c   |  2 +-
 include/linux/efi.h                       |  8 ++++----
 7 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index cb6ed616a543..4205baaae450 100644
=2D-- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -21,7 +21,7 @@ static enum efi_secureboot_mode get_sb_mode(void)

 	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
 		pr_info("ima: secureboot mode unknown, no efi\n");
-		return efi_secureboot_mode_unknown;
+		return EFI_SECUREBOOT_MODE_UNKNOWN;
 	}

 	/* Get variable contents into buffer */
@@ -29,12 +29,12 @@ static enum efi_secureboot_mode get_sb_mode(void)
 				  NULL, &size, &secboot);
 	if (status =3D=3D EFI_NOT_FOUND) {
 		pr_info("ima: secureboot mode disabled\n");
-		return efi_secureboot_mode_disabled;
+		return EFI_SECUREBOOT_MODE_DISABLED;
 	}

 	if (status !=3D EFI_SUCCESS) {
 		pr_info("ima: secureboot mode unknown\n");
-		return efi_secureboot_mode_unknown;
+		return EFI_SECUREBOOT_MODE_UNKNOWN;
 	}

 	size =3D sizeof(setupmode);
@@ -46,11 +46,11 @@ static enum efi_secureboot_mode get_sb_mode(void)

 	if (secboot =3D=3D 0 || setupmode =3D=3D 1) {
 		pr_info("ima: secureboot mode disabled\n");
-		return efi_secureboot_mode_disabled;
+		return EFI_SECUREBOOT_MODE_DISABLED;
 	}

 	pr_info("ima: secureboot mode enabled\n");
-	return efi_secureboot_mode_enabled;
+	return EFI_SECUREBOOT_MODE_ENABLED;
 }

 bool arch_ima_get_secureboot(void)
@@ -61,12 +61,12 @@ bool arch_ima_get_secureboot(void)
 	if (!initialized && efi_enabled(EFI_BOOT)) {
 		sb_mode =3D boot_params.secure_boot;

-		if (sb_mode =3D=3D efi_secureboot_mode_unset)
+		if (sb_mode =3D=3D EFI_SECUREBOOT_MODE_UNSET)
 			sb_mode =3D get_sb_mode();
 		initialized =3D true;
 	}

-	if (sb_mode =3D=3D efi_secureboot_mode_enabled)
+	if (sb_mode =3D=3D EFI_SECUREBOOT_MODE_ENABLED)
 		return true;
 	else
 		return false;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a74262c71484..76a7b66ef0e6 100644
=2D-- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1126,10 +1126,10 @@ void __init setup_arch(char **cmdline_p)

 	if (efi_enabled(EFI_BOOT)) {
 		switch (boot_params.secure_boot) {
-		case efi_secureboot_mode_disabled:
+		case EFI_SECUREBOOT_MODE_DISABLED:
 			pr_info("Secure boot disabled\n");
 			break;
-		case efi_secureboot_mode_enabled:
+		case EFI_SECUREBOOT_MODE_ENABLED:
 			pr_info("Secure boot enabled\n");
 			break;
 		default:
diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 1abe455d926a..bb715e3c9474 100644
=2D-- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -110,7 +110,7 @@ static enum efi_secureboot_mode xen_efi_get_secureboot=
(void)
 				  NULL, &size, &secboot);

 	if (status =3D=3D EFI_NOT_FOUND)
-		return efi_secureboot_mode_disabled;
+		return EFI_SECUREBOOT_MODE_DISABLED;

 	if (status !=3D EFI_SUCCESS)
 		goto out_efi_err;
@@ -123,7 +123,7 @@ static enum efi_secureboot_mode xen_efi_get_secureboot=
(void)
 		goto out_efi_err;

 	if (secboot =3D=3D 0 || setupmode =3D=3D 1)
-		return efi_secureboot_mode_disabled;
+		return EFI_SECUREBOOT_MODE_DISABLED;

 	/* See if a user has put the shim into insecure mode. */
 	size =3D sizeof(moksbstate);
@@ -135,15 +135,15 @@ static enum efi_secureboot_mode xen_efi_get_securebo=
ot(void)
 		goto secure_boot_enabled;

 	if (moksbstate =3D=3D 1)
-		return efi_secureboot_mode_disabled;
+		return EFI_SECUREBOOT_MODE_DISABLED;

  secure_boot_enabled:
 	pr_info("UEFI Secure Boot is enabled.\n");
-	return efi_secureboot_mode_enabled;
+	return EFI_SECUREBOOT_MODE_ENABLED;

  out_efi_err:
 	pr_err("Could not determine UEFI Secure Boot status.\n");
-	return efi_secureboot_mode_unknown;
+	return EFI_SECUREBOOT_MODE_UNKNOWN;
 }

 void __init xen_efi_init(struct boot_params *boot_params)
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/ef=
i/libstub/arm-stub.c
index 13559c7e6643..87a3bdca1e0a 100644
=2D-- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -244,7 +244,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system=
_table_t *sys_table_arg)
 	 * boot is enabled if we can't determine its state.
 	 */
 	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
-	     secure_boot !=3D efi_secureboot_mode_disabled) {
+	     secure_boot !=3D EFI_SECUREBOOT_MODE_DISABLED) {
 		if (strstr(cmdline_ptr, "dtb=3D"))
 			pr_efi("Ignoring DTB from command line.\n");
 	} else {
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/=
efi/libstub/secureboot.c
index a765378ad18c..7fdbf9a87c3d 100644
=2D-- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -38,7 +38,7 @@ enum efi_secureboot_mode efi_get_secureboot(void)
 	status =3D get_efi_var(efi_SecureBoot_name, &efi_variable_guid,
 			     NULL, &size, &secboot);
 	if (status =3D=3D EFI_NOT_FOUND)
-		return efi_secureboot_mode_disabled;
+		return EFI_SECUREBOOT_MODE_DISABLED;
 	if (status !=3D EFI_SUCCESS)
 		goto out_efi_err;

@@ -49,7 +49,7 @@ enum efi_secureboot_mode efi_get_secureboot(void)
 		goto out_efi_err;

 	if (secboot =3D=3D 0 || setupmode =3D=3D 1)
-		return efi_secureboot_mode_disabled;
+		return EFI_SECUREBOOT_MODE_DISABLED;

 	/*
 	 * See if a user has put the shim into insecure mode. If so, and if the
@@ -64,13 +64,13 @@ enum efi_secureboot_mode efi_get_secureboot(void)
 	if (status !=3D EFI_SUCCESS)
 		goto secure_boot_enabled;
 	if (!(attr & EFI_VARIABLE_RUNTIME_ACCESS) && moksbstate =3D=3D 1)
-		return efi_secureboot_mode_disabled;
+		return EFI_SECUREBOOT_MODE_DISABLED;

 secure_boot_enabled:
 	pr_efi("UEFI Secure Boot is enabled.\n");
-	return efi_secureboot_mode_enabled;
+	return EFI_SECUREBOOT_MODE_ENABLED;

 out_efi_err:
 	pr_efi_err("Could not determine UEFI Secure Boot status.\n");
-	return efi_secureboot_mode_unknown;
+	return EFI_SECUREBOOT_MODE_UNKNOWN;
 }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/ef=
i/libstub/x86-stub.c
index 9db98839d7b4..f06bc07a2f75 100644
=2D-- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -777,7 +777,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 	 * If the boot loader gave us a value for secure_boot then we use that,
 	 * otherwise we ask the BIOS.
 	 */
-	if (boot_params->secure_boot =3D=3D efi_secureboot_mode_unset)
+	if (boot_params->secure_boot =3D=3D EFI_SECUREBOOT_MODE_UNSET)
 		boot_params->secure_boot =3D efi_get_secureboot();

 	/* Ask the firmware to clear memory on unclean shutdown */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2ab33d5d6ca5..0d3cd3f61e73 100644
=2D-- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1081,10 +1081,10 @@ extern void efi_call_virt_check_flags(unsigned lon=
g flags, const char *call);
 extern unsigned long efi_call_virt_save_flags(void);

 enum efi_secureboot_mode {
-	efi_secureboot_mode_unset,
-	efi_secureboot_mode_unknown,
-	efi_secureboot_mode_disabled,
-	efi_secureboot_mode_enabled,
+	EFI_SECUREBOOT_MODE_UNSET,
+	EFI_SECUREBOOT_MODE_UNKNOWN,
+	EFI_SECUREBOOT_MODE_DISABLED,
+	EFI_SECUREBOOT_MODE_ENABLED,
 };
 enum efi_secureboot_mode efi_get_secureboot(void);

=2D-
2.25.0

