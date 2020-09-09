Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51504263458
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 19:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgIIRTU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 13:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbgIIP1Y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:24 -0400
Received: from e123331-lin.nice.arm.com (adsl-204.109.242.29.tellas.gr [109.242.29.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A636422269;
        Wed,  9 Sep 2020 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599664618;
        bh=dBf3kT0+IU1h02iNcg1o94zReimfahA8wuaiLSo0fhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPe4pGxLiN3gkvZppqhigagtgKy6YWfDjJDJNWKM1COef61kJRWvXRmQOodnWV/pG
         mmBxCi+fGWoQXvbcWYszlUIYMe4py5b9uDOejI5OKGOL3yWz+C3UkJEXz4a8a+8uLw
         5Cs085rzV9uOgKWN9qtgpriPC6Nqiihf1LNj7eLk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Francois Ozog <francois.ozog@linaro.org>,
        Etienne CARRIERE <etienne.carriere@st.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Grant Likely <Grant.Likely@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christophe Priouzeau <christophe.priouzeau@linaro.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Patrick DELAUNAY <patrick.delaunay@st.com>
Subject: [PATCH RFC/RFT 3/3] efi/libstub: base FDT and initrd placement on image address not DRAM base
Date:   Wed,  9 Sep 2020 18:16:23 +0300
Message-Id: <20200909151623.16153-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909151623.16153-1-ardb@kernel.org>
References: <20200909151623.16153-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The way we use the base of DRAM in the EFI stub is problematic as it
is ill defined what the base of DRAM actually means. There are some
restrictions on the placement of FDT and initrd which are defined in
terms of dram_base, but given that the placement of the kernel in
memory is what defines these boundaries, it is better to use the image
address in these cases, and disregard dram_base altogether.

In a future patch, we should be able to get rid of dram_base entirely,
but at the moment, RISC-V support is in flight in another tree, so we
keep it around for now.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h              | 6 +++---
 arch/arm64/include/asm/efi.h            | 2 +-
 drivers/firmware/efi/libstub/efi-stub.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 5dcf3c6011b7..9e481b362227 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -75,16 +75,16 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 #define MIN_ZIMAGE_OFFSET	MAX_UNCOMP_KERNEL_SIZE
 
 /* on ARM, the FDT should be located in the first 128 MB of RAM */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
+static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
 {
-	return dram_base + ZIMAGE_OFFSET_LIMIT;
+	return image_addr + ZIMAGE_OFFSET_LIMIT;
 }
 
 /* on ARM, the initrd should be loaded in a lowmem region */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 						    unsigned long image_addr)
 {
-	return dram_base + SZ_512M;
+	return image_addr + SZ_512M;
 }
 
 struct efi_arm_entry_state {
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index d4ab3f73e7a3..27c2e8959ab6 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -65,7 +65,7 @@ efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 	(SEGMENT_ALIGN > THREAD_ALIGN ? SEGMENT_ALIGN : THREAD_ALIGN)
 
 /* on arm64, the FDT may be located anywhere in system RAM */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
+static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
 {
 	return ULONG_MAX;
 }
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index a5a405d8ab44..76ce60065f10 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -306,7 +306,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	install_memreserve_table();
 
 	status = allocate_new_fdt_and_exit_boot(handle, &fdt_addr,
-						efi_get_max_fdt_addr(dram_base),
+						efi_get_max_fdt_addr(image_addr),
 						initrd_addr, initrd_size,
 						cmdline_ptr, fdt_addr, fdt_size);
 	if (status != EFI_SUCCESS)
-- 
2.17.1

