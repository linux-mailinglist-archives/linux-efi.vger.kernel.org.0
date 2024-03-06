Return-Path: <linux-efi+bounces-754-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34563873D03
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 18:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A811C222E2
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 17:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73313666B;
	Wed,  6 Mar 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAu0MoXI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D68004B;
	Wed,  6 Mar 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745131; cv=none; b=XbS9yXadQDeyInxm3R+O6pLM2nmwzHYa25x+8tDh+W++L3/DQOS/PZSnPeufsER6unkNNAt0yfKMe+sDbmqFdGN7CLqEHGxf6gebexz8+vHANBS5E8kk2lVSfkh3fMfyoBEREmJvZ3begKlGxrfm9m2FzOsnHn/YeIWNEbc8avo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745131; c=relaxed/simple;
	bh=2qzpLpQnn8H/E5sxCIi6Nw1Lgq2F1o1a0Kzj4iP6/HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9mP4+BY/EpOcpdhr/sVB7iAnXuCJscKRecolnA//QX+4Kc29PHN6znFTl7RdK/d7C0MrFVi1HMDjby//PYyRxtdF3+sW6zbLlddIuY1T/Xw992WqerLeLcA7pTG8PIY4tYFU03zSC1C9W54tEhir47nEkoNT6N4JThwi8jKMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAu0MoXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149CEC433F1;
	Wed,  6 Mar 2024 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709745131;
	bh=2qzpLpQnn8H/E5sxCIi6Nw1Lgq2F1o1a0Kzj4iP6/HE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eAu0MoXIxajSQQaL1LT0wSKdAeRRyrrqtfu8uHL5NK6Fo4ueVjLvZrm6In+I2aN+P
	 C4o4B2HDf4p87eAqtB2nH25/+ea+yZOQPuwcnVAVNvwHtA9yrPgEOeQFDnZBLTdxqZ
	 nn3AL1tnZVxtUVECtZgu6qnEnumr+MYQ+ofCleEIk0EsLEBcmxczK4KAblyFAkTPxu
	 ENsZV1gkOx901rIg9qDGK6My6wusgClqj4xX1f+cIjCBw33KMeMFcXnKR0F6rqxzq6
	 uBTeVMVhvI8aK6K35MylHj1Bsoh/rXUZI8CZmUA217HbPNxzJIVUBQa7TrjwxpScFZ
	 Nt521NH0ci+9w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513173e8191so9059280e87.1;
        Wed, 06 Mar 2024 09:12:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGuL6waJvhKdSqe57FIkfO5EmlMSSvl76CI6ncI5ISsOc6hFZhtwnYk+2mnTMffVHG/oCCJGgr/z2V7OUYDAZ//+E55ZWcE7QQI3uoXAOGVOkOSpLu81QHUxO5DcyQAEWH+zLtaAxd
X-Gm-Message-State: AOJu0Yz/GLkNBTVMm+qdAsBF5R1GCY2jlaRcreTkJJwe2tMdnsJGVLU4
	zkaMfPtyOxV3kr6s/muq5p1GM41TNyhaSEoCqVysDJeRPt07cgA75od+zk7R+oaf3QUIaMrWLAm
	fSk9uB/b9XpbW4ADb+kWoi5WYemA=
X-Google-Smtp-Source: AGHT+IG8eOJw1BG9B4w1h55rfk9MeAdIqds6IcnkJPTcRCygr6hWs82XXKFP4nRlcZVuq4gRW/lGwGDNEdsAEYlYU+c=
X-Received: by 2002:a05:6512:3489:b0:513:1a38:2406 with SMTP id
 v9-20020a056512348900b005131a382406mr3648590lfr.13.1709745129142; Wed, 06 Mar
 2024 09:12:09 -0800 (PST)
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
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 6 Mar 2024 18:11:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHcisgPkkmkEM8AGDkmW64B-Sfp96ag457xV9uqxy3yVg@mail.gmail.com>
Message-ID: <CAMj1kXHcisgPkkmkEM8AGDkmW64B-Sfp96ag457xV9uqxy3yVg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] efistub: fix missed the initialization
 of gp
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: cuiyunhui@bytedance.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	aou@eecs.berkeley.edu, xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, bp@alien8.de, xiao.w.wang@intel.com, 
	jan.kiszka@siemens.com, kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Pedro Falcato <pedro.falcato@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 17:15, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 6 Mar 2024 at 16:44, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 6 Mar 2024 at 16:21, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >
...
> > >
> > > The UEFI spec says "UEFI firmware must neither trust the
> > > values of tp and gp nor make an assumption of owning the write access to
> > > these register in any circumstances".  It's kind of vague what "UEFI
> > > firmware" means here, but I think it's reasonable to assume that the
> > > kernel (and thus the EFI stub) is not included there.
> > >
> > > So under that interpretation, the kernel (including the EFI stub) would
> > > be allowed to overwrite GP with whatever it wants.
> > >
...

After some more consideration, I concluded that using GP in code that
executes in the context of EFI is never safe.

Taking the typical Linux/EFI boot sequence as an example, where GRUB
is loaded by the system firmware, and the Linux EFI stub is loaded by
GRUB, it is easy to spot the problem: GRUB exposes the initial ramdisk
via the LoadFile2 protocol, which is essentially a callback interface.

If we assume that EFI apps can use GP as they like, we cannot safely
call this callback interface without restoring GP to its original
value, since we have no idea whether GRUB (or some other loader) is
relying on its value. And in addition to synchronous callbacks, there
may be EFI event callbacks registered by GRUB that are signaled by the
system firmware asynchronously, which means GRUB code could be called
behind our backs. Without any guidance in the UEFI spec on how GP
needs to be managed across such boundaries, we should assume that GP
needs to be restored to the old value in each of those cases, but this
is impossible for async event handlers.

We might conclude then that using GP is only safe for EFI apps if they
don't install protocols or register for EFI events, but that would
still imply that we should restore GP to its old value upon exit.

So without a strong argument why GP relaxations need to be supported
in the EFI stub, I don't think we should consider these changes. If
there are any issues in the current code that result in inadvertent GP
relaxations, we should address those instead.

