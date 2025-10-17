Return-Path: <linux-efi+bounces-5069-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A4BEAAF0
	for <lists+linux-efi@lfdr.de>; Fri, 17 Oct 2025 18:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4145E35F20E
	for <lists+linux-efi@lfdr.de>; Fri, 17 Oct 2025 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A32857C6;
	Fri, 17 Oct 2025 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWOhR5wZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE969286413
	for <linux-efi@vger.kernel.org>; Fri, 17 Oct 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718421; cv=none; b=etwjh1ol95zDCV/48cm3Ymln2E5VcOeFcBY+PDcDx8oVZnfXP15SRWvmVKYxbIDIq2GGWx5BL7gmv0i7DyZjQh3EYXeSqX3hlnn+44Ju8EGFCMAHKJ4LcAvOC6m5dU7P08HYZ4pb5M8lTM9DlQQRl8ObZUp2pnuP0dItxslgQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718421; c=relaxed/simple;
	bh=8VfD/406RwiCMgcEBlvmZiOjcE4YxqTzVMxVhrToZ+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uw2OoDunpvNUb4qYCo+CB2H74xS+42pr31km2U1kx8xneaoVaHsQMJe9mox9mVst8HLlB4VGJG67+d0jiBDo9QsJHfs/pyjdZJAdkuRR6KzGG0QdM5tEaQSGM0soxfIJU9EblM72XIWfnvtAC2ODkFd+xfEBmQnRQDiceMHKQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWOhR5wZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CA3C116D0
	for <linux-efi@vger.kernel.org>; Fri, 17 Oct 2025 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718420;
	bh=8VfD/406RwiCMgcEBlvmZiOjcE4YxqTzVMxVhrToZ+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iWOhR5wZY5f4efgdHeBk9A0dCweP+3u1cQnDOe2XVZwcc1wRwNCTgP/muD5ig6YcP
	 PeF6kjDvfnWbEfT5Aej7wdpfEekT7xq1bn9oLTWuTYWoAz2SKh1hLKa5tlSRsQUVNk
	 NF1mw4a0MyQTVXmD2FCkRGr2+OBu8mD123o8LfVZNKkPTGSlEmACDAKqPDgrC+8vXG
	 ENluhb/p+wEIWaz8MidGKvNhHnC20oz8qC8FloBAzkon9MlZTFBZcRXzEtmoiot9Y7
	 fDnd71OoDxAcnUFT/gUy2tUPCRPbA+ra60G0elSXDyAKhgqi0ET42t6dYLePSCgzzS
	 MdZA9zt3hW+vw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so2520713e87.0
        for <linux-efi@vger.kernel.org>; Fri, 17 Oct 2025 09:27:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZnKPAmyB+Jezjwz4+V+BRcGyzL4tRYkdMfg7tV+/1msc3f2vJFHXE00jxCn/Y6zQoaTrGm17cMHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR54dbE0+vIm7pxH6uPPIUVWWYrwO6/8mldqtQfd9JYW6ICFJB
	3XZuQKt1WKBPT0A+P+n5Ja8ZSjtepKFLy8g6EqFMYL0ywip6KHxgA2lZ71HK9/kpBCmGfPC1v43
	Qq2oN8/BQ9y46IKCX+yk07j0q/eCaz90=
X-Google-Smtp-Source: AGHT+IFprw8czhfbQksqvWLP33iOCV9x+wGKMsbvBVEwL3PGVUpyMkEAQwIKJCflJAogYYqB0NgG9EMzSKWajs6p15M=
X-Received: by 2002:a05:6512:2c03:b0:591:c202:45db with SMTP id
 2adb3069b0e04-591d8546902mr1595944e87.39.1760718418870; Fri, 17 Oct 2025
 09:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
 <CAMj1kXEs5=VRi_rJwgHUrQWos-27PBbr3c4fYnmkV8Ahi8HZgw@mail.gmail.com>
 <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
 <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
 <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>
 <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
 <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
 <lgyzruqczm7uti2lfbhfhr5hyzpnm7wtvgffa2o7nigx76g6i3@wlffltvmhhez>
 <CAMj1kXFDquPxCYSBWgjikS=209pSJ_kth67M0RDeuetV9CPYAw@mail.gmail.com> <wlx6pt5crtfdwtop4w5vjznjfarrwitq44wdbufncjdvtsx647@tgobruak66yb>
In-Reply-To: <wlx6pt5crtfdwtop4w5vjznjfarrwitq44wdbufncjdvtsx647@tgobruak66yb>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 17 Oct 2025 18:26:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFfEBkcc-aiwGrRR-pKg4LBbS7weK0pEpZJsKOk5pbkuA@mail.gmail.com>
X-Gm-Features: AS18NWDwz4zbZmQW5XvAmIIWD850b5AgZUuR52rVREJ1ppW8ezbZ6L0AdbIPLIo
Message-ID: <CAMj1kXFfEBkcc-aiwGrRR-pKg4LBbS7weK0pEpZJsKOk5pbkuA@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 18:22, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Fri, Oct 17, 2025 at 01:00:17PM +0200, Ard Biesheuvel wrote:
> > On Thu, 16 Oct 2025 at 17:49, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > >
> > > On Thu, Oct 16, 2025 at 04:52:20PM +0200, Ard Biesheuvel wrote:
> > > > On Tue, 14 Oct 2025 at 18:47, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > > > The idea is that libstub code doesn't belong in vmlinux.o because it's
> > > > > not a part of the kernel proper, and doesn't need to be validated or
> > > > > modified by objtool for any reason.
> > > > >
> > > >
> > > > I don't see a reason to change this on architectures that a) do not
> > > > use objtool and b) link the EFI stub into vmlinux. If LoongArch wants
> > > > to change this, that is fine, but that still does not mean it needs to
> > > > change on other architectures too.
> > > >
> > > > EFI related boot errors are a nightmare to debug, and I will be the
> > > > one getting the reports when this regresses arm64 on hardware that 2
> > > > people on the planet have access to.
> > >
> > > The idea was to have more consistency, so vmlinux.o never has libstub,
> > > regardless of arch, but that's your call.
> > >
> >
> > The code in libstub ends up in .init.text, which will be mapped
> > executable during boot on architectures that incorporate it into
> > vmlinux.
> >
> > If objtool validation is never needed for such code, on the basis that
> > it is not actually called even though it is present, then I think that
> > is fine.
> >
> > For the other architectures, I don't have any objections in principle,
> > I'm just being cautious due to the regression risk.
> >
> > > I'd still propose we keep the KBUILD_VMLINUX_LIBS_PRELINK mechanism to
> > > allow other arches to opt in as needed.
> > >
> >
> > Again, no objection in principle. To me, it just seems a lot of churn
> > just to avoid having to teach objtool about indirect calls to noreturn
> > functions.
>
> Well, one of these days we will need to do that with some kind of
> compiler -fannotate-noreturn feature or plugin or whatever, but this was
> more about "why are we validating libstub code anyway, it doesn't seem
> necessary and x86 doesn't do it, so lets make them consistent".
>

Sure. So objtool validation is not needed even if the code is
incorporated into vmlinux, and therefore mapped executable at boot?
I.e., objtool does not check for gadgets or other things that may be
problematic even if they are never called directly from reachable
code?

> > > And that variable might even be useful for other cases (x86 startup
> > > code?)
> > >
> >
> > Not all x86 startup code is in .init.text; some of it sticks around
> > and is still used at runtime. I reckon that implies that objtool
> > validation will remain needed for that, no?
>
> I wasn't aware of that, in that case I guess the x86 startup code
> belongs in vmlinux.o, or at least the runtime portions of it.
>

OK thanks for confirming.

