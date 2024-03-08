Return-Path: <linux-efi+bounces-777-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF99875F39
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 09:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD96C28270D
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AC751031;
	Fri,  8 Mar 2024 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJEBJF65"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F992C85C;
	Fri,  8 Mar 2024 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885788; cv=none; b=E01/DpLkbH9EYdBnXzbVBILY/eZpZNvyhQZipHTCPvwMSJWwRQN/og54KF5LEetbJRyRSnXT6IwR7bmyKjtGvTVuD1EQgyDsrmRAxl22661lDPgPOzTkcAroov7N2tH4K4jtMX7oTh9z0etrDx8yAQtvrqMdeQCaWsWEwrLHBr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885788; c=relaxed/simple;
	bh=+KlByP7rf+bOfulZPxS+EKdSXzyhEgQiIoUkRNVAth0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XC/lCe/fyFBmTQ6hzHH3MX6IumzL606ItjuYIEd2KxlfdEuZlsCGeC1WdG6ZzjK17vq06g/e4s0kzimTXHu9L80TbJxmVFUtgxUgkduB1Q7t5Sdaijyzq+jyfBY25R+ZLoLYK9bFbmmG0v5+04cvXEhIFMvUQORmSwAfNbBeXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJEBJF65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA060C43142;
	Fri,  8 Mar 2024 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709885787;
	bh=+KlByP7rf+bOfulZPxS+EKdSXzyhEgQiIoUkRNVAth0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AJEBJF65mmnJlZwCUPpKFJYdzNJka13dBkz0edt4+/KqQdM7xUsiNLYeVYxnMrgt2
	 q+ehRfCaOtMGAyldwckSNhgvODgQReTpEl3zR9QqFbo3uY3bApcRnMHPrQ0Jz7CICf
	 /dXmWydc0avlzbfadhLItkiAcm0UkiiFbC5UT9mmuEDm1vtLh7koBbseq3h8OqxMqs
	 wkoWMTKjHqaRBj/tku/OkDmQo7tcmrc+F8KaDn5kdqbOAoKuIScNjFtabxUgiwPq26
	 HUDMaS0ENmScg89zDJ/noNVANFZ7cHVPYmrtjBFbgqxgS43RJMGbKnYX5cE3p8ZdVO
	 TgMdERL4rmWaw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512e4f4e463so2464373e87.1;
        Fri, 08 Mar 2024 00:16:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0p8qTYyZVBf2/15oS9KmhQ/8S/WaIrALpY/5Eeprzv+Gay1jSWLKNsReSwKu4etqlNJ1s4tVqv1oE09R9MInr+0HEzKnSYsAOvlw8zcEqbXM+AkIvl9wQQUk0jSQaj2tH6iqpIBtx
X-Gm-Message-State: AOJu0YwJaKVR6iM08DesEWXxnWcgGdGv7hpLG71JrDwBD9Zk888Q4m/M
	xR0CBolYV09chPwJT4nnfXOFe0Q+1pHqz9Au/s+exHEM1xvUXu3vq+mBmw3mAMuLAxW5KPHoAEe
	BDGx6mpduVbFSPcWgkrNdsKHIwRE=
X-Google-Smtp-Source: AGHT+IGpv/Z8DQiyJqrjf2eUzf7yHR2/5h5Z4A8FPQ0x7MSK7aRM10lTeI1HNy98FRtxs0WDa4CCB8IatOX9H1APg7I=
X-Received: by 2002:a05:6512:4851:b0:513:54c6:9f68 with SMTP id
 ep17-20020a056512485100b0051354c69f68mr2751944lfb.18.1709885785595; Fri, 08
 Mar 2024 00:16:25 -0800 (PST)
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
 <CAEEQ3wkN3HDUuPDfWTn4kTxKH03OaRxBTFru3jJzZgW+BVhABg@mail.gmail.com>
 <CAMj1kXHuKbaXqWuFuMXhfL1_2w05CfJrk2uAPOW2HNHdpEnxXA@mail.gmail.com> <CAEEQ3wnv47x+FXYQ1=DdQdgRrp_EgX+C9eH+-JMPWh5p2450Zw@mail.gmail.com>
In-Reply-To: <CAEEQ3wnv47x+FXYQ1=DdQdgRrp_EgX+C9eH+-JMPWh5p2450Zw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 8 Mar 2024 09:16:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFE_G5-od5kbOiU_4D7dwjksdrMTofHfYsLkjFtZDz-dA@mail.gmail.com>
Message-ID: <CAMj1kXFE_G5-od5kbOiU_4D7dwjksdrMTofHfYsLkjFtZDz-dA@mail.gmail.com>
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

On Fri, 8 Mar 2024 at 08:10, yunhui cui <cuiyunhui@bytedance.com> wrote:
>
> Hi Ard,
>
> On Fri, Mar 8, 2024 at 12:49=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Thu, 7 Mar 2024 at 04:19, yunhui cui <cuiyunhui@bytedance.com> wrote=
:
> > >
...
> > >
> > > From the logic of binutils, if "__global_pointer$" exists, it is
> > > possible to use GP for optimization. For RISC-V, "__global_pointer$"
> > > was introduced in commit "fbe934d69eb7e". Therefore, for the system a=
s
> > > a whole, we should keep using GP uniformly.
> >
> > There is no 'system as a whole' that can use GP 'uniformly'
> >
> > The EFI stub is a separate executable that runs from a different
> > mapping of memory, in an execution context managed by the firmware. It
> > happens to be linked into the same executable as the vmlinux kernel.
> >
> > > The root cause of this
> > > problem is that GP is not loaded, rather than "On RISC-V, we also
> > > avoid GP based relocations..." as commit "d2baf8cc82c17" said.
> >
> > GP is not loaded because in the EFI firmware context, there is no safe
> > way to rely on it.
> >
> > > We need
> > > to address problems head-on, rather than avoid them.
> > >
> >
> > So what solution are you proposing for the potential GP conflicts
> > between the boot loader, the Linux EFI stub and the firmware?
>
>
> The GP register values are now loaded in the arch/riscv/kernel/head.S
> and arch/riscv/kernel/suspend_entry.S files.
>
> Let's think about EFI runtimeservice. If the EFI firmware code uses GP
> registers but the compiler does not avoid GP, and kernel uses the
> callback function provided by EFI, is there a problem? Is it possible
> to solve the problem only by making the firmware code not use GP at
> all and compiling options to avoid using GP?
>

EFI runtime services do not use callbacks, and execute in a context
that is entirely owned by the OS. So this is one place where EFI
firmware cannot use GP at all even if the UEFI spec permitted it.

> The same goes for efistub.
>

Not really. The UEFI spec seems to suggest that *system* firmware
should not touch GP or make any assumptions about its value, but it
doesn't say anything about EFI applications such as the EFI stub or
GRUB.

> So the way to solve this problem is that the firmware does not use GP
> optimization. Does this allow efistub to load the GP register?
>

What about GRUB or other bootloaders that are loaded before the
kernel, but are still active while the EFI stub is executing? Who gets
to own GP in this scenario?

