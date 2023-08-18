Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA4780B3F
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376706AbjHRLiU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376707AbjHRLiD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:38:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173BF2112
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D0C1611F0
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBCFC433CD;
        Fri, 18 Aug 2023 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358681;
        bh=h29N0feBCav5r5bx0a4iK0yWxYcrWfDbXT4psaOKqR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbkpZNYei9X+OpHern2zrvsSUsfRucH3f1ylsg07jLvAVE0koW2TOHXEkB7BcdCqX
         luNxc3/mfZv4tHLuQgwEAkK3cfsgfB9mL1xvB+suvYyQKjeBeNDCDa7XR49XzeVLMn
         yQE6lSwbgRzf9y5L1whs8fLzECjlnM1JDg63Zfq2IBKuy1cXmCqfrDgjAH5ERpna6p
         7lKkSB1PVGkiTQ91HQ5uvl27Q+mJvWa5tFHrkLvi2C7Zy9u/S2vh0AMKwJMEhLbmRJ
         OIL+O5qn7bwIbrc1LjohkFjnj28Cr+59lfeekAZIj9ATYLbFbMOTCwBY/JtRelewTS
         D0iUxiJSXh23A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 08/11] acpi/prmt: Use EFI runtime sandbox to invoke PRM handlers
Date:   Fri, 18 Aug 2023 13:37:21 +0200
Message-Id: <20230818113724.368492-9-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4465; i=ardb@kernel.org; h=from:subject; bh=h29N0feBCav5r5bx0a4iK0yWxYcrWfDbXT4psaOKqR8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++MevzoGn1iSu2tCTdqFzi9XRJz8mveVPr1yQ6a44O 45n2cwlHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAic2wZ/ul6Z8WeN7n00ycy duPO3j9Bm5qy1nr8PfHCrueG+dr3ezYzMvxT+evL8XzxoU/1foJ3L6hXGjwsW6y3NmRWiUFW/Rl LUyYA
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

While at it, give the function pointer struct member a more descriptive
name so it will stand out in diagnostic messages if any issues do occur.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/Kconfig                    |  2 +-
 drivers/acpi/prmt.c                     |  6 ++--
 drivers/firmware/efi/runtime-wrappers.c | 32 ++++++++++++++++++++
 include/linux/efi.h                     |  5 +++
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 00dd309b66828182..cee82b473dc50921 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -581,7 +581,7 @@ config ACPI_VIOT
 
 config ACPI_PRMT
 	bool "Platform Runtime Mechanism Support"
-	depends on EFI && (X86_64 || ARM64)
+	depends on EFI_RUNTIME_WRAPPERS && (X86_64 || ARM64)
 	default y
 	help
 	  Platform Runtime Mechanism (PRM) is a firmware interface exposing a
diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 71b9adaaf33b93cf..7020584096bfaaaf 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
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
index afe9248cc5bc61ba..71d3c70f0705e1b9 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -108,6 +108,12 @@ union efi_rts_args {
 		u64		*max_size;
 		int		*reset_type;
 	} QUERY_CAPSULE_CAPS;
+
+	struct {
+		efi_status_t	(__efiapi *acpi_prm_handler)(u64, void *);
+		u64		param_buffer_addr;
+		void		*context;
+	} ACPI_PRM_HANDLER;
 };
 
 struct efi_runtime_work efi_rts_work;
@@ -283,6 +289,14 @@ static void efi_call_rts(struct work_struct *work)
 				       args->QUERY_CAPSULE_CAPS.max_size,
 				       args->QUERY_CAPSULE_CAPS.reset_type);
 		break;
+	case EFI_ACPI_PRM_HANDLER:
+#ifdef CONFIG_ACPI_PRMT
+		status = arch_efi_call_virt(&args->ACPI_PRM_HANDLER,
+					    acpi_prm_handler,
+					    args->ACPI_PRM_HANDLER.param_buffer_addr,
+					    args->ACPI_PRM_HANDLER.context);
+		break;
+#endif
 	default:
 		/*
 		 * Ideally, we should never reach here because a caller of this
@@ -560,3 +574,21 @@ void efi_native_runtime_setup(void)
 	efi.update_capsule = virt_efi_update_capsule;
 	efi.query_capsule_caps = virt_efi_query_capsule_caps;
 }
+
+#ifdef CONFIG_ACPI_PRMT
+
+efi_status_t
+efi_call_acpi_prm_handler(efi_status_t (__efiapi *handler_addr)(u64, void *),
+			  u64 param_buffer_addr, void *context)
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
+
+#endif
diff --git a/include/linux/efi.h b/include/linux/efi.h
index cf450b6fbfd20aa5..15b94dad5091b406 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1229,6 +1229,10 @@ extern int efi_tpm_final_log_size;
 
 extern unsigned long rci2_table_phys;
 
+efi_status_t
+efi_call_acpi_prm_handler(efi_status_t (__efiapi *handler_addr)(u64, void *),
+			  u64 param_buffer_addr, void *context);
+
 /*
  * efi_runtime_service() function identifiers.
  * "NONE" is used by efi_recover_from_page_fault() to check if the page
@@ -1248,6 +1252,7 @@ enum efi_rts_ids {
 	EFI_RESET_SYSTEM,
 	EFI_UPDATE_CAPSULE,
 	EFI_QUERY_CAPSULE_CAPS,
+	EFI_ACPI_PRM_HANDLER,
 };
 
 union efi_rts_args;
-- 
2.39.2

