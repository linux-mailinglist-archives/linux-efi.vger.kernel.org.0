Return-Path: <linux-efi+bounces-2442-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF4C9FB547
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 21:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F24188577E
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 20:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAAC1CDA02;
	Mon, 23 Dec 2024 20:26:42 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7971C68B6;
	Mon, 23 Dec 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985602; cv=none; b=rdweXFwPYKlPH/b9usQUL7R/nAQBTsC3SgESnlMJOhzZ0DRxpTlQqYeziLqs4aw/676XZ20vwuNqxhY/BIdzoYCXyVNSxMLReLn46AomdajnHxRYvqXPYm2p5DA+ZEuFHZOMHa80xaRuGAOIitpCyWeMyUSa3YUpLBqvZsA3RLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985602; c=relaxed/simple;
	bh=g1fz4jD8i+Gw8p5L+d5HeGHuE1SKe2d8qrpmah3TFBs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGEKLFujKlI9+H4X46F0vG6uS5MOkFdjnMVYrPwbWNs7bXwFMJOlBBmK8qxojdYbnncwbxD/YzMI8PmCNxWBsdLEA3MZuEOt77X7FKAEbub88WETvdVXqiQFDVbtdFUIvU2iAmJRrbbhEkrhUHV0TotzhLJDVp4zdnK1skhAa88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH8gJ6L2tz689xS;
	Tue, 24 Dec 2024 04:26:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A305140A70;
	Tue, 24 Dec 2024 04:26:38 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 21:26:36 +0100
Date: Mon, 23 Dec 2024 20:26:35 +0000
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
Subject: Re: [PATCH v4 03/11] bus: fsl-mc: Constify fsl_mc_device_match()
Message-ID: <20241223202635.00005a0a@huawei.com>
In-Reply-To: <20241211-const_dfc_done-v4-3-583cc60329df@quicinc.com>
References: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com>
	<20241211-const_dfc_done-v4-3-583cc60329df@quicinc.com>
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

On Wed, 11 Dec 2024 08:08:05 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> fsl_mc_device_match() does not modify caller's inputs.
> 
> Constify it by simply changing its parameter types to const pointer.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Similar to previous patch, I'd say why you are making this change.
There are may places in the kernel where pointers are constant but
not marked so. Why does this one matter?  

With that info added
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/bus/fsl-mc/dprc-driver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
> index 4b68c84ef485055c9b300b4f7912a20f959b8ac1..11c8fadcf85148b4e4ea6b97b7efb6d4ddf22d3c 100644
> --- a/drivers/bus/fsl-mc/dprc-driver.c
> +++ b/drivers/bus/fsl-mc/dprc-driver.c
> @@ -22,8 +22,8 @@ struct fsl_mc_child_objs {
>  	struct fsl_mc_obj_desc *child_array;
>  };
>  
> -static bool fsl_mc_device_match(struct fsl_mc_device *mc_dev,
> -				struct fsl_mc_obj_desc *obj_desc)
> +static bool fsl_mc_device_match(const struct fsl_mc_device *mc_dev,
> +				const struct fsl_mc_obj_desc *obj_desc)
>  {
>  	return mc_dev->obj_desc.id == obj_desc->id &&
>  	       strcmp(mc_dev->obj_desc.type, obj_desc->type) == 0;
> 


