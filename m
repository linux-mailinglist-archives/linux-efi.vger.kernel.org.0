Return-Path: <linux-efi+bounces-752-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF2873B0B
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 16:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A2728548D
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8CE13540E;
	Wed,  6 Mar 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt9qKUxp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F7F1353FC;
	Wed,  6 Mar 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739895; cv=none; b=ACPWDhhnljV9pyKJoQ8qUe96Mc+gD5x8qEs6YGMV7nS9cp2UBNHqENnomFWgwr5MXDpmHZRjTWLcEiKzi5c7yY5yYUlzlMUzSckg0/jz8ohzv1pIt1U5p/y3kTHvJwrQ5J5upD8TSIapnAuAsdu8GL7ZfPN9jEF3XmE9Ivzo4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739895; c=relaxed/simple;
	bh=xAMk5pyQz9UpONsmW/NTVfslqq+/KWb7t3IHJQofhDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yu8mkFFjqwdlkV1GzrChUHC76F2LGqOPvh53A0xaKpTxV5c9FVDc+AR7XvIsIkd6fvY+lt4mEVbfQ6LeSoIakxVB853WMY4ARNSMw+mlmAoy7RzaTpnaF8jScycsGZcnDGu5WTWNPvclmt6MHf+75jg0qyLEXsc5BJQhDhXzC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt9qKUxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A38C433B1;
	Wed,  6 Mar 2024 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709739894;
	bh=xAMk5pyQz9UpONsmW/NTVfslqq+/KWb7t3IHJQofhDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bt9qKUxpXeQbrb3YWiQG107FywHj/KBKWMw0SlOwakgqbFM5qD08sPyDiZH4wjlek
	 HEJgKL2jFfFLlL485CVPWXisPcoBiMCU/sa5Po2HmrcHO8pnNUs1WdfuONH/h9BQMI
	 WfyiKCITC7HP60eexhpGpwKo4+YfLEt1SAIASxTIhhOkFUGGJSss68mjn9vkH5JY0W
	 G8ag3DY1HdnMu+cNgJDH9dteyZwUcHC1wdDtHRgik6NzjKfLwhnfuAcVOc9jkjEjsJ
	 fOat8NPPi3zWTNZMA30t2CNSBh/Edn88hjUun4/gq+0pw/2G92Y4bBFBsn+foL17Gs
	 fk2eqzYXOcCzQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5101cd91017so9817202e87.2;
        Wed, 06 Mar 2024 07:44:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+6T0lEQCGYA/HLYsqY4RTKMzqyuyarI5vyto0pBilJ+ba22P1Hn7RshyvTUZEuxBvJIGjT4K0tOGEvbPggcZrpjZNTC9XeKb5pGJTb6iBlKHDeIF0FUyCMrGF7yHS2mQKKIH3Y6P5
X-Gm-Message-State: AOJu0Yx8Af9HadAwP2gSgy2ZnLSy3CyrQQKRM4wkPQkQDTqaBoFHzFye
	XVDhOpVkKKNer3lPQWceNjRbTlGiqKKaxsTJmdCo/dgi7HQ9XDRsry68QjwQHadfvqJzNLPbf0U
	4QG4NbpmExAc6+1QR0TKxLtTZmuY=
X-Google-Smtp-Source: AGHT+IG8a8zdHPmm0jfwc6beeYzok7P50PDp5pIcrT+wKrTKH+ZlY8xyBP2Rqn0K0ZEENyJUCPedUS9me5kcZsP5RfI=
X-Received: by 2002:a05:6512:e98:b0:513:59fb:1a50 with SMTP id
 bi24-20020a0565120e9800b0051359fb1a50mr3067541lfb.54.1709739892821; Wed, 06
 Mar 2024 07:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
 <mhng-c53211c1-4708-459a-bdc5-6e013c2adaee@palmer-ri-x1c9>
In-Reply-To: <mhng-c53211c1-4708-459a-bdc5-6e013c2adaee@palmer-ri-x1c9>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 6 Mar 2024 16:44:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEFqMx8qUHQEbg=OqbG-H0Zpj-nWu=a6qhhvNEZPO7f4Q@mail.gmail.com>
Message-ID: <CAMj1kXEFqMx8qUHQEbg=OqbG-H0Zpj-nWu=a6qhhvNEZPO7f4Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] efistub: fix missed the initialization
 of gp
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: cuiyunhui@bytedance.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	aou@eecs.berkeley.edu, xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, bp@alien8.de, xiao.w.wang@intel.com, 
	jan.kiszka@siemens.com, kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 at 16:21, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 06 Mar 2024 05:09:07 PST (-0800), Ard Biesheuvel wrote:
> > On Wed, 6 Mar 2024 at 14:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Wed, 6 Mar 2024 at 13:34, yunhui cui <cuiyunhui@bytedance.com> wrot=
e:
> >> >
> >> > Hi Ard,
> >> >
> >> > On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
> >> > >
> >> > > On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance.com> =
wrote:
> >> > > >
> >> > > > Compared with gcc version 12, gcc version 13 uses the gp
> >> > > > register for compilation optimization, but the efistub module
> >> > > > does not initialize gp.
> >> > > >
> >> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >> > > > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
> >> > >
> >> > > This needs a sign-off, and your signoff needs to come after.
> >> > >
> >> > > > ---
> >> > > >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
> >> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> >> > > >
> >> > > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/=
efi-header.S
> >> > > > index 515b2dfbca75..fa17c08c092a 100644
> >> > > > --- a/arch/riscv/kernel/efi-header.S
> >> > > > +++ b/arch/riscv/kernel/efi-header.S
> >> > > > @@ -40,7 +40,7 @@ optional_header:
> >> > > >         .long   __pecoff_data_virt_end - __pecoff_text_end      =
// SizeOfInitializedData
> >> > > >  #endif
> >> > > >         .long   0                                       // SizeO=
fUninitializedData
> >> > > > -       .long   __efistub_efi_pe_entry - _start         // Addre=
ssOfEntryPoint
> >> > > > +       .long   _efistub_entry - _start         // AddressOfEntr=
yPoint
> >> > > >         .long   efi_header_end - _start                 // BaseO=
fCode
> >> > > >  #ifdef CONFIG_32BIT
> >> > > >         .long  __pecoff_text_end - _start               // BaseO=
fData
> >> > > > @@ -121,4 +121,13 @@ section_table:
> >> > > >
> >> > > >         .balign 0x1000
> >> > > >  efi_header_end:
> >> > > > +
> >> > > > +       .global _efistub_entry
> >> > > > +_efistub_entry:
> >> > >
> >> > > This should go into .text or .init.text, not the header.
> >> > >
> >> > > > +       /* Reload the global pointer */
> >> > > > +       load_global_pointer
> >> > > > +
> >> > >
> >> > > What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=3Dy? T=
he EFI
> >> > > stub Makefile removes the SCS CFLAGS, so the stub will be built
> >> > > without shadow call stack support, which I guess means that it mig=
ht
> >> > > use GP as a global pointer as usual?
> >> > >
> >> > > > +       call __efistub_efi_pe_entry
> >> > > > +       ret
> >> > > > +
> >> > >
> >> > > You are returning to the firmware here, but after modifying the GP
> >> > > register. Shouldn't you restore it to its old value?
> >> > There is no need to restore the value of the gp register. Where gp i=
s
> >> > needed, the gp register must first be initialized. And here is the
> >> > entry.
> >> >
> >>
> >> But how should the firmware know that GP was corrupted after calling
> >> the kernel's EFI entrypoint? The EFI stub can return to the firmware
> >> if it encounters any errors while still running in the EFI boot
> >> services.
> >>
> >
> > Actually, I wonder if GP can be modified at all before
> > ExitBootServices(). The EFI timer interrupt is still live at this
> > point, and so the firmware is being called behind your back, and might
> > rely on GP retaining its original value.
>
> [A few of us are talking on IRC as I'm writing this...]
>
> The UEFI spec says "UEFI firmware must neither trust the
> values of tp and gp nor make an assumption of owning the write access to
> these register in any circumstances".  It's kind of vague what "UEFI
> firmware" means here, but I think it's reasonable to assume that the
> kernel (and thus the EFI stub) is not included there.
>
> So under that interpretation, the kernel (including the EFI stub) would
> be allowed to overwrite GP with whatever it wants.
>

OK, so even if the UEFI spec seems to suggest that using GP in EFI
applications such as the Linux EFI stub should be safe, I'd still like
to understand why this change is necessary. The patches you are
reverting are supposed to ensure that a) the compiler does not
generate references that can be relaxed to GP based ones, and b) no
R_RISCV_RELAX relocations are present in any of the code that runs in
the context of the EFI firmware.

Are you still seeing GP based symbol references? Is there C code that
gets pulled into the EFI stub that uses GP based relocations perhaps?
(see list below). If any of those are implemented in C, they should
not be used by the EFI stub directly unless they are guaranteed to be
uninstrumented and callable at arbitrary offsets other than the one
they were linked to run at.


__efistub_memcmp         =3D memcmp;
__efistub_memchr         =3D memchr;
__efistub_memcpy         =3D memcpy;
__efistub_memmove        =3D memmove;
__efistub_memset         =3D memset;
__efistub_strlen         =3D strlen;
__efistub_strnlen        =3D strnlen;
__efistub_strcmp         =3D strcmp;
__efistub_strncmp        =3D strncmp;
__efistub_strrchr        =3D strrchr;
__efistub___memcpy       =3D memcpy;
__efistub___memmove      =3D memmove;
__efistub___memset       =3D memset;
__efistub__start         =3D _start;
__efistub__start_kernel  =3D _start_kernel;

(from arch/riscv/kernel/image-vars.h)

