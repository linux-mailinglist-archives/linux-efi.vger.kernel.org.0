Return-Path: <linux-efi+bounces-1483-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C778B93B46F
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 18:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBA1281EAD
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36FA15921D;
	Wed, 24 Jul 2024 16:01:21 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA11BF38;
	Wed, 24 Jul 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836881; cv=none; b=ST5EVZ2h0GVb0WiIl37AT9xLGXZAmcoB9ANP5+kbrQkbUYZiCc2XFJYmv0gyjTKkeGH3in+peb0lYWz5JfQbYZmNU75x+xU9JwmMk+SX0mNWidqK37o5Z0CvOR/hRCT1Bn+Bsi/M2d+42ba+4vD1NjloA6KSD97YpF5SIKNcDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836881; c=relaxed/simple;
	bh=Wgw64SezXFBtKILZ5/aUGwTc2dTrlpV4yOYXb0FmBUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nfffd84LZmfi15AocnoInuyTihRUoIdC9dIZ0vOmT4gkAHF2+ClX5VsnssJgP6Gxd+zP56/JJv2xlXCkjIW+8StfUyUjj4btceF0ScLoWRwRDodzQfEs6yUiqIYI6XfdNrvkRR70UGSW+KQKZB8ZI796SIWpBvICOhIAsNwfRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 91D802800AE0F;
	Wed, 24 Jul 2024 18:01:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8A59325C4B5; Wed, 24 Jul 2024 18:01:08 +0200 (CEST)
Date: Wed, 24 Jul 2024 18:01:08 +0200
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
Message-ID: <ZqElRH38f_XV3fKK@wunner.de>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>

On Tue, Jul 23, 2024 at 04:25:19PM +0000, Aditya Garg wrote:
> On Wed, Jul 17, 2024 at 04:35:15PM +0000, Aditya Garg wrote:
> > For the Macs having a single GPU, in case a person uses an eGPU,
> > they still need this apple-set-os quirk for hybrid graphics.
> 
> Sending this message again as for some reason it got sent only to Lukas:
> 
> Full model name: Mac mini (2018) (Macmini8,1)
> 
> The drive link below has the logs:
> 
> https://drive.google.com/file/d/1P3-GlksU6WppvzvWC0A-nAoTZh7oPPxk/view?usp=drive_link

Some observations:

* dmesg-with-egpu.txt:  It seems the system was actually booted *without*
  an eGPU, so the filename appears to be a misnomer.

* The two files in the with_apple_set_os_efi directory only contain
  incomplete dmesg output.  Boot with log_buf_len=16M to solve this.
  Fortunately the truncated log is sufficient to see what's going on.

* If the apple_set_os protocol is not used, the attached eGPU is not
  enumerated by the kernel on boot and a rescan is required.
  So neither the iGPU nor the eGPU are working.  The reason is BIOS
  sets up incorrect bridge windows for the Thunderbolt host controller:
  Its two downstream ports' 64-bit windows overlap.  The 32-bit windows
  do not overlap.  If apple_set_os is used, the eGPU is using the
  (non-overlapping) 32-bit window.  If apple_set_os is not used,
  the attached eGPU is using the (overlapping, hence broken) 64-bit window.  

  So not only is apple_set_os needed to keep the iGPU enabled,
  but also to ensure BIOS sets up bridge windows in a manner that is
  only halfway broken and not totally broken.

  Below, 0000:06:01.0 and 0000:06:04.0 are the downstream ports on the
  Thunderbolt host controller and 0000:09:00.0 is the upstream port of
  the attached eGPU.

  iGPU enabled, no eGPU attached (dmesg.txt):
  pci 0000:06:01.0:   bridge window [mem 0x81900000-0x888fffff]
  pci 0000:06:01.0:   bridge window [mem 0xb1400000-0xb83fffff 64bit pref]
  pci 0000:06:04.0:   bridge window [mem 0x88900000-0x8f8fffff]
  pci 0000:06:04.0:   bridge window [mem 0xb8400000-0xbf3fffff 64bit pref]

  iGPU disabled, eGPU attached, apple_set_os not used (journalctl.txt):
  pci 0000:06:01.0:   bridge window [mem 0x81900000-0x888fffff]
  pci 0000:06:01.0:   bridge window [mem 0xb1400000-0xc6ffffff 64bit pref]
  pci 0000:06:04.0:   bridge window [mem 0x88900000-0x8f8fffff]
  pci 0000:06:04.0:   bridge window [mem 0xb8400000-0xbf3fffff 64bit pref]
  pci 0000:06:04.0: bridge window [mem 0xb8400000-0xbf3fffff 64bit pref]: can't claim; address conflict with PCI Bus 0000:09 [mem 0xb1400000-0xbf3fffff 64bit pref]

  iGPU enabled, eGPU attached, apple_set_os used (working-journalctl.txt):
  pci 0000:06:01.0:   bridge window [mem 0x81900000-0x888fffff]
  pci 0000:06:01.0:   bridge window [mem 0xb1400000-0xc6ffffff 64bit pref]
  pci 0000:06:04.0:   bridge window [mem 0x88900000-0x8f8fffff]
  pci 0000:06:04.0:   bridge window [mem 0xb8400000-0xbf3fffff 64bit pref]
  pci 0000:09:00.0:   bridge window [mem 0x81900000-0x81cfffff]

* As to how we can solve this and keep using apple_set_os only when
  necessary:

  I note that on x86, the efistub walks over all PCI devices in the system
  (see setup_efi_pci() in drivers/firmware/efi/libstub/x86-stub.c) and
  retrieves the Device ID and Vendor ID.  We could additionally retrieve
  the Class Code and count the number of GPUs in the system by checking
  whether the Class Code matches PCI_BASE_CLASS_DISPLAY.  If there's
  at least 2 GPUs in the system, invoke apple_set_os.

  The question is whether this is needed on *all* Apple products or only
  on newer ones.  I suspect that the eGPU issue may be specific to
  recent products.  Ideally we'd find someone with a Haswell or Ivy Bridge
  era Mac Mini and an eGPU who could verify whether apple_set_os is needed
  on older models as well.

  We could constrain apple_set_os to newer models by checking for
  presence of the T2 PCI device [106b:1802].  Alternatively, we could
  use the BIOS date (DMI_BIOS_DATE in SMBIOS data) to enforce a
  cut-off such that only machines with a recent BIOS use apple_set_os.

Thanks,

Lukas

