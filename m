Return-Path: <linux-efi+bounces-4270-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263ECAFFAED
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 09:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710F94A15FE
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD6323E25B;
	Thu, 10 Jul 2025 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnPUXsw7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92361227EB9;
	Thu, 10 Jul 2025 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132763; cv=none; b=eMyqyM9c/UxBFfe7qmqZ//dzwZr5mdyAmqFkwOKgtXm8+V5ioYnt8FMfyYrpU+A5oNL7zUTvjLMfoXXsQfYJcUrR+7nPOzp5Gwm8PbTfHmFjrkTwFhOn7IB4uHQLkZtqyIKqeDZsqiRQXjz1ULl9bzqNDiexv2sTPZdZ1CNDMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132763; c=relaxed/simple;
	bh=ESvz/aMQ45s+6/z/6QsQGCVI/B73/273Qyl466OeL1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOXHNeltXjipRJQfl6apDi6aocrC8cH2FmEvA+cR7arXEtbqi2K8jX8KahbhO8EToEo3xCPJwro+jJhL6izVXHMVp5cIglxFuRU5vdbNn1Zv0lgExOGrouCPbSx0bG9nn2GknSsY+Mfs8A8YvssR9qu9cTCUpDkjj4imGhmKmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnPUXsw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CF5C4CEF5;
	Thu, 10 Jul 2025 07:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132763;
	bh=ESvz/aMQ45s+6/z/6QsQGCVI/B73/273Qyl466OeL1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GnPUXsw7OJQlyWo6uBqnUBdiNaLRn8lWrqFsE7r86UzusxTd3mRXl2poex8UUxJ3e
	 R4dq1hp1aEeMDta4GqahpX6ycaGiT02CKjQECgOZOgEAanDUXpuM95rYL5kCgXUkx0
	 XWB7CS3vnFLmUNR47RDjFJkRmo3/6uUHwQO7SmVZ08TPHECiDISUv1icdQpf3420OZ
	 ZSCehca3ebFKSMMI5YDH5ivV1HzfxWAUIp8t5Gb85WOTiANqVV+0xIpO/Q9vc91nCK
	 /HGsx1AwoI9rL+R4ArEj78OnBaFrHLgPqf+4UM9Qbu9iwf/5OlFgWfxR4msvFE+D2E
	 Dii0CISHIyWSw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553c31542b1so620156e87.2;
        Thu, 10 Jul 2025 00:32:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBm+xczxuhobLQiX+YCegwbC/3WjtZCIfE1g/saVKew3ZtLT7IK5tfg9azT84TI2M37D1lFQljihjprLea@vger.kernel.org, AJvYcCXe3Afc4oOgBBGR7tUwoQhym0rVsdQA+wx0fA8c6I7YxjKTNLiVkY2+9uXoqFDfEmOoEQxa31Tmlj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJARkW8aeGMoGRnRlb8gR2AtgfUAB32WDjabwsNQeyerN5zeO
	kB8ISUiwqjgVRBXwUhJCO82ZaE6vJnma3vF8irCuH86vS/szzlTi8gN78Z6IWJLH+INnZBYPwGZ
	tlJfSbyT2/mwIODiLFPbedei09QJdc1k=
X-Google-Smtp-Source: AGHT+IEtVwAV9djQfFwoA1IBeLCVCay0CkhTeGJoYyUKB09pexaqDJ1lrfGjS0A4D8sMH88d3zURnxyLFVnl3sWz7E4=
X-Received: by 2002:ac2:4e13:0:b0:553:3407:eee0 with SMTP id
 2adb3069b0e04-5592e2ecd7fmr605344e87.4.1752132761717; Thu, 10 Jul 2025
 00:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709103541.7268-1-feng.tang@linux.alibaba.com>
 <CAMj1kXEvxPjFsqoMzZnb2zxSf9uyLVzuzKEeKD4fLEux3NbUhw@mail.gmail.com>
 <aG5Lod-McOlBmt7_@U-2FWC9VHC-2323.local> <CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com>
 <aG9qmV-wzFr7I-Tb@U-2FWC9VHC-2323.local>
In-Reply-To: <aG9qmV-wzFr7I-Tb@U-2FWC9VHC-2323.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 10 Jul 2025 17:32:30 +1000
X-Gmail-Original-Message-ID: <CAMj1kXG+0hjhNziKMnhKY-uX4V=OBFuS1mUCdZs7VW2DjAsjyg@mail.gmail.com>
X-Gm-Features: Ac12FXzcrwS81h_2LOgE93cGgRkIBJTXEvdRPyKl1GdAjQZ-aeSlCrcwBahhZOg
Message-ID: <CAMj1kXG+0hjhNziKMnhKY-uX4V=OBFuS1mUCdZs7VW2DjAsjyg@mail.gmail.com>
Subject: Re: [PATCH] efi: remove the rtc-wakeup capability from default value
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 17:24, Feng Tang <feng.tang@linux.alibaba.com> wrote:
>
> Add Alexandre Belloni for his view on rtc-efi driver
>
> On Thu, Jul 10, 2025 at 09:33:19AM +1000, Ard Biesheuvel wrote:
> > On Wed, 9 Jul 2025 at 21:00, Feng Tang <feng.tang@linux.alibaba.com> wrote:
> > >
> > > On Wed, Jul 09, 2025 at 08:42:24PM +1000, Ard Biesheuvel wrote:
> > > > On Wed, 9 Jul 2025 at 20:35, Feng Tang <feng.tang@linux.alibaba.com> wrote:
> > > > >
> > > > > The kernel selftest of rtc reported a error on an ARM server:
> > > > >
> > > > >         RUN           rtc.alarm_alm_set ...
> > > > >         rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
> > > > >         rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
> > > > >         alarm_alm_set: Test terminated by assertion
> > > > >                  FAIL  rtc.alarm_alm_set
> > > > >         not ok 5 rtc.alarm_alm_set
> > > > >
> > > > > The root cause is, the unerlying EFI firmware doesn't support wakeup
> > > > > service (get/set alarm), while it doesn't have the efi 'RT_PROP'
> > > > > table either. The current code logic will claim efi supports these
> > > > > runtime service capability by default, and let following 'RT_PROP'
> > > > > table parsing to correct it, if that table exists.
> > > > >
> > > > > This issue was reproduced on ARM server from another verndor, and not
> > > > > reproudce on one x86 server (Icelake). All these 3 platforms don't have
> > > > > 'RT_PROP' tables, so they are all claimed to support alarm service,
> > > > > but x86 server uses real CMOS RTC device instead rtc-efi device, and
> > > > > passes the test.
> > > > >
> > > > > So remove the wakeup/alarm capability from default value, and setup
> > > > > the capability bits according to the 'RT_PROP' table parsing.
> > > > >
> > > >
> > > > What does this achieve? The test result is accurate, as the platform
> > > > violates the spec by not implementing the RTC wakeup services, and not
> > > > setting the RT_PROP table bits accordingly.
> > > >
> > > > What do we gain by pretending that the platform is not broken, and
> > > > lying about it?
> > >
> > > I don't have much experience with EFI, so I might be totally wrong. I
> > > don't think not providing the RT_PROP table is 'broken', that's why I
> > > tried to borrow platforms from different vendors to do the check, which
> > > all have no this table.
> > >
> > > For platform which have no 'RT_PROP' tables (seems to be not a rare case),
> > > claiming them support all efi runtime service may be kind of risky.
> > >
> >
> > It is the other way around. The UEFI spec mandates that all runtime
> > services are implemented, unless a RT_PROP table is provided.
>
> Thanks for the explaination! Yes, it's fair to claim the uefi implementation
> on the 2 ARM servers 'broken' :)
>
> I talked with some firmware developers. They said the rtc-alarm service could
> be implemented, while the difficult part is how to notify OS. I submitted a
> request for a correct RT_PROP table.
>
> Meanwhile, given there are quite some platforms (All ARM server I can access)
> don't have the table and not support rtc wakeup service, I'm thinking of adding
> some runtime check for the service in rtc-efi driver, something like:
>
> ---
> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index fa8bf82df948..7ae948aebd11 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -259,6 +259,7 @@ static int __init efi_rtc_probe(struct platform_device *dev)
>         struct rtc_device *rtc;
>         efi_time_t eft;
>         efi_time_cap_t cap;
> +       efi_bool_t enabled, pending;
>
>         /* First check if the RTC is usable */
>         if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
> @@ -272,7 +273,8 @@ static int __init efi_rtc_probe(struct platform_device *dev)
>
>         rtc->ops = &efi_rtc_ops;
>         clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> -       if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES))
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES) &&
> +               efi.get_wakeup_time(&enabled, &pending, &eft) == EFI_SUCCESS)
>                 set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
>         else
>                 clear_bit(RTC_FEATURE_ALARM, rtc->features);
>
> This works on one ARM server I can test kernel with. Any suggestions?
>

I think this is fine - please send it as a proper patch with commit log etc.

