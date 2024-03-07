Return-Path: <linux-efi+bounces-755-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B278746AB
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 04:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD381C2224E
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 03:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D6DF55;
	Thu,  7 Mar 2024 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NM3a8GuP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4751B7F7
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781580; cv=none; b=YXMrPCmVnNgBR5G8Vb5nBiUiwVsTlhsLbv5hKUut1kXderdNUdjdQrabFLm93MCx2XQflS32TfPliYv1fLvFOlY0j8GeN9Fve6jsFEKWiEqMlr5HwxjJsCq3raUp9AGj5rScQ9+rYqLAek/xTn8d7J4Wq5aihxG7x7cZXeDhxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781580; c=relaxed/simple;
	bh=2C88qV+fxIBbpmK+jFwOWYwyMdx0WzXNpACjvByuKIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a89zURXOi+FTI27UK7Djvd8O2RlepdWHt9UYVBgyjgf4D4vRC6Pp3jZS0/4bdxvJtdxS7YxleUOJDYlbkiH+Q3tkYieeT7SXHDMk/jZjm3RaR2JlU3E9QPIqXTDoOq1pMh6N3CTnawdLM6rP4K8uk7zemHawZ4MaD5SMQY9EyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NM3a8GuP; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21fa872dce3so204863fac.2
        for <linux-efi@vger.kernel.org>; Wed, 06 Mar 2024 19:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709781577; x=1710386377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJGvA1f7vKRh3tCkcbglNtzIq8rFLROAN/5bMKhQkTg=;
        b=NM3a8GuPQexXnH1MDHNTmkR95OocXfh7kWDccrmC6v6ozCc5/8B/uvOYDnl06J++gg
         GbJwgpY7jQ7ePmv/sHbZDugLhX4cZyuaf5KLNGriGytoSs4rAt/ogrt8pj2ab6/W6IsH
         GEQyNJbpovEkF28rA9vSOshBE2ptTNnJnOlg9qyD6GPNl1SH3G4MhFFIHbtBVzc7Bk5D
         6vmNQHgkJGstMhn+lM3pMek342D3L8D6PSiyuqZzfqpGWnegGAZQlMtdv4Gwd/H16Jg6
         sHDwSBbntV0r42kUzrnqFF0ipTxXSPIqTLKjktvt+gR5SNep/gYDMx3Aqh45Zfy/6qKs
         /7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709781577; x=1710386377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJGvA1f7vKRh3tCkcbglNtzIq8rFLROAN/5bMKhQkTg=;
        b=nk+pddJfQPPYB6zDrJREBo69QgGFXD5fyy4LdI+f9+5baEoTSLXJKGPPlz+WZ9zSZS
         5txYZWUAEcWOmzPav+8bRqVt88Liu1BRx1OoCrRUP9mT0CbSpNn8Ul97dRF/I7+Mrr0+
         e8IpdchDeRxVpKGysLBcfQKlIxFcp7iIM1tMcJedBMCJrppYGgK569f8fb05OmK497b6
         8h42HFVNF/5pqmGxi4BP8l5f09OlV521Fd0ZC43V9wfeGx7tSTZ3BOFVshW3gs6Y52hM
         tj2GTGYDYFFPcP5aUIQTMVnPHKl8TVJfSkL8eFJ9bsTegkYa7pPqLiDfq0u0v6TgCEqA
         cJSA==
X-Forwarded-Encrypted: i=1; AJvYcCWLqXf8HBzW9oFVYomino5u1tirVmQ6cf+P261aAm09QyWg9BoFZK8w3TGk/XuOnXcyK46oxFdXS1J+SO1hd8T8hoiYOBF+cLlA
X-Gm-Message-State: AOJu0YyGMBgok8LipZz7GNrMdFlVwUk82Kd1UTvIdndFp6UElJKa0eYz
	z8YcTRwRKzixSJ36S5VDXd/bGictwoMS9u2+Aiv32H9P949SDo/B+HE7+sR931E2op22GVB64kg
	T1qqhvDgZQwhBlO3I/mSEk+3Er/PAInim/CW4QQ==
X-Google-Smtp-Source: AGHT+IFY13j0u68bFIORwkMkdH6ODO/zQ9SH+109GglozC611Ks1AmA61dWksvu8K9ufjtIT4F4LCd6h7ApZ15aRObk=
X-Received: by 2002:a05:6870:4181:b0:220:8c16:fe1b with SMTP id
 y1-20020a056870418100b002208c16fe1bmr7006609oac.40.1709781577510; Wed, 06 Mar
 2024 19:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
 <mhng-c53211c1-4708-459a-bdc5-6e013c2adaee@palmer-ri-x1c9>
 <CAMj1kXEFqMx8qUHQEbg=OqbG-H0Zpj-nWu=a6qhhvNEZPO7f4Q@mail.gmail.com> <CAMj1kXG4SXsBfNqWMRUJ+AVv=6trWUAow-f8Mk5oKCpO=WueFg@mail.gmail.com>
In-Reply-To: <CAMj1kXG4SXsBfNqWMRUJ+AVv=6trWUAow-f8Mk5oKCpO=WueFg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 7 Mar 2024 11:19:26 +0800
Message-ID: <CAEEQ3wkN3HDUuPDfWTn4kTxKH03OaRxBTFru3jJzZgW+BVhABg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] efistub: fix missed the initialization
 of gp
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, 
	xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, samitolvanen@google.com, 
	bp@alien8.de, xiao.w.wang@intel.com, jan.kiszka@siemens.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On Thu, Mar 7, 2024 at 12:15=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Wed, 6 Mar 2024 at 16:44, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 6 Mar 2024 at 16:21, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >
> > > On Wed, 06 Mar 2024 05:09:07 PST (-0800), Ard Biesheuvel wrote:
> > > > On Wed, 6 Mar 2024 at 14:02, Ard Biesheuvel <ardb@kernel.org> wrote=
:
> > > >>
> > > >> On Wed, 6 Mar 2024 at 13:34, yunhui cui <cuiyunhui@bytedance.com> =
wrote:
> > > >> >
> > > >> > Hi Ard,
> > > >> >
> > > >> > On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Ard Biesheuvel <ardb@kern=
el.org> wrote:
> > > >> > >
> > > >> > > On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> > > >> > > >
> > > >> > > > Compared with gcc version 12, gcc version 13 uses the gp
> > > >> > > > register for compilation optimization, but the efistub modul=
e
> > > >> > > > does not initialize gp.
> > > >> > > >
> > > >> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > >> > > > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
> > > >> > >
> > > >> > > This needs a sign-off, and your signoff needs to come after.
> > > >> > >
> > > >> > > > ---
> > > >> > > >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
> > > >> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >> > > >
> > > >> > > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/ker=
nel/efi-header.S
> > > >> > > > index 515b2dfbca75..fa17c08c092a 100644
> > > >> > > > --- a/arch/riscv/kernel/efi-header.S
> > > >> > > > +++ b/arch/riscv/kernel/efi-header.S
> > > >> > > > @@ -40,7 +40,7 @@ optional_header:
> > > >> > > >         .long   __pecoff_data_virt_end - __pecoff_text_end  =
    // SizeOfInitializedData
> > > >> > > >  #endif
> > > >> > > >         .long   0                                       // S=
izeOfUninitializedData
> > > >> > > > -       .long   __efistub_efi_pe_entry - _start         // A=
ddressOfEntryPoint
> > > >> > > > +       .long   _efistub_entry - _start         // AddressOf=
EntryPoint
> > > >> > > >         .long   efi_header_end - _start                 // B=
aseOfCode
> > > >> > > >  #ifdef CONFIG_32BIT
> > > >> > > >         .long  __pecoff_text_end - _start               // B=
aseOfData
> > > >> > > > @@ -121,4 +121,13 @@ section_table:
> > > >> > > >
> > > >> > > >         .balign 0x1000
> > > >> > > >  efi_header_end:
> > > >> > > > +
> > > >> > > > +       .global _efistub_entry
> > > >> > > > +_efistub_entry:
> > > >> > >
> > > >> > > This should go into .text or .init.text, not the header.
> > > >> > >
> > > >> > > > +       /* Reload the global pointer */
> > > >> > > > +       load_global_pointer
> > > >> > > > +
> > > >> > >
> > > >> > > What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=3D=
y? The EFI
> > > >> > > stub Makefile removes the SCS CFLAGS, so the stub will be buil=
t
> > > >> > > without shadow call stack support, which I guess means that it=
 might
> > > >> > > use GP as a global pointer as usual?
> > > >> > >
> > > >> > > > +       call __efistub_efi_pe_entry
> > > >> > > > +       ret
> > > >> > > > +
> > > >> > >
> > > >> > > You are returning to the firmware here, but after modifying th=
e GP
> > > >> > > register. Shouldn't you restore it to its old value?
> > > >> > There is no need to restore the value of the gp register. Where =
gp is
> > > >> > needed, the gp register must first be initialized. And here is t=
he
> > > >> > entry.
> > > >> >
> > > >>
> > > >> But how should the firmware know that GP was corrupted after calli=
ng
> > > >> the kernel's EFI entrypoint? The EFI stub can return to the firmwa=
re
> > > >> if it encounters any errors while still running in the EFI boot
> > > >> services.
> > > >>
> > > >
> > > > Actually, I wonder if GP can be modified at all before
> > > > ExitBootServices(). The EFI timer interrupt is still live at this
> > > > point, and so the firmware is being called behind your back, and mi=
ght
> > > > rely on GP retaining its original value.
> > >
> > > [A few of us are talking on IRC as I'm writing this...]
> > >
> > > The UEFI spec says "UEFI firmware must neither trust the
> > > values of tp and gp nor make an assumption of owning the write access=
 to
> > > these register in any circumstances".  It's kind of vague what "UEFI
> > > firmware" means here, but I think it's reasonable to assume that the
> > > kernel (and thus the EFI stub) is not included there.
> > >
> > > So under that interpretation, the kernel (including the EFI stub) wou=
ld
> > > be allowed to overwrite GP with whatever it wants.
> > >
> >
> > OK, so even if the UEFI spec seems to suggest that using GP in EFI
> > applications such as the Linux EFI stub should be safe, I'd still like
> > to understand why this change is necessary. The patches you are
> > reverting are supposed to ensure that a) the compiler does not
> > generate references that can be relaxed to GP based ones, and b) no
> > R_RISCV_RELAX relocations are present in any of the code that runs in
> > the context of the EFI firmware.
> >
> > Are you still seeing GP based symbol references? Is there C code that
> > gets pulled into the EFI stub that uses GP based relocations perhaps?
> > (see list below). If any of those are implemented in C, they should
> > not be used by the EFI stub directly unless they are guaranteed to be
> > uninstrumented and callable at arbitrary offsets other than the one
> > they were linked to run at.
> >
> >
> > __efistub_memcmp         =3D memcmp;
> > __efistub_memchr         =3D memchr;
> > __efistub_memcpy         =3D memcpy;
> > __efistub_memmove        =3D memmove;
> > __efistub_memset         =3D memset;
> > __efistub_strlen         =3D strlen;
> > __efistub_strnlen        =3D strnlen;
> > __efistub_strcmp         =3D strcmp;
> > __efistub_strncmp        =3D strncmp;
> > __efistub_strrchr        =3D strrchr;
> > __efistub___memcpy       =3D memcpy;
> > __efistub___memmove      =3D memmove;
> > __efistub___memset       =3D memset;
> > __efistub__start         =3D _start;
> > __efistub__start_kernel  =3D _start_kernel;
> >
> > (from arch/riscv/kernel/image-vars.h)
>
> Uhm never mind - these are all gone now, I was looking at a v6.1
> kernel source tree.
>
> So that means that, as far as I can tell, the only kernel C code that
> executes in the context of the EFI firmware is built with -mno-relax
> and is checked for the absence of R_RISCV_RELAX relocations. So I fail
> to see why these changes are needed.
>
> Yunhui, could you please explain the reason for this series?

From the logic of binutils, if "__global_pointer$" exists, it is
possible to use GP for optimization. For RISC-V, "__global_pointer$"
was introduced in commit "fbe934d69eb7e". Therefore, for the system as
a whole, we should keep using GP uniformly. The root cause of this
problem is that GP is not loaded, rather than "On RISC-V, we also
avoid GP based relocations..." as commit "d2baf8cc82c17" said. We need
to address problems head-on, rather than avoid them.

Thanks,
Yunhui

