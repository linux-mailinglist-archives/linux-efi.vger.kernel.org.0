Return-Path: <linux-efi+bounces-1333-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FB391D772
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3051C22211
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 05:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4A18622;
	Mon,  1 Jul 2024 05:35:05 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272810E6;
	Mon,  1 Jul 2024 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812105; cv=none; b=Y0PCC/BvunbkHp/4m/i15AWyBakQQXHxwzHztC6fz2bX4G69tAzn2iWLJ6kqA/OW6Rw8cI9yh6k3AKNMuTjQ26RZdcdLtfO01G5OTLc8O4mClpGKYv3tvSgAFFtUoiSX/vcCHj+jpljW8+F4NRbj3Egm9sVWknD3xqXzoWBQvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812105; c=relaxed/simple;
	bh=Ko69j6cPLuKA5T4gwCyFb9URCiuiAt8JrPO3VIKfk1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR4pypIH+Qo1jgP7llD9ZxdkQ2W984F5uK0ab16nzM2z7pw6wu9yPEn3CMJtuqVuRawekokr3ATd5vqFb7rPSwFQ3RfFBvDETY3+hLR10LmJQohQuuu0m6ddEZ1JDSavPmC0WVLw3XRVwNx3UxCZVef4+gVZPPKu2sA/Y+z6OAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 79AE5100DCEF9;
	Mon,  1 Jul 2024 07:34:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1D49031F8B7; Mon,  1 Jul 2024 07:34:58 +0200 (CEST)
Date: Mon, 1 Jul 2024 07:34:58 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <gargaditya08@live.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	Kerem Karabay <kekrby@gmail.com>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Message-ID: <ZoJAAifMqIDXdniv@wunner.de>
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>

On Sun, Jun 30, 2024 at 07:24:54PM +0000, Aditya Garg wrote:
> @@ -335,9 +359,12 @@ static const efi_char16_t apple[] = L"Apple";
>  
>  static void setup_quirks(struct boot_params *boot_params)
>  {
> -	if (IS_ENABLED(CONFIG_APPLE_PROPERTIES) &&
> -	    !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))
> -		retrieve_apple_device_properties(boot_params);
> +	if (!memcmp(efistub_fw_vendor(), apple, sizeof(apple))) {
> +		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES)) {
> +			retrieve_apple_device_properties(boot_params);
> +		}
> +		apple_set_os();
> +	}

Nit: Unnecessary curly braces around retrieve_apple_device_properties().

(And I'd appreciate a blank line between it and the apple_set_os() call.

