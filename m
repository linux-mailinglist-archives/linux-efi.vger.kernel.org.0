Return-Path: <linux-efi+bounces-4269-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0E1AFFAC5
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA043BCFC4
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F71288C2F;
	Thu, 10 Jul 2025 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z0fm0Heh"
X-Original-To: linux-efi@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F6288C27;
	Thu, 10 Jul 2025 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132262; cv=none; b=dYmAXnp1e6FkUoKaFFEMU8IvjTpD8KJ46w0P4aEYDPdqgBFKnwMyVNbJHiQAN5Q86wznL0V4QPgC7sySRnx5r4vjpWIEv79i5LdyhEA/rBf62DXyEWtKXhY2nJ/PrIyRzi0DMRxAejzQQG9Z/JZfcSdqyZLxnUYJ4Ax75VeUMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132262; c=relaxed/simple;
	bh=hj1wHBXsOXAzb0/74g63WRGpCXf33Xc+zY0S+GiRtF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6CQzfvZ6n1R5/Q5YUwc8a+Uq8Ym4PErQugbBXp1yWrJ48DZuGjfQJdNFiGLUqJybhDxJgW/0I2vmfwV5sdRqWEmDIhHEjJriBgFU64dRCQJn5i4Vy3Fa+wllX1CSynVFRkgWpwCN/ex0y6qcpiiOkYh35tS7bAA1ZG+p7exHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z0fm0Heh; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752132250; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=jzNpYOFOnap/qF7qFC2NV9w8EFH37E1K9D31EdWc9Yk=;
	b=Z0fm0HehE9gbr02XGj17KU/Jh/mvcu1K9a5Tse50GMEp2qUXiY4GHuXQBWlVxETC9Q+8bFjtzzI0IK62GKYvAeNgKlJzhHlK4E0J7SSg9Mc2JxxqIQqjw2GeuIxUOtT1KalZgRjrYJOBNj6OBaIzy4E6RhxOdDbKkyGW32E/+eo=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wic.8WA_1752132249 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 15:24:09 +0800
Date: Thu, 10 Jul 2025 15:24:09 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: remove the rtc-wakeup capability from default value
Message-ID: <aG9qmV-wzFr7I-Tb@U-2FWC9VHC-2323.local>
References: <20250709103541.7268-1-feng.tang@linux.alibaba.com>
 <CAMj1kXEvxPjFsqoMzZnb2zxSf9uyLVzuzKEeKD4fLEux3NbUhw@mail.gmail.com>
 <aG5Lod-McOlBmt7_@U-2FWC9VHC-2323.local>
 <CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com>

Add Alexandre Belloni for his view on rtc-efi driver

On Thu, Jul 10, 2025 at 09:33:19AM +1000, Ard Biesheuvel wrote:
> On Wed, 9 Jul 2025 at 21:00, Feng Tang <feng.tang@linux.alibaba.com> wrote:
> >
> > On Wed, Jul 09, 2025 at 08:42:24PM +1000, Ard Biesheuvel wrote:
> > > On Wed, 9 Jul 2025 at 20:35, Feng Tang <feng.tang@linux.alibaba.com> wrote:
> > > >
> > > > The kernel selftest of rtc reported a error on an ARM server:
> > > >
> > > >         RUN           rtc.alarm_alm_set ...
> > > >         rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
> > > >         rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
> > > >         alarm_alm_set: Test terminated by assertion
> > > >                  FAIL  rtc.alarm_alm_set
> > > >         not ok 5 rtc.alarm_alm_set
> > > >
> > > > The root cause is, the unerlying EFI firmware doesn't support wakeup
> > > > service (get/set alarm), while it doesn't have the efi 'RT_PROP'
> > > > table either. The current code logic will claim efi supports these
> > > > runtime service capability by default, and let following 'RT_PROP'
> > > > table parsing to correct it, if that table exists.
> > > >
> > > > This issue was reproduced on ARM server from another verndor, and not
> > > > reproudce on one x86 server (Icelake). All these 3 platforms don't have
> > > > 'RT_PROP' tables, so they are all claimed to support alarm service,
> > > > but x86 server uses real CMOS RTC device instead rtc-efi device, and
> > > > passes the test.
> > > >
> > > > So remove the wakeup/alarm capability from default value, and setup
> > > > the capability bits according to the 'RT_PROP' table parsing.
> > > >
> > >
> > > What does this achieve? The test result is accurate, as the platform
> > > violates the spec by not implementing the RTC wakeup services, and not
> > > setting the RT_PROP table bits accordingly.
> > >
> > > What do we gain by pretending that the platform is not broken, and
> > > lying about it?
> >
> > I don't have much experience with EFI, so I might be totally wrong. I
> > don't think not providing the RT_PROP table is 'broken', that's why I
> > tried to borrow platforms from different vendors to do the check, which
> > all have no this table.
> >
> > For platform which have no 'RT_PROP' tables (seems to be not a rare case),
> > claiming them support all efi runtime service may be kind of risky.
> >
> 
> It is the other way around. The UEFI spec mandates that all runtime
> services are implemented, unless a RT_PROP table is provided.

Thanks for the explaination! Yes, it's fair to claim the uefi implementation
on the 2 ARM servers 'broken' :)

I talked with some firmware developers. They said the rtc-alarm service could
be implemented, while the difficult part is how to notify OS. I submitted a 
request for a correct RT_PROP table.

Meanwhile, given there are quite some platforms (All ARM server I can access)
don't have the table and not support rtc wakeup service, I'm thinking of adding
some runtime check for the service in rtc-efi driver, something like:

---
diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index fa8bf82df948..7ae948aebd11 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -259,6 +259,7 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	struct rtc_device *rtc;
 	efi_time_t eft;
 	efi_time_cap_t cap;
+	efi_bool_t enabled, pending;
 
 	/* First check if the RTC is usable */
 	if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
@@ -272,7 +273,8 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 
 	rtc->ops = &efi_rtc_ops;
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES) &&
+		efi.get_wakeup_time(&enabled, &pending, &eft) == EFI_SUCCESS)
 		set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
 	else
 		clear_bit(RTC_FEATURE_ALARM, rtc->features);

This works on one ARM server I can test kernel with. Any suggestions?

Thanks,
Feng

