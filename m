Return-Path: <linux-efi+bounces-2608-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716EA0AD6B
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 03:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56518162CB2
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 02:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340E04437C;
	Mon, 13 Jan 2025 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNW6FKVF"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FED14A85
	for <linux-efi@vger.kernel.org>; Mon, 13 Jan 2025 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735611; cv=none; b=twhHsY9n93o7ZNEw/kf+kqA1YSyWzqkNTjAgAo52Gj4d1ZOM++WlrxlXu2QI900TF7PraMmxKQA3T6pzIVT3jl778xDpW0OWRyB07/o4RtoWqLeZFBDKxleo1qzva9peM6lPR4k5Hr6Yc2uMw/3y4cCRNPHq2OEtXpOVCjMAQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735611; c=relaxed/simple;
	bh=+PaI+7tjJDa2TAzZmw95358z9lvNYKhqoQPHJNn+t/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8P1N5B0OvlPX13vJASGufmzT0mb+oZ2/LMQI2cz3qYLr5Q3aMJINwIr7utYUIWAtkBwezoXj99B5yEjCYCd/ycfwU0im6A5Hf/r5l7INfR4MMLTKwUS363vMqiHa0fkM2fao+wvMzoq13ZuuDBPfCMCU971Ir1dbxI1Nb2ee0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNW6FKVF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736735608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tjexe4TPFa4m9QlhBjs7sJPAbZ6T/UDfptFEwG+BFw=;
	b=WNW6FKVFUU2yro46nGKqNKps4WSJfwB8Oyf+83khQ/FxAXKWb1mqPCl43c4b97zfW5zRz9
	NXhkgycapmput2bhNuAhk7FMoNC5RnJ68EXFR58dKCZe0sdVO+pAa4ffvnXfOmdu+8HGnE
	EMtuGtUyZaYqKG8SRzoumpSGnjSeDAg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-sjBVDlQsM5qQs3gZQi6uyA-1; Sun, 12 Jan 2025 21:33:25 -0500
X-MC-Unique: sjBVDlQsM5qQs3gZQi6uyA-1
X-Mimecast-MFC-AGG-ID: sjBVDlQsM5qQs3gZQi6uyA
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso36916695ab.1
        for <linux-efi@vger.kernel.org>; Sun, 12 Jan 2025 18:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735604; x=1737340404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tjexe4TPFa4m9QlhBjs7sJPAbZ6T/UDfptFEwG+BFw=;
        b=Z4ENttgkewz4uP3T/+JxORB8Yza7WqRKR2z8UaILPGja/KY5dGyFleCznGHxxprPTf
         argt1S7E0ds0Y4apeaq9HBCRUJvWyBjoQbag370eU4RIj2KJ/qs+zlrO074r7gK98ESp
         ehbR9iPyKglkPI+bp9f0aQcNDcuNDogqKVt5+BEcjmJG5NnKCuLluQH6330+4oPAOTZJ
         2hMpeh5787pFacRmrqBfiKcfCXZeBQvNkaCEkb+n3+Xn9a3xEcVdhOKSqXLj3SHmGiZY
         Vc4lf9kJ+LSjh/COtBpyTfpXU7fWO6ezwrpGSTQ2Z5WVUazOwVpVXCL+4P8/gMjFpr+V
         JY4w==
X-Forwarded-Encrypted: i=1; AJvYcCUbSvGtvT4VMjAolKqNdJoayArx6byKPnHpXWbgkGpv1dwSIPAr3KGi94EPG9LRW9lxi2ZWphLS+6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVz2TrWRlFCoRNjwOCxIlDypQn8D9pNFzFsEzzJU604Btzgxy
	ms81YLRwkijeDKeDSANJU5om0bB5E1cy2D03xBmnFjHzXA9h39cjdmLuvGd+zG/j6MRUTwpf/jI
	0WW4TjPItIlklZ7LRdVfgwMJwGi4DLTin4N34mL9M/1Tv9vmyaTQsZ3eQInuuap8nWwwwguoKQu
	Ank10i8Tjnku3RZh9/+gE5GFn/Qg45KqVT
X-Gm-Gg: ASbGncvhZKrvMJXnjSwYJolpUUApdprKIzmjGaKiZ0VY7e8KnTwtBxcZnLxwJKLKNDS
	RNjfGRoStaRFPbKAotx7wnIwcZW48T+dmrMmt0ho=
X-Received: by 2002:a05:6e02:308b:b0:3a7:6c6a:e2a2 with SMTP id e9e14a558f8ab-3ce3a9b8f55mr145581515ab.9.1736735604321;
        Sun, 12 Jan 2025 18:33:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX/BB3a+x1+hlFag+y4MCY2vYZR+JO6tZHm61qqMxdGOWka7/7g093c98crf0DIa7amAkRJIPbGaJHsF5lggk=
X-Received: by 2002:a05:6e02:308b:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3ce3a9b8f55mr145581395ab.9.1736735604015; Sun, 12 Jan 2025
 18:33:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com> <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com> <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
In-Reply-To: <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 13 Jan 2025 10:33:29 +0800
X-Gm-Features: AbW1kvYKcHAghdXJwnimGQLKt2N80oQHvYivo3yXntwzaQ6sbrU260HdmO9BHWo
Message-ID: <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, devel@edk2.groups.io, 
	kexec@lists.infradead.org, hannes@cmpxchg.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 18:54, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 10/01/2025 07:21, Ard Biesheuvel wrote:
> > On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >>
> >>
> >> On 09/01/2025 15:45, Ard Biesheuvel wrote:
> >>> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
> >>>>
> >>>> The commit in [1] introduced a check to see if EFI memory attributes
> >>>> table was corrupted. It assumed that efi.memmap.nr_map remains
> >>>> constant, but it changes during late boot.
> >>>> Hence, the check is valid during cold boot, but not in the subsequent
> >>>> kexec boot.
> >>>>
> >>>> This is best explained with an exampled. At cold boot, for a test
> >>>> machine:
> >>>> efi.memmap.nr_map=91,
> >>>> memory_attributes_table->num_entries=48,
> >>>> desc_size = 48
> >>>> Hence, the check introduced in [1] where 3x the size of the
> >>>> entire EFI memory map is a reasonable upper bound for the size of this
> >>>> table is valid.
> >>>>
> >>>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
> >>>> efi.memmap.nr_map:
> >>>> - efi_map_regions which reduces the `count` of map entries
> >>>>   (for e.g. if should_map_region returns false) and which is reflected
> >>>>   in efi.memmap by __efi_memmap_init.
> >>>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
> >>>> - efi_free_boot_services which also reduces the number of memory regions
> >>>>   available (for e.g. if md->type or md->attribute is not the right value).
> >>>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
> >>>> Hence when you kexec into a new kernel and pass efi.memmap, the
> >>>> paramaters that are compared are:
> >>>> efi.memmap.nr_map=9,
> >>>> memory_attributes_table->num_entries=48,
> >>>> desc_size = 48
> >>>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
> >>>> as it was reduced due to efi_map_regions and efi_free_boot_services.
> >>>>
> >>>> A more appropriate check is to see if the description size reported by
> >>>> efi and memory attributes table is the same.
> >>>>
> >>>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
> >>>>
> >>>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
> >>>> Reported-by: Breno Leitao <leitao@debian.org>
> >>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >>>> ---
> >>>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
> >>>>  1 file changed, 6 insertions(+), 10 deletions(-)
> >>>>
> >>>
> >>> The more I think about this, the more I feel that kexec on x86 should
> >>> simply discard this table, and run with the firmware code RWX (which
> >>> is not the end of the world).
> >>
> >>
> >> By discard this table, do you mean kexec not use e820_table_firmware?
> >
> > No, I mean kexec ignores the memory attributes table.
> >
> >> Also a very basic question, what do you mean by run with the firmware RWX?
> >>
> >
> > The memory attributes table is an overlay for the EFI memory map that
> > describes which runtime code regions may be mapped with restricted
> > permissions. Without this table, everything will be mapped writable as
> > well as executable, but only in the EFI page tables, which are only
> > active when an EFI call is in progress.
> >
>
> Thanks for explaining!
>
> So basically get rid of memattr.c :)
>
> Do you mean get rid of it only for kexec, or not do it for any
> boot (including cold boot)?
> I do like this idea! I couldn't find this in the git history,
> but do you know if this was added in the linux kernel just
> because EFI spec added support for it, or if there was a
> specific security problem?
>

Usama, can you try the patch below?
[ format is wrong due to webmail corruption.  But if it works I can
send a formal patch later ]

$ git diff arch/x86
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 846bf49f2508..58dc77c5210e 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)

                if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
                        ((efi_config_table_64_t *)p)->table = data->smbios;
+
+               /* Not bother to play with mem attr table across kexec */
+               if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
+                       ((efi_config_table_64_t *)p)->table =
EFI_INVALID_TABLE_ADDR;
+
                p += sz;
        }


