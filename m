Return-Path: <linux-efi+bounces-845-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D178867BE
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 09:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B9B1C236C1
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 08:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D41426C;
	Fri, 22 Mar 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMQquRtc"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719A13FFB;
	Fri, 22 Mar 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094413; cv=none; b=HOMxZEDkXT/FsUoP+d5f1lMv4AYw+tq9aHfq8AsJ2vp9cOMuw88/3QN68LDBUapDTgCE6MLd610YaRFPQuHrEk9QO+s/ZaPN0vpy7XsXF7d1vXAO7/w2ivH8aDIGI5mYO+ZSBJSyjWlE2A1/VI8pXjFTyfzmkECCt1U4T33ZmSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094413; c=relaxed/simple;
	bh=pUttzwL1DYJWH3XdwaA1Y4ZDVmHRSfh3Fe1BGs2Ngt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6OBQ8cMLswr6iC1BJPubsKb1P9qrFkpAOvnje1dyDhtuORU0lswShIn1CpPql/cjn6RlYo+0BrFtPCzTqWpzqaSDXmZHssnZPPVNXc1Zn8obsGMLC6omF1XtfoA0syjyjBDIzrr3TmMCIxFqNZot7LTu2r5FgUghuKFmGnFhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMQquRtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CEDC43394;
	Fri, 22 Mar 2024 08:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711094413;
	bh=pUttzwL1DYJWH3XdwaA1Y4ZDVmHRSfh3Fe1BGs2Ngt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMQquRtcYqhnI+2E4oD4kQOZafGCl0NVfDCpf7E5Ri1KzEeAmxQJKZk+7HalbTO34
	 gEvJ9fUuCbIZJ8VLFy1hDe096f4n+UoJTGSjUmaufEG7CqxGnrUmjnocyFtb603x+y
	 CPVlsTQdtSUdAy0w3BKRwGOxl2+JaFmO8AzPm7DYllMAMQuvspP00piJYR9DpstKYw
	 Vx9QkfqN0rcOGeesVHtA66T+4tx+99ZwB95a8SgFzxT22CPRjmBTQuJBI5iDF+EWNB
	 XIr986UiQwePkNKzwKQ83NnXE3rORn5iWnDMYDWOHe4lHX5CiyxuAObygwBNFATl6B
	 +mFDh2ZbhZchA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rnZp7-000000001O5-0HMc;
	Fri, 22 Mar 2024 09:00:21 +0100
Date: Fri, 22 Mar 2024 09:00:21 +0100
From: Johan Hovold <johan@kernel.org>
To: Oleksandr Tymoshenko <ovt@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, johan+linaro@kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: fix panic in kdump kernel
Message-ID: <Zf06lazi4bBbzTVg@hovoldconsulting.com>
References: <20240322010846.305860-1-ovt@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322010846.305860-1-ovt@google.com>

On Fri, Mar 22, 2024 at 01:08:45AM +0000, Oleksandr Tymoshenko wrote:
> Check if get_next_variable() is actually valid pointer before
> calling it. In kdump kernel this method is set to NULL that causes
> panic during the kexec-ed kernel boot.
> 
> Tested with QEMU and OVMF firmware.

Sounds like you want a Fixes and CC stable tag here as well.

> Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
> ---
>  drivers/firmware/efi/efi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 8859fb0b006d..800b85807a02 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -203,6 +203,8 @@ static bool generic_ops_supported(void)
>  
>  	name_size = sizeof(name);
>  
> +	if (efi.get_next_variable == NULL)
> +		return false;

Please move this check above the name_size initialisation and make sure
you have a new line before and after.

I'd also suggest rewriting this as:

	if (!efi.get_next_variable)
		return false;

>  	status = efi.get_next_variable(&name_size, &name, &guid);
>  	if (status == EFI_UNSUPPORTED)
>  		return false;

Johan

