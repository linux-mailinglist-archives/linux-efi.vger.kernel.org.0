Return-Path: <linux-efi+bounces-697-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FCB870036
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785691F24768
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD638F88;
	Mon,  4 Mar 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGDQ5+Fw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33FC39FCD
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551233; cv=none; b=vBb6jZQHmfsUgUOhK2YbRCSKhaUEfY2VNnuyrRfWf33OtKvPg06lbxryMpHvhXiF50WGBxEaXd7sDUvuJVQoCJveEFxuDKzTP8AJkOPsAgMk5aZXM5Ip6Ira6kr8eTzlUTMkgGWxmve8MUCWcwHcLWxs/3J4qzvxYXfy3DNadlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551233; c=relaxed/simple;
	bh=PIMBMVnRUrsYcSZxvKMo5suzVvX6xt5s+wQ5thbUD1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kghQyP7nmJL9m7ABun9K2DyLK+tSk8ejkjPGpPYNspRjB8ckfYdzcHGs/oSjKWzo0HVuGIU0WzcbfIWHzT9zy8R2SSaspALo9YT5pBQFdBL+ApS/13+j7wdZt2Z/9sPQMh6TsxaMGkeXE/s6F1y4ryvx1YOEYbLcmlJ3hI6O4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mGDQ5+Fw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso21816355e9.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551230; x=1710156030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlmDO7w1t4G2Y2I38OgxQ7WUNgvZu+OzH+DIdIich+s=;
        b=mGDQ5+FwtvJZUqRdHT3yezcPOEhbqG4FjgExBOOXMAh+k5n/C6QFOahM6r46yHu5mU
         iF9AqNDDQ77uLyQSpMwxOsdIPX/xRD+l2m1l+7tEVZi70pMx8vbaKY5Atcd9Ny8sKDmb
         +GCQHCsOZ+nccxRtBByMdwFr6Wz2bwKye1SZ1wrSrGXR77rctQSaAQXhBwZsD7s20t4x
         +3Rpy6WsjJyzGTct1/uM0bqyu+SoQ/Nm61FGs/n1gXHxhh4qFRUrw1ynnsVUQqehkjA9
         9twlMPab4Xf7rmgqV/Z8B0i9Q7VUe4sTDgeKbmv9E54+uESFMFWJ1VYash3YEniJsgQR
         ywGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551230; x=1710156030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlmDO7w1t4G2Y2I38OgxQ7WUNgvZu+OzH+DIdIich+s=;
        b=ZWi9kXrecltgl+FrvWFaamXF44+37qM1ldGNT6qpyf9F9d81amPOkIdYj49FTB983M
         8eJXb4wRLitqo02nJiQlhkuf9JvNoSlRNTk1G0anN1qhpH3aH8Vu+g4DkhUJnBCQLjTz
         Sq3pUJFN6rKwW5sx/lVm7X2RjqHDxdgOOnMChEcpWqXEMHK2Jp+dR2x7Oo8AhZn2GOaL
         nDmHYIBo7NXNRGlLD9NYh+tPWkZO9iGH16ljnWF4Je/chJyPLne2dyWwU3qIdgyRFunw
         /pC2bSNkQqfVA/bS1ALF77TpcryO3mCtJ31u9BH037NZ/7QavZ5vCx41RlX0KF/8XxR3
         we4g==
X-Gm-Message-State: AOJu0YzdLMb6ANhEpVTSNJ3iXWJc6wyMLWiW2cjzhmULNV4AalcoNmbI
	UR34JEzANGI81nmKS4FBDqu2Ejmetfnzu5UG3f5ERK7rNzYlR92JlHMraSjIiVIz3v/EHQ==
X-Google-Smtp-Source: AGHT+IG2nmwouE72v++bZAgqJPellEQfcK8Fz13wIU07OT8uXVoz1Q8oBkgJVP5ljzwDkMctncc5K+Rx
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3d93:b0:412:e80f:8efb with SMTP id
 bi19-20020a05600c3d9300b00412e80f8efbmr22600wmb.3.1709551230156; Mon, 04 Mar
 2024 03:20:30 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:43 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3215; i=ardb@kernel.org;
 h=from:subject; bh=VOX29KPhh0Yo9TI3cfEO+keD2WYPXEllnu6VlFM9GBY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpOv+Or6sZV2TrM9avZBJOvuPpyVJ8v6vE+1a1p8QZe
 6nCWIeOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJHDXIwMD2dulzwb01zeMnGH
 5vpVTcVbQtp1nwq/lGPfrr5uU8Oyawz/S1sNe7pfZ1y9mxZ8b/WFRwFFN4t0Xz9ZdKEw5SWr6da H7AA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-25-ardb+git@google.com>
Subject: [PATCH stable-v6.1 05/18] x86/efistub: Clear BSS in EFI handover
 protocol entrypoint
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit d7156b986d4cc0657fa6dc05c9fcf51c3d55a0fe upstream ]

The so-called EFI handover protocol is value-add from the distros that
permits a loader to simply copy a PE kernel image into memory and call
an alternative entrypoint that is described by an embedded boot_params
structure.

Most implementations of this protocol do not bother to check the PE
header for minimum alignment, section placement, etc, and therefore also
don't clear the image's BSS, or even allocate enough memory for it.

Allocating more memory on the fly is rather difficult, but at least
clear the BSS region explicitly when entering in this manner, so that
the EFI stub code does not get confused by global variables that were
not zero-initialized correctly.

When booting in mixed mode, this BSS clearing must occur before any
global state is created, so clear it in the 32-bit asm entry point.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-7-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S    | 14 +++++++++++++-
 drivers/firmware/efi/libstub/x86-stub.c | 13 +++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index deb36129e3a9..d6d1b76b594d 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -148,6 +148,18 @@ SYM_FUNC_END(__efi64_thunk)
 	.code32
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 SYM_FUNC_START(efi32_stub_entry)
+	call	1f
+1:	popl	%ecx
+
+	/* Clear BSS */
+	xorl	%eax, %eax
+	leal	(_bss - 1b)(%ecx), %edi
+	leal	(_ebss - 1b)(%ecx), %ecx
+	subl	%edi, %ecx
+	shrl	$2, %ecx
+	cld
+	rep	stosl
+
 	add	$0x4, %esp		/* Discard return address */
 	popl	%ecx
 	popl	%edx
@@ -340,7 +352,7 @@ SYM_FUNC_END(efi32_pe_entry)
 	.org	efi32_stub_entry + 0x200
 	.code64
 SYM_FUNC_START_NOALIGN(efi64_stub_entry)
-	jmp	efi_stub_entry
+	jmp	efi_handover_entry
 SYM_FUNC_END(efi64_stub_entry)
 #endif
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 9661d5a5769e..764bac6b58f9 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -925,12 +925,21 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 }
 
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
+			struct boot_params *boot_params)
+{
+	extern char _bss[], _ebss[];
+
+	memset(_bss, 0, _ebss - _bss);
+	efi_stub_entry(handle, sys_table_arg, boot_params);
+}
+
 #ifndef CONFIG_EFI_MIXED
-extern __alias(efi_stub_entry)
+extern __alias(efi_handover_entry)
 void efi32_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 		      struct boot_params *boot_params);
 
-extern __alias(efi_stub_entry)
+extern __alias(efi_handover_entry)
 void efi64_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 		      struct boot_params *boot_params);
 #endif
-- 
2.44.0.278.ge034bb2e1d-goog


