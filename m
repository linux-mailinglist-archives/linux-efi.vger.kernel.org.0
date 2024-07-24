Return-Path: <linux-efi+bounces-1488-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0997F93B512
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80EBAB20F4A
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CAF3A8C0;
	Wed, 24 Jul 2024 16:31:55 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A810F4;
	Wed, 24 Jul 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838715; cv=none; b=fixk4kphgzd//fvoWKENqPQqeW8lf8LBwysd6Wxl54Q0zqQmAvhw6Jq2lr99i9INZk73Mp1fr2KD5H4BkGoml2+HMk35aaXrnpWlOSdDilW7PsZrMx2V5zwThL9KnlKlAnJgwnxsIBITO133XK22G/xVCfm3FVAoLGle/iTrl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838715; c=relaxed/simple;
	bh=lO9ykqJ8kZPlf4npavcP7VoQ/S4NN0JPTsgRTSv3j3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcpJisEpbgT6ctMpffjrsExMgCJ2N5GZt1Ztak6EmtfWZjxyw3Pmbclr5R9hpaREiu4/ojwjO+wh1/oLz0qr6fboAcREhDX3zWuNURHGV3bgmqWwZFXI11EE/irQ7GXyMss8cqBL5N6OwgHXGJr1s+QKhq3DVle+vlgGO5TE08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D334E2800AE14;
	Wed, 24 Jul 2024 18:31:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BC599F514C; Wed, 24 Jul 2024 18:31:50 +0200 (CEST)
Date: Wed, 24 Jul 2024 18:31:50 +0200
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
Message-ID: <ZqEsdkVvwsq-CgeB@wunner.de>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqElRH38f_XV3fKK@wunner.de>
 <MA0P287MB021789D73CAD62C16BCF0306B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB021789D73CAD62C16BCF0306B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>

On Wed, Jul 24, 2024 at 04:26:58PM +0000, Aditya Garg wrote:
> > On 24 Jul 2024, at 9:31 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > I note that on x86, the efistub walks over all PCI devices in the system
> > (see setup_efi_pci() in drivers/firmware/efi/libstub/x86-stub.c) and
> > retrieves the Device ID and Vendor ID.  We could additionally retrieve
> > the Class Code and count the number of GPUs in the system by checking
> > whether the Class Code matches PCI_BASE_CLASS_DISPLAY.  If there's
> > at least 2 GPUs in the system, invoke apple_set_os.
> 
> This also looks like a good idea, but I'm not well aware of the pci
> quirks in the Linux kernel. So, would consider it a bug report for
> the maintainers to fix.

This is not a PCI quirk in the kernel.  The efistub is a separate
program.  I'm saying that the efistub already walks over all PCI devices,
it would be trivial to hook into this to count GPUs, recognize the T2
device or do something else entirely.

Thanks,

Lukas

