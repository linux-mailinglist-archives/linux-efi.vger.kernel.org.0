Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B1577058B
	for <lists+linux-efi@lfdr.de>; Fri,  4 Aug 2023 18:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjHDQEa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Aug 2023 12:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjHDQEW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Aug 2023 12:04:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C52449CC;
        Fri,  4 Aug 2023 09:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18F5862098;
        Fri,  4 Aug 2023 16:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C429C433C7;
        Fri,  4 Aug 2023 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691165057;
        bh=IfMv8SHx+JE9F5RRuZsyY+MA4Vr/mLYztl2bV87OWao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTSIpMfFwqAjzti3fG7cNPMQKVf20hyv8c1fhensEU0gOkuL/ZQOcPhTVrOUdAJEa
         BuxR+az0iauZo5lumo1MGQjVg86kRd4rkg8KIv5G2CRMjZZXI7V5sCIHkO2DnGm6GQ
         QVAm7cqrOIj9TvUxYQLb5osvaycK5TN8gwJCI361KGfQiw8FIZjZBu6dnMqlTiELIB
         xrkSCfyOkiUKmJyGhFjTBh73JPfbXauZCq6UCVq1mXsQSFqFjYSe9bhVFo2V1RY9ZD
         t9+Ppt9/XcKzOzLT6UIAgusRoCr8WsFVPYVVsr78zAei//4XQotwC5Qhsgq1BH0/I6
         rQmT9/8xdyEJA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4/4] acpi/prmt: Use EFI runtime sandbox to invoke PRM handlers
Date:   Fri,  4 Aug 2023 18:03:59 +0200
Message-Id: <20230804160359.228901-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804160359.228901-1-ardb@kernel.org>
References: <20230804160359.228901-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4104; i=ardb@kernel.org; h=from:subject; bh=IfMv8SHx+JE9F5RRuZsyY+MA4Vr/mLYztl2bV87OWao=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWsYp7u/lka9zhrmHKNO6TusVSde/xnDQdL74HCmebh0 fM33ZvXUcLCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSsZ/hD9dur6/nnXd/eCPT cJPT6NnKZVJfMtlPtQTfb+Rkr9Wsus3wzWztloalmZc6mHmdCibnc2Q3zxUJPLNy1bGNerfOi1/ hBgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of bypassing the kernel's adaptation layer for performing EFI
runtime calls, wire up ACPI PRM handling into it. This means these calls
can no longer occur concurrently with EFI runtime calls, and will be
made from the EFI runtime workqueue. It also means any page faults
occurring during PRM handling will be identified correctly as
originating in firmware code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/prmt.c                     |  8 ++++----
 drivers/firmware/efi/runtime-wrappers.c | 20 ++++++++++++++++++++
 include/linux/efi.h                     | 13 +++++++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 3d4c4620f9f95309..95be1c80db387faa 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -53,7 +53,7 @@ static LIST_HEAD(prm_module_list);
 
 struct prm_handler_info {
 	guid_t guid;
-	void *handler_addr;
+	efi_acpi_prm_handler_t *handler_addr;
 	u64 static_data_buffer_addr;
 	u64 acpi_param_buffer_addr;
 
@@ -260,9 +260,9 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 		context.static_data_buffer = handler->static_data_buffer_addr;
 		context.mmio_ranges = module->mmio_info;
 
-		status = efi_call_virt_pointer(handler, handler_addr,
-					       handler->acpi_param_buffer_addr,
-					       &context);
+		status = efi_call_acpi_prm_handler(handler->handler_addr,
+						   handler->acpi_param_buffer_addr,
+						   &context);
 		if (status == EFI_SUCCESS) {
 			buffer->prm_status = PRM_HANDLER_SUCCESS;
 		} else {
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index b3ef208299ae591e..ce306cd1efdfda21 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -212,6 +212,12 @@ static void efi_call_rts(struct work_struct *work)
 				       efi_rts_work.QUERY_CAPSULE_CAPS.max_size,
 				       efi_rts_work.QUERY_CAPSULE_CAPS.reset_type);
 		break;
+	case EFI_ACPI_PRM_HANDLER:
+		status = efi_call_virt_pointer(&efi_rts_work.ACPI_PRM_HANDLER,
+					       handler_addr,
+					       efi_rts_work.ACPI_PRM_HANDLER.param_buffer_addr,
+					       efi_rts_work.ACPI_PRM_HANDLER.context);
+		break;
 	default:
 		/*
 		 * Ideally, we should never reach here because a caller of this
@@ -475,3 +481,17 @@ void __init efi_native_runtime_setup(void)
 	efi.update_capsule = virt_efi_update_capsule;
 	efi.query_capsule_caps = virt_efi_query_capsule_caps;
 }
+
+efi_status_t efi_call_acpi_prm_handler(efi_acpi_prm_handler_t *handler_addr,
+				       efi_physical_addr_t param_buffer_addr,
+				       void *context)
+{
+	efi_status_t status;
+
+	if (down_interruptible(&efi_runtime_lock))
+		return EFI_ABORTED;
+	status = efi_queue_work(ACPI_PRM_HANDLER, handler_addr,
+				param_buffer_addr, context);
+	up(&efi_runtime_lock);
+	return status;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c72715821016851b..065af735d90a411c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1230,6 +1230,12 @@ extern int efi_tpm_final_log_size;
 
 extern unsigned long rci2_table_phys;
 
+typedef efi_status_t (__efiapi efi_acpi_prm_handler_t)(efi_physical_addr_t, void *);
+
+efi_status_t efi_call_acpi_prm_handler(efi_acpi_prm_handler_t *handler_addr,
+				       efi_physical_addr_t param_buffer_addr,
+				       void *context);
+
 /*
  * efi_runtime_service() function identifiers.
  * "NONE" is used by efi_recover_from_page_fault() to check if the page
@@ -1249,6 +1255,7 @@ enum efi_rts_ids {
 	EFI_RESET_SYSTEM,
 	EFI_UPDATE_CAPSULE,
 	EFI_QUERY_CAPSULE_CAPS,
+	EFI_ACPI_PRM_HANDLER,
 };
 
 /*
@@ -1324,6 +1331,12 @@ struct efi_runtime_work {
 			u64		*max_size;
 			int		*reset_type;
 		} QUERY_CAPSULE_CAPS;
+
+		struct {
+			efi_acpi_prm_handler_t	*handler_addr;
+			efi_physical_addr_t	param_buffer_addr;
+			void			*context;
+		} ACPI_PRM_HANDLER;
 	};
 	efi_status_t status;
 	struct work_struct work;
-- 
2.39.2

