Return-Path: <linux-efi+bounces-3616-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BF0AAC55C
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 15:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110114615D9
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467BF281365;
	Tue,  6 May 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Wld+X18X"
X-Original-To: linux-efi@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51F28134A
	for <linux-efi@vger.kernel.org>; Tue,  6 May 2025 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537080; cv=none; b=Lymfxtu5uky2KswHahcNdr+4dyxhOhzbhd7KIg5YJiAuq1xEvtulZpY34rvIrA9/PtI7ny6c8nzYwoJGo9qbKFt4K+1M6GNPVMjFelPJrcvnamwSwIc+TKL4o8mmBetSvGMlu/gh6zhWM3LslT+iTJC1QZRAoN+5ab7BwFf/3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537080; c=relaxed/simple;
	bh=32sZ7zs+7V0u9CG5C8+o85/JGenmObMMHpGaRyPNu8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SZbYeELg3bLHyLRvqxtgCdAxQR39YVh7VaAdtQFnDXjEoRehfXRXabO+bpfsC5dKTOiOAUqZ2vYMH+23mEcJwXamaeTojzStYnLoq5NaOL36UjbDPJ6u8UaY7Tpumgtd6rt7ijoEB7QUH9lEj2w9IMRNpjDRD2C2g2/eNaJc+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Wld+X18X; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 246CD41080
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1746537078; bh=1oPLAFxOds3QyWMzEctu4ArSA4p7FPYqtdXGzF6UWuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Wld+X18XqTBa+rOSDbHGYKuGMf0Cli2cKdgagcSjtd1Dsw1g6/qMX/5PFzyobuPKV
	 XmJQQ72NBipUenlPncbC1wW0x5l9FsG+94/Qes4yO08sfrHR2QPqsfHLkL7fFuhV4G
	 56tg96KVa/0keLr8OIcQOO/eYAdtjI44pXNNnh8NcLyeVxVUIU/piM4BimF3hwcdc4
	 XEPn5T+qMaWu0DE00ukBKJWm4ybXK0qHOwiUoy/q1NasfQejjCGgW/EMV3ZJoWoSt3
	 gKu4+P1N0MI5TZxqYF/QaHdcGAH7q/yAaknkb1AB5/Xl7ZWhIrQ8AYcfen/KOR6x+Y
	 Ez2us5DCo3mug==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 246CD41080;
	Tue,  6 May 2025 13:11:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Hugo Osvaldo Barrera <hugo@whynothugo.nl>, linux-efi@vger.kernel.org
Cc: Hugo Osvaldo Barrera <hugo@whynothugo.nl>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
In-Reply-To: <20250428131206.8656-2-hugo@whynothugo.nl>
References: <20250428131206.8656-2-hugo@whynothugo.nl>
Date: Tue, 06 May 2025 07:11:13 -0600
Message-ID: <87ecx1x4su.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hugo Osvaldo Barrera <hugo@whynothugo.nl> writes:

> Since the Handover Protocol was deprecated, the recommended approach is
> to provide an initrd using a UEFI boot service with the
> LINUX_EFI_INITRD_MEDIA_GUID device path. Documentation for the new
> approach has been no more than an admonition with a link to an existing
> implementation.
>
> Provide a short explanation of this functionality, to ease future
> implementations without having to reverse engineer existing ones.
>
> Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
> ---
>  Documentation/admin-guide/efi-stub.rst |  5 ++++
>  Documentation/arch/x86/boot.rst        | 36 +++++++++++++++++++-------
>  2 files changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
> index 090f3a185e18..3af702259f1d 100644
> --- a/Documentation/admin-guide/efi-stub.rst
> +++ b/Documentation/admin-guide/efi-stub.rst
> @@ -1,3 +1,5 @@
> +.. _efi-boot-stub:

This label is unneeded...

>  =================
>  The EFI Boot Stub
>  =================
> @@ -79,6 +81,9 @@ because the image we're executing is interpreted by the EFI shell,
>  which understands relative paths, whereas the rest of the command line
>  is passed to bzImage.efi.
>  
> +.. hint::
> +   It is also possible to provide an initrd using UEFI boot services. See
> +   :ref:`pe-coff-entry-point` for details.
>  
>  The "dtb=" option
>  -----------------
> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> index 77e6163288db..2fecf89910ec 100644
> --- a/Documentation/arch/x86/boot.rst
> +++ b/Documentation/arch/x86/boot.rst
> @@ -1431,12 +1431,30 @@ The boot loader *must* fill out the following fields in bp::
>  All other fields should be zero.
>  
>  .. note::
> -     The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
> -     entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
> -     loading protocol (refer to [0] for an example of the bootloader side of
> -     this), which removes the need for any knowledge on the part of the EFI
> -     bootloader regarding the internal representation of boot_params or any
> -     requirements/limitations regarding the placement of the command line
> -     and ramdisk in memory, or the placement of the kernel image itself.
> -
> -[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
> +   The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
> +   entry point described below.
> +
> +.. _pe-coff-entry-point:
> +
> +PE/COFF entry point
> +===================
> +
> +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
> +regular PE/COFF binary. See :ref:`efi-boot-stub` for implementation details.

...just say "see Documentation/admin-guide/efi-stub.rst here.
> +
> +The stub loader can request the initrd via a UEFI protocol. For this to work,
> +the firmware or bootloader needs to register a handle which implements the
> +``EFI_LOAD_FILE2`` protocol with the ``LINUX_EFI_INITRD_MEDIA_GUID`` device
> +path. In this case, a kernel booting via the EFI stub will use the ``LoadFile``
> +function on the registered handle to obtain a reference to the initrd.
> +
> +This approach removes the need for any knowledge on the part of the EFI
> +bootloader regarding the internal representation of boot_params or any
> +requirements/limitations regarding the placement of the command line and
> +ramdisk in memory, or the placement of the kernel image itself.
> +
> +For sample implementations, refer to `the original u-boot implementation`_ or
> +`the implementation in candyboot`_.
> +
> +.. _the original u-boot implementation: https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
> +.. _the implementation in candyboot: https://git.sr.ht/~whynothugo/candyboot/tree/4097b2538d7f1cf85f03922bf42409490b666202/item/src/main.rs#L225
> -- 

Thanks,

jon

