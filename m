Return-Path: <linux-efi+bounces-1337-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9FC91D82B
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 08:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012A91F2323E
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 06:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D532231C;
	Mon,  1 Jul 2024 06:41:17 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A0A4A0F;
	Mon,  1 Jul 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816077; cv=none; b=mnLPBVLozrM+To6bfn0Q7wyC1Ajy08LFWvlEn7JRoa2Kp6kRgSCXiPmMSWbM5zfIMD8zmVJO9emFB1kLbt6WC7wRejAhcWwaj17fBfZg9BxDesJp3n7ipVDHQ1w0S2jmysWF99OMJXxHOkP21B5sQh03Is4XQzUsVWgsshRPdwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816077; c=relaxed/simple;
	bh=0giSCIxMHwaDnOvFpUqp4Y73M/ZlyG2EnIUwXN/iyRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqeaonjmTIhu+mDz0KK3rzoy5IMJdXSHBGNtXkLkLLVqbuyoxWV530PJMXg+hJjptL/G8aGiqU1OHn6ZEQhNv47qkgshCSD5Aw4GxmLkX+uSTtcF+9s1CJzndPp5bZnDiUMf3sv3HWq0/lyVxfnekK4eo4/zMQBRT/3uJ3SuTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0F4263000086C;
	Mon,  1 Jul 2024 08:41:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0371036558D; Mon,  1 Jul 2024 08:41:06 +0200 (CEST)
Date: Mon, 1 Jul 2024 08:41:05 +0200
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
Message-ID: <ZoJPgSlZJ3ZlU2zL@wunner.de>
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>

On Mon, Jul 01, 2024 at 07:56:04AM +0200, Ard Biesheuvel wrote:
> On Mon, 1 Jul 2024 at 07:50, Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Jul 01, 2024 at 07:38:38AM +0200, Ard Biesheuvel wrote:
> > > Any thoughts on whether this should depend on CONFIG_APPLE_GMUX or not?
> >
> > I tend towards *not* making it depend on CONFIG_APPLE_GMUX:
> >
> > * The gpu-switch utility Orlando linked to doesn't use the apple-gmux
> >   driver.  (It changes EFI variables that influence to which GPU the
> >   EFI driver will switch on next reboot.)
> >
> > * apple_set_os() has side effects beyond exposing the iGPU (such as
> >   switching the keyboard+trackpad access method to SPI instead of USB).
> >   If there are issues, they will be harder to debug if their occurrence
> >   depends on a Kconfig option.
> 
> Understood. I agree that having fewer possible combinations is
> strongly preferred.
> 
> However, this change affects all Intel Macs. Is the latter side effect
> likely to cause any regressions on Intel Mac users that don't have two
> GPUs to begin with?

MacBook Air models introduced 2013/2014 will use SPI instead of USB
to access the keyboard and trackpad.  And from a quick look, the
applespi_tp_models[] array in drivers/input/keyboard/applespi.c
seems to be missing the trackpad dimensions of those models.
The driver may also need a quirk to work around missing properties
in the DSDT on those models.  Back in 2018 someone tested apple_set_os()
on such a machine and reported these issues, but the GitHub discussion
to narrow them down and fix them fizzled out:

https://github.com/cb22/macbook12-spi-driver/issues/65

The problem is that users of such models will generally run a
distribution kernel which has CONFIG_APPLE_GMUX enabled,
so constraining apple_set_os() to CONFIG_APPLE_GMUX won't help them.
Also, there is no incentive to amend the applespi.c driver for
affected machines if apple_set_os() is never called on them,
which is regrettable.

Another potential regression is that exposing the iGPU may consume
more power.  Or maybe the i915 driver will autosuspend if the panel
is not connected, I don't know.  Likewise there is no incentive to
fix the issue if apple_set_os() is never run.

I've also heard rumors that the EFI firmware configures different
CPU frequency scaling parameters if apple_set_os() is called,
but maybe Linux overwrites them anyway.  Apple never cared for Linux,
so apple_set_os() basically just differentiates between macOS and
Windows (via Boot Camp).  We generally choose to masquerade as macOS
to get access to the full set of hardware features, not the crippled
setup exposed to Windows.

If you think that we absolutely need to avoid these potential regressions,
a better approach than constraining to CONFIG_APPLE_GMUX would be to
match DMI data for dual-GPU MacBook Pros.  I notice that the efistub
has been amended with SMBIOS support through efi_get_smbios_record() +
efi_get_smbios_string().  Would that get us to the laptop model name?
If so that would seem to be a viable way to avoid or at least minimize
regressions.

Thanks,

Lukas

