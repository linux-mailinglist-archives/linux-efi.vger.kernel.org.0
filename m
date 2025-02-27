Return-Path: <linux-efi+bounces-2836-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40312A476DD
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 08:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0EA07A4061
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 07:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E908213E71;
	Thu, 27 Feb 2025 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/NvBEXn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F91E521D;
	Thu, 27 Feb 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642621; cv=none; b=fxe+Rk5I/tadHUQThhXOIAL/Og61Tpr15IE3XC/2vwUHsij1H3aCiqXT1YgKgOPg94RXPOxXqCIaOg081JnSzhST8wvEB+qPiEWpqPPyuIFaib0LMGvmGGwwE3UQHu40mlvoRk4gxeIppqyqxPKgl9ocGO7wd+hTfudbeRop49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642621; c=relaxed/simple;
	bh=S9F2e7lRkRHtdgYVDmpNIrj//smsh+2ow+191iLu8q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqUbHT37mUJZ+SGbzbLZOHuuP9Rvff/U0jXBQO6/TD/ChCh8490oY/jz691M7BY+0Y1Ewinn8VUTKg/gtT186kE5dRKB0sg5ww46j7Z7yP6oDVF3P/iBnzCVuinrb56fW4jQQ9C/1Xqm1OWEjuMk11k3VGewDi07hcjNgjxeLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/NvBEXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE188C4CEDD;
	Thu, 27 Feb 2025 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740642621;
	bh=S9F2e7lRkRHtdgYVDmpNIrj//smsh+2ow+191iLu8q4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B/NvBEXn9z9ZunU9RAfNjOW8+Nq5YR/vfOkOe1VJ4pmmXBHUjWCaXAKvCrhNsygYw
	 NUulPAwVlCYGpXawY88uFu3QJf5fUgU5VCTYUUX4setaP/QOBuwiLrdhp249cPWhH/
	 Ks9J9EkmNz0ntJ4Y7AE3bOMYISkN0pDrSL12Pbg773bk4Y4/8RxW87wOMqELVXn25M
	 InCFlJ3sZSMNU7O7OUbrDu9aJs664HLwtyyedZ9KXSwuto192lrpuA2AbOpzEslP0j
	 7CWpfoBzp+m0oq7a5+SZTozPobse3D9wzNkILUCL4l3maJA8z0c1qsZ8S4SvxrJ/QB
	 t2+scGfZrGjvw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-543d8badc30so672604e87.0;
        Wed, 26 Feb 2025 23:50:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoRM2M6E7qSlEZm6kmd6z9CiSXaz6rceWtQzHPlvzcHQ1lF2kJZVxkOsxA3CuOxCH7/nl+OdsE6+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyut12W2jrhyfDIqcnvvOSgd/bU+fAwNxGxZW+qMskfFDXFuTZo
	SwbYVDeF8dHwqAzILfEqvxx8apFf4YNFCGGU2oPlOSUYwjM7STKZY3i3AMmjGUfM/uTZFQ0I/ZZ
	2ZTIhGiC4crzmZox9aAkksYwOQmw=
X-Google-Smtp-Source: AGHT+IHWEL1CdAYVLlEtN6d4NWSiBrd1AluWIZPywKB1C2n2QQO7LcEEEv/DooBX39mSH3Bib2QjhA8X0mcjDkiIkNI=
X-Received: by 2002:a05:6512:3b84:b0:545:4d1:64c0 with SMTP id
 2adb3069b0e04-548510dc454mr7011683e87.27.1740642620001; Wed, 26 Feb 2025
 23:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226201839.2374631-1-pjones@redhat.com>
In-Reply-To: <20250226201839.2374631-1-pjones@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Feb 2025 08:50:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGoZ5RB4GWs_YTG7g+vGZokwe3yF-ri5BV4vOBinhqfLQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqPg0a_qnsvgproOVYZdvPH5EHWsCax5Bh00K5KLJQaqgl9mR85caZgAkk
Message-ID: <CAMj1kXGoZ5RB4GWs_YTG7g+vGZokwe3yF-ri5BV4vOBinhqfLQ@mail.gmail.com>
Subject: Re: [PATCH] efi: don't map the entire mokvar table to determine its size
To: Peter Jones <pjones@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Lenny Szubowicz <lszubowi@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 21:18, Peter Jones <pjones@redhat.com> wrote:
>
> Currently when validating the mokvar table, we (re)map the entire table
> on each iteration of the loop, adding space as we discover new entries.
> If the table grows over a certain size, this fails due to limitations of
> early_memmap(), and we get a failure and traceback:
>
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 0 at mm/early_ioremap.c:139 __early_ioremap+0xef/0x220
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.15-200.fc41.x86_64 #1
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20250221-6.copr8698600 02/21/2025
>   RIP: 0010:__early_ioremap+0xef/0x220
>   Code: e5 00 f0 ff ff 48 81 e5 00 f0 ff ff 4c 89 6c 24 08 41 81 e4 ff 0f 00 00 4c 29 ed 48 89 e8 48 c1 e8 0c 41 89 c7 83 f8 40 76 04 <0f> 0b eb 82 45 6b ee c0 41 81 c5 ff 05 00 00 45 85 ff 74 36 83 3d
>   RSP: 0000:ffffffff96803dd8 EFLAGS: 00010002 ORIG_RAX: 0000000000000000
>   RAX: 0000000000000041 RBX: 0000000000000001 RCX: ffffffff97768250
>   RDX: 8000000000000163 RSI: 0000000000000001 RDI: 000000007c4c3000
>   RBP: 0000000000041000 R08: ffffffffff201630 R09: 0000000000000030
>   R10: 000000007c4c3000 R11: ffffffff96803e20 R12: 0000000000000000
>   R13: 000000007c4c3000 R14: 0000000000000001 R15: 0000000000000041
>   FS:  0000000000000000(0000) GS:ffffffff97291000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffff9f1d8000040e CR3: 00000000653a4000 CR4: 00000000000000f0
>   Call Trace:
>    <TASK>
>    ? __early_ioremap+0xef/0x220
>    ? __warn.cold+0x93/0xfa
>    ? __early_ioremap+0xef/0x220
>    ? report_bug+0xff/0x140
>    ? early_fixup_exception+0x5d/0xb0
>    ? early_idt_handler_common+0x2f/0x3a
>    ? __early_ioremap+0xef/0x220
>    ? efi_mokvar_table_init+0xce/0x1d0
>    ? setup_arch+0x864/0xc10
>    ? start_kernel+0x6b/0xa10
>    ? x86_64_start_reservations+0x24/0x30
>    ? x86_64_start_kernel+0xed/0xf0
>    ? common_startup_64+0x13e/0x141
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>   mokvar: Failed to map EFI MOKvar config table pa=0x7c4c3000, size=265187.
>
> Mapping the entire structure isn't actually necessary, as we don't ever
> need more than one entry header mapped at once.
>
> This patch changes efi_mokvar_table_init() to only map each entry
> header, not the entire table, when determining the table size.  Since
> we're not mapping any data past the variable name, it also changes the
> code to enforce that each variable name is NUL terminated, rather than
> attempting to verify it in place.
>
> Signed-off-by: Peter Jones <pjones@redhat.com>
> ---
>  drivers/firmware/efi/mokvar-table.c | 41 +++++++++--------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
> index 5ed0602c2f7..66eb83a0f12 100644
> --- a/drivers/firmware/efi/mokvar-table.c
> +++ b/drivers/firmware/efi/mokvar-table.c
> @@ -103,7 +103,6 @@ void __init efi_mokvar_table_init(void)
>         void *va = NULL;
>         unsigned long cur_offset = 0;
>         unsigned long offset_limit;
> -       unsigned long map_size = 0;
>         unsigned long map_size_needed = 0;
>         unsigned long size;
>         struct efi_mokvar_table_entry *mokvar_entry;
> @@ -134,48 +133,34 @@ void __init efi_mokvar_table_init(void)
>          */
>         err = -EINVAL;
>         while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
> -               mokvar_entry = va + cur_offset;
> -               map_size_needed = cur_offset + sizeof(*mokvar_entry);
> -               if (map_size_needed > map_size) {
> -                       if (va)
> -                               early_memunmap(va, map_size);
> -                       /*
> -                        * Map a little more than the fixed size entry
> -                        * header, anticipating some data. It's safe to
> -                        * do so as long as we stay within current memory
> -                        * descriptor.
> -                        */
> -                       map_size = min(map_size_needed + 2*EFI_PAGE_SIZE,
> -                                      offset_limit);
> -                       va = early_memremap(efi.mokvar_table, map_size);
> -                       if (!va) {
> -                               pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%lu.\n",
> -                                      efi.mokvar_table, map_size);
> -                               return;
> -                       }
> -                       mokvar_entry = va + cur_offset;
> +               if (va)
> +                       early_memunmap(va, sizeof(*mokvar_entry));
> +               va = early_memremap(efi.mokvar_table + cur_offset, sizeof(*mokvar_entry));
> +               if (!va) {
> +                       pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%zu.\n",
> +                              efi.mokvar_table + cur_offset, sizeof(*mokvar_entry));
> +                       return;
>                 }
> +               mokvar_entry = va;
>
>                 /* Check for last sentinel entry */
>                 if (mokvar_entry->name[0] == '\0') {
>                         if (mokvar_entry->data_size != 0)
>                                 break;
>                         err = 0;
> +                       map_size_needed = cur_offset + sizeof(*mokvar_entry);
>                         break;
>                 }
>
> -               /* Sanity check that the name is null terminated */
> -               size = strnlen(mokvar_entry->name,
> -                              sizeof(mokvar_entry->name));
> -               if (size >= sizeof(mokvar_entry->name))
> -                       break;
> +               /* Enforce that the name is null terminated */
> +               mokvar_entry->name[sizeof(mokvar_entry->name)-1] = '\0';
>
>                 /* Advance to the next entry */
> -               cur_offset = map_size_needed + mokvar_entry->data_size;
> +               cur_offset += sizeof(*mokvar_entry) + mokvar_entry->data_size;
>         }
>
>         if (va)
> -               early_memunmap(va, map_size);
> +               early_memunmap(va, sizeof(*mokvar_entry));
>         if (err) {
>                 pr_err("EFI MOKvar config table is not valid\n");
>                 return;

Thanks for the fix.

Should we add something like the below to avoid mapping the same page
over and over again? Or is this premature optimization?


--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -99,13 +99,13 @@
  */
 void __init efi_mokvar_table_init(void)
 {
+       struct efi_mokvar_table_entry __aligned(1) *mokvar_entry, *next_entry;
        efi_memory_desc_t md;
        void *va = NULL;
        unsigned long cur_offset = 0;
        unsigned long offset_limit;
        unsigned long map_size_needed = 0;
        unsigned long size;
-       struct efi_mokvar_table_entry *mokvar_entry;
        int err;

        if (!efi_enabled(EFI_MEMMAP))
@@ -142,7 +142,7 @@
                        return;
                }
                mokvar_entry = va;
-
+next:
                /* Check for last sentinel entry */
                if (mokvar_entry->name[0] == '\0') {
                        if (mokvar_entry->data_size != 0)
@@ -156,7 +156,19 @@ void __init efi_mokvar_table_init(void)
                mokvar_entry->name[sizeof(mokvar_entry->name) - 1] = '\0';

                /* Advance to the next entry */
-               cur_offset += sizeof(*mokvar_entry) + mokvar_entry->data_size;
+               size = sizeof(*mokvar_entry) + mokvar_entry->data_size;
+               cur_offset += size;
+
+               /*
+                * Don't bother remapping if the current entry header and the
+                * next one end on the same page.
+                */
+               next_entry = (void *)((unsigned long)mokvar_entry + size);
+               if (((((unsigned long)(mokvar_entry + 1) - 1) ^
+                     ((unsigned long)(next_entry + 1) - 1)) &
PAGE_MASK) == 0) {
+                       mokvar_entry = next_entry;
+                       goto next;
+               }
        }

        if (va)

