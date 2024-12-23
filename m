Return-Path: <linux-efi+bounces-2441-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835389FB536
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 21:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039B37A1F2E
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 20:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E101C68B6;
	Mon, 23 Dec 2024 20:25:38 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF01B6CEF;
	Mon, 23 Dec 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985537; cv=none; b=e2eQL2vaXTLS50uiNS1/Mu0jCAJBZDgsL7RSPasL/l1Q/BKZF+WeUPhhJ056/p4kg047AUvc/XHt4h1n6I1B47tWxMjT7bsSwdqckgBfer9gyUAW9XLlBSJ1uSuoJOpkMVR8mKweI+LUFqpQlap3Gr3udsr8HMWOWp1C9rOB2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985537; c=relaxed/simple;
	bh=HQosAhj6yDzXPDXmfSRhTQ+maz93aF0v8iiG4Tu0AUk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VU4zgY+1Yla9nCQgmTdnR8TueXtLuECbgCz4IRiK+NsC3/dLSX4mNpNPVPQKVr12hjxGd2Q0m2x9rc1Rx35M5/QsDWt02bVLwglpJ2BJ4mzrlMt6BIMT7f8So5hEvjNFJGD3GxSWdZobYArkCsJbrswzax270FQF+kZ20RvHYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH8d16bSPz6LDSB;
	Tue, 24 Dec 2024 04:24:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A53F140A70;
	Tue, 24 Dec 2024 04:25:34 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 21:25:32 +0100
Date: Mon, 23 Dec 2024 20:25:30 +0000
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
Subject: Re: [PATCH v4 02/11] slimbus: core: Constify slim_eaddr_equal()
Message-ID: <20241223202530.00002d37@huawei.com>
In-Reply-To: <20241211-const_dfc_done-v4-2-583cc60329df@quicinc.com>
References: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com>
	<20241211-const_dfc_done-v4-2-583cc60329df@quicinc.com>
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

On Wed, 11 Dec 2024 08:08:04 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> bool slim_eaddr_equal(struct slim_eaddr *a, struct slim_eaddr *b)
> does not modify @*a or @*b.
> 
> Constify it by simply changing its parameter type to
> 'const struct slim_eaddr *'.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Absolutely makes sense given later patches mean one of the inputs
is of type constant pointer, but maybe worth calling that out as
the reason for the change here.

Other than that looks good.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/slimbus/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 65e5515f7555e2eb840fedaf2dc4cc5d76dbc089..b5d5bbb9fdb6614ffd578f5754226b50e394f0df 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -328,7 +328,8 @@ void slim_report_absent(struct slim_device *sbdev)
>  }
>  EXPORT_SYMBOL_GPL(slim_report_absent);
>  
> -static bool slim_eaddr_equal(struct slim_eaddr *a, struct slim_eaddr *b)
> +static bool slim_eaddr_equal(const struct slim_eaddr *a,
> +			     const struct slim_eaddr *b)
>  {
>  	return (a->manf_id == b->manf_id &&
>  		a->prod_code == b->prod_code &&
> 


