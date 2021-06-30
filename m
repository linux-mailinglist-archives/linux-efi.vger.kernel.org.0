Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0A3B7F36
	for <lists+linux-efi@lfdr.de>; Wed, 30 Jun 2021 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhF3IrE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Jun 2021 04:47:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35120 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233108AbhF3IrE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 30 Jun 2021 04:47:04 -0400
Received: from zn.tnic (p200300ec2f12c3005601b47fb9547aa2.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:5601:b47f:b954:7aa2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 238381EC0521;
        Wed, 30 Jun 2021 10:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625042674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=mjE5wjKFJgfHACkYVBoQm0MkgIkbvmXkN5Worc2rFtQ=;
        b=kaw444MEx7UHj7NA4UFs6J2CPVplHWdTDZKwNMRrUuMwRUtnpC7eThdftdq06yeeIMcghG
        wULRkuMyBHEUosM8PiiYx+UY/E/mGJ75Y2vd0dCobwYQCJRc7YRxoHRWw1xe4u74XKjqoF
        4fC4wkvGiJRaOotTdB0LJ/Rq8MKMXLI=
Date:   Wed, 30 Jun 2021 10:44:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>
Cc:     glin@suse.com, =?utf-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-efi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] efi/mokvar: Reserve the table only if it is in boot
 services data
Message-ID: <YNwu7LmZaImyoOer@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi guys,

so below is what we've been staring at recently, please doublecheck me
whether I'm even making sense here.

Thx!

---
From: Borislav Petkov <bp@suse.de>

One of the SUSE QA tests triggered:

  localhost kernel: efi: Failed to lookup EFI memory descriptor for 0x000000003dcf8000

which comes from x86's version of efi_arch_mem_reserve() trying to
reserve a memory region. Usually, that function expects
EFI_BOOT_SERVICES_DATA memory descriptors but the above case is for the
MOKvar table which is allocated in the EFI shim as runtime services.

That lead to a fix changing the allocation of that table to boot services.

However, that fix broke booting SEV guests with that shim leading to
this kernel fix

  8d651ee9c71b ("x86/ioremap: Map EFI-reserved memory as encrypted for SEV")

which extended the ioremap hint to map reserved EFI boot services as
decrypted too.

However, all that wasn't needed, IMO, because that error message in
efi_arch_mem_reserve() was innocuous in this case - if the MOKvar table
is not in boot services, then it doesn't need to be reserved in the
first place because it is, well, in runtime services which *should* be
reserved anyway.

So do that reservation for the MOKvar table only if it is allocated
in boot services data. I couldn't find any requirement about where
that table should be allocated in, unlike the ESRT which allocation is
mandated to be done in boot services data by the UEFI spec.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/firmware/efi/mokvar-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index d8bc01340686..38722d2009e2 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -180,7 +180,10 @@ void __init efi_mokvar_table_init(void)
 		pr_err("EFI MOKvar config table is not valid\n");
 		return;
 	}
-	efi_mem_reserve(efi.mokvar_table, map_size_needed);
+
+	if (md.type == EFI_BOOT_SERVICES_DATA)
+		efi_mem_reserve(efi.mokvar_table, map_size_needed);
+
 	efi_mokvar_table_size = map_size_needed;
 }
 
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
