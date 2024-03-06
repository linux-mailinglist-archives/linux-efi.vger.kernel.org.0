Return-Path: <linux-efi+bounces-753-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAC2873BE3
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 17:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0478BB245DB
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDC2136643;
	Wed,  6 Mar 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJc/pkpj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23859134733;
	Wed,  6 Mar 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741749; cv=none; b=YPF/xqtTv8B6oXwMn0N/O3+OZVJ+q+q9maZOuj5B+PZzBDTGUJ1xHUKQHY2dwh2o+122B/vfQ3aRwhilWY9MpiRwX0enhfZOvmaOua9Rzs8xFsKYlNMkjr2ss6xr17HLdWnH/lDqHvQjaMt5HsI4OEX+0MYTQmpBC4EHuh3h7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741749; c=relaxed/simple;
	bh=9TDFN1nLS5vzHXXEb+683QRaxfk5FDzO3wQOrqruukk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtwHj+9aiBXmEqvtL2VdteWC5mKUXdNtPWRj6Opdoweye4+TJKLPUdqA7c3FVKGPnrOAcKvtUerNdQSu12tnov4e6unXG2wIHRQqmEQYCntHGEZiWuHVgVgkRlgUSGM8oY3K37WUSiBc3stixkeZIBJ3RpTfoT+rL59e4PBQjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJc/pkpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A997BC433B2;
	Wed,  6 Mar 2024 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709741748;
	bh=9TDFN1nLS5vzHXXEb+683QRaxfk5FDzO3wQOrqruukk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WJc/pkpj0EkKbMhp/ITE2LWkUfVJ/bxv/dKJqUkBQLIDRaQaXnhfLAjHmYk8I8NUZ
	 uSZbHZAiFnl9TDK5oGeWe/57I1lkUNYbQ775Xr9LhvFATsD/H4+YPFP9jMD/gSdT+U
	 AkJZ7J7EeXiy7d9iYrYOyOb2FDVrP7Vv3H/+RZDCsfLTqy6GN5IhotF2rd2WhJrVd9
	 wARrQ5yEfUR/OdOmd4uo92n0p0ecvby1Mao1xBFOqazGpDQytUL9fuvxcJ0SfJccvV
	 xGauP7EbOps9Qzt7WeVM7w2jbG/FJt8c46Dc+bcVYjQH7Ayi2uNObfGU57DbpaZAH/
	 sQ4VJPkLmsPsQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51336ab1fb7so6144501e87.1;
        Wed, 06 Mar 2024 08:15:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYjOeeyWV4kf1FxphIW3d033DNzA95hiP69MXHH1GEqUMeaGv+h6CNWUSQeZvmF3OtzlEfcit7ksV+wc0Hcx01Q/cBNQIDMDY/kZEBVuG+IFYJ/QdF7jOLmOXM1azwt+32iM3zQYM6
X-Gm-Message-State: AOJu0YyfTVMUryVEN/i3R6yr4rUt6SxrQVYZteKHA/TxW8HAfLYSXp1E
	Vf7p0bF0VQfWt3jcIaCpWPef67oM4dfDqc0K+9EZOZDRPJ+H4t0NfgmcoOdur++JQO0umIGU9Mh
	WEl/YjMDc4yJ3HnNDyo0nShgUYVo=
X-Google-Smtp-Source: AGHT+IEDXj5oWHWFn9P3DjO+pLhu1y5R5pH2z+Rft3zLjcvHIfM6k/Q+JmWOlFa8GhR35YR3+SEaqocewfA65j5tIBQ=
X-Received: by 2002:ac2:5de1:0:b0:513:523b:6e20 with SMTP id
 z1-20020ac25de1000000b00513523b6e20mr3499389lfq.23.1709741746708; Wed, 06 Mar
 2024 08:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
 <mhng-c53211c1-4708-459a-bdc5-6e013c2adaee@palmer-ri-x1c9> <CAMj1kXEFqMx8qUHQEbg=OqbG-H0Zpj-nWu=a6qhhvNEZPO7f4Q@mail.gmail.com>
In-Reply-To: <CAMj1kXEFqMx8qUHQEbg=OqbG-H0Zpj-nWu=a6qhhvNEZPO7f4Q@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 6 Mar 2024 17:15:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG4SXsBfNqWMRUJ+AVv=6trWUAow-f8Mk5oKCpO=WueFg@mail.gmail.com>
Message-ID: <CAMj1kXG4SXsBfNqWMRUJ+AVv=6trWUAow-f8Mk5oKCpO=WueFg@mail.gmail.com>
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

On Wed, 6 Mar 2024 at 16:44, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 6 Mar 2024 at 16:21, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Wed, 06 Mar 2024 05:09:07 PST (-0800), Ard Biesheuvel wrote:
> > > On Wed, 6 Mar 2024 at 14:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>
> > >> On Wed, 6 Mar 2024 at 13:34, yunhui cui <cuiyunhui@bytedance.com> wr=
ote:
> > >> >
> > >> > Hi Ard,
> > >> >
> > >> > On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Ard Biesheuvel <ardb@kernel=
.org> wrote:
> > >> > >
> > >> > > On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
> > >> > > >
> > >> > > > Compared with gcc version 12, gcc version 13 uses the gp
> > >> > > > register for compilation optimization, but the efistub module
> > >> > > > does not initialize gp.
> > >> > > >
> > >> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > >> > > > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
> > >> > >
> > >> > > This needs a sign-off, and your signoff needs to come after.
> > >> > >
> > >> > > > ---
> > >> > > >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
> > >> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >> > > >
> > >> > > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kerne=
l/efi-header.S
> > >> > > > index 515b2dfbca75..fa17c08c092a 100644
> > >> > > > --- a/arch/riscv/kernel/efi-header.S
> > >> > > > +++ b/arch/riscv/kernel/efi-header.S
> > >> > > > @@ -40,7 +40,7 @@ optional_header:
> > >> > > >         .long   __pecoff_data_virt_end - __pecoff_text_end    =
  // SizeOfInitializedData
> > >> > > >  #endif
> > >> > > >         .long   0                                       // Siz=
eOfUninitializedData
> > >> > > > -       .long   __efistub_efi_pe_entry - _start         // Add=
ressOfEntryPoint
> > >> > > > +       .long   _efistub_entry - _start         // AddressOfEn=
tryPoint
> > >> > > >         .long   efi_header_end - _start                 // Bas=
eOfCode
> > >> > > >  #ifdef CONFIG_32BIT
> > >> > > >         .long  __pecoff_text_end - _start               // Bas=
eOfData
> > >> > > > @@ -121,4 +121,13 @@ section_table:
> > >> > > >
> > >> > > >         .balign 0x1000
> > >> > > >  efi_header_end:
> > >> > > > +
> > >> > > > +       .global _efistub_entry
> > >> > > > +_efistub_entry:
> > >> > >
> > >> > > This should go into .text or .init.text, not the header.
> > >> > >
> > >> > > > +       /* Reload the global pointer */
> > >> > > > +       load_global_pointer
> > >> > > > +
> > >> > >
> > >> > > What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=3Dy?=
 The EFI
> > >> > > stub Makefile removes the SCS CFLAGS, so the stub will be built
> > >> > > without shadow call stack support, which I guess means that it m=
ight
> > >> > > use GP as a global pointer as usual?
> > >> > >
> > >> > > > +       call __efistub_efi_pe_entry
> > >> > > > +       ret
> > >> > > > +
> > >> > >
> > >> > > You are returning to the firmware here, but after modifying the =
GP
> > >> > > register. Shouldn't you restore it to its old value?
> > >> > There is no need to restore the value of the gp register. Where gp=
 is
> > >> > needed, the gp register must first be initialized. And here is the
> > >> > entry.
> > >> >
> > >>
> > >> But how should the firmware know that GP was corrupted after calling
> > >> the kernel's EFI entrypoint? The EFI stub can return to the firmware
> > >> if it encounters any errors while still running in the EFI boot
> > >> services.
> > >>
> > >
> > > Actually, I wonder if GP can be modified at all before
> > > ExitBootServices(). The EFI timer interrupt is still live at this
> > > point, and so the firmware is being called behind your back, and migh=
t
> > > rely on GP retaining its original value.
> >
> > [A few of us are talking on IRC as I'm writing this...]
> >
> > The UEFI spec says "UEFI firmware must neither trust the
> > values of tp and gp nor make an assumption of owning the write access t=
o
> > these register in any circumstances".  It's kind of vague what "UEFI
> > firmware" means here, but I think it's reasonable to assume that the
> > kernel (and thus the EFI stub) is not included there.
> >
> > So under that interpretation, the kernel (including the EFI stub) would
> > be allowed to overwrite GP with whatever it wants.
> >
>
> OK, so even if the UEFI spec seems to suggest that using GP in EFI
> applications such as the Linux EFI stub should be safe, I'd still like
> to understand why this change is necessary. The patches you are
> reverting are supposed to ensure that a) the compiler does not
> generate references that can be relaxed to GP based ones, and b) no
> R_RISCV_RELAX relocations are present in any of the code that runs in
> the context of the EFI firmware.
>
> Are you still seeing GP based symbol references? Is there C code that
> gets pulled into the EFI stub that uses GP based relocations perhaps?
> (see list below). If any of those are implemented in C, they should
> not be used by the EFI stub directly unless they are guaranteed to be
> uninstrumented and callable at arbitrary offsets other than the one
> they were linked to run at.
>
>
> __efistub_memcmp         =3D memcmp;
> __efistub_memchr         =3D memchr;
> __efistub_memcpy         =3D memcpy;
> __efistub_memmove        =3D memmove;
> __efistub_memset         =3D memset;
> __efistub_strlen         =3D strlen;
> __efistub_strnlen        =3D strnlen;
> __efistub_strcmp         =3D strcmp;
> __efistub_strncmp        =3D strncmp;
> __efistub_strrchr        =3D strrchr;
> __efistub___memcpy       =3D memcpy;
> __efistub___memmove      =3D memmove;
> __efistub___memset       =3D memset;
> __efistub__start         =3D _start;
> __efistub__start_kernel  =3D _start_kernel;
>
> (from arch/riscv/kernel/image-vars.h)

Uhm never mind - these are all gone now, I was looking at a v6.1
kernel source tree.

So that means that, as far as I can tell, the only kernel C code that
executes in the context of the EFI firmware is built with -mno-relax
and is checked for the absence of R_RISCV_RELAX relocations. So I fail
to see why these changes are needed.

Yunhui, could you please explain the reason for this series?

