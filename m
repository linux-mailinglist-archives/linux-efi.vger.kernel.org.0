Return-Path: <linux-efi+bounces-775-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81E1875E40
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 08:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBBD1C209C3
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0E4EB30;
	Fri,  8 Mar 2024 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QbTPBYei"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58324EB2C
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709881799; cv=none; b=VONeNX1QMXS9S4rbpJKKjluCO3tnJkFFEY8Bcx/ALFerT2N1iZ1cLKyuI0BONz0mLvgzioGc8KabECL+IhHq2IzLBb0eLmepX1xurvbwtC816fIrWS40XAJFgb+O9pVk/UTQxaBeOEFemm/pM0ZAmsAwQpMCM/P0EsTBaiuRbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709881799; c=relaxed/simple;
	bh=zRZa5pLUOC5g9yma7RyKYKAPSpayxGnS5uyQlDWGukc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY0esn3A65DYSRvzJ4adt5q92D8vwVmAC/91GnjPj1lL2Pf2A6s5SQ/K9YauWLcy7dCYtWklxHFnqoo1eIXjVBlw6kFqiFBhTJ5WTCPUunPx5ttD1WosR3eCBm1oQ5BSNxqSZA++3cylW0ESL2vYwoNO6ND3of9xwjiUCcZ6iIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QbTPBYei; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2210865d962so280432fac.3
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 23:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709881797; x=1710486597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mzC03zGyATOP3gzEZUnSU+K1YFl+dHhu2DUvP/mur0=;
        b=QbTPBYeiMMrnXyebM095xVgAfc1vivYqVcuQa3qEmpLbAKjCuj/O0LPOcVQ4s6IUyI
         RwaBUvtmC31CzL+3qusGEt7CjtewcN9GeYGmHkanComAvQcY2jgdJjxQKHzqnOF3+eYI
         Mt6M17vWVLJw5qFNmm5v4oOJCKgphTfzrtcZprVddHY2+rvMP2E9lBuGIzwFbOdED9yn
         Vg90qiDXn/g0KuOJVH/uVdd6QSWzJbx3EwuVhNdLI69ZATyf+zG1OKJ2pjDaPwlkjJ6J
         4ZZaZ34sG9i+8FiJuPMMi6xRwu5vRs94oaKL3iAsKvreeDIRiwxeq+ukcmrlRr57io3g
         NcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709881797; x=1710486597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mzC03zGyATOP3gzEZUnSU+K1YFl+dHhu2DUvP/mur0=;
        b=KHtORlBnGQr2RcUIWzqaWEM1Ba8qIoZqbo+paD6USagqhUOvD19FEx5JAcXbA46m7u
         aGdaQL+nxHF0uAfT7ow9vy5LJPV/nY2dp2tDnt/FXuFdcDASShLzAJFX6DmC5wmQk6Iv
         ZLUmbjdFMIf6WsADlP6M1pgJRzhG5ptG2oIJ6CJis5mw1KcYAzLreRiMqnFl5isn4srS
         QQjkb3B213YXeCC/Tt5c1kgDFW/qJqpyU48Fg4Pg4tMAnlVMjyVgaS0VQOffLL7SQaRE
         iJV+jv4dbI6jn1U9I0/nmGPDOXTzIqRlPlN//2XB63QbB9vOg9lmYzNguW2Lk7Agu6tj
         R65Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6IqTdoBEjUGGhbCIOLmVf/AlnP22MGDHSKXa+cX/5JM8q3RctA2lk8RO/+3v0AKp3Run6kl6wcyRvucJmL2XSK6RVT8byS45D
X-Gm-Message-State: AOJu0YzOT2VhMSJ91mfsafoIL6EUS1chU+Qk+YMZuu2pF+QKcPEnfAfY
	eEk94HAtNisLYcv3bi2XSyUtbwm36UliVfd6GmxPyuVted5S7xPP/4cwEsnNQdyf9iJO6n7Hq1Y
	2siPGn3Ht6pbIbp/uWlCNUulo2SmWUfgCsP3fyw==
X-Google-Smtp-Source: AGHT+IGJaQPKULBRKwom8yBScA6iZBIqZ91f3P5FmgQwZCLuAnfKfifGfvdvenmLvSeYDN939jyjfi7/aTwKnk/aEzU=
X-Received: by 2002:a05:6870:1649:b0:221:45a1:b72a with SMTP id
 c9-20020a056870164900b0022145a1b72amr2439591oae.35.1709881796686; Thu, 07 Mar
 2024 23:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
 <mhng-c53211c1-4708-459a-bdc5-6e013c2adaee@palmer-ri-x1c9>
 <CAMj1kXEFqMx8qUHQEbg=OqbG-H0Zpj-nWu=a6qhhvNEZPO7f4Q@mail.gmail.com>
 <CAMj1kXG4SXsBfNqWMRUJ+AVv=6trWUAow-f8Mk5oKCpO=WueFg@mail.gmail.com>
 <CAEEQ3wkN3HDUuPDfWTn4kTxKH03OaRxBTFru3jJzZgW+BVhABg@mail.gmail.com> <CAMj1kXHuKbaXqWuFuMXhfL1_2w05CfJrk2uAPOW2HNHdpEnxXA@mail.gmail.com>
In-Reply-To: <CAMj1kXHuKbaXqWuFuMXhfL1_2w05CfJrk2uAPOW2HNHdpEnxXA@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 8 Mar 2024 15:09:45 +0800
Message-ID: <CAEEQ3wnv47x+FXYQ1=DdQdgRrp_EgX+C9eH+-JMPWh5p2450Zw@mail.gmail.com>
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

On Fri, Mar 8, 2024 at 12:49=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Thu, 7 Mar 2024 at 04:19, yunhui cui <cuiyunhui@bytedance.com> wrote:
> >
> > Hi Ard,
> >
> > On Thu, Mar 7, 2024 at 12:15=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Wed, 6 Mar 2024 at 16:44, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 6 Mar 2024 at 16:21, Palmer Dabbelt <palmer@dabbelt.com> wr=
ote:
> > > > >
> > > > > On Wed, 06 Mar 2024 05:09:07 PST (-0800), Ard Biesheuvel wrote:
> > > > > > On Wed, 6 Mar 2024 at 14:02, Ard Biesheuvel <ardb@kernel.org> w=
rote:
> > > > > >>
> > > > > >> On Wed, 6 Mar 2024 at 13:34, yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> > > > > >> >
> > > > > >> > Hi Ard,
> > > > > >> >
> > > > > >> > On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Ard Biesheuvel <ardb@=
kernel.org> wrote:
> > > > > >> > >
> > > > > >> > > On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > > > >> > > >
> > > > > >> > > > Compared with gcc version 12, gcc version 13 uses the gp
> > > > > >> > > > register for compilation optimization, but the efistub m=
odule
> > > > > >> > > > does not initialize gp.
> > > > > >> > > >
> > > > > >> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > >> > > > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.co=
m>
> > > > > >> > >
> > > > > >> > > This needs a sign-off, and your signoff needs to come afte=
r.
> > > > > >> > >
> > > > > >> > > > ---
> > > > > >> > > >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
> > > > > >> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > >> > > >
> > > > > >> > > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv=
/kernel/efi-header.S
> > > > > >> > > > index 515b2dfbca75..fa17c08c092a 100644
> > > > > >> > > > --- a/arch/riscv/kernel/efi-header.S
> > > > > >> > > > +++ b/arch/riscv/kernel/efi-header.S
> > > > > >> > > > @@ -40,7 +40,7 @@ optional_header:
> > > > > >> > > >         .long   __pecoff_data_virt_end - __pecoff_text_e=
nd      // SizeOfInitializedData
> > > > > >> > > >  #endif
> > > > > >> > > >         .long   0                                       =
// SizeOfUninitializedData
> > > > > >> > > > -       .long   __efistub_efi_pe_entry - _start         =
// AddressOfEntryPoint
> > > > > >> > > > +       .long   _efistub_entry - _start         // Addre=
ssOfEntryPoint
> > > > > >> > > >         .long   efi_header_end - _start                 =
// BaseOfCode
> > > > > >> > > >  #ifdef CONFIG_32BIT
> > > > > >> > > >         .long  __pecoff_text_end - _start               =
// BaseOfData
> > > > > >> > > > @@ -121,4 +121,13 @@ section_table:
> > > > > >> > > >
> > > > > >> > > >         .balign 0x1000
> > > > > >> > > >  efi_header_end:
> > > > > >> > > > +
> > > > > >> > > > +       .global _efistub_entry
> > > > > >> > > > +_efistub_entry:
> > > > > >> > >
> > > > > >> > > This should go into .text or .init.text, not the header.
> > > > > >> > >
> > > > > >> > > > +       /* Reload the global pointer */
> > > > > >> > > > +       load_global_pointer
> > > > > >> > > > +
> > > > > >> > >
> > > > > >> > > What is supposed to happen here if CONFIG_SHADOW_CALL_STAC=
K=3Dy? The EFI
> > > > > >> > > stub Makefile removes the SCS CFLAGS, so the stub will be =
built
> > > > > >> > > without shadow call stack support, which I guess means tha=
t it might
> > > > > >> > > use GP as a global pointer as usual?
> > > > > >> > >
> > > > > >> > > > +       call __efistub_efi_pe_entry
> > > > > >> > > > +       ret
> > > > > >> > > > +
> > > > > >> > >
> > > > > >> > > You are returning to the firmware here, but after modifyin=
g the GP
> > > > > >> > > register. Shouldn't you restore it to its old value?
> > > > > >> > There is no need to restore the value of the gp register. Wh=
ere gp is
> > > > > >> > needed, the gp register must first be initialized. And here =
is the
> > > > > >> > entry.
> > > > > >> >
> > > > > >>
> > > > > >> But how should the firmware know that GP was corrupted after c=
alling
> > > > > >> the kernel's EFI entrypoint? The EFI stub can return to the fi=
rmware
> > > > > >> if it encounters any errors while still running in the EFI boo=
t
> > > > > >> services.
> > > > > >>
> > > > > >
> > > > > > Actually, I wonder if GP can be modified at all before
> > > > > > ExitBootServices(). The EFI timer interrupt is still live at th=
is
> > > > > > point, and so the firmware is being called behind your back, an=
d might
> > > > > > rely on GP retaining its original value.
> > > > >
> > > > > [A few of us are talking on IRC as I'm writing this...]
> > > > >
> > > > > The UEFI spec says "UEFI firmware must neither trust the
> > > > > values of tp and gp nor make an assumption of owning the write ac=
cess to
> > > > > these register in any circumstances".  It's kind of vague what "U=
EFI
> > > > > firmware" means here, but I think it's reasonable to assume that =
the
> > > > > kernel (and thus the EFI stub) is not included there.
> > > > >
> > > > > So under that interpretation, the kernel (including the EFI stub)=
 would
> > > > > be allowed to overwrite GP with whatever it wants.
> > > > >
> > > >
> > > > OK, so even if the UEFI spec seems to suggest that using GP in EFI
> > > > applications such as the Linux EFI stub should be safe, I'd still l=
ike
> > > > to understand why this change is necessary. The patches you are
> > > > reverting are supposed to ensure that a) the compiler does not
> > > > generate references that can be relaxed to GP based ones, and b) no
> > > > R_RISCV_RELAX relocations are present in any of the code that runs =
in
> > > > the context of the EFI firmware.
> > > >
> > > > Are you still seeing GP based symbol references? Is there C code th=
at
> > > > gets pulled into the EFI stub that uses GP based relocations perhap=
s?
> > > > (see list below). If any of those are implemented in C, they should
> > > > not be used by the EFI stub directly unless they are guaranteed to =
be
> > > > uninstrumented and callable at arbitrary offsets other than the one
> > > > they were linked to run at.
> > > >
> > > >
> > > > __efistub_memcmp         =3D memcmp;
> > > > __efistub_memchr         =3D memchr;
> > > > __efistub_memcpy         =3D memcpy;
> > > > __efistub_memmove        =3D memmove;
> > > > __efistub_memset         =3D memset;
> > > > __efistub_strlen         =3D strlen;
> > > > __efistub_strnlen        =3D strnlen;
> > > > __efistub_strcmp         =3D strcmp;
> > > > __efistub_strncmp        =3D strncmp;
> > > > __efistub_strrchr        =3D strrchr;
> > > > __efistub___memcpy       =3D memcpy;
> > > > __efistub___memmove      =3D memmove;
> > > > __efistub___memset       =3D memset;
> > > > __efistub__start         =3D _start;
> > > > __efistub__start_kernel  =3D _start_kernel;
> > > >
> > > > (from arch/riscv/kernel/image-vars.h)
> > >
> > > Uhm never mind - these are all gone now, I was looking at a v6.1
> > > kernel source tree.
> > >
> > > So that means that, as far as I can tell, the only kernel C code that
> > > executes in the context of the EFI firmware is built with -mno-relax
> > > and is checked for the absence of R_RISCV_RELAX relocations. So I fai=
l
> > > to see why these changes are needed.
> > >
> > > Yunhui, could you please explain the reason for this series?
> >
> > From the logic of binutils, if "__global_pointer$" exists, it is
> > possible to use GP for optimization. For RISC-V, "__global_pointer$"
> > was introduced in commit "fbe934d69eb7e". Therefore, for the system as
> > a whole, we should keep using GP uniformly.
>
> There is no 'system as a whole' that can use GP 'uniformly'
>
> The EFI stub is a separate executable that runs from a different
> mapping of memory, in an execution context managed by the firmware. It
> happens to be linked into the same executable as the vmlinux kernel.
>
> > The root cause of this
> > problem is that GP is not loaded, rather than "On RISC-V, we also
> > avoid GP based relocations..." as commit "d2baf8cc82c17" said.
>
> GP is not loaded because in the EFI firmware context, there is no safe
> way to rely on it.
>
> > We need
> > to address problems head-on, rather than avoid them.
> >
>
> So what solution are you proposing for the potential GP conflicts
> between the boot loader, the Linux EFI stub and the firmware?


The GP register values are now loaded in the arch/riscv/kernel/head.S
and arch/riscv/kernel/suspend_entry.S files.

Let's think about EFI runtimeservice. If the EFI firmware code uses GP
registers but the compiler does not avoid GP, and kernel uses the
callback function provided by EFI, is there a problem? Is it possible
to solve the problem only by making the firmware code not use GP at
all and compiling options to avoid using GP?

The same goes for efistub.

So the way to solve this problem is that the firmware does not use GP
optimization. Does this allow efistub to load the GP register?


Thanks,
Yunhui

