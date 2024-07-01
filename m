Return-Path: <linux-efi+bounces-1341-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D55D991D943
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 09:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 602CAB20D70
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BD576034;
	Mon,  1 Jul 2024 07:44:26 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F467406D;
	Mon,  1 Jul 2024 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819866; cv=none; b=HiyxkfO1gyRIlcTUijMEfVdjFlvIVWSTWfmG3sv2HLWboJWJyOrTS9V2n0g9CZatQzlIKEzPHCG2Z2mQfV59VXuP4UnNGLhPSA09IkybxTSpQE7dVFzyIpRGLh2o7s7HqZqUNXU05zKQy9inFKiW5WSnnkF7B0+frv0se/ZAxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819866; c=relaxed/simple;
	bh=DgUlr6XUs2nTAWW5SPXrtKns8ChralA1z58braa/C88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6CfeHuD0eWdPbxqJk/8KdQPCww+2T+Xor2Jv5MpFQUk/41AHna4hI3kBVzSzTB62x6w6hWcNQq8d/niffyYd9903DMLHCS8niOCjHwfB+voQ30/NxD0LKKWoTZnWGbPgQef+yInjvYUUYbuKuziGL2NiaTtgtab5ZLDMrgsqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A24C5100DEC95;
	Mon,  1 Jul 2024 09:44:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5984931F8A6; Mon,  1 Jul 2024 09:44:21 +0200 (CEST)
Date: Mon, 1 Jul 2024 09:44:21 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Aditya Garg <gargaditya08@live.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	Kerem Karabay <kekrby@gmail.com>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Message-ID: <ZoJeVWMU8yg4CRLl@wunner.de>
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
 <ZoJPgSlZJ3ZlU2zL@wunner.de>
 <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>

On Mon, Jul 01, 2024 at 09:30:34AM +0200, Ard Biesheuvel wrote:
> Assuming that Intel Macs implement the EFI SMBIOS protocol, reusing
> the existing pieces should be rather straight-forward. Something like
> the below should work in that case (whitespace damage courtesy of
> gmail)
> 
> Note that the smbios.c  libstub source file needs some changes to
> build correctly for x86 with CONFIG_EFI_MIXED=y, but I can take care
> of that.

Orlando, Aditya, could you test Ard's patch with CONFIG_EFI_MIXED=n?


> +static bool apple_match_product_name(void)
> +{

Maybe something like apple_has_dual_gpu() ?

