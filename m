Return-Path: <linux-efi+bounces-252-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53467818505
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 11:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62FB28564F
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43CA14273;
	Tue, 19 Dec 2023 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj3apFkr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6C14A89
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 10:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC9DC433CD
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702980549;
	bh=ElUn8m+6b1TAX4bcZp+QTfLV7c7hHZG04YmQXoq1H8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dj3apFkrfYCcaiGPIBvy/9z0aXfEK2jIqZ5fD2FkOYlvr8wQosUn8NHpVNKJQsgae
	 7iTVV5y5knq1Rycxjj+Ek6ePum1IvVGiWzEox0l+TXXtECixF7taIJQZF9xxn22mDE
	 dC9MFU4OvQbKKy2OF2C8OV4KvSDV6SRncmLZnuvXr9a8luJXY30huoMRnjO50vxeIU
	 i9z68kL4HP4svgQ4ab9iW9YfiNOlgZnXNF5pnWpSTq/gq1tUdFcd0s/kLGLA003ITi
	 kTRIbe3KggeEMqwmXIgp5R5Qn8GNzITvef/WOKXQUSz6CEMmt3PzBcPu+fF5Skm2Zv
	 0OK3D7BAvvD6Q==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e23a4df33so4397365e87.2
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 02:09:09 -0800 (PST)
X-Gm-Message-State: AOJu0YxBqUYMiHw49qLFbFl0lvFPTBrEEU62xnNOGc5VYDdrXWQXI55F
	5HK4GiSECixUPvu8awQFYXjF5IYRleserhu8pYM=
X-Google-Smtp-Source: AGHT+IG3/2ncXwk+blzXhpa2cVUhDd3AKT3YGcR8v3ObuHM5lZm0DKKtkI4iJy8osNQlwhVDD/3xEx5mdHLtf6qvDN0=
X-Received: by 2002:a05:6512:39cb:b0:50b:fcd4:8316 with SMTP id
 k11-20020a05651239cb00b0050bfcd48316mr10844645lfu.100.1702980547449; Tue, 19
 Dec 2023 02:09:07 -0800 (PST)
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
 <CAMj1kXFFb3ksR=HCxiWpfhcjRcx-U=XE5LmZ2AMt9K110QpynQ@mail.gmail.com> <CAPWE4_wAa5uYEqkSRkJH+V57jNgjUZgFcrrjtRqRDECTCCASyQ@mail.gmail.com>
In-Reply-To: <CAPWE4_wAa5uYEqkSRkJH+V57jNgjUZgFcrrjtRqRDECTCCASyQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Dec 2023 11:08:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHLApok+q99a_MSb6korFnV5qhS5fDL6MXhX9F2pSjBfw@mail.gmail.com>
Message-ID: <CAMj1kXHLApok+q99a_MSb6korFnV5qhS5fDL6MXhX9F2pSjBfw@mail.gmail.com>
Subject: Re: [PATCH v2] efi/loongarch: Directly position the loaded image file
To: Ainux Wang <ainux.wang@gmail.com>
Cc: wangyao@lemote.com, chenhuacai@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Dec 2023 at 11:05, Ainux Wang <ainux.wang@gmail.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=BA=8C 17:35=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, 19 Dec 2023 at 10:32, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > ...
> > > I'll queue this up.
> > >
> >
> > This patch does not apply. What commit is it based on?
> >
>
> It based on the newest loongarch-next branch that based on the v6.7-rc6.
>
> Link:
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git/log/?h=3Dloongarch-next
>

Please rebase it onto v6.7-rc6, notably, this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=3Durg=
ent&id=3D271f2a4a9576b87ed1f8584909d6d270039e52ea

which is now in mainline.

