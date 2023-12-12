Return-Path: <linux-efi+bounces-188-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23DE80E4A9
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 08:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1251C22146
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06C91642B;
	Tue, 12 Dec 2023 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5Od11fz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F715AFC
	for <linux-efi@vger.kernel.org>; Tue, 12 Dec 2023 07:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A353C433C9;
	Tue, 12 Dec 2023 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702365111;
	bh=mAmUSentyWLmxS3uIGWIk1/WaLIBgAtASobEkLuZlvM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k5Od11fzDY5KMknbUEDyOS5n59hXgpWpDno++QZ6xjmcPaPcEsafwrSrEjApDSC4h
	 t7ixBPBEmBsPs+nQs1l2SU/llp3dhp/jgsu4RhCeYvhVGxP+XbsbiOEYNspmF8kjZL
	 aBu0Sw3RE2NiVj8ZIWsaTqsDW0njBI24wNHouv7LxNv8gjChTb+uNuiIzBLJ9yaN1p
	 Ipkg52K2CDW1XVuUKil0GjZmPnqUm5rHHr8G9mBNBuHpob2r0Zzh6I4yhVFs7ZOZ3C
	 mzOpta/DA47V14vrwI6EuFnhfcZ8uSUcA7O3KqGUxvgVk4Y1jU2xmK7F+p3Bi2FBVO
	 heNSrKqzhwU0Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c9bd3ec4f6so66679581fa.2;
        Mon, 11 Dec 2023 23:11:51 -0800 (PST)
X-Gm-Message-State: AOJu0Ywyo9yPrKG9CxJK9vgL4SYITliZEJDsvNu7Iy1rffH0wf9Odfgx
	ywIV6BdS4KbAoStJR2FB9qXrbse5MSctI0izoyA=
X-Google-Smtp-Source: AGHT+IFOwmyXSlMHNCihbFQURemSWuU5fLaZxVeC+4D0v54JRt+64Efmqtk8z5oD2pOuRTub/XTcFcsK5ie5zv0RSJI=
X-Received: by 2002:a2e:9856:0:b0:2ca:16d0:9e9a with SMTP id
 e22-20020a2e9856000000b002ca16d09e9amr1456456ljj.92.1702365109470; Mon, 11
 Dec 2023 23:11:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
 <20231013074540.8980-5-masahisa.kojima@linaro.org> <CAMj1kXEFPwqd=Ksc_HuoNSwRUyCNka4E7cWZgkgMq7XHcu2VFA@mail.gmail.com>
 <CADQ0-X8DJk02oKabzQcMwqKFjr6A6LDWaQDCndKybC6D=9M7vg@mail.gmail.com>
In-Reply-To: <CADQ0-X8DJk02oKabzQcMwqKFjr6A6LDWaQDCndKybC6D=9M7vg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 12 Dec 2023 08:11:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEB6XajecjXe3oX2nagO8foajdwZ99SiC_dD8WBjr+93w@mail.gmail.com>
Message-ID: <CAMj1kXEB6XajecjXe3oX2nagO8foajdwZ99SiC_dD8WBjr+93w@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] efivarfs: automatically update super block flag
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Sumit Garg <sumit.garg@linaro.org>, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 06:39, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ard,
>
> On Mon, 11 Dec 2023 at 19:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 13 Oct 2023 at 09:47, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > efivar operation is updated when the tee_stmm_efi module is probed.
> > > tee_stmm_efi module supports SetVariable runtime service,
> > > but user needs to manually remount the efivarfs as RW to enable
> > > the write access if the previous efivar operation does not support
> > > SerVariable and efivarfs is mounted as read-only.
> > >
> > > This commit notifies the update of efivar operation to
> > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > operation supports SetVariable.
> > >
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >
> > Unfortunately, I have identified a problem with this approach.
> >
> > There are cases where there are multiple instances of struct
> > superblock are associated with the efivarfs file system [0].
> >
> > So I reworked the patch a little - please take the time to double
> > check that I did not make any mistakes here.
> >
> > [0] https://lore.kernel.org/linux-efi/20231208163925.3225018-8-ardb@google.com/T/#u
>
> I think you are referring to this patch[1]?
> The modification should be OK, also I have tested it works as expected.
>
> Thank you very much for fixing this.
>

Thank you Masahisa.

