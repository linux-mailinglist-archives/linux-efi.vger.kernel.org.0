Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95388164BB8
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 18:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgBSRTk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 12:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgBSRTk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:40 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2DE24676;
        Wed, 19 Feb 2020 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132780;
        bh=gdQmEVdPMB7OpD2L+VsjxXfWQ5vdiViQIL2+0izbhf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaoPLJGhon0mufOibywikBN50sNz/WG4MxbynfX3w26H0TFxu7i6/aWSYIUMCiYEF
         1vsWJadcWF9Riu6tJkcGDKYZ9iAfh3cJjh0vjeGhKg8Zxo6KOPgbgEeowR2sgoNPXf
         p3UkJMV9VdrjsDhc/eeQNuuNcGE6SepZg5NuYJbs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org
Subject: [PATCH 3/9] efi: use more granular check for availability for variable services
Date:   Wed, 19 Feb 2020 18:19:01 +0100
Message-Id: <20200219171907.11894-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219171907.11894-1-ardb@kernel.org>
References: <20200219171907.11894-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The UEFI spec rev 2.8 permits firmware implementations to support only
a subset of EFI runtime services at OS runtime (i.e., after the call to
ExitBootServices()), so let's take this into account in the drivers that
rely specifically on the availability of the EFI variable services.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c |  2 +-
 drivers/firmware/efi/efi.c        | 28 ++++++--------------
 drivers/firmware/efi/efivars.c    |  2 +-
 fs/efivarfs/super.c               |  2 +-
 4 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 9ea13e8d12ec..d2f6855d205b 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -356,7 +356,7 @@ static struct pstore_info efi_pstore_info = {
 
 static __init int efivars_pstore_init(void)
 {
-	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
 		return 0;
 
 	if (!efivars_kobject())
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a35230517f9c..abf4c02e0201 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -328,12 +328,13 @@ static int __init efisubsys_init(void)
 		return -ENOMEM;
 	}
 
-	error = generic_ops_register();
-	if (error)
-		goto err_put;
-
-	if (efi_enabled(EFI_RUNTIME_SERVICES))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES)) {
 		efivar_ssdt_load();
+		error = generic_ops_register();
+		if (error)
+			goto err_put;
+		platform_device_register_simple("efivars", 0, NULL, 0);
+	}
 
 	error = sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
 	if (error) {
@@ -358,7 +359,8 @@ static int __init efisubsys_init(void)
 err_remove_group:
 	sysfs_remove_group(efi_kobj, &efi_subsys_attr_group);
 err_unregister:
-	generic_ops_unregister();
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
+		generic_ops_unregister();
 err_put:
 	kobject_put(efi_kobj);
 	return error;
@@ -650,20 +652,6 @@ void __init efi_systab_report_header(const efi_table_hdr_t *systab_hdr,
 		vendor);
 }
 
-#ifdef CONFIG_EFI_VARS_MODULE
-static int __init efi_load_efivars(void)
-{
-	struct platform_device *pdev;
-
-	if (!efi_enabled(EFI_RUNTIME_SERVICES))
-		return 0;
-
-	pdev = platform_device_register_simple("efivars", 0, NULL, 0);
-	return PTR_ERR_OR_ZERO(pdev);
-}
-device_initcall(efi_load_efivars);
-#endif
-
 static __initdata char memory_type_name[][20] = {
 	"Reserved",
 	"Loader Code",
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index 7576450c8254..d309abca5091 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -664,7 +664,7 @@ int efivars_sysfs_init(void)
 	struct kobject *parent_kobj = efivars_kobject();
 	int error = 0;
 
-	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
 		return -ENODEV;
 
 	/* No efivars has been registered yet */
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index fa4f6447ddad..12c66f5d92dd 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -252,7 +252,7 @@ static struct file_system_type efivarfs_type = {
 
 static __init int efivarfs_init(void)
 {
-	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
 		return -ENODEV;
 
 	if (!efivars_kobject())
-- 
2.17.1

