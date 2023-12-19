Return-Path: <linux-efi+bounces-253-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF7818514
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 11:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B501C216A1
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA5A14282;
	Tue, 19 Dec 2023 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoohcTUW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936341427A
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 10:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301BBC433CD
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702980705;
	bh=J+j1WN6tswAdLPPtFIirYIdJjW34zh1q91cUZtiltoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CoohcTUWHMG22coOqUuFNm3ZwZwLkxf1beZhkRwRN2dwtARZRB51kfPkNPp/XYmW5
	 Ww1suNxK7QbnAr14xvxL3JsSxdNHwOdWg0kG2eJG1xdhB9RRik61TYqhcOmy6SZypD
	 d9xUXKrA0XsHEg43wNoPEXPUS7/HR15/K5YsEc/uccMQXYLeDA1fHUq263zOxV7loq
	 UMzlWorIm8ue7hXNPCu0a5AuU1iN24UVdkxqnadOou/YTiJ7cmgNYCPJIijFeKQRHK
	 3aCwRS+DKlxXWJVFq7qrVp9W5ta5X2U+TTMwSe4v4tQg7OWjkayEaES2bL0onNDhgy
	 ci4JnAfNWvleg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cc259392a6so49917461fa.2
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 02:11:45 -0800 (PST)
X-Gm-Message-State: AOJu0Yz8nUeBlIXrldlkIKOPjASoDC7kdLw7y/51xMo38GI+mDn5AVdp
	knDFClGtBTZxGzRgrgP/PIJ7C97NJeepahh6kOo=
X-Google-Smtp-Source: AGHT+IG1tSbiOzV6ceoj4WzgSlTGenkVUP62UYTJYacdWQ0yHAf/laS1kcB5OH0DoZd2E4lU6SSpOEQ+T9NtdxjFzrM=
X-Received: by 2002:a05:6512:214a:b0:50e:399d:5f74 with SMTP id
 s10-20020a056512214a00b0050e399d5f74mr1353093lfr.32.1702980703358; Tue, 19
 Dec 2023 02:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219091405.39867-1-wangyao@lemote.com> <CAMj1kXEPdMBkne=ugR_j1Be8Aeh8jCA_ryHvh8rMA-c27i+RuA@mail.gmail.com>
 <CAPWE4_wydoTWHUYPmALp1oii+=ALVy_BTDUO_1wOo7XmkJ=cjA@mail.gmail.com>
 <CAMj1kXEL2nuVyNq1O=ytrCr3xh3tA6TU6kRFuk07H1EmneRTTg@mail.gmail.com>
 <CAMj1kXFqpJvH0ukOTufsLCTyCk1abct1kaPUV3JTaS6hMb75Og@mail.gmail.com>
 <CAMj1kXFFb3ksR=HCxiWpfhcjRcx-U=XE5LmZ2AMt9K110QpynQ@mail.gmail.com>
 <CAPWE4_wAa5uYEqkSRkJH+V57jNgjUZgFcrrjtRqRDECTCCASyQ@mail.gmail.com> <CAMj1kXHLApok+q99a_MSb6korFnV5qhS5fDL6MXhX9F2pSjBfw@mail.gmail.com>
In-Reply-To: <CAMj1kXHLApok+q99a_MSb6korFnV5qhS5fDL6MXhX9F2pSjBfw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Dec 2023 11:11:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFq2a+34cPMmq6LP9VpZGrQV0QAGt0=a-r03wczCE+brg@mail.gmail.com>
Message-ID: <CAMj1kXFq2a+34cPMmq6LP9VpZGrQV0QAGt0=a-r03wczCE+brg@mail.gmail.com>
Subject: Re: [PATCH v2] efi/loongarch: Directly position the loaded image file
To: Ainux Wang <ainux.wang@gmail.com>
Cc: wangyao@lemote.com, chenhuacai@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Dec 2023 at 11:08, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 19 Dec 2023 at 11:05, Ainux Wang <ainux.wang@gmail.com> wrote:
> >
> > Ard Biesheuvel <ardb@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=BA=8C 17:35=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, 19 Dec 2023 at 10:32, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > ...
> > > > I'll queue this up.
> > > >
> > >
> > > This patch does not apply. What commit is it based on?
> > >
> >
> > It based on the newest loongarch-next branch that based on the v6.7-rc6=
.
> >
> > Link:
> > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongs=
on.git/log/?h=3Dloongarch-next
> >
>
> Please rebase it onto v6.7-rc6, notably, this patch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=3Du=
rgent&id=3D271f2a4a9576b87ed1f8584909d6d270039e52ea
>
> which is now in mainline.

Apologies, I got that the wrong way around.

Merged now, thanks.

