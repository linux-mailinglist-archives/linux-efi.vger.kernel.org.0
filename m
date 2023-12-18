Return-Path: <linux-efi+bounces-235-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D87D816E6A
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 13:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EF01F23960
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2A03A1C0;
	Mon, 18 Dec 2023 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7TJVj1O"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92833A1BA;
	Mon, 18 Dec 2023 12:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F88C433C8;
	Mon, 18 Dec 2023 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903486;
	bh=hxOYtkrvXr0YGv5k71wXYFxrXgmkaN1BwpEhsyVMYlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7TJVj1O7JDo4tqZWqbPjYJ67u8iYvz00rFgqBJUbLbRO4/Lk8xQdQNPwJnX5zESL
	 2Us8uAvqylHi0aOiM/8thpQMj2XcSx9NN44c5fnr/alo1eB4yGmUEC1O2lV48rD7Gj
	 bIzj1Fc5fY1D9V9XwCfcCuK527lGq8y2Qf78PaDM/ffy4PDeFiiesRApFt7f2ErwFl
	 LsLzdsuHtsx3Z+8vjWZWKg6uy+5z/wryFKUCG/ZkeZOkUDLzhw2gHRvMs5ArOewoJa
	 Y0gyIY90HV5OIKDbKbcGUqiktWsWyGubJ6R/zBP4l77WxMdJ0DK2TDPP+E+uzXLudt
	 FzG0fYOR1s0hQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wang Yao <wangyao@lemote.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 11/18] efi/loongarch: Use load address to calculate kernel entry address
Date: Mon, 18 Dec 2023 07:43:45 -0500
Message-ID: <20231218124415.1379060-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124415.1379060-1-sashal@kernel.org>
References: <20231218124415.1379060-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.7
Content-Transfer-Encoding: 8bit

From: Wang Yao <wangyao@lemote.com>

[ Upstream commit 271f2a4a9576b87ed1f8584909d6d270039e52ea ]

The efi_relocate_kernel() may load the PIE kernel to anywhere, the
loaded address may not be equal to link address or
EFI_KIMG_PREFERRED_ADDRESS.

Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Wang Yao <wangyao@lemote.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/efi.h              | 2 +-
 drivers/firmware/efi/libstub/loongarch-stub.c | 4 ++--
 drivers/firmware/efi/libstub/loongarch.c      | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
index 091897d40b037..91d81f9730ab3 100644
--- a/arch/loongarch/include/asm/efi.h
+++ b/arch/loongarch/include/asm/efi.h
@@ -32,6 +32,6 @@ static inline unsigned long efi_get_kimg_min_align(void)
 
 #define EFI_KIMG_PREFERRED_ADDRESS	PHYSADDR(VMLINUX_LOAD_ADDRESS)
 
-unsigned long kernel_entry_address(void);
+unsigned long kernel_entry_address(unsigned long kernel_addr);
 
 #endif /* _ASM_LOONGARCH_EFI_H */
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index 72c71ae201f0d..d6ec5d4b8dbe0 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -35,9 +35,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	return status;
 }
 
-unsigned long kernel_entry_address(void)
+unsigned long kernel_entry_address(unsigned long kernel_addr)
 {
 	unsigned long base = (unsigned long)&kernel_offset - kernel_offset;
 
-	return (unsigned long)&kernel_entry - base + VMLINUX_LOAD_ADDRESS;
+	return (unsigned long)&kernel_entry - base + kernel_addr;
 }
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 807cba2693fc1..0e0aa6cda73f7 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -37,9 +37,9 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 	return EFI_SUCCESS;
 }
 
-unsigned long __weak kernel_entry_address(void)
+unsigned long __weak kernel_entry_address(unsigned long kernel_addr)
 {
-	return *(unsigned long *)(PHYSADDR(VMLINUX_LOAD_ADDRESS) + 8);
+	return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS + kernel_addr;
 }
 
 efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
@@ -73,7 +73,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
 	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
 
-	real_kernel_entry = (void *)kernel_entry_address();
+	real_kernel_entry = (void *)kernel_entry_address(kernel_addr);
 
 	real_kernel_entry(true, (unsigned long)cmdline_ptr,
 			  (unsigned long)efi_system_table);
-- 
2.43.0


