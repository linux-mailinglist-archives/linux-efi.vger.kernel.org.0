Return-Path: <linux-efi+bounces-4245-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE1AFE6DF
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 13:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07345163254
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB063595C;
	Wed,  9 Jul 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Sche2DAG"
X-Original-To: linux-efi@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E2C259CA9;
	Wed,  9 Jul 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059116; cv=none; b=JSKE5rOOaDASRALioXTdWOJYyfEe5dIoTQWhxEgHYIeqPmvuj905HWEqzw8PVzwyZsLhfg5Ox2NNqyIGxdA8KAhreNJzCqHtXwyYPgEBbaOpr9PGBwi1cv8mjho6BMjbPkQmi73IT+JmZl4sTg9voli+oAOhqjTm0Jta9Q/k7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059116; c=relaxed/simple;
	bh=zC5DMURo7dk1BXBoQPOLaJiSa8UzYlbWp5CUbluR7b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPz832WcMoN9wAklETYvEI6eKF/aJOaee8HaZYplGpj+lUHB8Tpz5yFBs2rWALo8+MxzL/fea+Vo7u1bU5voRx+yVAR/Z13ayDBF5ZNQ3d5oHBrZet9p7psLAivqL2swtukggEnaokR6Hnq7v+2kGTBTBYQAVHumYiHPH+KJ2yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Sche2DAG; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752059105; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=ss3HlPeDIPax/mtYrqLltP9bIdYBxx6PDDADcRZoukA=;
	b=Sche2DAG2QPGkt8LDm7adVJ6YdtRj+mHs4n/4sgfjnW4/aOk01eXab1hDLhI5P8ksuU7Jjce/Pm20Tm4iHySFJY0tkUOT/lfHf9c5tVCs89AevxLmD81qknK0vTy3GHbkgaEoHlUNYQA7f6tedKlVmxriOiagQazLUnx/TFCilQ=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WiXrtbM_1752058785 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 18:59:46 +0800
Date: Wed, 9 Jul 2025 18:59:45 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: remove the rtc-wakeup capability from default value
Message-ID: <aG5Lod-McOlBmt7_@U-2FWC9VHC-2323.local>
References: <20250709103541.7268-1-feng.tang@linux.alibaba.com>
 <CAMj1kXEvxPjFsqoMzZnb2zxSf9uyLVzuzKEeKD4fLEux3NbUhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEvxPjFsqoMzZnb2zxSf9uyLVzuzKEeKD4fLEux3NbUhw@mail.gmail.com>

On Wed, Jul 09, 2025 at 08:42:24PM +1000, Ard Biesheuvel wrote:
> On Wed, 9 Jul 2025 at 20:35, Feng Tang <feng.tang@linux.alibaba.com> wrote:
> >
> > The kernel selftest of rtc reported a error on an ARM server:
> >
> >         RUN           rtc.alarm_alm_set ...
> >         rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
> >         rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
> >         alarm_alm_set: Test terminated by assertion
> >                  FAIL  rtc.alarm_alm_set
> >         not ok 5 rtc.alarm_alm_set
> >
> > The root cause is, the unerlying EFI firmware doesn't support wakeup
> > service (get/set alarm), while it doesn't have the efi 'RT_PROP'
> > table either. The current code logic will claim efi supports these
> > runtime service capability by default, and let following 'RT_PROP'
> > table parsing to correct it, if that table exists.
> >
> > This issue was reproduced on ARM server from another verndor, and not
> > reproudce on one x86 server (Icelake). All these 3 platforms don't have
> > 'RT_PROP' tables, so they are all claimed to support alarm service,
> > but x86 server uses real CMOS RTC device instead rtc-efi device, and
> > passes the test.
> >
> > So remove the wakeup/alarm capability from default value, and setup
> > the capability bits according to the 'RT_PROP' table parsing.
> >
> 
> What does this achieve? The test result is accurate, as the platform
> violates the spec by not implementing the RTC wakeup services, and not
> setting the RT_PROP table bits accordingly.
> 
> What do we gain by pretending that the platform is not broken, and
> lying about it?

I don't have much experience with EFI, so I might be totally wrong. I
don't think not providing the RT_PROP table is 'broken', that's why I
tried to borrow platforms from different vendors to do the check, which
all have no this table.

For platform which have no 'RT_PROP' tables (seems to be not a rare case),
claiming them support all efi runtime service may be kind of risky.

> 
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> >  drivers/firmware/efi/efi.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index e57bff702b5f..7cf35376a2f7 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -789,6 +789,17 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
> >                 }
> >         }
> >
> > +       /*
> > +        * After bootup, the runtime_supported_mask was set to be capable of
> > +        * all features, which could be kind of too optimistici. In real
> > +        * world, many platforms don't support advanced RTC wakeup runtime
> > +        * service, while they don't provide RT_PROPERTY table either, which
> > +        * led to rtc-wakeup capability being worngly claimed.
> > +        *
> > +        * So remove the wakeup capbility from default value, and let the
> > +        * RT_PROPERTY do the judge.
> > +        */
> > +       efi.runtime_supported_mask &= ~EFI_RT_SUPPORTED_WAKEUP_SERVICES;
> >         if (rt_prop != EFI_INVALID_TABLE_ADDR) {
> >                 efi_rt_properties_table_t *tbl;
> >
> 
> Doesn't this break the RTC wakeup services on platforms that do
> implement them, and don't expose a RT_PROP table?

You are right, there is such risk.

Thanks,
Feng


