Return-Path: <linux-efi+bounces-2446-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017E99FB58F
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 21:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8481883548
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C11D14FA;
	Mon, 23 Dec 2024 20:44:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F391C3F01;
	Mon, 23 Dec 2024 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734986699; cv=none; b=WDagT/TlbW20UPEULBQ53AdVgYvPvktI6oxQlU8I2MPmcK/W6kyooO1XVWcGt3w61+bl8NVmvZg4IRrjVD+qrcPA+XtZoI3ijqLqu3WPh6qyPfltZ43qvciGYqF4GspEBK1iuPv6GoN+qUTtAxuWuh/omGMIyIu6gKRfz5sfS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734986699; c=relaxed/simple;
	bh=IWkoWlo6KqZQ7bM8Y4HXHrKl5qFkFAUQuAxCS3AXi/w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRVO9eVmD/GCSryIYyBO+17RvnBLkkmIeN8VtHsdAEA9c4VzC4JZthxOuQcuHR3b25u11eAGgyhbVNQYOfVd1jyi+wPyRVlpinPWu65YVgxzx2u9XLEORut9ZEre5WCKEK1lsb9XVnTU1XnebrdL8JFzk86tFGnAYyQbGy4perk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH90J5wVhz6K5VT;
	Tue, 24 Dec 2024 04:41:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C7FFB140A70;
	Tue, 24 Dec 2024 04:44:55 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 21:44:54 +0100
Date: Mon, 23 Dec 2024 20:44:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zijun Hu <zijun_hu@icloud.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Thomas =?ISO-8859-1?Q?Wei=DFschu?=
 =?ISO-8859-1?Q?h?= <thomas@t-8ch.de>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-sound@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux1394-devel@lists.sourceforge.net>,
	<arm-scmi@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-hwmon@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-remoteproc@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<netdev@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v4 07/11] slimbus: core: Remove of_slim_match_dev()
Message-ID: <20241223204452.000067e6@huawei.com>
In-Reply-To: <20241211-const_dfc_done-v4-7-583cc60329df@quicinc.com>
References: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com>
	<20241211-const_dfc_done-v4-7-583cc60329df@quicinc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Dec 2024 08:08:09 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> static of_slim_match_dev() has same function as API device_match_of_node().
> 
> Remove the former and use the later instead.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Nice tidy up given the current code is dance up and down containing structure to exactly
the same device it started with.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/slimbus/core.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index ab927fd077cb4fe1e29c004269fe52b2896c302f..005fa2ef100f526df5603d212b6334c06a366c94 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -385,21 +385,13 @@ struct slim_device *slim_get_device(struct slim_controller *ctrl,
>  }
>  EXPORT_SYMBOL_GPL(slim_get_device);
>  
> -static int of_slim_match_dev(struct device *dev, const void *data)
> -{
> -	const struct device_node *np = data;
> -	struct slim_device *sbdev = to_slim_device(dev);
> -
> -	return (sbdev->dev.of_node == np);
> -}
> -
>  static struct slim_device *of_find_slim_device(struct slim_controller *ctrl,
>  					       struct device_node *np)
>  {
>  	struct slim_device *sbdev;
>  	struct device *dev;
>  
> -	dev = device_find_child(ctrl->dev, np, of_slim_match_dev);
> +	dev = device_find_child(ctrl->dev, np, device_match_of_node);
>  	if (dev) {
>  		sbdev = to_slim_device(dev);
>  		return sbdev;
> 


