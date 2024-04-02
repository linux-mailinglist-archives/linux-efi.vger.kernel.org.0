Return-Path: <linux-efi+bounces-914-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C81C894B5A
	for <lists+linux-efi@lfdr.de>; Tue,  2 Apr 2024 08:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F84B229C3
	for <lists+linux-efi@lfdr.de>; Tue,  2 Apr 2024 06:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5120B02;
	Tue,  2 Apr 2024 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBoduPgq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8C200AE;
	Tue,  2 Apr 2024 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039124; cv=none; b=LoJTMAWmhBZ52/me3l0EalLOZ6Ts6Qz52+1CXiN50O9EwMNIMKIt9akSzE/kzT3zm0BHwsI5PFEn2Ta6blbQGdozff8/egyUF51yjjbvSWsizAo9nvV50xSaujyjDrEiuSGafMUaGNwFVFVQl848bLcqAl9baOyZFwDoDFcm7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039124; c=relaxed/simple;
	bh=qWNlzf9hVn7Nq9JKKcMH71MNQcX1Kc7lHC9pZXRDUEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yygrqc01Y3vqCam3bKQJUCY1M5dJUoOdSDI8/ziRY85A2mRKhMbcd/L9sS5NopHUsinBuP3RN2TfF1y47wtv5UErVsIIwxXxJn5rBCT7GnEyiu4npS04Su3PHLEAFE4bSCOjTfy+IK+uqzCe9GrIM0mgWUfhrNx/G3PZvc5teII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBoduPgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316BAC433A6;
	Tue,  2 Apr 2024 06:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712039124;
	bh=qWNlzf9hVn7Nq9JKKcMH71MNQcX1Kc7lHC9pZXRDUEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pBoduPgqQBVKrCZGKup28FQzuFNeO+1oV8fiEpigtfVatinFyIgw8ZNeOm9RV9FH6
	 ntME1QS8fJHbDm3yU08kpeokI284bAUWnhJAhU9MNV1GPhgImTbB9/S8VEEFCAHyC+
	 dCpQeNnF81SEhQbE183YkYPH5amLNKDUkm//gsoirkR57UMVmIh/0x/L9FAMHqcItg
	 7jjD8XksSDM72QGw25si1SDxvRsLWlBOJh/LLjmY8TH7Ff3pLkFxOFneDHIkEVGFiD
	 AlsgRU/PdVJ0T8usj2NDb/5Jf5hde0+VAWtxQbgCg1MXchScoEmSrcTq2wOOqtCAKr
	 ARDGciy3PXMig==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6ee6c9945so35341831fa.3;
        Mon, 01 Apr 2024 23:25:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRsXm6tH2yvKTAdsimyaejpXNhxdOFLJCc+hPp1PORz3X99RnVokbgM6EztQiNfmGQynOWyOXw/A8urTj2OzPE63rXjHONiGD1oGDmYhEYbzB86eQk1uCT0ENihz3Apuke4YhJkcVu
X-Gm-Message-State: AOJu0YyI0ZKDWL6JGyC5Yq/AQ9BxWQKdI8Umisn0dj4fjBb1HNYBz3yb
	ST/GSQvifv1mpaE5OpZopl960HGBnf/EvERXXMOWaTQErnNpN6kFyrwIXUJeSAKZJn+jUPFCW+H
	BOiukyGCLqT+P+dNAT6bRKQyqpjg=
X-Google-Smtp-Source: AGHT+IGhyrPVK3HlxK0dcUI85aMquYw1I/ByvFIRl+DehA6Qm3UUsArC6R4U6R5J6xCr3U/WZOdnNH/nN4Vfyncx7ao=
X-Received: by 2002:a2e:a606:0:b0:2d4:973e:247f with SMTP id
 v6-20020a2ea606000000b002d4973e247fmr7308348ljp.23.1712039122487; Mon, 01 Apr
 2024 23:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321150510.GI8211@craftyguy.net> <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <a3aae375-5582-46e4-866b-6a81641998af@redhat.com> <CAMj1kXGrWGGv-aXabsn1oRwwMy-Ck1nz85QkEMqQ8LdQxyeBKQ@mail.gmail.com>
 <749b1cea4fd9e8d8debadc51cf3c0374d9878ae9@craftyguy.net> <CAMj1kXGyKdoLZ9t9_X4diiy9GsqxJ_NkHsm_t+cAJBxhHW7mAA@mail.gmail.com>
 <20240401154436.GB26633@craftyguy.net>
In-Reply-To: <20240401154436.GB26633@craftyguy.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Apr 2024 09:25:10 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGDnYoz-rF+8JZoMfhGmGqL0PEdvSK8xWH8F4ELXiJB_Q@mail.gmail.com>
Message-ID: <CAMj1kXGDnYoz-rF+8JZoMfhGmGqL0PEdvSK8xWH8F4ELXiJB_Q@mail.gmail.com>
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: Clayton Craft <clayton@craftyguy.net>
Cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 01:44, Clayton Craft <clayton@craftyguy.net> wrote:
>
> On Sun, 24 Mar 2024 22:53:47 +0200 Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > Thanks.
> > > >
> > > > I pushed another branch
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-clayton-3
> > > >
> > > > which has a proper fix for the issue that you found.
> > > >
> > > > As it turns out, the compat mixed mode (with handover protocol) was
> > > >
> > > > broken from the beginning, and the change you identified just happened
> > > >
> > > > to trigger it on your hardware.
> > >
> > >
> > > Tested and fixes booting on my Bay Trail tablet and NUC. Thanks for fixing this!
> > >
> > > Tested-by: Clayton Craft <clayton@craftyguy.net>
>
> So... maybe my testing wasn't as thorough as I thought, OR I am experiencing an
> unrelated problem. In any case, I'm having some difficulty figuring out what to
> blame. When using this patch on the 6.6 LTS:
>
> 1) kernel seems to panic right after displaying `disabling bootcon [efifb0]`. I
> determined that it's panicking by setting `panic=-1` and seeing it reboot after
> showing that message. I can work around it by setting `keep_bootcon`, but that's
> not ideal.
>

First of all, if you make it all the way to this point, it is unlikely
that this is the same issue. The issue that was fixed was preventing
the boot from proceeding past the very early 32-bit boot stage in the
decompressor, and by the time you hit this panic, the kernel is up an
running.


> 2) kernel complains about no root (from initrd). I can work around this by
> passing `initrd=my-initramfs` on the kernel cmdline.
>

So why is systemd-boot not passing this directly? AFAIK this is the
default method for systemd-boot, and I don't think it implements any
other methods.

> I haven't tried any newer kernels yet. The second issue above makes me wonder if
> your patch related to args might be to blame, but I'm not sure. Any help poking
> around further would be greatly appreciated :)
>

You might try this stable -rc

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=linux-6.6.y

which should get released any day now. It has a couple of EFI related
fixes, although none of them seem related in particular.

Another thing you might try is to pass efi=noruntime to the boot, to
check whether EFI is implicated in this to begin with.

