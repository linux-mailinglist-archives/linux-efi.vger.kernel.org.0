Return-Path: <linux-efi+bounces-2449-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086139FB5BF
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 21:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AE51882304
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8421D5ABA;
	Mon, 23 Dec 2024 20:48:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CF183CCA;
	Mon, 23 Dec 2024 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734986939; cv=none; b=FAOtyobZnLjkJl7+Y/gj4kMZ7d0BpLUrw/A6cS5glUWft/V5hvp1YWhoe65n1eT1vs+duhci8WSYOJrMDisWueh9lln6qQpVn4XwC4rmgRyQhsSEtatNPFvD1xp7ZbsfjRTEuhBxgJuXNAL98ZyV6PznxJ+hfngb7+EljwiN1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734986939; c=relaxed/simple;
	bh=oRSjJGvVb5IAjOiiFlqdIhrCt8cKW3fQl+pz26q3vTs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lO4ebZ2XepBQOE53kUOLDaFylHAl2w4Yjp/hN6pA4F//szpwO68Vyc5jElSNlF/zdF378onB0bPfpOZKEjw66TTtbDj8dun2Vj+smuL/lHDaNxH4v/1pY7L7yDTRJZ1NHAwZjO0+ZFG7uMWAo+ucQ7oXINCbq2nzR+gU9J7td94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH94w3CSYz6K5lq;
	Tue, 24 Dec 2024 04:45:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C27E140517;
	Tue, 24 Dec 2024 04:48:55 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 21:48:53 +0100
Date: Mon, 23 Dec 2024 20:48:52 +0000
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
	<netdev@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: Re: [PATCH v4 10/11] cxl/pmem: Replace match_nvdimm_bridge() with
 API device_match_type()
Message-ID: <20241223204852.000021d5@huawei.com>
In-Reply-To: <20241211-const_dfc_done-v4-10-583cc60329df@quicinc.com>
References: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com>
	<20241211-const_dfc_done-v4-10-583cc60329df@quicinc.com>
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

On Wed, 11 Dec 2024 08:08:12 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Static match_nvdimm_bridge(), as matching function of device_find_child()
> matches a device with device type @cxl_nvdimm_bridge_type, and its task
> can be simplified by the recently introduced API device_match_type().
> 
> Replace match_nvdimm_bridge() usage with device_match_type().
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

I don't see any uses of is_cxl_nvdimm_bridge() other than this one
Drop that as well?

This one is a bit of a trade off because the way is_cxl_nvdimm_bridge()
is identified is kind of an internal detail, but it's been true for a long
time so I'm fine with this change.

Jonathan


> ---
>  drivers/cxl/core/pmem.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index a8473de24ebfd92f12f47e0556e28b81a29cff7c..0f8166e793e14fc0b1c04ffda79e756a743d9e6b 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -57,11 +57,6 @@ bool is_cxl_nvdimm_bridge(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_nvdimm_bridge, "CXL");
>  
> -static int match_nvdimm_bridge(struct device *dev, const void *data)
> -{
> -	return is_cxl_nvdimm_bridge(dev);
> -}
> -
>  /**
>   * cxl_find_nvdimm_bridge() - find a bridge device relative to a port
>   * @port: any descendant port of an nvdimm-bridge associated
> @@ -75,7 +70,9 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port)
>  	if (!cxl_root)
>  		return NULL;
>  
> -	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
> +	dev = device_find_child(&cxl_root->port.dev,
> +				&cxl_nvdimm_bridge_type,
> +				device_match_type);
>  
>  	if (!dev)
>  		return NULL;
> 


