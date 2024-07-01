Return-Path: <linux-efi+bounces-1346-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC791D9C2
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 10:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE341C217B4
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457998248C;
	Mon,  1 Jul 2024 08:15:02 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DDD81AC6;
	Mon,  1 Jul 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821702; cv=none; b=kArBY1hM3xSg/RIC+msLCCn+B21UlRvYTkwJ2/fwjAeAPjVYca1Jqaz2DBA6tiUKsX2gF0/qNjDIsZkVafDIiKIdD8eCcLFxCm+Ax7O5ZA8hEouJuiVlOxyBXmryaNtbNDGX0sW4GPcPKf2VvVMJSXHaeraV+fqucidn7Kkh5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821702; c=relaxed/simple;
	bh=ww4gwc/UihX8xlft+UwWCdy4RV4QsqLqei8Apf0nwVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5l6WdNuScLIJa+ADlfb1dMgdvH55KpC088J5r1NSwV/lzTyu86nL/iwLCTkIFNWdTifKAqPKL521iLfDFKLTF88NzecPy9jgW21PtPSTo6dFLaByNlyClflFG4ZtuQ/F8WEHhBegTBWa7b8c2oQ8hf+rAknr4u91I7w+uVqleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id BF0BF300037C4;
	Mon,  1 Jul 2024 10:14:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9E98240D5F; Mon,  1 Jul 2024 10:14:58 +0200 (CEST)
Date: Mon, 1 Jul 2024 10:14:58 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <gargaditya08@live.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	Kerem Karabay <kekrby@gmail.com>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Message-ID: <ZoJlgkUohsIuL0_r@wunner.de>
References: <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
 <ZoJPgSlZJ3ZlU2zL@wunner.de>
 <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>
 <ZoJeVWMU8yg4CRLl@wunner.de>
 <CAMj1kXFRNrmyAtVaqHr+RWQ22+++u70eJ__brLjmJa0ocyc0Bw@mail.gmail.com>
 <MA0P287MB0217F69CBAB2D5776D4AFA43B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217751F3532CF80BA255DB3B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB0217751F3532CF80BA255DB3B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>

On Mon, Jul 01, 2024 at 08:02:55AM +0000, Aditya Garg wrote:
> IIRC, t2 macs do not support SMBIOS, but I'll test this anyways.

From MacBookPro16,1 dmesg:

[    0.000000] efi: EFI v2.40 by Apple
[    0.000000] efi:  ACPI=0x7affe000  ACPI 2.0=0x7affe014  SMBIOS=0x7aed1000  SMBIOS 3.0=0x7aecf000 
[    0.000000] secureboot: Secure boot disabled
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Apple Inc. MacBookPro16,1/Mac-E1008331FDC96864, BIOS 1037.80.53.0.0 (iBridge: 17.16.13050.0.0,0) 01/17/2020

Source:

https://github.com/Dunedan/mbp-2016-linux/blob/master/MacBookPro16%2C1/dmesg

