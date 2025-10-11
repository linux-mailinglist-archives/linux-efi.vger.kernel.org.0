Return-Path: <linux-efi+bounces-5029-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D7FBCF7BD
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 17:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3677D422C3F
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F0B18A921;
	Sat, 11 Oct 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsHAGq8d"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C81B4F0A
	for <linux-efi@vger.kernel.org>; Sat, 11 Oct 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760194901; cv=none; b=WervNXglDlofGQFAAk8nLQfvqglfWr1I/aRxZD0oHAhtv+dKxWKKhVHKLnVHuzR4CK6B9LTztffG80cJHQ2BIWnnKZewalKEj9zFgvsklp1MC9n0aFcge04qi/jW4onJvB1sBNWMkEAIySMazYAa37z8qRlhckB+bqQatdSFyA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760194901; c=relaxed/simple;
	bh=l+BZFi7FQ0gPIfmUyKUU89IcSli2ZdE01CP6ZymDA1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7cDTUwZbw5ljquB7yqkitCUNmQotu2MCHFuAHwRfOQzIGQzrAYhInEoTzE4lhQ5j87rBhue3pUhuI0pr6vaip/q8k9AK60kyrLLNLlyxXVsvaij4LaSGNOqNecERqLDzRRs+4HlwYOcszmQGio5aqyRkOby1b3P1KZyBUWVCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsHAGq8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138B2C116D0
	for <linux-efi@vger.kernel.org>; Sat, 11 Oct 2025 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760194901;
	bh=l+BZFi7FQ0gPIfmUyKUU89IcSli2ZdE01CP6ZymDA1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tsHAGq8dCVb2hVSocMgxqr7qyYj5+AKGnNNotgILXaJcZW20HJ9zHbk5bc8MAasJB
	 DGIgOAcZoh181a0g3qHUSjhsInio82Gzpz/0bSDpc9HMowZhB0UYG+wL685LcxiDHA
	 GHDirQ4tLupNMXXJCX07tPelAY0JHllVubWToOWC0fFxRIJMyQebl/4kfn7XL/tLpe
	 i1SUOxXGMViX3cjRPGrAnFt4WJkRMR9jfqaGHwAoSrdQ+L1QfCD3gFsPaLtCJvgOg0
	 8t04jZiPVC8y3aEqpyCX99zqFY0hHt3A+faZRg0StkoJRoQQdFmqX0a8kNyNzCZZfQ
	 ilr5qP68oSOFA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so5235675a12.0
        for <linux-efi@vger.kernel.org>; Sat, 11 Oct 2025 08:01:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7R6IMZIsHU4VXTCri95XXefWHkeZCTtNxWD2ekgqVuITzHkRsXNCKY6yF5XLW6aJosDUgAy0oAUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmvwvUgVt+EDySw1LCOL96s+8In3UVYQhvZbB22PIDUlUuAA1
	1wWyTKgq/obMkI+OwhxnLW7KomThHY+/iwtYNv73Y21jNnJ6od2+j6Nl67sfN8FpZGpIdSii8d/
	mnRlKoBi3Kxh/iemTh1hcqA9lGHSjqG0=
X-Google-Smtp-Source: AGHT+IHAAjGILFWSLd2horNFRfV9fxdmdzWYj3ySTCm2Rj6N1tAB750HNgdkpDddPHK+8MUEnYbHC/EcCmKKJlMNNAU=
X-Received: by 2002:a05:6402:254f:b0:637:e4d1:aeff with SMTP id
 4fb4d7f45d1cf-639d5c3ebc3mr15509926a12.19.1760194899593; Sat, 11 Oct 2025
 08:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928085506.4471-1-yangtiezhu@loongson.cn> <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
 <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com>
 <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
 <CAMj1kXHWe2uGY3S1NJ6mckqD4n116rPmaOzw3_Qbvxyjh7ECMw@mail.gmail.com>
 <fec0c03d-9d8c-89a3-886a-1adc22e59b66@loongson.cn> <CAMj1kXFLyBbRL+pAAQ6be6dxqFPiyw_Ug8qNQWaicZQ235HE=A@mail.gmail.com>
 <8091e8fa-3483-af39-2f7a-e4eb62b0944f@loongson.cn> <CAAhV-H4+UGLSkbjHbq9MerWfxnq0a13x+uzNfTsCoe1UxjbWsg@mail.gmail.com>
 <CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com>
 <0c9b8e6a-96a6-91d4-946f-2109f48a529b@loongson.cn> <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
 <CAMj1kXEs5=VRi_rJwgHUrQWos-27PBbr3c4fYnmkV8Ahi8HZgw@mail.gmail.com>
In-Reply-To: <CAMj1kXEs5=VRi_rJwgHUrQWos-27PBbr3c4fYnmkV8Ahi8HZgw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 11 Oct 2025 23:01:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
X-Gm-Features: AS18NWAB1PQYI1FQztjMtlWlWvM53GRJ5zRkwYU-MM98Alr4NPAHm_TfvKHj05U
Message-ID: <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 10:48=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Sat, 11 Oct 2025 at 00:43, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > On Sat, Oct 11, 2025 at 3:29=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> > >
> > > On 2025/10/11 =E4=B8=8A=E5=8D=8811:40, Ard Biesheuvel wrote:
> > > > On Fri, 10 Oct 2025 at 19:54, Huacai Chen <chenhuacai@kernel.org> w=
rote:
> > > >>
> > > >> On Sat, Oct 11, 2025 at 9:13=E2=80=AFAM Tiezhu Yang <yangtiezhu@lo=
ongson.cn> wrote:
> > > >>>
> > > >>> On 2025/10/11 =E4=B8=8A=E5=8D=8812:25, Ard Biesheuvel wrote:
> > > >>> ...
> > > >>>> Why do we need both (1) and (2)?
> > > >>>
> > > >>> Not both, either (1) or (2).
> > > >>> Which one do you prefer? Or any other suggestions?
> > > >>>
> > > >>> Taking all of the considerations in balance, we should decide
> > > >>> what is the proper way.
> > > >> As a summary, there are three methods:
> > > >> (1) Only link libstub with vmlinux.o during the final vmlinux link=
.
> > > >> (2) Remove the attribute __noreturn for real_kernel_entry() and ad=
d while (1).
> > > >> (3) Ignore "__efistub_" prefix in objtool.
> > > >>
> > > >> Josh prefers method (1), I prefer method (3) but also accept metho=
d
> > > >> (1) if it is not only specific to loongarch.
> > > >>
> > > >
> > > > This is a false positive warning in objtool, which complains about =
a
> > > > function that falls through, even though that can never happen in
> > > > reality.
> > > >
> > > > To me, it is not acceptable to modify how vmlinux.o is constructed
> > > > also for other architectures, in order to hide some of its constitu=
ent
> > > > parts from objtool, which do not use objtool to begin with.
> > > >
> > > >
> > > > If you are not willing to fix objtool, I suggest fixing the loongar=
ch
> > > > code like this:
> > >
> > > Thank you.
> > >
> > > > --- a/drivers/firmware/efi/libstub/loongarch.c
> > > > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > > > @@ -10,7 +10,7 @@
> > > >   #include "efistub.h"
> > > >   #include "loongarch-stub.h"
> > > >
> > > > -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long =
cmdline,
> > > > +typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
> > > >                                            unsigned long systab);
> > > >
> > > >   efi_status_t check_platform_features(void)
> > > > @@ -81,4 +81,6 @@
> > > >
> > > >          real_kernel_entry(true, (unsigned long)cmdline_ptr,
> > > >                            (unsigned long)efi_system_table);
> > > > +
> > > > +       return EFI_LOAD_ERROR;
> > > >   }
> > >
> > > I tested the above changes, the falls through objtool warning can
> > > be fixed because efi_boot_kernel() ends with a return instruction,
> > > I think this is reasonable.
> > >
> > > efi_boot_kernel() has a return value, there are "return status" in
> > > other parts of efi_boot_kernel(), it should also return at the end
> > > of efi_boot_kernel() in theory, although we should never get here.
> > >
> > > If there are more comments, please let me know.
> > I still don't want LoongArch to be a special case, which means
> > efi_boot_kernel() in fdt.c, jump_kernel_func in riscv.c and
> > enter_kernel in arm64.c should also be modified.
> >
>
> You have made LoongArch a special case by adding objtool support,
> which  arm64 and RISC-V do not have.
>
> So NAK to changing arm64 and RISC-V as well.
Hmmm, I want to know whether this problem is an objtool issue or an
efistub issue in essence. If it is an objtool issue, we should fix
objtool and don't touch efistub. If it is an efistub issue, then we
should modify efistub (but not specific to LoongArch, when RISC-V and
ARM64 add objtool they will meet the same issue).

Huacai

