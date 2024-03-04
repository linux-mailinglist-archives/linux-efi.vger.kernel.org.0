Return-Path: <linux-efi+bounces-702-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5542870040
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46463B244A2
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4938DDA;
	Mon,  4 Mar 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c72v3JVb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B28F39FDC
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551244; cv=none; b=qTGfnxggH37eGVqEGkEO9G+/oXdbciTKg8Np6Q8pgCx5woawauIUuz/cnKz6KQbwR1yVrzAQh7zkUOlqt90JFSrXtB3MF0BYefhbZ5Gkggt4ESH/tpnZ43YY/rDmupnftsR5gfprGUo7sEa8w/HnKY6zw1ulA1d2ZlOLKYumzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551244; c=relaxed/simple;
	bh=9v4Efw2z8SB3Tc4ArfJlBWi1Eg90T646DeIvlN39qmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pP4jepHMIPbFdBN1mM0BRSCMz4vkgZZweMM0x/8jzOJ/IhgXyLbwQU00x5DSFeyNjHel/nW0BdopQajKdaeStRUIVwaekTnIeOtMNVih0dGzVK+urCqk+0+E0NvifT/q+azHf2WehuVGuwYzsnpVn9EDHWLYrF/qKq7yvkW6K8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c72v3JVb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6092bf785d7so80509047b3.0
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551242; x=1710156042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLgfIvqok1SsDmyZ/SdqBU3eBRlX3u5Je2bvoxghFv0=;
        b=c72v3JVbXZpKLkd/zWec7ghBqMcubYncruI3uICdjDXNcokR18HjVbA7EKzff1az/7
         +7mkHvwx6ZN0FcmdWDPPNZoYQzFSQ+0cg7B772G4kHly7KCnQjxEwhPHWL1dsLbx2Xmw
         /7s5pOfKN8kKXTuh+lLcru3OYalShkwJn533XiJhtB8VWFCnqPdYCbqyPbsMZspwntW0
         ri2xTiIA4Dmz9JMMyiS18CkZ7e1RJYkBAxmLQFpGzchLG3mWhchZ3WX3W9IX+8nM3iVv
         VWqR/G2iJXCmAFoRE4znu88yFWmF/nqsjc6JQmfHzQu0HuNYIe8SvUUT4e9XVvUKuzsA
         TkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551242; x=1710156042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLgfIvqok1SsDmyZ/SdqBU3eBRlX3u5Je2bvoxghFv0=;
        b=sKJCp5efNT+vMdEl03vukgnIINiqqusWIJL/LJXnNiUNsYBnos8NwZ8dWFzpNiX2aK
         8vKXcIYRqEy1f7KM5q2f5kuDfZJQtKr6a0c+WvRiGTe5BcQZxJkV5NQdjIICtGUmokgQ
         4WJdqlOaZKwrnpYFzN2mZ1cAKZS5tRsX15sEfTvYzrjWoqDrx5yZHDCHfacIGxACeDTe
         caFO6/Rt8TMUSTckIxsSiawq5e/1qMIuiNlnNooYQ3RKLcyBWQ0MiSJcjjR9jyHZZruq
         uG50ewpcx7kzTKWLIPG7Ejz1LBzUbyd595Oy1PnVfG9Jid8IEPoSXVpov5edzDTky7UK
         lpiQ==
X-Gm-Message-State: AOJu0YyG2wrKktBYpDF8j7x41im/9TT741xjBWvYVMYHtvjitEq8iizt
	ecDpqOFqJKbZdiJfaV58fLZrBsi1UclhIEbfCH90gagvbsp96mq+UWx3HSaFN0ne828zvQ==
X-Google-Smtp-Source: AGHT+IFasKJ6Z68qaeCaukFCF6DRkwqJkno3BBevyuI5tKr5w/FKowjXFh+E9j4Hv6vnekr3UMfzrJFg
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:3504:b0:608:769c:d72a with SMTP id
 fq4-20020a05690c350400b00608769cd72amr2772758ywb.5.1709551241815; Mon, 04 Mar
 2024 03:20:41 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:48 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3205; i=ardb@kernel.org;
 h=from:subject; bh=vBybC5CFAcbRqTd0/RmU7gK/sMqPpIdkZgsnDcKzfeU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpuhBBr7k9u+JWHX1y92+4HsehzQu3TnpyUsLzV7Z7d
 eXPKNGqjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR1DUM/3TC8uwntNzP2nS9
 YXmoxeKauXpL785a/mXymtDJWvf2/3Vj+Cu5JuePQkNBrvt7lZbwwBubtTg5pF6LBKTbMcxp8ns xjQsA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-30-ardb+git@google.com>
Subject: [PATCH stable-v6.1 10/18] x86/decompressor: Factor out kernel
 decompression and relocation
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 83381519352d6b5b3e429bf72aaab907480cb6b6 upstream ]

Factor out the decompressor sequence that invokes the decompressor,
parses the ELF and applies the relocations so that it can be called
directly from the EFI stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-21-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.c | 29 ++++++++++++++++----
 arch/x86/include/asm/boot.h     |  8 ++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index e4e3e49fcc37..fb55ac18af6f 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,11 +330,33 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+const unsigned long kernel_total_size = VO__end - VO__text;
+
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
 
 extern unsigned char input_data[];
 extern unsigned int input_len, output_len;
 
+unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
+				void (*error)(char *x))
+{
+	unsigned long entry;
+
+	if (!free_mem_ptr) {
+		free_mem_ptr     = (unsigned long)boot_heap;
+		free_mem_end_ptr = (unsigned long)boot_heap + sizeof(boot_heap);
+	}
+
+	if (__decompress(input_data, input_len, NULL, NULL, outbuf, output_len,
+			 NULL, error) < 0)
+		return ULONG_MAX;
+
+	entry = parse_elf(outbuf);
+	handle_relocations(outbuf, output_len, virt_addr);
+
+	return entry;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -354,7 +376,6 @@ extern unsigned int input_len, output_len;
  */
 asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 {
-	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	memptr heap = (memptr)boot_heap;
 	unsigned long needed_size;
@@ -457,10 +478,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
-	__decompress(input_data, input_len, NULL, NULL, output, output_len,
-			NULL, error);
-	entry_offset = parse_elf(output);
-	handle_relocations(output, output_len, virt_addr);
+
+	entry_offset = decompress_kernel(output, virt_addr, error);
 
 	debug_putstr("done.\nBooting the kernel (entry_offset: 0x");
 	debug_puthex(entry_offset);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 215d37f7dde8..b3a7cfb0d99e 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -79,4 +79,12 @@
 # define BOOT_STACK_SIZE	0x1000
 #endif
 
+#ifndef __ASSEMBLY__
+extern unsigned int output_len;
+extern const unsigned long kernel_total_size;
+
+unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
+				void (*error)(char *x));
+#endif
+
 #endif /* _ASM_X86_BOOT_H */
-- 
2.44.0.278.ge034bb2e1d-goog


