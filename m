Return-Path: <linux-efi+bounces-2828-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F510A46002
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 14:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E97F189409F
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D78D18027;
	Wed, 26 Feb 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZI0usb5m"
X-Original-To: linux-efi@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA680BEC
	for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574968; cv=none; b=IWIDErBIkLSbYSlThvotVIcj9MXK9I4vW7rPBrJGXa2atom6utywaxrJmJxTxuUE9Hbg9rvM9z4TBgbm1Imar9qSlzabUv5AYhmiBm6DtsKU5nctyhdTlMEKjPv0Wqux9Xwu1SyLpxjP557g+3lc6H1BOQA3O/mwxUrU+x/iDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574968; c=relaxed/simple;
	bh=SNKhYbYt318SR7Em3CdtIvzg9A45agpxfUYFStEcurw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ibdMLc+MoiW2YTMfE2DtzEX/PHlNqtln6Czgzp3jtvq2MckZBBNgnqaSDZqNDPwbVOmyGl9Ec3WW6ERakiEB6mQfe2C3tSgphT1Pe6It85ld/Srr5OijxF3lpEZeahB3psjrBhhT3VD5j1rg6KkAcNnV+JGrPiuY1jTWm7EQNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZI0usb5m; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740574964;
	bh=SNKhYbYt318SR7Em3CdtIvzg9A45agpxfUYFStEcurw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZI0usb5mkhYv6ZqTdnRbke92QDzHUN8gquPeR4Kmsmov84oIyY4/9SoVtSCQyh/lp
	 CLpKn/tlhE/H01OTb8Us/Xth7Hmzk/JD3X1kRnVaKnBhLRnWod01KNoU5onBXRgMw0
	 R2e0B8b5a2rsF5cn5ve0WaFuqy8aDWv6FrtiGkxQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 8FCA91C2566;
	Wed, 26 Feb 2025 08:02:44 -0500 (EST)
Message-ID: <0ebb2fc8cbab6be663ad7504db3b7d89d0f2ae5c.camel@HansenPartnership.com>
Subject: Re: efivarfs: fix error on write to new variable leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Richard Hughes <richard@hughsie.com>, linux-efi@vger.kernel.org
Date: Wed, 26 Feb 2025 08:02:43 -0500
In-Reply-To: <CAMj1kXGsZVAWmG7NV+6fevvZy6RwEXrw2avT1EBRWjn5Kk_hvw@mail.gmail.com>
References: 
	<SBFUY-p4-fI9JOrQa51x141vKHs_rbFLw4q9kfPGAK8Z76PQfgYl6zM3nUjlOeIPY6PgEhqLFaSJkW0vdBVzET3MDYUBZwzmYCJuNK4TaYU=@hughsie.com>
	 <ffd953c76d3a0bc0f88aeb319589632e8da032dc.camel@HansenPartnership.com>
	 <CAMj1kXGsZVAWmG7NV+6fevvZy6RwEXrw2avT1EBRWjn5Kk_hvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-26 at 12:30 +0100, Ard Biesheuvel wrote:
> On Tue, 25 Feb 2025 at 13:59, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > [added correct mailing list for bug report]
> > On Tue, 2025-02-25 at 12:10 +0000, Richard Hughes wrote:
> > > Hi,
> > > 
> > > I'm not sure what I'm supposed to do about:
> > > 
> > > commit 908af31f4896f2c0645031f8b74a89d3a8beb5b9
> > > Author: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Date:   Sun Jan 19 10:12:12 2025 -0500
> > > 
> > >     efivarfs: fix error on write to new variable leaving remnants
> > > 
> ...
> > > 
> > > It causes a regression in fwupd -- seen in
> > > https://github.com/fwupd/fwupd/issues/8495 and
> > > https://bugzilla.redhat.com/show_bug.cgi?id=2346831 so far -- and
> > > it seems broken for anyone (including me) updating to 6.14.
> > 
> > OK, so the problem with this as a bug report is that it doesn't
> > explain what you're doing.  However
> > 
> > > I can work around the behavior in
> > > https://github.com/fwupd/fwupd/pull/8500 (which is also the
> > > arguably correct thing to do) but it's going to cause a panic as
> > > I have to get an updated fwupd out on all distros so we'll need
> > > releases for multiple branches.
> 
> This code was introduced in the merge window for v6.14, which is due
> to be released end of March. How much time do you need?

The request in the original was for a few more months.

> Derailing LVFS is the last thing I want to do, but we all know how
> this works: once a workaround is put in, it is never going to be
> removed.

I think simply queueing the workaround now (If it works; I'd still like
to see a tested by since it's nowhere near a pure revert) in the fixes
branch for the v14-rc and immediately queueing its revert in the
updates for v15 would give an additional three months automatically and
no-one would have to do anything more (unless more time were needed).

Regards,

James


