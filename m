Return-Path: <linux-efi+bounces-2545-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10298A079B2
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 15:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E29188B4A7
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A1521C9E3;
	Thu,  9 Jan 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZk0iJ3Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7421C16F;
	Thu,  9 Jan 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434149; cv=none; b=oIpit1P89Kkq7VZvGvtiWGckyv1g5r6oGmrcGHykWzqh05Fm18sKFzUCytfg0lSxhEXX76FWKZJ2IYTP0kTqsQ8hL7fbMuMFqpJKl4UOl6O0NedYqXf1H9loQd8RqgvLeEkou6NEUqjpKgbWR2Z+XXFAa6zB7iDsbP4VAxtzi4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434149; c=relaxed/simple;
	bh=qq3hACfvtQfc2ipUXFPbhbynoe3D/LRZY3O74eue9qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+B62hk41fkVi74LkzJtnH50ytedjMWyRfRNsC1NulfRZsUQpETjxPo2GYB8NMrJZwNoBn5j2aCwMeWDqvxAwaVLjOc17sjunhZMnnlF/JK05bsPFUrZ9ZaDFtk+iVCSLoMnjd8khn8blUr71GlILybP+5PsG05doxDqLNbFnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZk0iJ3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198B4C4CEE6;
	Thu,  9 Jan 2025 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736434149;
	bh=qq3hACfvtQfc2ipUXFPbhbynoe3D/LRZY3O74eue9qY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uZk0iJ3Q2gAKtpBk9UWyktbE4ite2gTonPVq4mCkEddeH4Tc5Tx90xyLf9OmXaM7/
	 HgKgrNfHkz2547nWQz8KUADjy5mdJkiy9It9Fll9oz0F9YQpnP6Eaq/mQcbiTcMl2J
	 AQuoa+R0DM7+5fP/ZlP7nJZQ4LrSUVcn3vW56lAZq6+lb/8McPDD8mfxXfkrqEjWok
	 jyzVkZaQ0LcbY2Pr1UN+J2VUxMHhafn5KaXrctC7d8+hUV4QgflVQ/IuHYnr/K7/jF
	 2I/GPCDigQsV0IWXr0k3TLxmHLRtOi7Ccdcbfa8REwhIZieJti9YZoDdIWZYcDEZRx
	 AXW/VqkdQzkkw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-540201cfedbso959466e87.3;
        Thu, 09 Jan 2025 06:49:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfbB4+J2EkdG64+T20/UH+5yEJicYOcBQ1t4TJmA4O1rytSmrb0I4Ct0CRDxcPfjjL2shGVn2Qhu5/QnqZ@vger.kernel.org, AJvYcCXE+Q2OM97lIMeLeePTPi4iOtLSo0l6UQ5Q4fA9LXpUTzSaZ9nTqIjx4BN7xTj4Pi5/2hA2KKsEUI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjMYikFrNOE1fpmAeiWiOtbrNd/8WpahQhbxwwKIHARKPCBxOs
	2+aZVtvc2bfe45nuoN936zU8WonGit/idUX/p+g3Ji7e1MwIrFFmFBtMR4i/P7U1wS/ID02GMoI
	vLvwQKRP4gBhsIvE28HT4ouE3r9o=
X-Google-Smtp-Source: AGHT+IF2nBYsKBCUEIGuvQHkwNJJBtlgyOsf7KoLwbY12xzwwh3z4mK+ezgQjTCp3Fl2I5hiUI6TzO7HTXst9CBMMBA=
X-Received: by 2002:a05:6512:2205:b0:540:2542:cba6 with SMTP id
 2adb3069b0e04-54284527758mr1880020e87.21.1736434147285; Thu, 09 Jan 2025
 06:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
 <20250106-efi_fw_bug-v1-3-01a8eb40bfeb@debian.org> <CAMj1kXFn7CeT6R2w_XKAJoj5WUYObOWKeUO2istY8sULQTwomQ@mail.gmail.com>
 <20250107-versatile-loyal-mussel-2dba59@leitao>
In-Reply-To: <20250107-versatile-loyal-mussel-2dba59@leitao>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Jan 2025 15:48:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEjzM0YmPt8Ysh139ruPKUR9NJJYOz0Pw6aWBP9V7fpag@mail.gmail.com>
X-Gm-Features: AbW1kvaihH4YtHuquSE9lfyUmzf08-ScfHVuhBn6ofVkq69AzdSb4002X3SwiYw
Message-ID: <CAMj1kXEjzM0YmPt8Ysh139ruPKUR9NJJYOz0Pw6aWBP9V7fpag@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi/memattr: Include EFI memmap size in corruption warnings
To: Breno Leitao <leitao@debian.org>
Cc: Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jan 2025 at 13:05, Breno Leitao <leitao@debian.org> wrote:
>
> Hello Ard,
>
> On Tue, Jan 07, 2025 at 12:24:03PM +0100, Ard Biesheuvel wrote:
> > On Mon, 6 Jan 2025 at 20:03, Breno Leitao <leitao@debian.org> wrote:
> > >
> > > Add EFI memory map size to warning messages when a corrupted Memory
> > > Attributes Table is detected, making it easier to diagnose firmware issues.
> > >
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  drivers/firmware/efi/memattr.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> > > index 5f83cdea88b05cb325e9f90c14a0048131e53cfa..2c276bcc0df48352bec6cd96b69edf67a16f6069 100644
> > > --- a/drivers/firmware/efi/memattr.c
> > > +++ b/drivers/firmware/efi/memattr.c
> > > @@ -22,7 +22,7 @@ unsigned long __ro_after_init efi_mem_attr_table = EFI_INVALID_TABLE_ADDR;
> > >  void __init efi_memattr_init(void)
> > >  {
> > >         efi_memory_attributes_table_t *tbl;
> > > -       unsigned long size;
> > > +       unsigned long size, efi_map_size;
> > >
> > >         if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
> > >                 return;
> > > @@ -49,9 +49,10 @@ void __init efi_memattr_init(void)
> > >          * just be ignored altogether.
> > >          */
> > >         size = tbl->num_entries * tbl->desc_size;
> > > -       if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
> > > -               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
> > > -                       tbl->version, tbl->desc_size, tbl->num_entries);
> > > +       efi_map_size = efi.memmap.nr_map * efi.memmap.desc_size;
> > > +       if (size > 3 * efi_map_size) {
> > > +               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u, efi_map_size == %lu)\n",
> > > +                       tbl->version, tbl->desc_size, tbl->num_entries, efi_map_size);
> > >                 goto unmap;
> > >         }
> > >
> > >
> >
> > Hello Breno,
> >
> > I don't mind the patch per se, but I don't think it is terribly useful either.
> >
> > Could you explain how this helps?
>
> We are seeing a bunch of `Corrupted EFI Memory Attributes Table
> detected!` in the Meta fleet, and this is something we are
> investigating.
>
> We highly think this is related to some kexec overwrites, and when we
> get here, the EFI table is completely garbage. I haven't seen this
> problem on cold boot.
>

It likely means the memory is not reserved correctly.

Could you check whether this

--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -56,7 +56,7 @@ int __init efi_memattr_init(void)
        }

        tbl_size = sizeof(*tbl) + size;
-       memblock_reserve(efi_mem_attr_table, tbl_size);
+       efi_mem_reserve(efi_mem_attr_table, tbl_size);
        set_bit(EFI_MEM_ATTR, &efi.flags);

 unmap:


makes any difference?


> Here are sof the instances I see:
>
>         efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 0, desc_size == 18058, num_entries == 33554432)
>         efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 1, desc_size == 2072184435, num_entries == 3248688968)
>         efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 0, desc_size == 83886080, num_entries == 304)
>         efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 2, desc_size == 48, num_entries == 40)
>

The last one looks like a false positive: each of those values seems
perfectly reasonable.

Any chance you could dump the memory map and this table (boot using
efi=debug) on this system?


> Anyway, back to you question, this patch helped us to narrow down and
> find where the problem was, by printing all variables taken in
> consideration to get the conclusion that the firmware is buggy.
>

Fair enough.

> Regarding the problem, Usama and I are suspecting that it might be
> related to some 77d48d39e99170 ("efistub/tpm: Use ACPI reclaim memory for
> event log to avoid corruption"), but at this time with memattr table, where it
> might not preserved during kexec(?).
>

Please see the suggestion above.

