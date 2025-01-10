Return-Path: <linux-efi+bounces-2561-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE1FA088E3
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 08:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043DC1630BB
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 07:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277BA2066C7;
	Fri, 10 Jan 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlqtP4f7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162D157A46;
	Fri, 10 Jan 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736493845; cv=none; b=W1kiRB+RGMhyQn6pJpf38Mp1IHqhW4SXQcCJmMvgTMZ+axbStbvzVRFeAAgO19ID8jQcMPpkrF72dB1am4KbIa58UKvZcq5YgObI5LRFCcntFOAmI1JRjmdIYxe53oQWTmCwNi3bAbKPUseO7UvmU4c4zfl8DqN0htNbq8wWmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736493845; c=relaxed/simple;
	bh=ONjJpzfv9Zxk2928li0BEitQLEUhD2tb/bzhAdSta+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+7F9hqRtpFtiZ/5HRve9jFU9JOr/9H+pSKED2d3kjLquSFF6j36v7ATmi8/PqDK71UiLA+BafxwlIXa6v79DZp2PcNLxW88Ar2rIYzCrtQ6L6YxJvRCq/tDnmLkuBHWSZcyi2YNiHWyP+ydc2coICs7fuoT0al6tdcRZXc6VXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlqtP4f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A21C4CEE4;
	Fri, 10 Jan 2025 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736493844;
	bh=ONjJpzfv9Zxk2928li0BEitQLEUhD2tb/bzhAdSta+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mlqtP4f7yLqe9jqY1wvABgSYtJQ/KT8ckCH3jOjNC78qpHkDbDdfWWTusH7SH+AdL
	 v+y4ODqcCIpDG1Vr0gp6kgujKfG4cao3Ney0QVKjj/FyLlji+6ZuZXGwa4Ocm2r16y
	 DZtxQTa9EsgZ/Enkn9+wlcriHH1MWuKiZRQwJK8+6ndu/Nmw0iITZBP4i1sGMSdDof
	 cS2IoS2dP8H7TqnsWGjdnZeGRau0pf5WHSG+01InUKUlx66yJUPQhWkt7QNhiFIDBZ
	 nXxOB19/88YKzI82fYZfS7QaemmmYAQB+ObrqyGTdJb2pQxEDBbgU3wkh5oIRcQP4e
	 oNe8pJXQ2I5bA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30229d5b229so14658491fa.0;
        Thu, 09 Jan 2025 23:24:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsp9zKkdVEX2Ix3Quvsh3PJBz1+jNk9WfrGIuKBJBp8QSdauzRCikGjt1bWtW3x5HlhBJ99PoF7axRVGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQPp4QRZ0M/noNr5S0JaRz1gaY8J7qEX3vkvrPS0BMPq0UJLeg
	Q0vszSpppqELis0fGc+up/xdk/6uTIMpeNa9YUkYY5KsWlzpij+PXoBk5ebzgUgbD6UQ4ro2SNV
	VSyFsN56fFP+ir85+cOxArg6mwUw=
X-Google-Smtp-Source: AGHT+IGYqkfOo1l5vp36+uebNKlLgeJDXUixK18FpXwrJSpHyumiIGT64CNoieQ3oaHhrHajrgMKZe9lPCDnkLCfZdM=
X-Received: by 2002:a05:6512:3082:b0:542:6d01:f54d with SMTP id
 2adb3069b0e04-542844f3fc1mr3354249e87.3.1736493843027; Thu, 09 Jan 2025
 23:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com> <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
In-Reply-To: <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jan 2025 08:21:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
X-Gm-Features: AbW1kvaLZXidD5PN4oD-GwjBbzl6R0uQiwKJYbNGyIakDi17-k8ZzLnZ277sE34
Message-ID: <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, dyoung@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 09/01/2025 15:45, Ard Biesheuvel wrote:
> > On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >> The commit in [1] introduced a check to see if EFI memory attributes
> >> table was corrupted. It assumed that efi.memmap.nr_map remains
> >> constant, but it changes during late boot.
> >> Hence, the check is valid during cold boot, but not in the subsequent
> >> kexec boot.
> >>
> >> This is best explained with an exampled. At cold boot, for a test
> >> machine:
> >> efi.memmap.nr_map=91,
> >> memory_attributes_table->num_entries=48,
> >> desc_size = 48
> >> Hence, the check introduced in [1] where 3x the size of the
> >> entire EFI memory map is a reasonable upper bound for the size of this
> >> table is valid.
> >>
> >> In late boot __efi_enter_virtual_mode calls 2 functions that updates
> >> efi.memmap.nr_map:
> >> - efi_map_regions which reduces the `count` of map entries
> >>   (for e.g. if should_map_region returns false) and which is reflected
> >>   in efi.memmap by __efi_memmap_init.
> >>   At this point efi.memmap.nr_map becomes 46 in the test machine.
> >> - efi_free_boot_services which also reduces the number of memory regions
> >>   available (for e.g. if md->type or md->attribute is not the right value).
> >>   At this point efi.memmap.nr_map becomes 9 in the test machine.
> >> Hence when you kexec into a new kernel and pass efi.memmap, the
> >> paramaters that are compared are:
> >> efi.memmap.nr_map=9,
> >> memory_attributes_table->num_entries=48,
> >> desc_size = 48
> >> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
> >> as it was reduced due to efi_map_regions and efi_free_boot_services.
> >>
> >> A more appropriate check is to see if the description size reported by
> >> efi and memory attributes table is the same.
> >>
> >> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
> >>
> >> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
> >> Reported-by: Breno Leitao <leitao@debian.org>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>  drivers/firmware/efi/memattr.c | 16 ++++++----------
> >>  1 file changed, 6 insertions(+), 10 deletions(-)
> >>
> >
> > The more I think about this, the more I feel that kexec on x86 should
> > simply discard this table, and run with the firmware code RWX (which
> > is not the end of the world).
>
>
> By discard this table, do you mean kexec not use e820_table_firmware?

No, I mean kexec ignores the memory attributes table.

> Also a very basic question, what do you mean by run with the firmware RWX?
>

The memory attributes table is an overlay for the EFI memory map that
describes which runtime code regions may be mapped with restricted
permissions. Without this table, everything will be mapped writable as
well as executable, but only in the EFI page tables, which are only
active when an EFI call is in progress.

> Sorry for the very basic questions above!
>

No worries.

