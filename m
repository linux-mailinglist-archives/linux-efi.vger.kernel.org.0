Return-Path: <linux-efi+bounces-5841-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F30CBCDD9
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 08:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6EB83009118
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34830BBB8;
	Mon, 15 Dec 2025 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqsTVgQ8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B323D7CF;
	Mon, 15 Dec 2025 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785326; cv=none; b=Zg3yZjOwuh1x/Az5zjtUofENWS7ltbZ/pQYeNCh4Yt2uevE10KNP9rpmgzHEmZ+cepeStzW7A7RjsebWp3p1tF0Z5JSi9jfKYCSRKN8vodzvjJ9FxtEJVCVqidiQd74scZh5os3H5HoldGd9O43nGjv3pDEaJu7XldW8eC4OFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785326; c=relaxed/simple;
	bh=2qJr895ogd7LPk/YsFAb/JfvV6B7y4KUOhDxybT1U8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD99JvbyXHawhW4/kwe9nbKpPtJA1CCNiLtxtqN0A+/3OVJBO3PEb0LH+F8TCm52X2vJZHrL5r1YRVBZcrK03NSiztBP5UuQI9d48lpiKANEipu4Yv9Zo2gQbK33RhdA6H83ccKEF5kmozEqJ7GQyWzA7fivprL++ZyML0CACmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqsTVgQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC736C4CEF5;
	Mon, 15 Dec 2025 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765785326;
	bh=2qJr895ogd7LPk/YsFAb/JfvV6B7y4KUOhDxybT1U8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqsTVgQ85nB3TC8WJu8my6yqsPEwgqdKMCHvbMV9Kk9vZi/KtU34Vp9mDYZkIkGvS
	 Rdv6SZ2PGO5hUg31hQqFiZC/huPk/HA0qATQzmYkwMQtpaYjN+4T9amD49GWE5OTJu
	 TXoehSJh6ITWFZt9u5OxLmWBwMA/F0j6FVpaB8S2Y49wXHS9cMi5fPtyXLwr3GxNGb
	 OGV2YoE22969pwGcn4fcSsxyzrpMTOFqil6WPhBRXBDoPKCsD/eGYt2vQg+B7xmiwv
	 3jKkeDKGQB2NhEQIhKXRSDf+rtgAke3aFRxjbovJXfcxMrj+70Iq8wHl5KE7H9xNQx
	 0S+Zv6QQWugIw==
Date: Mon, 15 Dec 2025 16:55:19 +0900
From: Sumit Garg <sumit.garg@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	op-tee@lists.trustedfirmware.org, linux-efi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/17] efi: stmm: Make use of
 module_tee_client_driver()
Message-ID: <aT--5-bIY8S2PiZa@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <0896270bc530d1e3b7fbcf5f7e168172dcc05d1e.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0896270bc530d1e3b7fbcf5f7e168172dcc05d1e.1765472125.git.u.kleine-koenig@baylibre.com>

On Thu, Dec 11, 2025 at 06:15:02PM +0100, Uwe Kleine-König wrote:
> Reduce boilerplate by using the newly introduced module_tee_client_driver().
> That takes care of assigning the driver's bus, so the explicit assigning
> in this driver can be dropped.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index 65c0fe1ba275..5903811858b6 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -584,24 +584,12 @@ static struct tee_client_driver tee_stmm_efi_driver = {
>  	.id_table	= tee_stmm_efi_id_table,
>  	.driver		= {
>  		.name		= "tee-stmm-efi",
> -		.bus		= &tee_bus_type,
>  		.probe		= tee_stmm_efi_probe,
>  		.remove		= tee_stmm_efi_remove,
>  	},
>  };
>  
> -static int __init tee_stmm_efi_mod_init(void)
> -{
> -	return driver_register(&tee_stmm_efi_driver.driver);
> -}
> -
> -static void __exit tee_stmm_efi_mod_exit(void)
> -{
> -	driver_unregister(&tee_stmm_efi_driver.driver);
> -}
> -
> -module_init(tee_stmm_efi_mod_init);
> -module_exit(tee_stmm_efi_mod_exit);
> +module_tee_client_driver(tee_stmm_efi_driver);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> -- 
> 2.47.3
> 
> 

