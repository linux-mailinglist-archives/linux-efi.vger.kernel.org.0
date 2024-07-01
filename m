Return-Path: <linux-efi+bounces-1340-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1860591D909
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 09:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C734F281FDE
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B5D4F8BB;
	Mon,  1 Jul 2024 07:35:54 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441DF376E6;
	Mon,  1 Jul 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819354; cv=none; b=e0ILvH7E8hQ8nN1MaUgbIDg6b5k63IJw4tXqLaQu6kRA1At1R67FVkKW+dX9lcMlmFz/QTDcJ+tXOW7QyOOg6D4Dljsh+lodsWJHbIHV6FnLoCi3JPIduu7pRzT4rPYpflcWxzUN3pu0XmSSdhIWKT+awSs3bfvO3oiA8dUFp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819354; c=relaxed/simple;
	bh=dg6kmojZHYR1bN4K1+Up2pa5rycFCMNU/IuaMaMNJ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks+UZ/gWDrm/zYoucQBJcS5x18WI8hodEa28sIgwhNjTndGrWCy1FIrtBvTaZFFJ+Zad1BcpxsaRrR2uucBNAeGVovEjNV/V8jaRocl1WSY8/KpPf+YDpO/aCMRkoo/jWzwislY8UMgDefOpLvMM84ZbAKI7nYpU0T60Svm12wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 222972800B1CD;
	Mon,  1 Jul 2024 09:35:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0DC31388371; Mon,  1 Jul 2024 09:35:49 +0200 (CEST)
Date: Mon, 1 Jul 2024 09:35:49 +0200
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
Message-ID: <ZoJcVf98MElXhMjT@wunner.de>
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
 <ZoJPgSlZJ3ZlU2zL@wunner.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoJPgSlZJ3ZlU2zL@wunner.de>

On Mon, Jul 01, 2024 at 08:41:05AM +0200, Lukas Wunner wrote:
> If you think that we absolutely need to avoid these potential regressions,
> a better approach than constraining to CONFIG_APPLE_GMUX would be to
> match DMI data for dual-GPU MacBook Pros.  I notice that the efistub
> has been amended with SMBIOS support through efi_get_smbios_record() +
> efi_get_smbios_string().  Would that get us to the laptop model name?
> If so that would seem to be a viable way to avoid or at least minimize
> regressions.

FWIW, there would be only 6 models to match if this needs to be
constrained to ones with dual GPUs:

MacBookPro11,3
MacBookPro11,5
MacBookPro13,3
MacBookPro14,3
MacBookPro15,1
MacBookPro16,1

And it seems to me that the product_name in efi_smbios_type1_record
would contain that model name.

Thanks,

Lukas

