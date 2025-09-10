Return-Path: <linux-efi+bounces-4719-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22CBB50C4E
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 05:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B737A4D7A
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 03:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F511258EEB;
	Wed, 10 Sep 2025 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KVVabbYX"
X-Original-To: linux-efi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C131D39C;
	Wed, 10 Sep 2025 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474751; cv=none; b=k7i1jY9kxWVTGoabla/OIPJDFhaIOg3bgsuEPU4lC0e89Ttvyg44+GFTaJDUGjktxjJ33rOKhc5cwz6BL1e/ROMXFfwKDELHMLxN+BCEScNVkXX56u8CWiFbX8Gjd3whStjF4+M0m6QvxsB3gteKMWZ7n0xbadAZBqUgGC12gdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474751; c=relaxed/simple;
	bh=xY5rA+hMSVyjSus3zfT68myqKGV0onGxAgOMxyqjBOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QteAKvLXKW1gRlKBTNb/j7HFm8X24nFduweya7MeV+9+8CsFTQUUH0P63WM6mtQJ3IM91LlUdNGN3IQeFgaHJDKYnjDnGXsqBcaxnyUkcNfwuJ5DBuI+WU1nyG4T/CfmWLLlIOZrT12xWL+cGWNnXIjf/7uDNG+4EVtEGZK0fXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KVVabbYX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=AY3GxwGfKCJrcEiXZl9PXnIPzFNTmR/piIW0AtCYuQc=; b=KVVabbYX/g9eYv64OWWc6ChYiT
	r7xbN6sr+zwhEQxS0J2An1J3slt14Qug3u/BosEZHGxUxeyrUtjp+4gy8K8PJwr6OlEyKqMjQ0x0/
	KsaWb/Ccp9Yoo+/wLclwB5jF4icyHVaS+zPftWOiikPORHy91YvMOYaSU899N3mJThuXj6Sd9GHJ8
	oOgvWRPKcTeOuFgDBNwHV4Gj7FtymNUMJ6VnfP5zf/3kVHpnSGpuyaZy54w1sguxywJCHb6Pl2OvM
	XtIhHMPSfobHMzPzQnmM0fNd3w+i7yLPznxBWAeOeAhkL/A6Cd71/fnHTwWZWxPP1vUldvBz0mdkf
	7U7QIxnQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwBSh-0000000BpMn-2NtJ;
	Wed, 10 Sep 2025 03:25:35 +0000
Message-ID: <0b61b6f3-f11a-494c-9d4e-94ca19fd1eb6@infradead.org>
Date: Tue, 9 Sep 2025 20:25:34 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux EFI <linux-efi@vger.kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Hugo Osvaldo Barrera <hugo@whynothugo.nl>
References: <20250910015738.14848-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250910015738.14848-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bagas,

This mostly looks good to me. I have a couple of small comments
below.


On 9/9/25 6:57 PM, Bagas Sanjaya wrote:
> From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
> 
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
> Link: https://lore.kernel.org/r/20250428131206.8656-2-hugo@whynothugo.nl
> [Bagas: Don't use :ref: link to EFI stub documentation]
> Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/admin-guide/efi-stub.rst |  3 +++
>  Documentation/arch/x86/boot.rst        | 35 ++++++++++++++++++++------
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
> index 090f3a185e1897..2f0f040f6913a4 100644
> --- a/Documentation/admin-guide/efi-stub.rst
> +++ b/Documentation/admin-guide/efi-stub.rst
> @@ -79,6 +79,9 @@ because the image we're executing is interpreted by the EFI shell,
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
> index 77e6163288db08..fadbe66517bdf2 100644
> --- a/Documentation/arch/x86/boot.rst
> +++ b/Documentation/arch/x86/boot.rst

> +.. _pe-coff-entry-point:
> +
> +PE/COFF entry point
> +===================
> +
> +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
> +implementation details.
> +
> +The stub loader can request the initrd via a UEFI protocol. For this to work,
> +the firmware or bootloader needs to register a handle which implements the
> +``EFI_LOAD_FILE2`` protocol with the ``LINUX_EFI_INITRD_MEDIA_GUID`` device
> +path. In this case, a kernel booting via the EFI stub will use the ``LoadFile``
> +function on the registered handle to obtain a reference to the initrd.

drivers/firmware/efi/libstub/efi-stub-helper.c (line 509) says LoadFile2
protocol. Is that the same as the LoadFile function?

https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
(the link below) also says LoadFile2() 4 times (and LoadFile 0 times).

thanks.
-- 
~Randy


