Return-Path: <linux-efi+bounces-2777-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43776A2F5D9
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8E23A7A2D
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34BE25B680;
	Mon, 10 Feb 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8rz4Et9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46E925B67A
	for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209806; cv=none; b=oRte31NwtkJYmb6/XbIxUk2iJ2XuhIig0kBjxI18syZDhLIiB4PLlEFc8A1xo3adueKByj4aRCLGurSg7tGIiD6zCZ7G4pdrFKkey+ooXQQrZGNBdbmYZOWsviPPS00aONtNCkL14x61TkPGCD2TXvUJA3057uGDhoXBC6Gx0zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209806; c=relaxed/simple;
	bh=tLEyE2tKrHLRRQGioPc6T8phbHPB5uM9AntkbE/t6tQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t93yzgtXpaBX7i9HvU5/w4aVmoy6zbT+ab8KHSMcFhK8UrvTIprjD8Jr4VBgXnoRipjr7Ga//+BzHcdLVO+1iPjJccw8YgiRQXDyQVDSN6lxbsxPR9ebK6guZE1f8HC+6b5qPjmRUF7WgDmOe5qzbnPvzFqbU26Jhyu2rTK64U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8rz4Et9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4388eee7073so26624235e9.0
        for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 09:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739209803; x=1739814603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXOCVBev49S8HtAUK1KjciNSffJFpbFvgi16EMD1kdo=;
        b=h8rz4Et9H/np0u9gRIskGIt50bicoh+JHg1xmm9r25lt6kowwzWbX56jqp5PVdSgfh
         PvoOBLO+wS1jxapOPCCYj5HNPQrwaflWoVTTLvVH4qbN32MoyB+xArEiY06A4HhwDuEb
         zQ7n3II0UWrREJbDwXPrBlfZqfOW52pr8eLmAXwD7AOuSwCmzVu2q/Do0O0JlklREwig
         2fGHZ6lqeFi3v8qHW8skK/O98C9yocLH242VZXJSr2f0CblBQX+UeVipXhpZFrtGx7Q+
         HAeUkVMXhS39nt++HpBU7YQL+fponL8Pfc9cCGA+UGdft1Ylfg33qIdaG2KRZdRQ9Ec9
         +KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209803; x=1739814603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXOCVBev49S8HtAUK1KjciNSffJFpbFvgi16EMD1kdo=;
        b=nZx1GMzU0k5CX4csLda4xVv/RhJT0zsheOPrHs/2qX7fKp3K0fZomNNw4AcdlefFVk
         wCNHt342kZma5FaB40bLEMQskfv2tN6J6udu9iewS8b26FFiARUmXEvx7jydZW0sbMFH
         tyuQFz8W6VhffIELcDMJb+ZCo/eJFVUkJQZGrOiO8vpBFrxhlzFWJauhYqqzcDqI+u96
         NrZi7PxkwJfvrqkrfE0qpP3TXqyNH3BQrHA75HhJjIy9lChz05ejfRc5MuzqWUi1dIa8
         /dC4tjTHQLM/oCKpHaTpice3h1dCg7Ss8Je5dCbFvdOJC8k0OCQ/N8x5DqFKnN05sF0g
         LkNA==
X-Gm-Message-State: AOJu0Yxp+56x1b5R9LmzWz+NYzsDHzhFiHZUOv0sN0u9Ssvv7D1daucU
	2dT68hsl9m0VjiaqtYhx71XE3k8kv6qDvG+cq6nFCNSi6ehsK1oqThBrRQSymXIzlerNnMnrDqQ
	NrVQYzx7zcZq+cp5MnZNibtYOWFauXtVN3BVzlwu9oNoWuPabIMJ60p+4LGxEZ4uTfoZK/1ZhRp
	8IHjtkt6aRih9z7P7Gg6rgWenIiQ==
X-Google-Smtp-Source: AGHT+IFMwV3Zl2miORohuHKLaVKpfbC1gQO191AdtI4XdCPtkIaeVrthh7V1NY3okRjP28dtIFZTxAd3
X-Received: from wmrn35.prod.google.com ([2002:a05:600c:5023:b0:436:3ea:c491])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3acc:b0:434:f3d8:62db
 with SMTP id 5b1f17b1804b1-4394ceb0edemr2299045e9.2.1739209803159; Mon, 10
 Feb 2025 09:50:03 -0800 (PST)
Date: Mon, 10 Feb 2025 18:49:43 +0100
In-Reply-To: <20250210174941.3251435-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210174941.3251435-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7137; i=ardb@kernel.org;
 h=from:subject; bh=5ybDI+xFhLmI8ZUbV0+NjWEPb8LdfPJ9G7/rWPzerkg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX2VjZljt5OGXpuuyb5dLsYLTr/4bc78YJ21dKnx/6eXz
 XZOb9/bUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayXovhf51x5bnCx3yc3dms
 vb3VR24+FDQJvjDndNmjU8xbnsZ9FGH47/XgsBDbjN/XqiYdSOcQkPwRmH9TsIDhcczx45r1j0Q VuAA=
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210174941.3251435-10-ardb+git@google.com>
Subject: [PATCH v2 1/7] x86/efistub: Merge PE and handover entrypoints
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The difference between the PE and handover entrypoints in the EFI stub
is that the former allocates a struct boot_params whereas the latter
expects one from the caller. Currently, these are two completely
separate entrypoints, duplicating some logic and both relying of
efi_exit() to return straight back to the firmware on an error.

Simplify this by making the PE entrypoint call the handover entrypoint
with NULL as the argument for the struct boot_params parameter. This
makes the code easier to follow, and removes the need to support two
different calling conventions in the mixed mode asm code.

While at it, move the assignment of boot_params_ptr into the function
that actually calls into the legacy decompressor, which is where its
value is required.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S    | 16 +-----
 drivers/firmware/efi/libstub/x86-stub.c | 52 +++++++++++---------
 2 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 876fc6d46a13..d681e30c6732 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -56,22 +56,8 @@ SYM_FUNC_START(startup_64_mixed_mode)
 	movl	efi32_boot_sp(%rip), %esp
 	andl	$~7, %esp
 
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 	mov	8(%rdx), %edx		// saved bootparams pointer
-	test	%edx, %edx
-	jnz	efi_stub_entry
-#endif
-	/*
-	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
-	 * shadow space on the stack even if all arguments are passed in
-	 * registers. We also need an additional 8 bytes for the space that
-	 * would be occupied by the return address, and this also results in
-	 * the correct stack alignment for entry.
-	 */
-	sub	$40, %rsp
-	mov	%rdi, %rcx		// MS calling convention
-	mov	%rsi, %rdx
-	jmp	efi_pe_entry
+	call	efi_stub_entry
 SYM_FUNC_END(startup_64_mixed_mode)
 
 SYM_FUNC_START(__efi64_thunk)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 863910e9eefc..cafc90d4caaf 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -397,17 +397,13 @@ static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
 		asm("hlt");
 }
 
-void __noreturn efi_stub_entry(efi_handle_t handle,
-			       efi_system_table_t *sys_table_arg,
-			       struct boot_params *boot_params);
-
 /*
  * Because the x86 boot code expects to be passed a boot_params we
  * need to create one ourselves (usually the bootloader would create
  * one for us).
  */
-efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
-				   efi_system_table_t *sys_table_arg)
+static efi_status_t efi_allocate_bootparams(efi_handle_t handle,
+					    struct boot_params **bp)
 {
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	struct boot_params *boot_params;
@@ -416,21 +412,15 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	unsigned long alloc;
 	char *cmdline_ptr;
 
-	efi_system_table = sys_table_arg;
-
-	/* Check if we were booted by the EFI firmware */
-	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
-		efi_exit(handle, EFI_INVALID_PARAMETER);
-
 	status = efi_bs_call(handle_protocol, handle, &proto, (void **)&image);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
-		efi_exit(handle, status);
+		return status;
 	}
 
 	status = efi_allocate_pages(PARAM_SIZE, &alloc, ULONG_MAX);
 	if (status != EFI_SUCCESS)
-		efi_exit(handle, status);
+		return status;
 
 	boot_params = memset((void *)alloc, 0x0, PARAM_SIZE);
 	hdr	    = &boot_params->hdr;
@@ -446,14 +436,14 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	cmdline_ptr = efi_convert_cmdline(image);
 	if (!cmdline_ptr) {
 		efi_free(PARAM_SIZE, alloc);
-		efi_exit(handle, EFI_OUT_OF_RESOURCES);
+		return EFI_OUT_OF_RESOURCES;
 	}
 
 	efi_set_u64_split((unsigned long)cmdline_ptr, &hdr->cmd_line_ptr,
 			  &boot_params->ext_cmd_line_ptr);
 
-	efi_stub_entry(handle, sys_table_arg, boot_params);
-	/* not reached */
+	*bp = boot_params;
+	return EFI_SUCCESS;
 }
 
 static void add_e820ext(struct boot_params *params,
@@ -740,13 +730,16 @@ static efi_status_t parse_options(const char *cmdline)
 	return efi_parse_options(cmdline);
 }
 
-static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
+static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
+					  struct boot_params *boot_params)
 {
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	unsigned long addr, alloc_size, entry;
 	efi_status_t status;
 	u32 seed[2] = {};
 
+	boot_params_ptr	= boot_params;
+
 	/* determine the required size of the allocation */
 	alloc_size = ALIGN(max_t(unsigned long, output_len, kernel_total_size),
 			   MIN_KERNEL_ALIGN);
@@ -777,7 +770,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 			seed[0] = 0;
 		}
 
-		boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
+		boot_params->hdr.loadflags |= KASLR_FLAG;
 	}
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
@@ -815,20 +808,27 @@ static void __noreturn enter_kernel(unsigned long kernel_addr,
 void __noreturn efi_stub_entry(efi_handle_t handle,
 			       efi_system_table_t *sys_table_arg,
 			       struct boot_params *boot_params)
+
 {
 	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
-	struct setup_header *hdr = &boot_params->hdr;
 	const struct linux_efi_initrd *initrd = NULL;
 	unsigned long kernel_entry;
+	struct setup_header *hdr;
 	efi_status_t status;
 
-	boot_params_ptr = boot_params;
-
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
+	if (!IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL) || !boot_params) {
+		status = efi_allocate_bootparams(handle, &boot_params);
+		if (status != EFI_SUCCESS)
+			efi_exit(handle, status);
+	}
+
+	hdr = &boot_params->hdr;
+
 	if (have_unsupported_snp_features())
 		efi_exit(handle, EFI_UNSUPPORTED);
 
@@ -870,7 +870,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (efi_mem_encrypt > 0)
 		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
 
-	status = efi_decompress_kernel(&kernel_entry);
+	status = efi_decompress_kernel(&kernel_entry, boot_params);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to decompress kernel\n");
 		goto fail;
@@ -940,6 +940,12 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	efi_exit(handle, status);
 }
 
+efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
+				   efi_system_table_t *sys_table_arg)
+{
+	efi_stub_entry(handle, sys_table_arg, NULL);
+}
+
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 			struct boot_params *boot_params)
-- 
2.48.1.362.g079036d154-goog


