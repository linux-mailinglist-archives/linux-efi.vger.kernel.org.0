Return-Path: <linux-efi+bounces-2952-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D1A5A3F7
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 20:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C00189290D
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 19:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24444347B4;
	Mon, 10 Mar 2025 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="af8mDcPh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4F288A5
	for <linux-efi@vger.kernel.org>; Mon, 10 Mar 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635922; cv=none; b=mhMt0UM8OsO0IfmS2Yl4y+jVwIci/f9W9h5aMgTVaZrAibKT1jQ/jkf7utiOchquGJNGGikZNBZTZsyajQG3PewiNYrsc5kaOKJW7m9Kjfx5239JDFtNeV+v/fsWcA5gErr4xeSxIZj/R4PjA2qCB3RlvmgZcQSWHG0sqINTMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635922; c=relaxed/simple;
	bh=5zgFnWmXH5a4GCH3xdsxPyj7DVl9hjZCYcNGTu7oE8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKTzjo3ZpC5/xTcny4BI4xjXxdpc7p5qawOnjWabJ4PYxhpmjq1M5VluMSjti3jD3Bb5tg+kBLRgfRILsa+2HVU8eZJqEDrOpJ0I4H1+YhuJkHAlmkFfXbP63J1UprsdaiY+ZS1tJ98bjZiTUz5jMfWpwSStetvY+qzteHeBPE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=af8mDcPh; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5dcc411189so4282331276.0
        for <linux-efi@vger.kernel.org>; Mon, 10 Mar 2025 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741635918; x=1742240718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tqWgGBygD81G0N674tqdfSvRInpCyOsgpZJOfXWVfYM=;
        b=af8mDcPhYGyCqJojYmfGHLJqyn6RhxzEezW+1iO/OcSgcjWUOZ416qqI6L8Sm4NwPz
         hJ07eNTfHxRdHLL7ZKB7AUD3U+gHyECWToFRr0CWk5/qPkBrbi0vf5z+uASmwQ2xHrsQ
         TbgWyS/OB98wG0H9+VlleP1z5AcbSjzqBLR0vgyrU5hp/+vE1B2Ci0ZhY/Wejt0TeCco
         X1ecKLmzEnnB4RSvfrAzJf5p2AxWYBJlH/wUGJqS0/Xln+J8qc3wHo66SGuwgSrogCpN
         gQJcZwtE5HX7ZWaZW2J2+SibFwYpvkHpN86mAJtyhL+5sZX1D+G/Vc2P92NtjuUB01TE
         j8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741635918; x=1742240718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqWgGBygD81G0N674tqdfSvRInpCyOsgpZJOfXWVfYM=;
        b=nCrUzQTVb6XQvSXv//74k7A3A3QOj7PKEYKaDed95+pbYiQEJnW93z4EmDWBUWeoFK
         fbQElBMWXBON1hzT8rnAfxk7l7z7yqtC/O3ubNnB/V0VdnNtHZxGvrFdEE2a+qn64c7n
         88TIxkZra20Vp1+LAAnN9sJBG8GUwk+Flf1gQXNtuvGO1A9UK1DSLGKGihsMwuj0vtsU
         Oi/VIv4ZFHsqaLrV6r9SQb9x8KL1U/JWuu8EZulMJ7L55E7qycqD6i/0xFDojm7rcDwl
         Zth+lyKs5GNByt4R1PMSX8m2e/+Nqn5Cu2Kh3SBdeqfOagXxJV5T8xD77RG8FSjc0g80
         jXtA==
X-Forwarded-Encrypted: i=1; AJvYcCUTUIjJeQe6PYzUXi9Ar+SGGTFLro5hgdDNN5ZIoirFg6MVyDZFiGyheNTcEHVE44yrFneZ9OclsNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3GQk7LgdAvMIernp0t8AVw7f+56KD+p90S2vH4owBrovpo+g
	CGoJEjPKaxfYdAmJ0UpY+PgoJFAyn1XPd8dOeVU0FZpvYSKc9LPzov4Ddr8ed/B7vl5L/060clH
	6aBMjakPuzFDHiIOHGFbD9U0cOy7nRp/zYBp4EQ==
X-Gm-Gg: ASbGncs8l9l2AI1PMCZPBBZizvOY4Y96ILao3aFQzBquq5Q2/LVNylktmiShv9HyXiI
	fCCUyaGlt6zdbxyzKMud0FUEFr6f6t+r3xyFOF+fyFhjAHFvYHQTiuGDTpXVUqdfcBWgflhydAb
	xn5Lffkv+qP3JEorxFMKBW5RGBQFM=
X-Google-Smtp-Source: AGHT+IEbFwLQNm8mqLUNaM41246kTuzKXsyEv1y0ze5twEF9pbxo2U9oQEoqCmIFj+D6SzWuyZiskrvAFW7IavkpXF8=
X-Received: by 2002:a05:6902:3302:b0:e58:14b:6f99 with SMTP id
 3f1490d57ef6-e635c10115fmr16252325276.1.1741635918088; Mon, 10 Mar 2025
 12:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus>
 <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com>
 <YT8Nabg2mhqfljPaZg1ruLmAwW-C6iNOaSA4yUC3h8tkwEgaHJswhIP0fKxb_0Tvmsc6muBWW7TRgnCgXejXrXZ5zxx8gMc1aMFZW0A8-v0=@bens.haus>
 <CAC_iWj+LdNXYO-nTzenCvhQN=--hmfJLzH1w_D5g676_6wQ8=g@mail.gmail.com> <PkBypGXyjiJ7T845148vEiHaoabJOyVg26qTLI-SygtRbQ9aQjnMWUddWHiYB9KPR8JVqDFQ1pZRnRUq06vIRR7L4CDLERwJL9-2LdvcxBc=@bens.haus>
In-Reply-To: <PkBypGXyjiJ7T845148vEiHaoabJOyVg26qTLI-SygtRbQ9aQjnMWUddWHiYB9KPR8JVqDFQ1pZRnRUq06vIRR7L4CDLERwJL9-2LdvcxBc=@bens.haus>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Mar 2025 21:44:41 +0200
X-Gm-Features: AQ5f1JqSqrqdwNJ_JMx33AI1sHDGK0YJMAHOfI8pjBTgdBJlBPq2VSOJ9bUVee8
Message-ID: <CAC_iWj+YFNMZZneaQ+zh3ziM2iogB-whRsH81A8hKyNVPY0H9w@mail.gmail.com>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ben

On Sun, 9 Mar 2025 at 20:12, Ben Schneider <ben@bens.haus> wrote:
>
> Hi Ilias, thank you for connecting the threads. I'm clearly
> struggling a bit and appreciate how patient and helpful
> everyone has been.

No worries, I'd rather help than leave a bug lingering around. They
tend to come back biting

>
> On Saturday, March 8th, 2025 at 5:43 PM, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > The 'efidebug' command will dump the EFI memory map. Can you send that?
>
> This is what U-Boot reports:
>
> Type             Start            End              Attributes
> ================ ================ ================ ==========
> CONVENTIONAL     0000000000000000-0000000004000000 WB
> BOOT DATA        0000000004000000-0000000004200000 WB
> CONVENTIONAL     0000000004200000-0000000004400000 WB
> BOOT DATA        0000000004400000-0000000005400000 WB
> CONVENTIONAL     0000000005400000-000000003eabc000 WB
> BOOT DATA        000000003eabc000-000000003eac1000 WB
> RUNTIME DATA     000000003eac1000-000000003eac2000 WB|RT
> BOOT DATA        000000003eac2000-000000003eac3000 WB
> RUNTIME DATA     000000003eac3000-000000003eae5000 WB|RT
> BOOT DATA        000000003eae5000-000000003eaee000 WB
> BOOT CODE        000000003eaee000-000000003fb8a000 WB
> RUNTIME DATA     000000003fb8a000-000000003fb8b000 WB|RT
> BOOT CODE        000000003fb8b000-000000003ff00000 WB
> RUNTIME CODE     000000003ff00000-000000003ff10000 WB|RT
> BOOT CODE        000000003ff10000-0000000040000000 WB
>
> > Any idea if we can reproduce this on QEMU?
>
> I have not attempted to reproduce with QEMU.
>
> From what I can tell on my device, total_slots is 467 and
> target_slot seems to always start with a value of 0 despite the
> comment that it should be a random value in [0, total_slots).
>
> In the first iteration through the second for loop,
> MD_NUM_SLOTS(md) appears to have a value of 24 and since
> target_slot is always 0, it never reaches the 'continue'
> statement. With current builds, &target appears to have a value of
> 3faee138.

&target is the stack-allocated address -- it makes sense to be
identical. What we really want to print is 'target,' which is the
requested address.
Can you print 'target' in both of your success/fail cases and also
apply the patch below to u-boot:

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 6d00b1862505..421206d3c4a9 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -456,6 +456,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
        uint flags;
        efi_status_t ret;
        phys_addr_t addr;
+        efi_uintn_t map_size;
+       struct efi_mem_desc *memmap, *map;
+        int i;

        /* Check import parameters */
        if (memory_type >= EFI_PERSISTENT_MEMORY_TYPE &&
@@ -490,6 +493,18 @@ efi_status_t efi_allocate_pages(enum
efi_allocate_type type,
                if (*memory & EFI_PAGE_MASK)
                        return EFI_NOT_FOUND;

+               efi_get_memory_map_alloc(&map_size, &memmap);
+
+#define EFI_PHYS_ADDR_WIDTH (int)(sizeof(efi_physical_addr_t) * 2)
+               for (i = 0, map = memmap; i < map_size / sizeof(*map);
map++, i++) {
+                       printf("%-x %.*llx-%.*llx\n", map->type,
EFI_PHYS_ADDR_WIDTH,
+                              (u64)map_to_sysmem((void *)(uintptr_t)
map->physical_start),
+                              EFI_PHYS_ADDR_WIDTH,
+                              (u64)map_to_sysmem((void *)(uintptr_t)
(map->physical_start + map->num_pages * EFI_PAGE_SIZE)));
+               }
+
+               efi_free_pool(memmap);
+
                addr = map_to_sysmem((void *)(uintptr_t)*memory);
                addr = (u64)lmb_alloc_addr(addr, len, flags);
                if (!addr)

That will print the memory map, right before the efi_allocate_pages() request.

>  U-Boot appears to send this address to map_to_sysmem()
> [1] which seems to return 0, which is then what results in the
> EFI_NOT_FOUND.

map_to_sysmem() does nothing in actual hardware, it's there for an
internal platform called 'sandbox'. What fails is the call to
efi_allocate_pages().

>
> I went back to try figure out why it is somehow working when I
> block the 'break' statement with the condition status ==
> EFI_SUCCESS. Doing so causes the loop to start its second
> iteration when EFI_NOT_FOUND comes back. In the second iteration,
> MD_NUM_SLOTS(md) is 0 so we reach the 'continue' statement. This
> happens for the third and fourth iteration too. On the fifth
> iteration, MD_NUM_SLOTS(md) is 443 so it makes its second call to
> efi_allocate_pages(). On all iterations, target_slot remains 0.
>
> What is confusing is this second call to efi_allocate_pages()
> seems to have the same value for &target of 3faee138, but this
> time when U-Boot calls map_to_sysmem() it returns a value of
> 88080384 instead of 0. As a result, we get EFI_SUCCESS and the
> kernel boots.

Look above, what changes is the physical address not the pointer itself.
What I assume is happening here, is that the first call requests an
address which U-Boot somehow has already allocated, or the requested
length exceeds what we have available. Then you move to the next slot
and the new address happens to be ok.

>
> U-Boot also reports a new reservation in its lmb map between the
> first and second calls to efi_allocate_pages().
>

Yes internally efi_allocate_pages() uses the lmb APIs to allocate and
manage memory so that's normal.

> During first call to efi_allocate_pages():
>
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x0-0x3fffffff], 0x40000000 bytes, flags: none
>  reserved.count = 0x5
>  reserved[0]    [0x4000000-0x41fffff], 0x200000 bytes, flags: none
>  reserved[1]    [0x4400000-0x53fffff], 0x1000000 bytes, flags: none
>  reserved[2]    [0x3dae3000-0x3e2c8fff], 0x7e6000 bytes, flags: no-overwrite, no-map
>  reserved[3]    [0x3ea6c000-0x3eaedfff], 0x82000 bytes, flags: no-overwrite, no-map
>  reserved[4]    [0x3eaee960-0x3fffffff], 0x15116a0 bytes, flags: no-map
>
> During second call to efi_allocate_pages():
>
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x0-0x3fffffff], 0x40000000 bytes, flags: none
>  reserved.count = 0x6
>  reserved[0]    [0x0-0x113ffff], 0x1140000 bytes, flags: no-overwrite, no-map
>  reserved[1]    [0x4000000-0x41fffff], 0x200000 bytes, flags: none
>  reserved[2]    [0x4400000-0x53fffff], 0x1000000 bytes, flags: none
>  reserved[3]    [0x3dae3000-0x3e2c8fff], 0x7e6000 bytes, flags: no-overwrite, no-map
>  reserved[4]    [0x3ea6c000-0x3eaedfff], 0x82000 bytes, flags: no-overwrite, no-map
>  reserved[5]    [0x3eaee960-0x3fffffff], 0x15116a0 bytes, flags: no-map
>
> [1] https://github.com/u-boot/u-boot/blob/master/lib/efi_loader/efi_memory.c#L493
>

Cheers
/Ilias

