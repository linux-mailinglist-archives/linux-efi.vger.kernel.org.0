Return-Path: <linux-efi+bounces-4284-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F6B016F9
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 10:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC1582DC2
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0DE2080C8;
	Fri, 11 Jul 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MRndLyM9"
X-Original-To: linux-efi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A61F239B;
	Fri, 11 Jul 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224173; cv=none; b=KzKz2LQkSNoYZjkEWl24Q/gv9EVNVAY7Hw1IEomRm8+C7E3GGdOXvL4cXd/YxKMC3WulqSF+aWeNcs+pwR1xO/mqyjhPxselUNN5L4LjVhXz6IGyfKMxJYQ7UmLYHoIk9I/rp/R52ia1Kr1HPuWBeICaf/ZFrhPcsl69EwITLWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224173; c=relaxed/simple;
	bh=nGZxBPgcyvIXg3cWoL9n7n609A6VK6iikw5GRM1A1mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC3PnAK7Xb6CuKkSYinc7qLV7MtFGix1RC2oOqDQ+2/H1QzyzFyRJuCi7j7VYWsOxiXmFCwnx83FVd4Ah86j2qhik8JZvr1SJl9sBCqgswaLLRGtOtQMo+PFP0rWG6MgnT1BLcaOkUWDqSZbeOOJPKeR2JVmxUh1jV+DjZJ9wY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MRndLyM9; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DD9A205B6;
	Fri, 11 Jul 2025 08:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752224169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3s4Z6xT0P2MBx5071F2O5vZS5sxJmlJEOi3WGKuQ1M=;
	b=MRndLyM9KDDN2xOekjN5Fucibl4QMHrF4zp83Cu96ZGwegXXOXl/bo3+oJYx4Fc46ThJbC
	hUO0lgFZIuVQQ4os4qgc1HM3cixgBOz0htA0AcA4JjQmPddlb+k4Tcq2m8h13S9Zx/tyS0
	MLGAh7xyQHMIdDbEH62Yvu4o1ygX+ILqMUjxZc+I2vMZ34//vhkqrh8bGggWAQ5Kpith7L
	d6mp2Nop54xeakqep10lQCq4H4QeVkA+pUGgaDPlAiewI2EBPl3FahtieCnn5ASotCvy0k
	H3yAY61SHaAGEw0VHjxe0kgMxkIHKvqTgQtziaHaIUiV7KwV9c6Z3t94W+ddkg==
Date: Fri, 11 Jul 2025 10:56:08 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: efi: Add runtime check for the wakeup service
 capability
Message-ID: <20250711085608f4146d99@mail.local>
References: <20250710084151.55003-1-feng.tang@linux.alibaba.com>
 <CAMj1kXHDFq3FZj4134CTcQZnke4t1=u6iRNNsQBvuhb3F6KurQ@mail.gmail.com>
 <CAMj1kXGiixvwsSmOz65F=OXQuHovO4DMAsJaPZ2sL3PBbMHh8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGiixvwsSmOz65F=OXQuHovO4DMAsJaPZ2sL3PBbMHh8A@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemvgdtfhgvmeegfhdvfhemvdelvgegmeehudejtgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemvgdtfhgvmeegfhdvfhemvdelvgegmeehudejtgdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhgvnhhgrdhtrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdpr
 hgtphhtthhopehlihhnuhigqdhrthgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

On 11/07/2025 11:26:18+1000, Ard Biesheuvel wrote:
> On Fri, 11 Jul 2025 at 11:06, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 10 Jul 2025 at 18:41, Feng Tang <feng.tang@linux.alibaba.com> wrote:
> > >
> > > The kernel selftest of rtc reported a error on an ARM server which
> > > use rtc-efi device:
> > >
> > >         RUN           rtc.alarm_alm_set ...
> > >         rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
> > >         rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
> > >         alarm_alm_set: Test terminated by assertion
> > >                  FAIL  rtc.alarm_alm_set
> > >         not ok 5 rtc.alarm_alm_set
> > >
> > > The root cause is, the underlying EFI firmware doesn't support wakeup
> > > service (get/set alarm), while it doesn't have the EFI RT_PROP table
> > > either. As Ard Biesheuvel clarified [1], this breaks the UEFI spec,
> > > which requires EFI firmware to provide a 'RT_PROP' table if it doesn't
> > > support all runtime services (Section 4.6.2, UEFI spec 2.10).
> > >
> > > This issue was also reproduced on ARM server from another vendor, which
> > > doesn't have RT_PROP table either. This means, in real world, there are
> > > quite some platforms having this issue, that it doesn't support wakeup
> > > service while not providing a correct RT_PROP table, which makes it
> > > wrongly claimed to support it.
> > >
> > > Add a runtime check for the wakeup service to detect and correct this
> > > kind of cases.
> > >
> > > [1]. https://lore.kernel.org/lkml/CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com/
> > >
> > > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > > ---
> > >  drivers/rtc/rtc-efi.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> >
> > Thanks, I've queued this up now.
> >
> 
> Actually, we might just remove the EFI get/set wakeup time
> functionality altogether, as it seems rather pointless to me to begin
> with.
> 
> I'll send out an RFC shortly.

I guess this is going to also solve the issue reported by loongson
https://lore.kernel.org/linux-rtc/20250613061747.4117470-1-wangming01@loongson.cn/

However, please let me take care of patches in my subsystem...


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

