Return-Path: <linux-efi+bounces-1353-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BA391E10A
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 15:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B521F21EF6
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7939814B96E;
	Mon,  1 Jul 2024 13:45:08 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A470115E5D3;
	Mon,  1 Jul 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841508; cv=none; b=F9XvdzJDJqtWo11KK+lIBWXE9t9KzHHXHjbA0cLWLdIoEqRwDPolhfCFGd6vPBrIGk+8S2djqPnyPaCRx/+AWL4QlcJYIuj2J7YktI6Be9puH0tAeUSPFI0ZzfJHVU/bFR/Jvl2hrFmT1QfUU3pLa5SGEPvIuNxGHqH5tt1a4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841508; c=relaxed/simple;
	bh=8yk7TzMBp8LQxMDCULwcQoiummuODihgQAn/T9L1wQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpgB2ejpz4tN8gVxCK1ReWe6Qz3v3Z2KpddUaULJaYAGTuWHZNU4ipT5Pds/ZO/X+HDtnl16YBfgbkc7t41n868LJhJ+1Ok4gsyzYp0aZg7kCh1ZQF7El3tL46DKx+il1l6A2fFU5usV+FxY25YhxwK8jDw4raAy3RHccgeXGmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 08337100DA1CB;
	Mon,  1 Jul 2024 15:44:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AEAC331F8C9; Mon,  1 Jul 2024 15:44:54 +0200 (CEST)
Date: Mon, 1 Jul 2024 15:44:54 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc: ardb@kernel.org, gargaditya08@live.com, hdegoede@redhat.com,
	kekrby@gmail.com, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Message-ID: <ZoKy1jeLC-FRLJgr@wunner.de>
References: <ZoJcVf98MElXhMjT@wunner.de>
 <20240701231452.3d547e7f@redecorated-mbp>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701231452.3d547e7f@redecorated-mbp>

On Mon, Jul 01, 2024 at 11:14:52PM +1000, Orlando Chamberlain wrote:
> > FWIW, there would be only 6 models to match if this needs to be
> > constrained to ones with dual GPUs:
> >
> > MacBookPro11,3
> > MacBookPro11,5
> > MacBookPro13,3
> > MacBookPro14,3
> > MacBookPro15,1
> > MacBookPro16,1
> 
> I know that at least these two also need it:
> MacBookPro16,4
> MacBookPro15,3

Ah okay, thanks.  I went by the list in Wikipedia, disappointing
that it apparently wasn't updated with those final T2 models:

https://en.wikipedia.org/wiki/MacBook_Pro_(Intel-based)


> I think there could be more older ones too. Apple has a list of
> MacBookPros [0], but I don't know how many of the older models that
> list 2 gpus on their "Tech Specs" pages need apple-set-os.

No, Bruno Bierbaumer's page lists the MacBookPro11,3 and 11,5
as the first models that need apple_set_os:

https://github.com/0xbb/gpu-switch

I'm still using a MacBookPro9,1 (last pre-retina) on a daily basis
and apple_set_os isn't needed there.  Neither on the MacBookPro10,1
(first retina).  Both were introduced mid 2012.


> The original apple-set-os code was posted to the GRUB mailing list in
> December 2013 [1] so maybe it was in 2013 that new dual GPU Macbooks
> started needing apple-set-os?

Yes, Haswell generation introduced Oct 2013 was the first one that
needed it.

Thanks,

Lukas

