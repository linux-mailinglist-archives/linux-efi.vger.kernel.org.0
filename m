Return-Path: <linux-efi+bounces-4282-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F531B010CA
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 03:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309FB3A67E4
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 01:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4A272616;
	Fri, 11 Jul 2025 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJf/j2N5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDAF6F073;
	Fri, 11 Jul 2025 01:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197192; cv=none; b=tugRKl7ZBfFX3CLa8nm2ThLtKqsLQHJlgxQ4agcEo5B8p9RI86L9ROGr96TWCyHrYQmCNf/NkmzEntwEf3lROoaK0xgWKU3O96ddXspfoeYYIe/L/kp7PR88dPxrk0jQ27IxD6h71DRDSW18xTh7iRL+VBfykYDMnq6yO2opyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197192; c=relaxed/simple;
	bh=RfxQfmg2Dd887FUvfCHez0x+Wjj1R3iRmWBqk9ugQCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNYhM42WXbG39Rcy7V60nVcz1wA6llz8LvHG4xWyA6w0ln+mcmviI94LvUMgEik8FUzI4jsweKxWhWg4REiRhbXC01a8qExsNTxtKM6jqhYjHv1f/7gI96Q1/BxgSxU9pgfnGJrtJw8Ill/VA+BcJmiwGOLJOyAUqpes45ugHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJf/j2N5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF880C4CEF4;
	Fri, 11 Jul 2025 01:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752197191;
	bh=RfxQfmg2Dd887FUvfCHez0x+Wjj1R3iRmWBqk9ugQCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rJf/j2N5Q07CWlnP1M4BmFz+2uM8GwTbXMe4Z0A27pXRY4lShSKueYZ7JLD7Jf9Dj
	 SAFT1DClPlKSk07Vvqcx+eebmjjZaqkA5a96eDeSim+VhOITOEjLkVfThC52B6apT5
	 raRNrns+3fugjK3MfvRlNV5JU90vpQMeSXNyeSeh5B7/7yuB7+1e5zcLW1oZ1eaEZu
	 qsV0RAyL1dfV35pEKNoNFvIrs8EH90J7EukkJcj7TxTJP8RX/9oWn41RnIHL6htcbF
	 Acqbf47NSVxyjBTiCDNfXMUWpCWf/AjdQOrAZEBUDlQ13laCrG1CG9vRdK3WC+4x+3
	 0MF5rncxvmIxQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553c31542b1so1538312e87.2;
        Thu, 10 Jul 2025 18:26:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4RkhArmKxKRx0egU4kb9lW1I13Yzniu1IvlHLqrEwEsOf8S1pimhWrAdULQttz8u7+qWR+gVxep9poKIo@vger.kernel.org, AJvYcCUlKAvcYUlw4ZGeFTt6gty3EGDbFalyPYAsCAvSY9MX6tw6wmM211R3O9Hg/CJ3pT06SJA3MhrMZQ+4@vger.kernel.org, AJvYcCV+7r3YEUBBm7fVALBZebkv33p4BX0U2DktXsWib7eHDGiSdh/3KZr7ZwcYTMXh0Ul7I7ZNUFIwWEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIoBtJtVgVAOuUbyOPUASkoPXFubiShKTeUSqbgwrRwyXQOom
	YJd8mHbPnm7B9jHZ8tHp2GfbMJf/7TrGwqzIoD+k1q9BN7bXTUFvJCt+wWHPSX2RjtkOv9S9DG4
	Ani3cjV2YKjkN1N9U+TbOc2RIFV+ySSE=
X-Google-Smtp-Source: AGHT+IGGzPWQHD569ufcCOEYTYZwdRC3705oAS6A4zsc48S475Ka2iXU/TxJZAgksgyT8EOmAOqmiGHegF6pdf2KlGk=
X-Received: by 2002:a05:6512:10d6:b0:554:f9cc:bea5 with SMTP id
 2adb3069b0e04-55a04603ce3mr277116e87.34.1752197190066; Thu, 10 Jul 2025
 18:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710084151.55003-1-feng.tang@linux.alibaba.com> <CAMj1kXHDFq3FZj4134CTcQZnke4t1=u6iRNNsQBvuhb3F6KurQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHDFq3FZj4134CTcQZnke4t1=u6iRNNsQBvuhb3F6KurQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 11 Jul 2025 11:26:18 +1000
X-Gmail-Original-Message-ID: <CAMj1kXGiixvwsSmOz65F=OXQuHovO4DMAsJaPZ2sL3PBbMHh8A@mail.gmail.com>
X-Gm-Features: Ac12FXwEVJ2X_qJfiRJv28DHyB9KSTVoj5V-JDQNvsUzFlu0sloXdMqexP7ENj4
Message-ID: <CAMj1kXGiixvwsSmOz65F=OXQuHovO4DMAsJaPZ2sL3PBbMHh8A@mail.gmail.com>
Subject: Re: [PATCH] rtc: efi: Add runtime check for the wakeup service capability
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 11:06, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 10 Jul 2025 at 18:41, Feng Tang <feng.tang@linux.alibaba.com> wrote:
> >
> > The kernel selftest of rtc reported a error on an ARM server which
> > use rtc-efi device:
> >
> >         RUN           rtc.alarm_alm_set ...
> >         rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
> >         rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
> >         alarm_alm_set: Test terminated by assertion
> >                  FAIL  rtc.alarm_alm_set
> >         not ok 5 rtc.alarm_alm_set
> >
> > The root cause is, the underlying EFI firmware doesn't support wakeup
> > service (get/set alarm), while it doesn't have the EFI RT_PROP table
> > either. As Ard Biesheuvel clarified [1], this breaks the UEFI spec,
> > which requires EFI firmware to provide a 'RT_PROP' table if it doesn't
> > support all runtime services (Section 4.6.2, UEFI spec 2.10).
> >
> > This issue was also reproduced on ARM server from another vendor, which
> > doesn't have RT_PROP table either. This means, in real world, there are
> > quite some platforms having this issue, that it doesn't support wakeup
> > service while not providing a correct RT_PROP table, which makes it
> > wrongly claimed to support it.
> >
> > Add a runtime check for the wakeup service to detect and correct this
> > kind of cases.
> >
> > [1]. https://lore.kernel.org/lkml/CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com/
> >
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> >  drivers/rtc/rtc-efi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
>
> Thanks, I've queued this up now.
>

Actually, we might just remove the EFI get/set wakeup time
functionality altogether, as it seems rather pointless to me to begin
with.

I'll send out an RFC shortly.

