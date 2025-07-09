Return-Path: <linux-efi+bounces-4264-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B96AFF568
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 01:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2FF5A8313
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 23:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4454D25C833;
	Wed,  9 Jul 2025 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9965+75"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB902459FE;
	Wed,  9 Jul 2025 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752104018; cv=none; b=h75W9+nL7fdEl31DU9uHEM4rbe/0WKSmrnwM5fr51gbQOccuXZ38XRaeCrju+/oLk61KezVRA3vcMQPZylOGfcW44oDWpLHOHRYpYYMsYxvNsWw7h5dLE+36TRQtCu/yTxWiXn1Ed4kgBudrJysxtdoScKOGkxZAv+5+wsYZFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752104018; c=relaxed/simple;
	bh=KN3ryJg70miFlqFy4in/+8Iwbx0iP26bdXxXVbvfJiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgcF70kYUx918Ul4oWwXyahRxv5Pk8uIrYjeWk7UMSQXS748lZViihXji2ZoUDS7osgQbE0U2AQEvGynfd8thN7E4jestEOSEYt2cSEUvF07A5sfGYW8f/UXy+UExU8ucAOAij8Ult2Mw7dDlxogGfBCs+rXDnxPO6EKYyrrJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9965+75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C6CC4CEF5;
	Wed,  9 Jul 2025 23:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752104015;
	bh=KN3ryJg70miFlqFy4in/+8Iwbx0iP26bdXxXVbvfJiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m9965+75QTQOSB8vZmrlz0cbC//HVhXjXIlOCV2/k3QNLLKe7fTCl3Y6SR9Ir42A2
	 cZI5xIztK4ejolTd0zN3ftwV6bU7LwlIzUb0qvzemQCFQkKcOXsjPMoxnZpk3b9bfA
	 gOW2uFqNVzjPcvp5x4GEhNmnOia8LSn0Ii0PjXVe+U55ztdn0DSW0jGHD791QqJS24
	 dVMOXrednkT4HOIfMl/kn99biebe88o6qkJJeytnUGmJgQtLXVXOsKaomuhZusMGv6
	 uFjIW876en03Zh3KzBnkgGm6DfkQt3DrF5aF6L84n3FX9/xKNyD83lVN+VNFM4JB10
	 pTPR11rAQ/lRA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-558fa0b2c99so266820e87.2;
        Wed, 09 Jul 2025 16:33:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMGCpwodMEvSvM5Y0JJ8aypQmYmATRoaLlI1L7NxkHh+yplOJlwnK/1yeZxXftgym6P1G15830+f1KDpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYqPkUgAg4QNubYP3LUJ1UCP6U81/Jzy07eGDmyWiILv2g1vA
	FwBrnsaQqhcEhRD3vLLah9gPcuCQmUrHve63IVeRea2UWsWbl7Enxww6xX/JtoU02K34WjTy1rI
	3tzyWGMoGyNoJGIpo8cPetrwcDOKOoh4=
X-Google-Smtp-Source: AGHT+IGHJkzs08j74d/j571QvtjzCViOCskOj13okKejdpeyF1bSvgeJBx7+yiT0JyYy7J7Rs2KQLYjnijAh2Kd0S2A=
X-Received: by 2002:a05:6512:ba1:b0:553:ab9a:c94 with SMTP id
 2adb3069b0e04-558fa877660mr1419512e87.6.1752104013886; Wed, 09 Jul 2025
 16:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709103541.7268-1-feng.tang@linux.alibaba.com>
 <CAMj1kXEvxPjFsqoMzZnb2zxSf9uyLVzuzKEeKD4fLEux3NbUhw@mail.gmail.com> <aG5Lod-McOlBmt7_@U-2FWC9VHC-2323.local>
In-Reply-To: <aG5Lod-McOlBmt7_@U-2FWC9VHC-2323.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 10 Jul 2025 09:33:19 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com>
X-Gm-Features: Ac12FXxBeMvD2NKHHndGU-JJq4Rqs2AwOFrTJ8lHL8syscDtxlFOmBHaX_PcbyI
Message-ID: <CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com>
Subject: Re: [PATCH] efi: remove the rtc-wakeup capability from default value
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 21:00, Feng Tang <feng.tang@linux.alibaba.com> wrote:
>
> On Wed, Jul 09, 2025 at 08:42:24PM +1000, Ard Biesheuvel wrote:
> > On Wed, 9 Jul 2025 at 20:35, Feng Tang <feng.tang@linux.alibaba.com> wrote:
> > >
> > > The kernel selftest of rtc reported a error on an ARM server:
> > >
> > >         RUN           rtc.alarm_alm_set ...
> > >         rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
> > >         rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
> > >         alarm_alm_set: Test terminated by assertion
> > >                  FAIL  rtc.alarm_alm_set
> > >         not ok 5 rtc.alarm_alm_set
> > >
> > > The root cause is, the unerlying EFI firmware doesn't support wakeup
> > > service (get/set alarm), while it doesn't have the efi 'RT_PROP'
> > > table either. The current code logic will claim efi supports these
> > > runtime service capability by default, and let following 'RT_PROP'
> > > table parsing to correct it, if that table exists.
> > >
> > > This issue was reproduced on ARM server from another verndor, and not
> > > reproudce on one x86 server (Icelake). All these 3 platforms don't have
> > > 'RT_PROP' tables, so they are all claimed to support alarm service,
> > > but x86 server uses real CMOS RTC device instead rtc-efi device, and
> > > passes the test.
> > >
> > > So remove the wakeup/alarm capability from default value, and setup
> > > the capability bits according to the 'RT_PROP' table parsing.
> > >
> >
> > What does this achieve? The test result is accurate, as the platform
> > violates the spec by not implementing the RTC wakeup services, and not
> > setting the RT_PROP table bits accordingly.
> >
> > What do we gain by pretending that the platform is not broken, and
> > lying about it?
>
> I don't have much experience with EFI, so I might be totally wrong. I
> don't think not providing the RT_PROP table is 'broken', that's why I
> tried to borrow platforms from different vendors to do the check, which
> all have no this table.
>
> For platform which have no 'RT_PROP' tables (seems to be not a rare case),
> claiming them support all efi runtime service may be kind of risky.
>

It is the other way around. The UEFI spec mandates that all runtime
services are implemented, unless a RT_PROP table is provided.

