Return-Path: <linux-efi+bounces-2786-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AF3A2F9BA
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 21:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74BE3A571A
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 20:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEA424C687;
	Mon, 10 Feb 2025 20:09:18 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C94B24C67A;
	Mon, 10 Feb 2025 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739218158; cv=none; b=UazanUX0yWoJj2i387KDbbVjUrcUfCx6NOVGAPvpNHH010zn1MZQOs1Pk3BJ2HVDk5DfiVPoY4OHuQvw8F/sNtnty3gaNei80M5sQjpcrmDjLamsBcEkkvasLz9VKIaFDjwsAjprfFUGAVQe574z0LKFfFtsgwfI+1c1g7WmCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739218158; c=relaxed/simple;
	bh=Xak6uh1OA7Y0BzIO5iFJWeHBlh+xolgPuU4qT7XePH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQK29AaySJEdkGdxQfIJpIlKdkKDi8zgLSARU4qz2wQGrQ/nbFbFp7xoqEgiPIKJsniNzE/Ffl0/VXHMV8ro6oV/KZuKbEvOz7tQZkdZPD5Irm1EPiJw2fQnZ8S5fv1JaFpC9VmxvOAKxvFwX3ckhefhTJFYoigW6G4b5WFJpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 71A75100E5F5A;
	Mon, 10 Feb 2025 21:09:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 57B6D2C0470; Mon, 10 Feb 2025 21:09:09 +0100 (CET)
Date: Mon, 10 Feb 2025 21:09:09 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <gargaditya08@live.com>
Cc: Lleyton Gray <lleyton@fyralabs.com>, Ard Biesheuvel <ardb@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Message-ID: <Z6pc5SYaMhOfXeDz@wunner.de>
References: <20241228202212.89069-1-lleyton@fyralabs.com>
 <Z3EdkuCBzTGzTHK3@wunner.de>
 <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>
 <Z3EmoNWbkbYZ7NZO@wunner.de>
 <CAMj1kXEb9NPSwEr2brHYJtFQhnW55hoPycjcAgoPAfjU5ZFqZw@mail.gmail.com>
 <abe2274b-4341-4212-85a8-113273ce1b18@fyralabs.com>
 <PN3PR01MB7728B4C94846673A5FFACE29B80B2@PN3PR01MB7728.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN3PR01MB7728B4C94846673A5FFACE29B80B2@PN3PR01MB7728.INDPRD01.PROD.OUTLOOK.COM>

On Wed, Jan 01, 2025 at 11:39:13AM +0000, Aditya Garg wrote:
> We have had issues with other people unable to use their eGPU if their
> Mac doesn't have the apple set os quirk. We probably could do dual VGA
> checks suggested by Lukas, but will it work with GPU hotplug?

About hotplug:  There is a tiny time window when the EFI stub runs
during which an eGPU may be hotplugged and incorrectly not be
detected.  I.e. the quirk is not applied.  I don't think this can
be fixed.

If an eGPU is hotplugged while EFI boot services are still running,
Apple's EFI Thunderbolt driver will set up a tunnel to the device
and it will then be visible to the kernel's efi stub.  E.g. if you
hold down the Option key during boot and attach an eGPU, then
select the operating system to boot, the eGPU should correctly be
seen by the efi stub and the quirk is applied.

However hotplugging an eGPU at exactly the moment when the efi stub
runs results in a race between the efi stub doing all the initialization
and exiting boot services on the one hand, and the EFI Thunderbolt
driver bringing up the eGPU on the other hand.

But IMO this is "good enough".

Thanks,

Lukas

