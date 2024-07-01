Return-Path: <linux-efi+bounces-1357-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F86A91E22C
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E241F21FEC
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C268161937;
	Mon,  1 Jul 2024 14:17:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F99161307;
	Mon,  1 Jul 2024 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843479; cv=none; b=X3l9nfJNCfrshTwnUF1TXb5+NifPsq8Z3xf7pdXoxHBWeufXiTi4Pu+sXDy07XvZRttUyLVuj/Ad7sleAIZm7PpHiAUhAfaP3ACYpUWeCQ8KY4Vimx+L2zgcNkow36aaZM+Hrn3ofrr+8DnQQwu6akOKLxgf1OmnVlV8b2Gs5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843479; c=relaxed/simple;
	bh=ZZiQiEcgWQWD2MGwBli8bZUxF0065QbUFbHZ8s+ZMOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaksL8kSWwYkIQ2ETOnp6uL4CEGV6z9ZReXNObkHW4xB6mdwojWZMsvRC0WIe9xvrpdjZOrU0Jn6lp+5j8Zmo42RLvmnYDCL25U8hq32xs72/ijFSziozXdHIPw+VkRg/BXCsY92edF5/trz/efyvGunAD2FSnFe/iFYPB1R8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4A964100DA1CB;
	Mon,  1 Jul 2024 16:17:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 003AF3CAD99; Mon,  1 Jul 2024 16:17:52 +0200 (CEST)
Date: Mon, 1 Jul 2024 16:17:52 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Aditya Garg <gargaditya08@live.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Kerem Karabay <kekrby@gmail.com>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Message-ID: <ZoK6kMvhl5R5e-rl@wunner.de>
References: <20240701140940.2340297-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701140940.2340297-4-ardb+git@google.com>

On Mon, Jul 01, 2024 at 04:09:41PM +0200, Ard Biesheuvel wrote:
> Aditya Garg (1):
>   x86/efistub: Call Apple set_os protocol on dual GPU Intel Macs
> 
> Ard Biesheuvel (1):
>   efistub/x86: Enable SMBIOS protocol handling for x86

For the series,

Reviewed-by: Lukas Wunner <lukas@wunner.de>

