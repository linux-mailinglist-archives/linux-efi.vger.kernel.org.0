Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF68A168FEF
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2020 16:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBVP4i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Feb 2020 10:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbgBVP4i (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 22 Feb 2020 10:56:38 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3C7214DB;
        Sat, 22 Feb 2020 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582386997;
        bh=phijotbUpSTfwGX04zeWUy6w+zfYujYb/qWds8j+1qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbFVjB1ANHVs38as8R5gcM1UD4vgPt6IazJYNOejMqrNjkdYKCkwm8N+W8EZORCOB
         LHzIrI+T8Rw/j1pdYweiSm+nc0PMp2sHTEdVhEl5BI+SasP01G8AphJcD6Xn6RuIWu
         txJH06BUcTgM1HaXyIWR+dCPMvaKpVy0u8gAin5M=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, hdegoede@redhat.com,
        nivedita@alum.mit.edu, x86@kernel.org
Subject: [PATCH v3 1/6] efi/x86: add headroom to decompressor BSS to account for setup block
Date:   Sat, 22 Feb 2020 16:55:14 +0100
Message-Id: <20200222155519.23550-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222155519.23550-1-ardb@kernel.org>
References: <20200222155519.23550-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In the bootparams struct, init_size defines the static footprint of the
bzImage, counted from the start of the kernel image, i.e., startup_32().

The PE/COFF metadata declares the same size for the entire image, but this
time, the image includes the setup block as well, and so the space reserved
by UEFI is a bit too small. This usually doesn't matter, since we normally
relocate the kernel into a memory allocation of the correct size.
But in the unlikely case that the image happens to be loaded at exactly
the preferred offset, we skip this relocation, and execute the image in
place, stepping on memory beyond the provided allocation, which may be
in use for other purposes.

Let's fix this by adding the size of the setup block to the image size as
declared in the PE/COFF header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/tools/build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 55e669d29e54..c08db2ee4ba2 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -408,7 +408,7 @@ int main(int argc, char ** argv)
 
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 	init_sz = get_unaligned_le32(&buf[0x260]);
-	update_pecoff_bss(i + (sys_size * 16), init_sz);
+	update_pecoff_bss(i + (sys_size * 16), init_sz + setup_sectors * 512);
 
 	efi_stub_entry_update();
 
-- 
2.17.1

