Return-Path: <linux-efi+bounces-1342-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5232491D961
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 09:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F45283AFF
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8D7406D;
	Mon,  1 Jul 2024 07:49:15 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91F61674;
	Mon,  1 Jul 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820155; cv=none; b=bog1eUc8l8DBiiasPfzmD+VWIMRg0lgT3zZhG7bOFkhx+nb1YFqxo/fCS33OjpCbZRDOiHaGl/p6OXzhbdOkcgmstBhi1n/cIfiaBEg7fxvlWsW0i1FM64u6dEqqmtCFgZpEQ+jlYklisaEKj6Z3tB9zSDkzrmSzHK/i3rUrU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820155; c=relaxed/simple;
	bh=/N9YpHzzw1kXMTEeN9PDz2gD0Ep7EP+Zecpj5e8FzJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9u653fGV1NXFkVaTC3Q1H2VuF6MwERUlJYN0a01MECIcLv5aGbsLvYbzqg7sEdLlYVk9tFUNhnepMcojk4P5/JxPlVCoVGf5dyY2mluRAaLd0SXRQiab4iYV6D0rClgkGMjYNy1GZN3az3skC9c4DAXlKwrJHK/oIDNmVLfVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7E5253000C985;
	Mon,  1 Jul 2024 09:49:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6B138388376; Mon,  1 Jul 2024 09:49:09 +0200 (CEST)
Date: Mon, 1 Jul 2024 09:49:09 +0200
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
Message-ID: <ZoJfdRZ3AqvTWfMx@wunner.de>
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
 <ZoJPgSlZJ3ZlU2zL@wunner.de>
 <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>
 <ZoJeVWMU8yg4CRLl@wunner.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoJeVWMU8yg4CRLl@wunner.de>

On Mon, Jul 01, 2024 at 09:44:21AM +0200, Lukas Wunner wrote:
> > +static bool apple_match_product_name(void)
> 
> Maybe something like apple_has_dual_gpu() ?

On second thought, maybe not.  A neutral name allows us to add
models like the MacBook Airs once we have support for them in
the SPI keyboard driver.

Thanks,

Lukas

