Return-Path: <linux-efi+bounces-5063-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D66CCBE4047
	for <lists+linux-efi@lfdr.de>; Thu, 16 Oct 2025 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 526DA35915F
	for <lists+linux-efi@lfdr.de>; Thu, 16 Oct 2025 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17A340D8C;
	Thu, 16 Oct 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3uwfPCa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555B19D06B
	for <linux-efi@vger.kernel.org>; Thu, 16 Oct 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626354; cv=none; b=YdpddKn8kvYbE9Y914DipG2QZIpDKpOAaecd8MdiUBcmzwhzIsCxr9RRl010Z8BpJK4naACkJhKrathcp11c2KZCjRgqd9UlwplmDAf4/5ax1pKy0hc+11p0PHe9XJ9IjHOWb7mszlVAgjx8jH8cFYtyflQnggfJIlT5Aj/BKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626354; c=relaxed/simple;
	bh=voMrHrP+eiEHoK6WpJLPwqOvwVd3gpO2XDGHiGYz4fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kY7Ztn/OWDBbPu9UKyyzMFa6RN/zO0ZHVZrzsF8gGksqpzMUOtIs/Dt2+QBGWHJJlinSz+7o6/vRccR25q9eS57oU42EyNC921KfN2n4qXglVgwJP1lYiDqBqvGYqRabE1tiN4jQetW/0TlSVRsGxjNFRTk/emz0zW5P81x6LNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3uwfPCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9D3C4AF09
	for <linux-efi@vger.kernel.org>; Thu, 16 Oct 2025 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760626354;
	bh=voMrHrP+eiEHoK6WpJLPwqOvwVd3gpO2XDGHiGYz4fc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n3uwfPCaa/w1vd11OjrfA6PC4kGDdFzTKBnn5qen7ETEDoSDzLOe4dL96VrMU3pci
	 M+ryr7peHybHNQhv9WNnBiaxXxH1zGudbRaZhmTIU8oOl0fm4sVK69mxJaca7hxog7
	 CtmCeiTeGN5t9SvqjQz1oWpeVix1HI1WwP5CKOLhKy+8XxjUr8RzockaMHPHysrQdh
	 0G1oIukrQaz0icDOKh2tHLang0qnn0O94Bv/EKjSuY6L5Pj74JdsE3v1iz/hkn/Gvw
	 G5W6CQguRRIR2fms/ppXsiFuRGgWOb68+r4kqC38jMpaz/A8B2roaPEjD4Xwl9iPcX
	 /W5MvIsfRRDeg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so1051985e87.1
        for <linux-efi@vger.kernel.org>; Thu, 16 Oct 2025 07:52:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbs0igG8fQlB8Wq4tUY5vQxuANqw2UmptvW0Djk6sJD+QT5mreDdikfPfAZaXaBIhmM/CYTicg93I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjeJl2s1JrXBIK1xbAvs0gVg2qsPmwdbKTLvGry+8Q8/6NsjZK
	Pif8GaaawVgRzgFwg4XpT6SVkypIImb4ezavxd8XRUQcb5q+KDluHePSOvTHHAMYTiz6Kn3QcI9
	k4IlyNFOTXRi7dKqlrwfaAMPreaJr3XY=
X-Google-Smtp-Source: AGHT+IExXYSyhYvIi8ji93wL4Ay4g8SIGKcbWu0lYZQJZ6G+i03LGkUOD03sda0e8uyyAoxsbSpe9f2IBUycSF0CisI=
X-Received: by 2002:a05:6512:1113:b0:585:48b2:95aa with SMTP id
 2adb3069b0e04-591d84feb7amr147281e87.15.1760626352708; Thu, 16 Oct 2025
 07:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8091e8fa-3483-af39-2f7a-e4eb62b0944f@loongson.cn>
 <CAAhV-H4+UGLSkbjHbq9MerWfxnq0a13x+uzNfTsCoe1UxjbWsg@mail.gmail.com>
 <CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com>
 <0c9b8e6a-96a6-91d4-946f-2109f48a529b@loongson.cn> <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
 <CAMj1kXEs5=VRi_rJwgHUrQWos-27PBbr3c4fYnmkV8Ahi8HZgw@mail.gmail.com>
 <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
 <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
 <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com> <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
In-Reply-To: <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 16 Oct 2025 16:52:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
X-Gm-Features: AS18NWA_66xpVdmKirMeIgw03wHK87OPCcvcMoX2mNDeb8mX8YKeO5fzBX6f5tc
Message-ID: <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2025 at 18:47, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Mon, Oct 13, 2025 at 04:36:49PM +0200, Ard Biesheuvel wrote:
> > On Mon, 13 Oct 2025 at 16:09, Huacai Chen <chenhuacai@kernel.org> wrote=
:
> > > On Sat, Oct 11, 2025 at 11:59=E2=80=AFPM Ard Biesheuvel <ardb@kernel.=
org> wrote:
> > > > It is an objtool issue in essence.
> > > >
> > > > The generated code looks like this
> > > >
> > > > 9000000001743080: ff b7 fe 57   bl      -332 <__efistub_kernel_entr=
y_address>
> > > > 9000000001743084: 26 03 c0 28   ld.d    $a2, $s2, 0
> > > > 9000000001743088: 87 00 15 00   move    $a3, $a0
> > > > 900000000174308c: 04 04 80 03   ori     $a0, $zero, 1
> > > > 9000000001743090: c5 02 15 00   move    $a1, $fp
> > > > 9000000001743094: e1 00 00 4c   jirl    $ra, $a3, 0
> > > >
> > > > 9000000001743098 <__efistub_exit_boot_func>:
> > > > 9000000001743098: 63 c0 ff 02   addi.d  $sp, $sp, -16
> > > >
> > > > There is nothing wrong with this code, given that the indirect call=
 is
> > > > to a __noreturn function, and so the fact that it falls through int=
o
> > > > __efistub_exit_boot_func() is not a problem.
> > > >
> > > > Even though the compiler does nothing wrong here, it would be nice =
if
> > > > it would emit some kind of UD or BRK instruction after such a call,=
 if
> > > > only to make the backtrace more reliable. But the code is fine, and
> > > > objtool simply does not have the information it needs to determine
> > > > that the indirect call is of a variety that never returns.
> > > So the best way is to fix the objtool?
> > >
> >
> > I think the best solution is to fix the compiler, and ensure that call
> > instructions are always followed by some undefined or debug/break
> > opcode. This works around this problem, but it also ensures that the
> > return address does not point to the wrong function, which may cause
> > confusion in backtraces.
>
> I think the compiler folks will say that's working as designed.  The
> whole point of __noreturn is to eliminate unecessary code after the
> call.
>
> Unwinders are already designed to handle that case anyway.
>
> If you don't want to optimize out the code after the call then just
> remove the __noreturn annotation from the function pointer.
>
> > > > So I don't mind fixing it in the code, but only for LoongArch, give=
n
> > > > that the problem does not exist on arm64 or RISC-V.
> > > You believe this problem won't exist even if they add objtool support
> > > (because their objtool will be sane)?
> > >
> >
> > It depends on the compiler.
>
> I don't think so, all compilers do this...
>
> My suggestion (which prompted this v2 patch) was to move the libstub
> code out of vmlinux.o (but still keep it in vmlinux), to make it
> consistent with what x86 already does.
>

This is because x86 links the EFI stub into the decompressor, not into vmli=
nux.

> The idea is that libstub code doesn't belong in vmlinux.o because it's
> not a part of the kernel proper, and doesn't need to be validated or
> modified by objtool for any reason.
>

I don't see a reason to change this on architectures that a) do not
use objtool and b) link the EFI stub into vmlinux. If LoongArch wants
to change this, that is fine, but that still does not mean it needs to
change on other architectures too.

EFI related boot errors are a nightmare to debug, and I will be the
one getting the reports when this regresses arm64 on hardware that 2
people on the planet have access to.

