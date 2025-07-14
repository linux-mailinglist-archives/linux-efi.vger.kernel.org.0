Return-Path: <linux-efi+bounces-4300-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C86B03458
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 04:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF7B3B95FB
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 02:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCE31ADC93;
	Mon, 14 Jul 2025 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5+SD9+2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601017B50A;
	Mon, 14 Jul 2025 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752458912; cv=none; b=kUk5PkSJBM8qfQvZAyRpkNWX0eYwZJQ/iduQ3C/fyhjDSFDIy9AIc9eCTs0xagJp+ddqln1BIpKRC6Vda1EsVsvM6DJEsCHDSIHWerW+SndafHvz0L97GICNYy8n+7qXoxnO62luyUqrxl5SK7aWtvnE1d4GjWmeD4i6RccGerA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752458912; c=relaxed/simple;
	bh=wu0gupS5zQwLU2l1U8KdXNwtiX+mE2dXFUa5VBnrjog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8dY2trLpyQs0Hu5rsqDCKFdfJyGNRvxsU3iGv0F5AQU78K3uNogaEhaVuWnHf/yNvthV95zQUAV0KqrujQpAXkAxL5u4H+xItI2WqPrWpv7l+sADl7eHFeMo22wRBHkWyun6zvuikSjYR+aMNx9Zm+ndXHWwzh9602EYwaEPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5+SD9+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B245FC4CEF7;
	Mon, 14 Jul 2025 02:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752458911;
	bh=wu0gupS5zQwLU2l1U8KdXNwtiX+mE2dXFUa5VBnrjog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e5+SD9+2Ik8EI+11sCkcR7PlafdAVzHPjAyXpMSsKZkmrympm/W2xQWAh2g0Q0zth
	 ibZT8iYJzxo3xIw8PjRg7Z9oMRKHoOJcYwP8uz53hdBt3H5ca11OrlPwLsQ9ovap3m
	 nwIVQJBnaUOfKpOzipmYDV7mEY6KHJMCwU2e0q2wvxBzHgO1W27npv3V9ZstBxHyWE
	 /RuzLi9pt1BVFnjgDGBJS20csCoBLF2pwrZ2lCXgj409pVaoslC4FQhyUUOZrVy6Oh
	 06mk17V3uOvd3JAPWpZb+jJjNA/KUO+UmYSeFwHejXgFKfT9nO/DueVz01k3k0aMv+
	 HQalDxBtBaEUQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55628eaec6cso3273734e87.0;
        Sun, 13 Jul 2025 19:08:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvny3fLb0lido73Sc/4PEZ8AX9781Qh6qK0z0cr06KV7SxknA+XpIelVUnKnjMgdD5ERK3DcHOPNi4@vger.kernel.org, AJvYcCVsmeTPpkAyMrtiphcHjItrE3nn4WyM2SXp2xmlOUpSK3NXnYUCz/leZrAxnfxvvS9Gp/UTr8SJ72M0tPPO@vger.kernel.org, AJvYcCWKqpTiJvInByfRXvKIZiU3+jfy4OokpWgYR+iKR4c0vxoKYpBc7L2fzQZHv7AY4LLV7ChP8LvfNVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCvGO+xiO0Qm50EemqElvSaaNFba/ptfJcVLdQjefjK/RHCav
	yMLrS24aYeiz9NBPSD+dc3udPhQt7K9px1XHP5iscx3tfLWuNpFOGQYY0mU6Ugnjhhje5Griz5q
	STgBuOtqcu6lZUg5S2bkFvgN3TWO2Juw=
X-Google-Smtp-Source: AGHT+IFnC+Wm7NuX4/bTU91+875Jm+qyuf6g707T7r7/ii7gdVDmWAsIHbymYTyYYrGPYk/9ZPeTCy/VoI7+hRJ7NC8=
X-Received: by 2002:a05:6512:3c92:b0:553:3127:b00 with SMTP id
 2adb3069b0e04-55a04637460mr3194297e87.32.1752458910051; Sun, 13 Jul 2025
 19:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710084151.55003-1-feng.tang@linux.alibaba.com>
 <CAMj1kXHDFq3FZj4134CTcQZnke4t1=u6iRNNsQBvuhb3F6KurQ@mail.gmail.com>
 <CAMj1kXGiixvwsSmOz65F=OXQuHovO4DMAsJaPZ2sL3PBbMHh8A@mail.gmail.com> <20250711085608f4146d99@mail.local>
In-Reply-To: <20250711085608f4146d99@mail.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Jul 2025 12:08:17 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEL90VvygoSk8EtQJO0cjybwpt10uHM+ufJg84LvR+Ouw@mail.gmail.com>
X-Gm-Features: Ac12FXzKaB6EQRJG9NaJZr-R85q2e6GV-jLd0mcBWosj_q8XLWX4-SgVkwxioP8
Message-ID: <CAMj1kXEL90VvygoSk8EtQJO0cjybwpt10uHM+ufJg84LvR+Ouw@mail.gmail.com>
Subject: Re: [PATCH] rtc: efi: Add runtime check for the wakeup service capability
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-rtc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 18:56, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 11/07/2025 11:26:18+1000, Ard Biesheuvel wrote:
> > On Fri, 11 Jul 2025 at 11:06, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 10 Jul 2025 at 18:41, Feng Tang <feng.tang@linux.alibaba.com> wrote:
> > > >
> > > > The kernel selftest of rtc reported a error on an ARM server which
> > > > use rtc-efi device:
> > > >
> > > >         RUN           rtc.alarm_alm_set ...
> > > >         rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
> > > >         rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
> > > >         alarm_alm_set: Test terminated by assertion
> > > >                  FAIL  rtc.alarm_alm_set
> > > >         not ok 5 rtc.alarm_alm_set
> > > >
> > > > The root cause is, the underlying EFI firmware doesn't support wakeup
> > > > service (get/set alarm), while it doesn't have the EFI RT_PROP table
> > > > either. As Ard Biesheuvel clarified [1], this breaks the UEFI spec,
> > > > which requires EFI firmware to provide a 'RT_PROP' table if it doesn't
> > > > support all runtime services (Section 4.6.2, UEFI spec 2.10).
> > > >
> > > > This issue was also reproduced on ARM server from another vendor, which
> > > > doesn't have RT_PROP table either. This means, in real world, there are
> > > > quite some platforms having this issue, that it doesn't support wakeup
> > > > service while not providing a correct RT_PROP table, which makes it
> > > > wrongly claimed to support it.
> > > >
> > > > Add a runtime check for the wakeup service to detect and correct this
> > > > kind of cases.
> > > >
> > > > [1]. https://lore.kernel.org/lkml/CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com/
> > > >
> > > > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > > > ---
> > > >  drivers/rtc/rtc-efi.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > >
> > > Thanks, I've queued this up now.
> > >
> >
> > Actually, we might just remove the EFI get/set wakeup time
> > functionality altogether, as it seems rather pointless to me to begin
> > with.
> >
> > I'll send out an RFC shortly.
>
> I guess this is going to also solve the issue reported by loongson
> https://lore.kernel.org/linux-rtc/20250613061747.4117470-1-wangming01@loongson.cn/
>
> However, please let me take care of patches in my subsystem...
>

Apologies - I've dropped it now.

But please don't queue this, I'll send out my RFC shortly.

