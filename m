Return-Path: <linux-efi+bounces-4707-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DBB483CC
	for <lists+linux-efi@lfdr.de>; Mon,  8 Sep 2025 07:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F125176426
	for <lists+linux-efi@lfdr.de>; Mon,  8 Sep 2025 05:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9DB21D3F4;
	Mon,  8 Sep 2025 05:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqEyEaRu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332B45945;
	Mon,  8 Sep 2025 05:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757310654; cv=none; b=tkSyK1UjpqWj/36teJMnv534EBXttbZf8BIDVhHZ/aelhXfcGsO4PhhX9l1j4tTa6D1H6/1oPThts7KaRgk6oaz1Vbu18g37Yvbrfzf2SQ+9Tfjjy2vYPcuIxPJRZKrjQmGfvIwGOcTQ6756xUoCQnL8K/Y1tcqP1uz7iF0vR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757310654; c=relaxed/simple;
	bh=GINqdprG7It+egCrjMUFqxjobyN5ZaYR3gYB4TpViCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lb4hY7iCj7L8VH1IBzY3hfIsxrB78ofKb327/Za5grcqwtFGGCldh1OObbTau6aKfUzumNIeZ8o8KyhHYmnk3Srgp9rkiq4O5qeOnmtWcRWaXnGilg6vArTX+kGU9pzJd6IRnxs37UY01HEb8lwX4rKuU+nGzU2MwTRKfRYMxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqEyEaRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216CEC4CEFE;
	Mon,  8 Sep 2025 05:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757310654;
	bh=GINqdprG7It+egCrjMUFqxjobyN5ZaYR3gYB4TpViCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eqEyEaRuhNunHE3meUU+OuoeHwAkGzIcX9usvYpVewBuHj2C3F7wHa8HZU9upo1Uz
	 s1VkxCRZF56OvA8sxNngOPt5NZ6pnkOCEulUlriyWxUo1E4eL43H7rH7690cbD5eqZ
	 HJaJya4gAhtb768C9GG8JjPPhvxMGBoAsAPWThKZM9HnQO4NKTYBxCL2MUulH9YBUU
	 DeQjZUYww54kwZqauuvIoQ/6Zc2xB4ygjAntlYYqg5OmvgKAH3n2EGAI4N7ku6FiU8
	 OpNacVHWw9Y6OuUu7HhWlzydOCTx8iWQVPVvmY5YSEPiPVQcOgH9sjep/xGJVpejzx
	 UG+3z+4InK5qw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f7c0fb972so4325112e87.3;
        Sun, 07 Sep 2025 22:50:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVa4/0NIPlxGoJLew/d3jjAqNWY2coBF5igvza0yPKIqT/DKRBWR6AyQpVC02YNGlga2vnKjzjjKw=@vger.kernel.org, AJvYcCX/QKZ1rjwb+g35Wpk3lHYGo4Khjc2GjUGRL5WED5M5n4WRt3t0FIgCx/8H2mNoOy1IRnzRi25CqnlKQdod@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1xGPk3QE+n0/oAxwnG2JmtbjSktFUeNysHtBKonqhgx81btr
	nIN4KmGnLDDrZgKiKkRTQ4IGDlNrgMVwJpvDky4MuTpsxApBcX71nCbDtVHhDSe3Top4OeYuAmW
	LcLV4A0OaMmH0xKvBMuI+TKigryuVVPY=
X-Google-Smtp-Source: AGHT+IHj3nVEJWnBkVlJaXrN5K6OwmGDBEDQK/Rmk6FQrn4LOuQl1f6hmY4bY5Osqcf46rysjnySFniHWM+nuYqAYng=
X-Received: by 2002:ac2:4e0e:0:b0:55b:9796:5d5a with SMTP id
 2adb3069b0e04-562637cbf62mr1664560e87.26.1757310652405; Sun, 07 Sep 2025
 22:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755721529.git.epetron@amazon.de> <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
 <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
 <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com>
 <20250904093455.73184-1-epetron@amazon.de> <CAMj1kXHTJxBMFX6J-QwcPRojLGMQsTNOH5Bz9kHk7CFdt1JApw@mail.gmail.com>
 <20250904125917.78112-1-epetron@amazon.de>
In-Reply-To: <20250904125917.78112-1-epetron@amazon.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 8 Sep 2025 07:50:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGUOFN_W_8c3a6BnsXDy4xsF+9DUV3wcPr2s7-1K_xUUQ@mail.gmail.com>
X-Gm-Features: Ac12FXy43MFxOfSIccwrzkLM_Cl2hPp8-URkzEi5uCzgUR5RgZV-_I5_vZSbyeQ
Message-ID: <CAMj1kXGUOFN_W_8c3a6BnsXDy4xsF+9DUV3wcPr2s7-1K_xUUQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: akpm@linux-foundation.org, bhe@redhat.com, changyuanl@google.com, 
	graf@amazon.com, ilias.apalodimas@linaro.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nh-open-source@amazon.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 14:59, Evangelos Petrongonas <epetron@amazon.de> wrote:
>
> On Thu, 4 Sep 2025 11:39:02 +0200, Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Thu, 4 Sept 2025 at 11:36, Evangelos Petrongonas <epetron@amazon.de> wrote:
> > >
> > > On Thu, 4 Sep 2025 09:19:21 +0200, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > On Sat, 23 Aug 2025 at 23:47, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > (cc Ilias)
> > > > >
> > > > > Note to akpm: please drop this series for now.
> > > > >
> > > > > On Fri, 22 Aug 2025 at 04:00, Evangelos Petrongonas <epetron@amazon.de> wrote:
> > > > > >
> > > > > > When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> > > > > > early during device tree scanning. After kexec, the new kernel
> > > > > > exclusively uses this region for memory allocations during boot up to
> > > > > > the initialization of the page allocator
> > > > > >
> > > > > > However, when booting with EFI, EFI's reserve_regions() uses
> > > > > > memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> > > > > > rebuilding them from EFI data. This destroys KHO scratch regions and
> > > > > > their flags, thus causing a kernel panic, as there are no scratch
> > > > > > memory regions.
> > > > > >
> > > > > > Instead of wholesale removal, iterate through memory regions and only
> > > > > > remove non-KHO ones. This preserves KHO scratch regions, which are
> > > > > > good known memory, while still allowing EFI to rebuild its memory map.
> > > > > >
> > > > > > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > > > Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> > > > > > ---
> > > > > > Changes in v3:
> > > > > >         - Improve the code comments, by stating that the scratch regions are
> > > > > >         good known memory
> > > > > >
> > > > > > Changes in v2:
> > > > > >         - Replace the for loop with for_each_mem_region
> > > > > >         - Fix comment indentation
> > > > > >         - Amend commit message to specify that scratch regions
> > > > > >         are known good regions
> > > > > >
> > > > > >  drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
> > > > > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > > > >
> > > > >
> > > > > I'd rather drop the memblock_remove() entirely if possible. Could we
> > > > > get some insight into whether memblocks are generally already
> > > > > populated at this point during the boot?
> > > > >
> > > > >
> > > >
> > > > Ping?
> > >
> > > Hey Ard I was AFK travelling. I am back now and will get to it.
> > > PS: Keen to meet you later today in the KVM Forum.
> > >
> >
> > Yes, let's catch up!
> >
> >
>
> I did some testing on qemu with memblock and EFI debug enabled
>
> (`memblock=debug efi=debug`) and no KHO.
> We see that `memblock_dump_all()` in `reserve_regions()` outputs:
> ```
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x0000000200000000 reserved size = 0x000000000db5383e
> [    0.000000]  memory.cnt  = 0x7
> [    0.000000]  memory[0x0]     [0x0000000040000000-0x000000023c76ffff], 0x00000001fc770000 bytes on node 0 flags: 0x0
> ...
> [    0.000000]  reserved.cnt  = 0xf
> [    0.000000]  reserved[0x0]   [0x00000000fe000000-0x00000000ffffffff], 0x0000000002000000 bytes flags: 0x20
> ```
>
> Moreover checking the code, the boot flow  (at least on arm64)
> populates memblocks from DT memory nodes via
> `early_init_dt_add_memory_arch()` before `efi_init()` is called
>
> `setup_arch()` -> `setup_machine_fdt()` -> `early_init_dt_scan()` ->
> `early_init_dt_scan_memory()` -> `early_init_dt_add_memory_arch()` ->
> `memblock_add()`
>
> As a result, it seems that memblocks ARE populated when calling the
> `reserve_regions()`. So looks like  we still need the
> `memblock_remove()` (?)
>

Indeed.

For the series,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

