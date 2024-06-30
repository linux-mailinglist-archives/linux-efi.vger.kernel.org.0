Return-Path: <linux-efi+bounces-1320-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F137E91D111
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 12:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181A31C20D0D
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5836139D0C;
	Sun, 30 Jun 2024 10:22:46 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816312E1C4;
	Sun, 30 Jun 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719742966; cv=none; b=dJvU3CdF4SJeSzizFxwi7OsJRueXjSJJN4UApTPUljB9DzigJyGGRts4//dpDNrLoNBEcPajSWoNEXtVVJoMnmr2QPqU+PVXGleJ3vFuGCZXPmv+gqHGF9vs+QiSsB167pRXkWtXuMqtF/7P0DSydBTJ4egXVSnN7Cszrklgi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719742966; c=relaxed/simple;
	bh=DOnNnE4RcBLiZAGrxkiwP6nL1AslR903xEuZh7DzIi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqaZQH5dvWiAayBBicuV45EIX+o0Axh3+rdDhMqzBfu2QRPjmpfzGzEDqaEmER52MI4UrbikUQdNoc3lR/u8e4a9TY77pjLMNCP4uL8vbH/0uqwMnyjWMz5Br6tscenlujnDd7R4spBv3DiJcicsXAn/TwrE02ZkEVvYDVcXslk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 56242100D942D;
	Sun, 30 Jun 2024 12:22:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0F4AF2473DA; Sun, 30 Jun 2024 12:22:41 +0200 (CEST)
Date: Sun, 30 Jun 2024 12:22:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <gargaditya08@live.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>,
	Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
Message-ID: <ZoEx8S0_eUDM6Cjq@wunner.de>
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

Only the very first MacBooks that shipped in 2006 used a 32-bit EFI.
We don't need to call apple_set_os on those, so just get rid of the
mixed_mode portion of this struct and then ...

> @@ -321,6 +345,9 @@ static void setup_quirks(struct boot_params *boot_params)
>  	if (IS_ENABLED(CONFIG_APPLE_PROPERTIES) &&
>  	    !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))
>  		retrieve_apple_device_properties(boot_params);
> +
> +	if (efi_apple_set_os)
> +		apple_set_os();
>  }

... make the call to apple_set_os() conditional on:

	if (efi_is_64bit() &&
	    !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))

We don't want to call this on non-Apple hardware if we can help it.

Thanks,

Lukas

