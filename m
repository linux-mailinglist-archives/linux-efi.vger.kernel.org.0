Return-Path: <linux-efi+bounces-4952-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E541BA71B1
	for <lists+linux-efi@lfdr.de>; Sun, 28 Sep 2025 16:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4FA24E03CF
	for <lists+linux-efi@lfdr.de>; Sun, 28 Sep 2025 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A021ABC1;
	Sun, 28 Sep 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+eEDf73"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE051F151C
	for <linux-efi@vger.kernel.org>; Sun, 28 Sep 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759070407; cv=none; b=YJjpVnVLySrbmaIQjY/VQatgEpDaDj4lNgfSAKpdDPANL98583MRo6NdL7GhkDSdydytgj69Hhobac5IDDoLowXxHhMtLccQRmVDAN4sj0EGh77ICRcHPVcNYOcmEXtiR7NDzMH5X+1QkE64VXMJ46RFSbFCftsm9dtRieyE6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759070407; c=relaxed/simple;
	bh=YTfeZ2Az2Z8Gm9DtkMQMER4W7eQCdNdPKRtSzc6jOSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SR53O2NSxGAuI6QmBQt/fOh7nTLDuKEkuZ7Z78ytqpIWD+29ZHbnJxD9swO+9IGmckK083O5JpMvgtu+O1v1lbA2Lea8vXLaXu9Xvmq8WPmmitTbK1//WMqxNLQ2inG4gBK6GGP3GQD8FpvTZh8q8IrJbe7vFFkGgd/Li8e7/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+eEDf73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66DBC116B1
	for <linux-efi@vger.kernel.org>; Sun, 28 Sep 2025 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759070406;
	bh=YTfeZ2Az2Z8Gm9DtkMQMER4W7eQCdNdPKRtSzc6jOSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E+eEDf738DIWH8AV/fKoc38BolmBbkv2V3MzRdl9kmp+cWmedZHwK0nxfwFGGO+UQ
	 45AqO5ZFt4tJZzxZd6CS2q3iWcAS4Cbm2N1Iy990txMQROoVk7uAHvjUuU/JHjVJcx
	 E3P76EMaVdCAm6ljVWWca2xSfv6YP/I871kQXLIassNB/tMf1STibLRON5mCzYfrnW
	 f3v6VVvYwtllH8yx9nPhcUazF0FUub5fedvheR2I3/cGe+iSgelMwVd2B05vSjy5SP
	 UbAmbTHotqsZB+WoHDd19rq+DNy7tPRZbosPIetRNE91Jw7cB4CFTM8kJNYWmpZNOE
	 yl+zwxV//VHnw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-371e4858f74so20521831fa.1
        for <linux-efi@vger.kernel.org>; Sun, 28 Sep 2025 07:40:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWl0VPHqOWMx6Ik5+GuKid2W66b4zuSXQyqBdbvM/Cdk8v2Y2dscJSullwvN1sRHlnCkJsrvuVKFw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jnNrai9FFaV/x97rR8bUvn5vl0VDc46HA6XhjLnPOfOYDISk
	1f46IN4B9bOYsuzzzBuNY/1qjo+8ivA1DYMpXK+CUVc6NwRxsHUOK1prVreSTxtkn9s1g8AP0H1
	/iH317yWEBsM3VowrFxLn5nR2U5AcnZg=
X-Google-Smtp-Source: AGHT+IHH3ITnfb2BpbA6fI4i1D/KynnPo0itxokVo5z2R2BxNhPDjgHL5REZ4v90HN8ojvUvINWVTbbCPEGJLRT00uM=
X-Received: by 2002:a2e:bc24:0:b0:36c:2899:7a33 with SMTP id
 38308e7fff4ca-36fb05aac1emr41368541fa.5.1759070405095; Sun, 28 Sep 2025
 07:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928085506.4471-1-yangtiezhu@loongson.cn> <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
 <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com>
In-Reply-To: <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 28 Sep 2025 16:39:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
X-Gm-Features: AS18NWBfnP56WGhzhDUorQf3ioUtwwx0in0DsVvUF4v8bsmet9iSfiUkxyOpxGQ
Message-ID: <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Sept 2025 at 15:52, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard,
>
> On Sun, Sep 28, 2025 at 9:42=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Sun, 28 Sept 2025 at 10:55, Tiezhu Yang <yangtiezhu@loongson.cn> wro=
te:
> > >
> > > When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> > > the following objtool warning on LoongArch:
> > >
> > >   vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
> > >   falls through to next function __efistub_exit_boot_func()
> > >
> > > This is because efi_boot_kernel() doesn't end with a return instructi=
on
> > > or an unconditional jump, then objtool has determined that the functi=
on
> > > can fall through into the next function.
> > >
> > > At the beginning, try to do something to make efi_boot_kernel() ends =
with
> > > an unconditional jump instruction, but this modification seems not pr=
oper.
> > >
> > > Since the efistub functions are useless for stack unwinder, they can =
be
> > > ignored by objtool. After many discussions, no need to link libstub t=
o
> > > the vmlinux.o, only link libstub to the final vmlinux.
> > >
> >
> > Please try keeping these changes confined to arch/loongarch. This
> > problem does not exist on other architectures, and changing the way
> > vmlinux is constructed might create other issues down the road.
> ARM, RISC-V and LoongArch do things exactly in the same way. Now
> LoongArch is the first of the three to enable objtool, so we meet the
> problem first.
>
> But yes, I also don't want to change the way of constructing vmlinux.
> So I prefer the earliest way to fix this problem.
> https://lore.kernel.org/loongarch/CAAhV-H7fRHGFVKV8HitRgmuoDPt5ODt--iSuV0=
EmeeUb9d5FNw@mail.gmail.com/T/#meef7411abd14f4c28c85e686614aa9211fccdca0
>

Can we just drop the __noreturn annotation from kernel_entry_t, and
return EFI_SUCCESS from efi_boot_kernel()?

