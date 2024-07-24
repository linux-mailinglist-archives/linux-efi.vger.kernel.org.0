Return-Path: <linux-efi+bounces-1486-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F7F93B4FB
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 18:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2401F21B0B
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1615E5D4;
	Wed, 24 Jul 2024 16:28:29 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3576A039;
	Wed, 24 Jul 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838509; cv=none; b=HE1PcsJvzw+LTbFil0wFBqFWq3NCYH442uqVk4L5pxXNCOy1kVBRx2fmEjoqgi84SzeyPRwlIxbnWytv+8iKh55Val9HdWoTDgx4dhBoeIsnGr/pLX1nk1eptklFsnzmEE/PT/7OHEYXjsxQN9hQger8U0JeubgDWFiOpQHbe4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838509; c=relaxed/simple;
	bh=M6fu0sgBXBIH9ELMRIIMevO5HoNVkN1QIhnVFirQrbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoRbCgK3BzgSNt7+cEJQHFkwjCW0SwziWok2p/bvAJjzh6H4ihkEOdu+JdTK+uRpiKNoWNzNJhLIX5HFjSoBv5A2uYfI1HZs0nNl9PpxFuVQuSakMPo6lkD8zPp16Cq3chSlK2rNbdK0TdKrvSCIGrujhOevusbZ2ftpKnNXwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B58B0300002CB;
	Wed, 24 Jul 2024 18:28:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9D6E42D32F; Wed, 24 Jul 2024 18:28:17 +0200 (CEST)
Date: Wed, 24 Jul 2024 18:28:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <gargaditya08@live.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Kerem Karabay <kekrby@gmail.com>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>,
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Message-ID: <ZqEroUgkB-J-JG4D@wunner.de>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqElRH38f_XV3fKK@wunner.de>
 <MA0P287MB0217AA8547F79B36B754A7B2B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB0217AA8547F79B36B754A7B2B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>

On Wed, Jul 24, 2024 at 04:21:03PM +0000, Aditya Garg wrote:
> https://www.phoronix.com/forums/forum/software/general-linux-open-source/1479158-linux-6-11-efi-will-fake-that-it-s-booting-apple-macos-to-fix-some-dual-gpu-macs?p=1479205#post1479205
> 
> By looking at this post, it seems to affect non T2 Macs as well.

Disabling iGPU if dGPU is present was a behavior that existed well
before T2 Macs, yes.  That affected MacBook Pros from Haswell onward.

However the question is since when iGPU is disabled if an eGPU is present.
I had never heard of this before.  It would be good to have more datapoints
to come up with a quirk that's as narrowly applied as possible to avoid
regressions.

Thanks,

Lukas

