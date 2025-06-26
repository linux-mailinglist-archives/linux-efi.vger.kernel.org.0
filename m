Return-Path: <linux-efi+bounces-4002-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E45AE9AB0
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 12:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3644A70A7
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8760215F4A;
	Thu, 26 Jun 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBYx7pDJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07C16A94A;
	Thu, 26 Jun 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932271; cv=none; b=ApsiUOLtPW+3IPmmHe/G33NJx4LSuTDFntezzFFSWSwuWwu9wck86OWTJF6PzrgBoVOfBlyjfmHZ12056mhehXNuN4cltpFi3/IQLOWhusXZHLrNvlMEHwqZJB1Kn0LNPT3lApPVV9dQ9cfp0xIuxT4wTMuRu1G7ZF3mJV6gNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932271; c=relaxed/simple;
	bh=j3ClOqqsBFvAvHSWSgDWUNz0vIVgAMLhB/5Jvn9F5CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ63pNJcYmU1gsvW64KURUHnA3ViRoEvrN8WLyiM33SpAJ0293ZG82xCR0jIdu0JmuZvqrw5k9TqsksAdjXla1HkGF5mNtuoc/btk7zcMcOfViAIoxh9wofJyCHdYmILm2zVzsqDmTVuX+Pb4oZnxWxzQNVHogc26dFhOF9VXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBYx7pDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555E9C4CEEB;
	Thu, 26 Jun 2025 10:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750932271;
	bh=j3ClOqqsBFvAvHSWSgDWUNz0vIVgAMLhB/5Jvn9F5CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBYx7pDJuz4HhzKdOi/VJQB+dwkfOqCJ65aU5xCToT75uUA0mW6f7noRWQ2kRPaz2
	 09ZFrjQiYFprAyQRZ/z4lLMC/b5IMhsHbUrybowxO+FTJ4LtEA7/HZqJOy5Y7K8x2n
	 ppRJF+Nb2TpB6sZglvfeQ/ZjJTnrAhOf9UkhhG3gl8q695QAoJiFgawDMlJJdrRCS9
	 jquNF6rai3o4zGJD9NqmPUGjjJNWAfEMmYJ2CjprIHCHv8OTE/efMOqBqRiQs/KfLG
	 00mpm3C2XGyvifTubVrnrgKuuipIclwgb0EYi954PhV9yeev3jOxv+1GX76fd32Dgl
	 0TnkbVhmnsryw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUjT5-000000007f2-00K4;
	Thu, 26 Jun 2025 12:04:31 +0200
Date: Thu, 26 Jun 2025 12:04:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 1/8] efi: efivars: don't crash in
 efivar_set_variable{,_locked} in r/o case
Message-ID: <aF0bLtnABcGTi0wM@hovoldconsulting.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-1-aacca9306cee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-more-qseecom-v4-1-aacca9306cee@oss.qualcomm.com>

On Wed, Jun 25, 2025 at 01:53:20AM +0300, Dmitry Baryshkov wrote:
> If efivar implementation doesn't provide write support, then calling
> efivar_set_variable() (e.g. when PM8xxx RTC driver tries to update the
> RTC offset) will crash the system. Prevent that by checking that
> set_variable callback is actually provided and fail with an
> EFI_WRITE_PROTECTED if it is not.
> 
> Fixes: 472831d4c4b2 ("efi: vars: Add thin wrapper around EFI get/set variable interface")

I don't think a fixes tag is warranted here as it currently appears to
be expected that the callers check if setvar is supported before calling
this helper (e.g. by calling efivar_supports_writes() as efivarfs does).

So should perhaps be fixed in the RTC driver if we agree that supporting
read-only offsets is indeed something we want.

Are there any other current user that may possibly benefit from
something like this?

> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/r/aFlps9iUcD42vN4w@hovoldconsulting.com
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/firmware/efi/vars.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 3700e98697676d8e6f04f061f447391503f9abba..11c5f785c09364f61642d82416822cb2e1a027fd 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -227,6 +227,8 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
>  	setvar = __efivars->ops->set_variable_nonblocking;
>  	if (!setvar || !nonblocking)
>  		 setvar = __efivars->ops->set_variable;
> +	if (!setvar)
> +		return EFI_WRITE_PROTECTED;
>  
>  	return setvar(name, vendor, attr, data_size, data);
>  }

Johan

