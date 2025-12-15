Return-Path: <linux-efi+bounces-5842-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83046CBCE45
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 09:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72A80304DEA1
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB22E7F2C;
	Mon, 15 Dec 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deQNvTra"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962EF2D8387;
	Mon, 15 Dec 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785366; cv=none; b=YhQt8DXHJY5qG/T6ONW85/f6nI0La5XVahi56hAJT4YsTkM2yK3/n4Ta6dYNyVg/mm0yYQT254ghHezMfc8blEECBpDnDBMuitMMioj/x6xlrHiWxmoIdl2y1VpvMr4rNCfreKsO3hcQHclzfP2HMhukBcuUBY/gV8qwciVW4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785366; c=relaxed/simple;
	bh=MlLssv01cYup7HpjM3F8nb2QRsjJ2hpns8lGvv96LxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vwc11p8E5UL+pK7tbgkWu1b1qmzkvM+VzNYNbznl2fDr2AhIgdR36mUimXWbgaLi51soZh+x+702L6RVL+heb7Mzf3uYgmccg8iOgGWl8HUpd30tP28lffQ6Kt7ExLhzCdUSJ140R/78hYlvKRHJlSm0zvKKH2mbytk3eXhhPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deQNvTra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F90C4CEF5;
	Mon, 15 Dec 2025 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765785365;
	bh=MlLssv01cYup7HpjM3F8nb2QRsjJ2hpns8lGvv96LxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=deQNvTratwzTgo1nYpirqW+raG211ew5e5OBLf6eOcDnhuHXPD80+udhz+WDYVaD3
	 uPznMJOefvjSB0YpIX+U8ByiU0aTknd/jqseZKkoy5F9ZGRSR7tkGy+y6ykzzT8FL5
	 Y4mxOuEDOvg3ynqQGStVdFuzjvpCqNoWba/+xKiVE95RKHeBLlyRb3rHQwBjo5AZE9
	 Hu73u4pMijggb8SRcIj2w963f5s6bs1PoPnE7c3IH/AeWyTj6b/anVxbt/NS5xX/7V
	 iMM/XK0ynNtSqkNQoN+JRyUCgOv2LvzBGKeJ3otrWuy2CAjgb17cgQpWXcytkZKIRa
	 k00BOxcaaco7g==
Date: Mon, 15 Dec 2025 16:55:57 +0900
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
Subject: Re: [PATCH v1 09/17] efi: stmm: Make use of tee bus methods
Message-ID: <aT-_DbMYPN0p2CrK@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <9e3d9ab0f7987f313237b51911865f0cccae8eb5.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e3d9ab0f7987f313237b51911865f0cccae8eb5.1765472125.git.u.kleine-koenig@baylibre.com>

On Thu, Dec 11, 2025 at 06:15:03PM +0100, Uwe Kleine-König wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index 5903811858b6..7b04dd649629 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -520,8 +520,9 @@ static void tee_stmm_restore_efivars_generic_ops(void)
>  	efivars_generic_ops_register();
>  }
>  
> -static int tee_stmm_efi_probe(struct device *dev)
> +static int tee_stmm_efi_probe(struct tee_client_device *tee_dev)
>  {
> +	struct device *dev = &tee_dev->dev;
>  	struct tee_ioctl_open_session_arg sess_arg;
>  	efi_status_t ret;
>  	int rc;
> @@ -571,21 +572,19 @@ static int tee_stmm_efi_probe(struct device *dev)
>  	return 0;
>  }
>  
> -static int tee_stmm_efi_remove(struct device *dev)
> +static void tee_stmm_efi_remove(struct tee_client_device *dev)
>  {
>  	tee_stmm_restore_efivars_generic_ops();
> -
> -	return 0;
>  }
>  
>  MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
>  
>  static struct tee_client_driver tee_stmm_efi_driver = {
>  	.id_table	= tee_stmm_efi_id_table,
> +	.probe		= tee_stmm_efi_probe,
> +	.remove		= tee_stmm_efi_remove,
>  	.driver		= {
>  		.name		= "tee-stmm-efi",
> -		.probe		= tee_stmm_efi_probe,
> -		.remove		= tee_stmm_efi_remove,
>  	},
>  };
>  
> -- 
> 2.47.3
> 
> 

