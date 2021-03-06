Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2B32F9C5
	for <lists+linux-efi@lfdr.de>; Sat,  6 Mar 2021 12:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhCFLfz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Mar 2021 06:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhCFLfZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 6 Mar 2021 06:35:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B727D6501A;
        Sat,  6 Mar 2021 11:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615030525;
        bh=kk8KGYHTnMmNSSZ2kd030rR2O8evnLGqDU9Hc8hiXSA=;
        h=From:To:Cc:Subject:Date:From;
        b=j/rkqS+MU09Q32u5NjS5ngwglgsflRqw3q+yVymc9EDDPT3r+3nI4s45+zPhhaf/B
         4gpEbWa/JuKB9tfzG39pWcUrT08bQvkWt09Eh6njSVTjmabX/5nR8W/ftFoocg5w+v
         68+PZ8Rkk3mABYay5WeyaBXcnAtjdXdH3+GxEcjZBa20vFSycr8I9juo3zRjUzduwM
         loPfKiTzWkoLuHL9hY5hFXXh0VrfkK/NI9Qs/4hLIuemkuFE46pJoRTCIIgrWw8gQU
         ZQwL3/LuB6zBmqjMLnfWOv0s32PQgGnoWYhzfiVuFqUM80MIW9vL84clcbzODdAScS
         717qeWqdGDQrg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] efi: stub: override RT_PROP table supported mask based on EFI variable
Date:   Sat,  6 Mar 2021 12:35:19 +0100
Message-Id: <20210306113519.294287-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Allow EFI systems to override the set of supported runtime services
declared via the RT_PROP table, by checking for the existence of a
'OverrideSupported' EFI variable of the appropriate size under the
RT_PROP table GUID, and if it does, combine the supported mask using
logical AND. (This means the override can only remove support, not
add it back).

Cc: Jeffrey Hugo <jhugo@codeaurora.org>,
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Leif Lindholm <leif@nuviainc.com>
Cc: linux-arm-msm@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 26e69788f27a..a23d95039b2a 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -96,6 +96,41 @@ static void install_memreserve_table(void)
 		efi_err("Failed to install memreserve config table!\n");
 }
 
+static void check_rt_properties_table_override(void)
+{
+	static const efi_guid_t rt_prop_guid = EFI_RT_PROPERTIES_TABLE_GUID;
+	efi_rt_properties_table_t *table;
+	unsigned long size = sizeof(u32);
+	efi_status_t status;
+	u32 override;
+
+	status = get_efi_var(L"OverrideSupported", &rt_prop_guid, NULL, &size, &override);
+	if (status != EFI_SUCCESS || size != sizeof(override))
+		return;
+
+	table = get_efi_config_table(rt_prop_guid);
+	if (!table) {
+		/* no table exists yet - allocate a new one */
+		status = efi_bs_call(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
+				     sizeof(*table), (void **)&table);
+		if (status != EFI_SUCCESS)
+			return;
+		table->version = EFI_RT_PROPERTIES_TABLE_VERSION;
+		table->length = sizeof(*table);
+		table->runtime_services_supported = EFI_RT_SUPPORTED_ALL;
+
+		status = efi_bs_call(install_configuration_table,
+				     (efi_guid_t *)&rt_prop_guid, table);
+		if (status != EFI_SUCCESS) {
+			efi_warn("Failed to install RT_PROP override table\n");
+			return;
+		}
+	}
+
+	efi_info("Applying RT_PROP table override from EFI variable\n");
+	table->runtime_services_supported &= override;
+}
+
 static u32 get_supported_rt_services(void)
 {
 	const efi_rt_properties_table_t *rt_prop_table;
@@ -210,6 +245,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	secure_boot = efi_get_secureboot();
 
+	check_rt_properties_table_override();
+
 	/*
 	 * Unauthenticated device tree data is a security hazard, so ignore
 	 * 'dtb=' unless UEFI Secure Boot is disabled.  We assume that secure
-- 
2.30.1

