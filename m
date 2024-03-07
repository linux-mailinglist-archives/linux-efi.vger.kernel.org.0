Return-Path: <linux-efi+bounces-772-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282A9875473
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D251828372B
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FF812FB15;
	Thu,  7 Mar 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFl8X5TF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AA12F5BD;
	Thu,  7 Mar 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830143; cv=none; b=LNccEIsJj5H+z3fzNBYr9tHxa3EoDZdrvRkW28l5znbPdAa2JRbd2ng8e7UL2HApEzm4fay0z14BbSJIMj9p2g9TjCuErh+tlZE1FY9VGY6zCXHYVS1BpRs40L1ZKParr/3nGQ5v5N3uYqbLhOMxRs7WxL3n2Yd755kzWm9Gs78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830143; c=relaxed/simple;
	bh=bGXZFdGS/RNVJi7lWH1UGeye9PjK4WOUDOWy34WpgMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj9NRg/udRo9pdVDMnUKJwOVBtyL2oC2xBmi2FSoKtXZMYLc7okXiFlSw5KxmBNI3aBhj1eEKxzI+EhALmNRJMADB8XdwhNiTZ4nQmPdtvBaIB/n1zmal6PJkPb75OU9jYA/GQPWRJTmb7kYsqgF4th9uNo4Hy/vHeePFzPGq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFl8X5TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AB1C433B1;
	Thu,  7 Mar 2024 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709830142;
	bh=bGXZFdGS/RNVJi7lWH1UGeye9PjK4WOUDOWy34WpgMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XFl8X5TFwf707o/wdagb6Bjffdtcvw6uIf9RdTm7wJTnwXAzLuAFiXDo0yPNNgyNS
	 YqUPALOeBG245VnW9rOdE5sXVYwDIaXNmuv5erhtRfbVhDmjlPo9Dm1k9FOhEuRCiT
	 fMlysdm/3Xe24f594KdgossXHSczgVCwueiq+cOO5OePs2Wb5mv8Wa+tse3I3iZn45
	 WhDnlJ6hntq7GN25fmSJTnC2L60dIhEURDS8QghX6a6bTeFD6IijSEA1/XTQHKrIJa
	 73KfoeoIeg1KtX9jozsaxniz/qdnRWKsG7O7XJRZ0+Ufgji4vCl9O4+za/79swD0QX
	 W8TLs4I4VKbUQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51340e89df1so1164573e87.1;
        Thu, 07 Mar 2024 08:49:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX53sbx9s+gn1ncNybIRg+7DZHAxiyBXlwpXnmdpx/fyRcIsHXsVzScuEzQojmTfvUYId+punNDCsXe/baKUGHKTbtfaaC9mpxT+TcSQSmJWscOGURUBbnx8PgRG5IreyoOPMXtanhm
X-Gm-Message-State: AOJu0YwUow/U0QirPn39MsDH5lQtg+zXTTThd79tj5RWgq444CeCueZh
	PBOgmuchyQoKnM9lW1k8l91A19LATXRK+qDTnX0kVH4ie5dY3lWLt+8ptulWqeIV1Eyl0RvV45b
	DuC9X/pEmz4mk5vLGtGIODbAiHEI=
X-Google-Smtp-Source: AGHT+IGHqIaoq6UC4dYQ48KRHV0PYDpHGBRgbgzKj5mSRGxFz3ei4Fb5ie9akjvh1UfC6e2loEpiHttdfnEf109FZyc=
X-Received: by 2002:ac2:4e97:0:b0:513:8a39:e0d9 with SMTP id
 o23-20020ac24e97000000b005138a39e0d9mr427359lfr.64.1709830140457; Thu, 07 Mar
 2024 08:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
 <mhng-c53211c1-4708-459a-bdc5-6e013c2adaee@palmer-ri-x1c9>
 <CAMj1kXEFqMx8qUHQEbg=OqbG-H0Zpj-nWu=a6qhhvNEZPO7f4Q@mail.gmail.com>
 <CAMj1kXG4SXsBfNqWMRUJ+AVv=6trWUAow-f8Mk5oKCpO=WueFg@mail.gmail.com> <CAEEQ3wkN3HDUuPDfWTn4kTxKH03OaRxBTFru3jJzZgW+BVhABg@mail.gmail.com>
In-Reply-To: <CAEEQ3wkN3HDUuPDfWTn4kTxKH03OaRxBTFru3jJzZgW+BVhABg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Mar 2024 17:48:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHuKbaXqWuFuMXhfL1_2w05CfJrk2uAPOW2HNHdpEnxXA@mail.gmail.com>
Message-ID: <CAMj1kXHuKbaXqWuFuMXhfL1_2w05CfJrk2uAPOW2HNHdpEnxXA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] efistub: fix missed the initialization
 of gp
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, 
	xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, samitolvanen@google.com, 
	bp@alien8.de, xiao.w.wang@intel.com, jan.kiszka@siemens.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Mar 2024 at 04:19, yunhui cui <cuiyunhui@bytedance.com> wrote:
>
> Hi Ard,
>
> On Thu, Mar 7, 2024 at 12:15=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Wed, 6 Mar 2024 at 16:44, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 6 Mar 2024 at 16:21, Palmer Dabbelt <palmer@dabbelt.com> wrot=
e:
> > > >
> > > > On Wed, 06 Mar 2024 05:09:07 PST (-0800), Ard Biesheuvel wrote:
> > > > > On Wed, 6 Mar 2024 at 14:02, Ard Biesheuvel <ardb@kernel.org> wro=
te:
> > > > >>
> > > > >> On Wed, 6 Mar 2024 at 13:34, yunhui cui <cuiyunhui@bytedance.com=
> wrote:
> > > > >> >
> > > > >> > Hi Ard,
> > > > >> >
> > > > >> > On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Ard Biesheuvel <ardb@ke=
rnel.org> wrote:
> > > > >> > >
> > > > >> > > On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > > > >> > > >
> > > > >> > > > Compared with gcc version 12, gcc version 13 uses the gp
> > > > >> > > > register for compilation optimization, but the efistub mod=
ule
> > > > >> > > > does not initialize gp.
> > > > >> > > >
> > > > >> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > >> > > > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
> > > > >> > >
> > > > >> > > This needs a sign-off, and your signoff needs to come after.
> > > > >> > >
> > > > >> > > > ---
> > > > >> > > >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
> > > > >> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > >> > > >
> > > > >> > > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/k=
ernel/efi-header.S
> > > > >> > > > index 515b2dfbca75..fa17c08c092a 100644
> > > > >> > > > --- a/arch/riscv/kernel/efi-header.S
> > > > >> > > > +++ b/arch/riscv/kernel/efi-header.S
> > > > >> > > > @@ -40,7 +40,7 @@ optional_header:
> > > > >> > > >         .long   __pecoff_data_virt_end - __pecoff_text_end=
      // SizeOfInitializedData
> > > > >> > > >  #endif
> > > > >> > > >         .long   0                                       //=
 SizeOfUninitializedData
> > > > >> > > > -       .long   __efistub_efi_pe_entry - _start         //=
 AddressOfEntryPoint
> > > > >> > > > +       .long   _efistub_entry - _start         // Address=
OfEntryPoint
> > > > >> > > >         .long   efi_header_end - _start                 //=
 BaseOfCode
> > > > >> > > >  #ifdef CONFIG_32BIT
> > > > >> > > >         .long  __pecoff_text_end - _start               //=
 BaseOfData
> > > > >> > > > @@ -121,4 +121,13 @@ section_table:
> > > > >> > > >
> > > > >> > > >         .balign 0x1000
> > > > >> > > >  efi_header_end:
> > > > >> > > > +
> > > > >> > > > +       .global _efistub_entry
> > > > >> > > > +_efistub_entry:
> > > > >> > >
> > > > >> > > This should go into .text or .init.text, not the header.
> > > > >> > >
> > > > >> > > > +       /* Reload the global pointer */
> > > > >> > > > +       load_global_pointer
> > > > >> > > > +
> > > > >> > >
> > > > >> > > What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=
=3Dy? The EFI
> > > > >> > > stub Makefile removes the SCS CFLAGS, so the stub will be bu=
ilt
> > > > >> > > without shadow call stack support, which I guess means that =
it might
> > > > >> > > use GP as a global pointer as usual?
> > > > >> > >
> > > > >> > > > +       call __efistub_efi_pe_entry
> > > > >> > > > +       ret
> > > > >> > > > +
> > > > >> > >
> > > > >> > > You are returning to the firmware here, but after modifying =
the GP
> > > > >> > > register. Shouldn't you restore it to its old value?
> > > > >> > There is no need to restore the value of the gp register. Wher=
e gp is
> > > > >> > needed, the gp register must first be initialized. And here is=
 the
> > > > >> > entry.
> > > > >> >
> > > > >>
> > > > >> But how should the firmware know that GP was corrupted after cal=
ling
> > > > >> the kernel's EFI entrypoint? The EFI stub can return to the firm=
ware
> > > > >> if it encounters any errors while still running in the EFI boot
> > > > >> services.
> > > > >>
> > > > >
> > > > > Actually, I wonder if GP can be modified at all before
> > > > > ExitBootServices(). The EFI timer interrupt is still live at this
> > > > > point, and so the firmware is being called behind your back, and =
might
> > > > > rely on GP retaining its original value.
> > > >
> > > > [A few of us are talking on IRC as I'm writing this...]
> > > >
> > > > The UEFI spec says "UEFI firmware must neither trust the
> > > > values of tp and gp nor make an assumption of owning the write acce=
ss to
> > > > these register in any circumstances".  It's kind of vague what "UEF=
I
> > > > firmware" means here, but I think it's reasonable to assume that th=
e
> > > > kernel (and thus the EFI stub) is not included there.
> > > >
> > > > So under that interpretation, the kernel (including the EFI stub) w=
ould
> > > > be allowed to overwrite GP with whatever it wants.
> > > >
> > >
> > > OK, so even if the UEFI spec seems to suggest that using GP in EFI
> > > applications such as the Linux EFI stub should be safe, I'd still lik=
e
> > > to understand why this change is necessary. The patches you are
> > > reverting are supposed to ensure that a) the compiler does not
> > > generate references that can be relaxed to GP based ones, and b) no
> > > R_RISCV_RELAX relocations are present in any of the code that runs in
> > > the context of the EFI firmware.
> > >
> > > Are you still seeing GP based symbol references? Is there C code that
> > > gets pulled into the EFI stub that uses GP based relocations perhaps?
> > > (see list below). If any of those are implemented in C, they should
> > > not be used by the EFI stub directly unless they are guaranteed to be
> > > uninstrumented and callable at arbitrary offsets other than the one
> > > they were linked to run at.
> > >
> > >
> > > __efistub_memcmp         =3D memcmp;
> > > __efistub_memchr         =3D memchr;
> > > __efistub_memcpy         =3D memcpy;
> > > __efistub_memmove        =3D memmove;
> > > __efistub_memset         =3D memset;
> > > __efistub_strlen         =3D strlen;
> > > __efistub_strnlen        =3D strnlen;
> > > __efistub_strcmp         =3D strcmp;
> > > __efistub_strncmp        =3D strncmp;
> > > __efistub_strrchr        =3D strrchr;
> > > __efistub___memcpy       =3D memcpy;
> > > __efistub___memmove      =3D memmove;
> > > __efistub___memset       =3D memset;
> > > __efistub__start         =3D _start;
> > > __efistub__start_kernel  =3D _start_kernel;
> > >
> > > (from arch/riscv/kernel/image-vars.h)
> >
> > Uhm never mind - these are all gone now, I was looking at a v6.1
> > kernel source tree.
> >
> > So that means that, as far as I can tell, the only kernel C code that
> > executes in the context of the EFI firmware is built with -mno-relax
> > and is checked for the absence of R_RISCV_RELAX relocations. So I fail
> > to see why these changes are needed.
> >
> > Yunhui, could you please explain the reason for this series?
>
> From the logic of binutils, if "__global_pointer$" exists, it is
> possible to use GP for optimization. For RISC-V, "__global_pointer$"
> was introduced in commit "fbe934d69eb7e". Therefore, for the system as
> a whole, we should keep using GP uniformly.

There is no 'system as a whole' that can use GP 'uniformly'

The EFI stub is a separate executable that runs from a different
mapping of memory, in an execution context managed by the firmware. It
happens to be linked into the same executable as the vmlinux kernel.

> The root cause of this
> problem is that GP is not loaded, rather than "On RISC-V, we also
> avoid GP based relocations..." as commit "d2baf8cc82c17" said.

GP is not loaded because in the EFI firmware context, there is no safe
way to rely on it.

> We need
> to address problems head-on, rather than avoid them.
>

So what solution are you proposing for the potential GP conflicts
between the boot loader, the Linux EFI stub and the firmware?

