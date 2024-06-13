Return-Path: <linux-efi+bounces-1219-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25BA907E82
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jun 2024 00:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94321C21DA8
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54BF139597;
	Thu, 13 Jun 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1/96HME"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FF1369A1;
	Thu, 13 Jun 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316154; cv=none; b=gz4zZFgUaPoLrkJY7QFSfUMMJKE6kLPzu8Qj6/ShNQMvv1zoWixau4q/TKnQR73qACN4AJDW3TTIplQ+tu4IMxb5xw6J4D42RyouxQofCwAGjl1FdtVJsSNkLDeYuYAXGgBEm24eLYX8bbLJeNKfEtTPhXq9qYv+MxdcLFKUh7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316154; c=relaxed/simple;
	bh=J6SgO+1w7jrwaSaaaWIqgKZRKOQa8blXxyttDPlg7FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoC/xPD5iHmhDecfc3ugrma2HnE+9CvowQM4LzPmFVijyuA6l2YcAhqe0LihK1iUHVgU9MwwO8YZRe344h2Rpa+/z3HKwZpgGRQVZ9TMuJre91w4gmYuRbqGl82TCl/SRZ8mn2wOnVzAy2f7WmbAVe9s/awan1F7y+o6df/1w8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1/96HME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F2FC4AF1C;
	Thu, 13 Jun 2024 22:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718316154;
	bh=J6SgO+1w7jrwaSaaaWIqgKZRKOQa8blXxyttDPlg7FI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c1/96HMEu7XsnkdUyT+aApIPDv0Djo0wHSrz19JNCVrb356AC/umj0OXtTdYju4sU
	 GdGf6c+bw/5FLeXfQoduvnDCwTsRN5rhAEqdMOeJxQ1QgYnpg5ufJJT3Pf+UJywLAO
	 mV8qiYTTnXlTjgt+/pSm35gsokKmx/4tB8cOkJeX4awX7IKkSDgFaWbVKoXOCF+iKL
	 ruvxJ0oMdzmHgLu6+yhcSVmCSrrrHbGwwzUXtjMGkyvOmS5zq5AQzqfCIokylKB+8K
	 TuDx7Nyx5eCW/uCZSYdB+p2YTN/COqw5AGWyc+pJPEEyT1qUNPrplmEHvf/UbEarBe
	 J3B2uVtGodiVA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ca342d6f3so1025295e87.2;
        Thu, 13 Jun 2024 15:02:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpHBMFaO3Be0G61Hz3ImJeA0ekpk8rxfGtOK841nsu9mePMPUz/i9/GwXoCjHQhcMgh5IgNeI65bwWW8AmHDvFZRj428X1RiyJm/z4SDY6NVcstkgYh2Tuaf7YfT9n6m57/Ctz3zZ+
X-Gm-Message-State: AOJu0Yycq+lQjTyBI/oK3mRkll+0BT01FxXSRO4HGlp9GGe5qM9o/TRX
	ly2MQcGUBCo7l3x4IuiYF0lKnvonDIy/NBCyHqjcHd+hOlPftAkGANxDYsGMDI3UxUne1crygIq
	CFPCYM84qcigHCtb6LpeHGNTHuIs=
X-Google-Smtp-Source: AGHT+IGL/ao/BTbPwg4eeajD/YZVVm/FlbNLMCnuJpDl+KfqJNTqU5nHxe3mD2+wcUfAiCG9rRytydfaNjKjaA+pWjU=
X-Received: by 2002:a19:f703:0:b0:51b:214c:5239 with SMTP id
 2adb3069b0e04-52ca6e9f465mr582618e87.62.1718316152378; Thu, 13 Jun 2024
 15:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612135638.298882-2-ardb+git@google.com> <16131a10-b473-41cc-a96e-d71a4d930353@amd.com>
In-Reply-To: <16131a10-b473-41cc-a96e-d71a4d930353@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 14 Jun 2024 00:02:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXExC47bMuRPatthoJQqAy=6fbN=5KZfEq05P+2dbLRcUA@mail.gmail.com>
Message-ID: <CAMj1kXExC47bMuRPatthoJQqAy=6fbN=5KZfEq05P+2dbLRcUA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/efi: Free EFI memory map only when installing a
 new one.
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Young <dyoung@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 at 22:05, Kalra, Ashish <ashish.kalra@amd.com> wrote:
>
> Hello Ard,
>
> On 6/12/2024 8:56 AM, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The logic in __efi_memmap_init() is shared between two different
> > execution flows:
> > - mapping the EFI memory map early or late into the kernel VA space, so
> >   that its entries can be accessed;
> > - cloning the EFI memory map in order to insert new entries that are
> >   created as a result of creating a memory reservation
> >   (efi_arch_mem_reserve())
> >
> > In the former case, the underlying memory containing the kernel's view
> > of the EFI memory map (which may be heavily modified by the kernel
> > itself on x86) is not modified at all, and the only thing that changes
> > is the virtual mapping of this memory, which is different between early
> > and late boot.
> >
> > In the latter case, an entirely new allocation is created that carries =
a
> > new, updated version of the kernel's view of the EFI memory map. When
> > installing this new version, the old version will no longer be
> > referenced, and if the memory was allocated by the kernel, it will leak
> > unless it gets freed.
> >
> > The logic that implements this freeing currently lives on the code path
> > that is shared between these two use cases, but it should only apply to
> > the latter. So move it to the correct spot.
> >
> > While at it, move __efi_memmap_free() into its only caller, and drop th=
e
> > dummy definition for non-x86 architectures, as that is no longer needed=
.
> >
> > Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Fixes: f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")
> > Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@=
amd.com
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > v3:
> > - don't move __efi_memmap_free() into what turned out not to be its onl=
y
> >   caller
> > - drop another CPP #define related to the dummy definition
> >
> > v2:
> > - free old memory map only after installing the new one succeeded
> > - move __efi_memmap_free() into its only caller
> > - drop obsolete dummy declaration from generic code
> >
> >  arch/x86/include/asm/efi.h     |  1 -
> >  arch/x86/platform/efi/memmap.c | 12 +++++++++++-
> >  drivers/firmware/efi/memmap.c  |  9 ---------
> >  3 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > index 1dc600fa3ba5..481096177500 100644
> > --- a/arch/x86/include/asm/efi.h
> > +++ b/arch/x86/include/asm/efi.h
> > @@ -401,7 +401,6 @@ extern int __init efi_memmap_alloc(unsigned int num=
_entries,
> >                                  struct efi_memory_map_data *data);
> >  extern void __efi_memmap_free(u64 phys, unsigned long size,
> >                             unsigned long flags);
> > -#define __efi_memmap_free __efi_memmap_free
> >
> >  extern int __init efi_memmap_install(struct efi_memory_map_data *data)=
;
> >  extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
> > diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/mem=
map.c
> > index 4ef20b49eb5e..6ed1935504b9 100644
> > --- a/arch/x86/platform/efi/memmap.c
> > +++ b/arch/x86/platform/efi/memmap.c
> > @@ -92,12 +92,22 @@ int __init efi_memmap_alloc(unsigned int num_entrie=
s,
> >   */
> >  int __init efi_memmap_install(struct efi_memory_map_data *data)
> >  {
> > +     unsigned long size =3D efi.memmap.desc_size * efi.memmap.nr_map;
> > +     unsigned long flags =3D efi.memmap.flags;
> > +     u64 phys =3D efi.memmap.phys_map;
> > +     int ret;
> > +
> >       efi_memmap_unmap();
> >
> >       if (efi_enabled(EFI_PARAVIRT))
> >               return 0;
> >
> > -     return __efi_memmap_init(data);
> > +     ret =3D __efi_memmap_init(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     __efi_memmap_free(phys, size, flags);
> > +     return 0;
> >  }
> >
> >  /**
> > diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memma=
p.c
> > index 3365944f7965..34109fd86c55 100644
> > --- a/drivers/firmware/efi/memmap.c
> > +++ b/drivers/firmware/efi/memmap.c
> > @@ -15,10 +15,6 @@
> >  #include <asm/early_ioremap.h>
> >  #include <asm/efi.h>
> >
> > -#ifndef __efi_memmap_free
> > -#define __efi_memmap_free(phys, size, flags) do { } while (0)
> > -#endif
> > -
> >  /**
> >   * __efi_memmap_init - Common code for mapping the EFI memory map
> >   * @data: EFI memory map data
> > @@ -51,11 +47,6 @@ int __init __efi_memmap_init(struct efi_memory_map_d=
ata *data)
> >               return -ENOMEM;
> >       }
> >
> > -     if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
> > -             __efi_memmap_free(efi.memmap.phys_map,
> > -                               efi.memmap.desc_size * efi.memmap.nr_ma=
p,
> > -                               efi.memmap.flags);
> > -
> >       map.phys_map =3D data->phys_map;
> >       map.nr_map =3D data->size / data->desc_size;
> >       map.map_end =3D map.map + data->size;
>
> Tested this patch with SNP guest kexec and i do not observe EFI memory ma=
p corruption with SNP guest kexec with this patch applied.
>
> Tested-by: Ashish Kalra <Ashish.Kalra@amd.com>
>

Thanks!

> I have another question related to the discussion on the following email =
thread:
>
> Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec - Da=
ve Young (kernel.org) <https://lore.kernel.org/all/CALu+AoQ2jNjb+5MZfFtpT_Y=
=3D2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com/><https://lore.kernel.org/all/=
CALu+AoQ2jNjb+5MZfFtpT_Y=3D2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com/>
>
> Do we still want to create another patch for skipping efi_arch_mem_reserv=
e() when the EFI_MEMORY_RUNTIME bit was set already ?
>

If it is not needed, let's not bother.

