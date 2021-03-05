Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6636032E50B
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 10:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCEJkn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 04:40:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCEJkm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 04:40:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC38B64FCF;
        Fri,  5 Mar 2021 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614937242;
        bh=OcgW7e5dsEfOiRnPlNxRnIX9X+KmlG1lTi/jpkrhSNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8xpM+GnavnRS83VsT7VFrY32MlID3xQPi/RTLWj61Rh1Qw3R1yxDE86jDyaHAixw
         U6l/fhwNmbtVU9cgqnqDFXadsRy+5/NfRM+/B8zpBk4XdqM9IVQ09VOfc33WyR+8B7
         juZTjIoAWDhQhE6Ra4ehSc5J/nfSZI+6AfsVxun3H2t9pdIOdPNpiCBSIXgbOQS477
         XhR32jG3Bq4rFUDYXOw0D/RJ4jN31lWMOj9HDVbzTs2LfI0F66OW1NFXiUfJjXWAUN
         NCEZotyLCloVy44Ee6z1VQWuT3patKnQf67LcfGtUomVA7tGfOQHDxuvCHZORBebSP
         w1rDf1jHIkBrw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/1] efi: stub: omit SetVirtualAddressMap() if marked unsupported in RT_PROP table
Date:   Fri,  5 Mar 2021 10:39:58 +0100
Message-Id: <20210305093958.187358-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305093958.187358-1-ardb@kernel.org>
References: <20210305093958.187358-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI_RT_PROPERTIES_TABLE contains a mask of runtime services that are
available after ExitBootServices(). This mostly does not concern the EFI
stub at all, given that it runs before that. However, there is one call
that is made at runtime, which is the call to SetVirtualAddressMap()
(which is not even callable at boot time to begin with)

So add the missing handling of the RT_PROP table to ensure that we only
call SetVirtualAddressMap() if it is not being advertised as unsupported
by the firmware.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index ec2f3985bef3..26e69788f27a 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -96,6 +96,18 @@ static void install_memreserve_table(void)
 		efi_err("Failed to install memreserve config table!\n");
 }
 
+static u32 get_supported_rt_services(void)
+{
+	const efi_rt_properties_table_t *rt_prop_table;
+	u32 supported = EFI_RT_SUPPORTED_ALL;
+
+	rt_prop_table = get_efi_config_table(EFI_RT_PROPERTIES_TABLE_GUID);
+	if (rt_prop_table)
+		supported &= rt_prop_table->runtime_services_supported;
+
+	return supported;
+}
+
 /*
  * EFI entry point for the arm/arm64 EFI stubs.  This is the entrypoint
  * that is described in the PE/COFF header.  Most of the code is the same
@@ -250,6 +262,10 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 			  (prop_tbl->memory_protection_attribute &
 			   EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA);
 
+	/* force efi_novamap if SetVirtualAddressMap() is unsupported */
+	efi_novamap |= !(get_supported_rt_services() &
+			 EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP);
+
 	/* hibernation expects the runtime regions to stay in the same place */
 	if (!IS_ENABLED(CONFIG_HIBERNATION) && !efi_nokaslr && !flat_va_mapping) {
 		/*
-- 
2.30.1

