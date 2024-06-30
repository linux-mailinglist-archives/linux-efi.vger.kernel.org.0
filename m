Return-Path: <linux-efi+bounces-1317-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F5C91D079
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 10:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF91281B21
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 08:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419033B2BB;
	Sun, 30 Jun 2024 08:10:17 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4A3A268;
	Sun, 30 Jun 2024 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719735017; cv=none; b=VDfKb1ldwM/2GzQoJp308tNw/Y6t2rtElGiI7lPLvcJ7RLqn0c51QtqeyQZkiJVpNkDxmZX8Yuco5K7EPsjqgkBig+xBsQeE0I2CjnCRpC0XSqh3Pa7KgQb75ClelMnDul0CUJL83F9wwnBSQEm3wpi34PRXMVsOlET/P9PMz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719735017; c=relaxed/simple;
	bh=H0n9BHPoOTdAepeEduREmT4dEfXjG2iu4JOFV0f/i1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGBs8f+ZSzmiiXVgh/0rWV9F6Ds1VCjpsIibb9dQx4eeIsUVg/SR1mUPFnQzcBppZs8fFYYibrtFzX6Gg2t9JXD/u+zIhPvYIxFv775x7iKXxOjNpF0/fQNxKdOJKJ+5J5pea0Ex4eR7njggW7DemVFyu+Lzps7qSFDW1c5cDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 649B7100D942D;
	Sun, 30 Jun 2024 10:04:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DDEA72760BE; Sun, 30 Jun 2024 10:04:39 +0200 (CEST)
Date: Sun, 30 Jun 2024 10:04:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <gargaditya08@live.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>,
	Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
Message-ID: <ZoERl1PWoc2xDGWz@wunner.de>
References: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>

On Sun, Jun 30, 2024 at 04:42:55AM +0000, Aditya Garg wrote:
> Commit 0c18184de990 brought support for T2 Macs in apple-gmux. But in order to

Please run patches through scripts/checkpatch.pl before submission.
The subject of the commit is missing here and lines should be wrapped
at 72 or at least 74 chars.


> Based on this patch for GRUB by Andreas Heider <andreas@heider.io>:
> https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html

Please include his Signed-off-by and cc him.


> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -399,6 +399,8 @@
>  			      useful so that a dump capture kernel won't be
>  			      shot down by NMI
>  
> +	apple_set_os	[KNL] Report that macOS is being booted to the firmware
> +

Why the kernel parameter?  Why not do this unconditionally?


> +struct apple_set_os_protocol {
> +	u64 version;
> +	efi_status_t (__efiapi *set_os_version) (const char *);
> +	efi_status_t (__efiapi *set_os_vendor) (const char *);
> +	struct {
> +		u32 version;
> +		u32 set_os_version;
> +		u32 set_os_vendor;
> +	} mixed_mode;
> +};

How about declaring this __packed, just to be on the safe side?

Why "mixed_mode"?  Seems like an odd name given "mixed mode"
in EFI context usually means 64-bit OS, but 32-bit EFI.


> +static void apple_set_os(void)
> +{
> +	efi_guid_t guid = APPLE_SET_OS_PROTOCOL_GUID;

My recollection is that if you don't declare this static const,
gcc generates suboptimal code.  (It constructs the GUID on the
stack at runtime instead of storing it in .rodata.)
Maybe it's become smarter in the meantime, but I doubt it.

Thanks,

Lukas

