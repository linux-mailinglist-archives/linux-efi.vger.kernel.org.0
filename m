Return-Path: <linux-efi+bounces-2575-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC0A09871
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 18:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9479188EA85
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB6E213E6E;
	Fri, 10 Jan 2025 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czlK2XO5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A24213E66;
	Fri, 10 Jan 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529938; cv=none; b=ZRxhu2yTeGKSP0FNx41R0eavbxKbaAhZUS5vjJb3HySig0vLJsQZv1AG1Fbh7xSKw5FZZcvLjr1jGTB2D4OEn9XjuDje6ebdbYzYBeS91yQ/hD4re3nNC2TrpEUfgKUtxopUg3GwP1pe/mhFEFMpjtV1nJeq0mfGIpHOwe0hm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529938; c=relaxed/simple;
	bh=uBrDyOj3slbVJ+PIUj2mbwZthei0bY1+kDWt5/y2BrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwZJNUNUu/6PMfFEO3Qk1xI+Fo4ReUnDSHC9U0JWaRqWhogo979udb++BtZMYautxdvP1R0PU1Yb+Hra2n6ee1+e6I3QihjA3gQfypuq25AHN0/QiBH8aVydWMxfz/n/qSYqMxUX0/zuu4a7Kd+PtemV9drrKnIEpVmc/4xknC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czlK2XO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE543C4CEE3;
	Fri, 10 Jan 2025 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736529937;
	bh=uBrDyOj3slbVJ+PIUj2mbwZthei0bY1+kDWt5/y2BrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=czlK2XO5KZAXhCzhutpznnEWzdQywlK2JxHrSr5SoEXQwHrFouikK90abHZsXdjye
	 Nd+Ta4utFCS8OXLI0UVFUdS82e89fuHpSfi1s4bnKD92fqK3corhrTSCydzpiXj0j/
	 ZWyD58iw6TTa97sunHeotB4Lo6DD4pNKFBRWsxAbboh0pRhW+YAp28+pMKlmQ3iXNv
	 vu9UagSdzqVTnj3pS+PHe6vGePRqRMDYRDdzX19MH5PP6VUFJqYY+Tbp2kI8gnkPwd
	 jyhp9cyJf6zA1QgDfybm39secevcsVawv3wsMM5F/Qz4D0t7p6pjuEDQbiQD2rAX09
	 dmOs6mmECXfUQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3043e84c687so17716241fa.1;
        Fri, 10 Jan 2025 09:25:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKtOyiMzcJ6JR1Aal1acq0QcMsb8P3Zsd1pjS8O3UzBoDybV1Z2TqGJkREAPsAEIkkAg5XQkXAvMsvQ3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSUxLpzZhNudaop4liiOYEA1sEYU2YFJApZdCUJiNzjQ1Xc84t
	Qb+EJoD/HEfCYcL22IvacwJbsMyeTqEnL/XugczylwWWgro0tYVF5bGvHO3bqE6IL+r1KnePJ90
	4NAm6NA5rVmyt4uI5WpSwDKBHfZo=
X-Google-Smtp-Source: AGHT+IH1YfVBqbm+Pgf7TBeHFLTJOJ9Hm6qsUhBbmahKzi8ZRlMk7bsMFmjtEcNd8F2vUCVRY9HYSEle6Ia2vdTZc80=
X-Received: by 2002:a05:651c:1415:b0:304:9de0:7d9 with SMTP id
 38308e7fff4ca-305f45a0f1fmr28575561fa.21.1736529935923; Fri, 10 Jan 2025
 09:25:35 -0800 (PST)
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
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jan 2025 18:25:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHqKw1CxqdqsYAgOXR4P+DxokBa3FGKUw4zPj+wbDMaqA@mail.gmail.com>
X-Gm-Features: AbW1kvYPA0MmDvM52yYY8OWWdO9cYIpDAVPSEFxEiFLV6IJYQpauDzlmq49gb3Q
Message-ID: <CAMj1kXHqKw1CxqdqsYAgOXR4P+DxokBa3FGKUw4zPj+wbDMaqA@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, dyoung@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 11:53, Usama Arif <usamaarif642@gmail.com> wrote:
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

Only for kexec, and only on x86

> I do like this idea! I couldn't find this in the git history,
> but do you know if this was added in the linux kernel just
> because EFI spec added support for it, or if there was a
> specific security problem?
>

Mapping memory RWX is generally a bad idea, so we should avoid it if
possible. But EFI runtime memory regions are only mapped during a EFI
runtime call, and these don't happen often at all, so the benefit is
only marginal. (In the early days of EFI, it was more common for the
OS to map these regions permanently, but we stopped doing that a long
time ago)

