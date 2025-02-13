Return-Path: <linux-efi+bounces-2792-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C9A33715
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2025 05:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1872816641C
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2025 04:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FDE2040B3;
	Thu, 13 Feb 2025 04:56:21 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC21FBE80;
	Thu, 13 Feb 2025 04:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739422581; cv=none; b=bFX3fwLQMNffIvl/qg7Yi8RI79C3sprTalNvZKj2Bn6jLBt94FenW7v+Im+0LF5hFr9VsjEnuH344t3JP3hBEa+qDi4uJD8oimEHwVgIj0LjHwmd9mUlj6ufxd2Z/EkXjY3xiWFy3XnuW64e4Al2CJcXvm6skqcZv166kMzKvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739422581; c=relaxed/simple;
	bh=N8p5qa++4nVZSAnRKJ/tqr5QpmCFNX686rlWEztOYho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTCQprCYxODFOE0IoCLyc6XelX2qotyKioSDQsAwDIMFhaFqccM8f2OSJO4Aw7xlVq6m/pdBZD/I0MxB0JKp9B0s39AHg2ewMcshZtiuOJQqBG0RQGQwZjV+DpcBl1jMdeZA2XVrzRzE8WXUBmJODGCqsf2m68hu+bX5TDVp7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7C0A7100DA1C2;
	Thu, 13 Feb 2025 05:56:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 48D0D34D01D; Thu, 13 Feb 2025 05:56:09 +0100 (CET)
Date: Thu, 13 Feb 2025 05:56:09 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <gargaditya08@live.com>
Cc: Lleyton Gray <lleyton@fyralabs.com>, Ard Biesheuvel <ardb@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Message-ID: <Z617aePOV7Vj_ffv@wunner.de>
References: <20241228202212.89069-1-lleyton@fyralabs.com>
 <Z3EdkuCBzTGzTHK3@wunner.de>
 <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>
 <Z3EmoNWbkbYZ7NZO@wunner.de>
 <CAMj1kXEb9NPSwEr2brHYJtFQhnW55hoPycjcAgoPAfjU5ZFqZw@mail.gmail.com>
 <abe2274b-4341-4212-85a8-113273ce1b18@fyralabs.com>
 <PN3PR01MB7728B4C94846673A5FFACE29B80B2@PN3PR01MB7728.INDPRD01.PROD.OUTLOOK.COM>
 <Z6paeFrjdv7L3mtv@wunner.de>
 <52B0B784-2FB5-4B7D-8FB6-A7B694EDDFC3@live.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52B0B784-2FB5-4B7D-8FB6-A7B694EDDFC3@live.com>

On Tue, Feb 11, 2025 at 04:05:12PM +0000, Aditya Garg wrote:
> > On 11 Feb 2025, at 1:28AM, Lukas Wunner <lukas@wunner.de> wrote:
> > FWIW, below would be my suggestion for replacing the DMI-based quirk
> > with one that is based on the number of GPUs.
> > 
> > It should invoke the apple_set_os protocol both on dual GPU laptops
> > as well as ones with an eGPU, hence my expectation is that it should
> > fix the issue reported by Lleyton.
> 
> This patch does not enable the os set protocol on my MacBook Pro 16 inch 2019
> 
> journalctl -k: https://pastebin.com/7etWy0D5

Hm, perhaps Apple's EFI disables the iGPU by default and re-enables it
upon the set_os protocol call.  Or I've botched the patch, but I just
double-checked the logic and it seems fine to me.

Could somebody with an eGPU test whether the patch results in the
expected invocation of set_os (and thus a working eGPU)?

If it does, we'd just have to keep apple_match_product_name() as an
alternative condition under which set_os is called.

Thanks,

Lukas

