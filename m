Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABBE60148B
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJQRRk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJQRRj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:17:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F66E2D5
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F7D4CE1322
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD304C433D7;
        Mon, 17 Oct 2022 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027054;
        bh=D4Jn3Fitnhn1WoeM1jwLVmRvZm9ddJhZtGMRDNrlP1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRX05rrdkvYJMACwz3XKq/SRc0UET3MYB1Yfy809nOv2BcJZ+BPxMwj2UuT1vZK0Z
         VMdr/95eWXAfv9n0UAy5bO2DOXiW/TIbZWptakicur8+wOBRrsCf7l8fp2/TGZhF3f
         CQlg1dtPA+OuV5IziRBuV6seubbU5obNp2W0WLT/NKhnTOsqm7AVhA8Y4rL+3B6DFl
         drE3xthPyDew+Mp9SH5dQyjpg7RoGytEJAEHg7AHK9RQu7KDbAFQuyA/4mfK7YIqLT
         2CpBTbb+hUjQ/4v/JeQecFgOiuhg3je2C6uezh0bKnV+/gHnOSEbBysnOv87p0U9Th
         pS56DYFucSZ6g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 05/21] efi: libstub: Drop randomization of runtime memory map
Date:   Mon, 17 Oct 2022 19:16:44 +0200
Message-Id: <20221017171700.3736890-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2242; i=ardb@kernel.org; h=from:subject; bh=D4Jn3Fitnhn1WoeM1jwLVmRvZm9ddJhZtGMRDNrlP1U=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY3wCcwlhr2fQBa/QFtayjmdk06nrvrlZWZBDf0x dogAWPWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N8AAKCRDDTyI5ktmPJA6DDA CVU8m8wInT1RibFuhC/SB+CNeeju0y8FRwLOJYpK/gLcPvmfM4gkQRRkvRoJrfyJuCpllLqnIDPUUx NqqRgMVZ1iOR+6GXO+hsPDhGdF5qDqS9N7K/tBX4zIK/UL2lYVPa2GP1eug6QJCSOHxTAV7HvuKWiL D2blMZa2Ys0pAjI2H+rOptWiLs1yC29xG5tKaALDezaFK6p8CvEPZQokarXwLjK+p0eG+lq9caUPc7 Xhshy/UhQep4he8eczN4lcWET5s2ts9aE2lApBpHxfOHAoa9SyBtIFwbcXNfWNPXXEZOJ3TdLu5wD9 YktSF/e8sRrrBK89OiwwFFFCQGX5cllMRgc/IyXhLFR47Qh2deELM3FCWjgkDP0c68SyvOQINxSWX6 WxTjqVmbEuWK7pUIrSLVEkRsH0nxvp+fsz5XHVuPbT9iKLged5hFlOWjPhpM5QyFW3JVLJ0xy8n5ha XGi7bPYwC5o9i2E7EPHasZgSrRwCCwNdW+gu+wobz05EM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Randomizing the UEFI runtime memory map requires the use of the
SetVirtualAddressMap() EFI boot service, which we prefer to avoid. So
let's drop randomization, which was already problematic in combination
with hibernation, which means that distro kernels never enabled it in
the first place.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 29 --------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index cf474f0dd261..0ebfa2d9628a 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -35,15 +35,6 @@
  * as well to minimize the code churn.
  */
 #define EFI_RT_VIRTUAL_BASE	SZ_512M
-#define EFI_RT_VIRTUAL_SIZE	SZ_512M
-
-#ifdef CONFIG_ARM64
-# define EFI_RT_VIRTUAL_LIMIT	DEFAULT_MAP_WINDOW_64
-#elif defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
-# define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE_MIN
-#else /* Only if TASK_SIZE is a constant */
-# define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE
-#endif
 
 /*
  * Some architectures map the EFI regions into the kernel's linear map using a
@@ -230,26 +221,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_novamap |= !(get_supported_rt_services() &
 			 EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP);
 
-	/* hibernation expects the runtime regions to stay in the same place */
-	if (!IS_ENABLED(CONFIG_HIBERNATION) && !efi_nokaslr && !flat_va_mapping) {
-		/*
-		 * Randomize the base of the UEFI runtime services region.
-		 * Preserve the 2 MB alignment of the region by taking a
-		 * shift of 21 bit positions into account when scaling
-		 * the headroom value using a 32-bit random value.
-		 */
-		static const u64 headroom = EFI_RT_VIRTUAL_LIMIT -
-					    EFI_RT_VIRTUAL_BASE -
-					    EFI_RT_VIRTUAL_SIZE;
-		u32 rnd;
-
-		status = efi_get_random_bytes(sizeof(rnd), (u8 *)&rnd);
-		if (status == EFI_SUCCESS) {
-			virtmap_base = EFI_RT_VIRTUAL_BASE +
-				       (((headroom >> 21) * rnd) >> (32 - 21));
-		}
-	}
-
 	install_memreserve_table();
 
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
-- 
2.35.1

