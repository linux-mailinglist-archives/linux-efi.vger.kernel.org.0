Return-Path: <linux-efi+bounces-2804-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CC8A3D6C6
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2025 11:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684B816ABD9
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2025 10:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A40F1F12E0;
	Thu, 20 Feb 2025 10:31:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD71EE7C6;
	Thu, 20 Feb 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047519; cv=none; b=P71DJb4zuuc6akjegZk53SqnX8mzZbHthJMFh6XmeUtsxvjb3GkP4H3KFeGdf64gW/ODhNs3LmiH+IAhkPFgVovTs1dCqxcPR5aMnVDxZ4+l83oY2O0QLDVNLkNW5Quma+D1iyz5ywMxwyEXjfupp9YFPcIg5D3GIvpSvkn8BO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047519; c=relaxed/simple;
	bh=EoE8bMHv7xu0prvb8E0epB/K/6l0shvsMw5QSn1M2s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8BPmiZJO3S1rOon0zYt1JRfAsvkONRUbeIJN9QyyLOyh4wFT+5q7DSDUNPB/wr5MyG2Iu6vn4WoYOyRJXOq1OhqdjvyO/PHEOd2SsEFC0s2fFgBhpgNYNqqGA9dmRDuj0bPfdDS7k+61YXc8rQ8/szdWHXAaXIQAydq/3aLF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66793C4CED1;
	Thu, 20 Feb 2025 10:31:52 +0000 (UTC)
Message-ID: <6dc1e10e-9c40-4da3-b0e0-72bdc9daa827@xs4all.nl>
Date: Thu, 20 Feb 2025 11:31:50 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] driver core: Constify API device_find_child()
 and adapt for various usages
To: Zijun Hu <zijun_hu@icloud.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-sound@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-gpio@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, netdev@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>
References: <20241224-const_dfc_done-v5-0-6623037414d4@quicinc.com>
 <20241224-const_dfc_done-v5-4-6623037414d4@quicinc.com>
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20241224-const_dfc_done-v5-4-6623037414d4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/12/2024 14:05, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Constify the following API:
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> To :
> struct device *device_find_child(struct device *dev, const void *data,
>                                  device_match_t match);
> typedef int (*device_match_t)(struct device *dev, const void *data);
> with the following reasons:
> 
> - Protect caller's match data @*data which is for comparison and lookup
>   and the API does not actually need to modify @*data.
> 
> - Make the API's parameters (@match)() and @data have the same type as
>   all of other device finding APIs (bus|class|driver)_find_device().
> 
> - All kinds of existing device match functions can be directly taken
>   as the API's argument, they were exported by driver core.
> 
> Constify the API and adapt for various existing usages.
> 
> BTW, various subsystem changes are squashed into this commit to meet
> 'git bisect' requirement, and this commit has the minimal and simplest
> changes to complement squashing shortcoming, and that may bring extra
> code improvement.
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Acked-by: Uwe Kleine-König <ukleinek@kernel.org> # for drivers/pwm
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

<snip>

> diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
> index bc63dc81bcae0d20924174be74b93a2139d5879f..697d50bedfe285d74c702efde61e510df87c1229 100644
> --- a/drivers/media/pci/mgb4/mgb4_core.c
> +++ b/drivers/media/pci/mgb4/mgb4_core.c
> @@ -123,7 +123,7 @@ static const struct hwmon_chip_info temp_chip_info = {
>  };
>  #endif
>  
> -static int match_i2c_adap(struct device *dev, void *data)
> +static int match_i2c_adap(struct device *dev, const void *data)
>  {
>  	return i2c_verify_adapter(dev) ? 1 : 0;
>  }
> @@ -139,7 +139,7 @@ static struct i2c_adapter *get_i2c_adap(struct platform_device *pdev)
>  	return dev ? to_i2c_adapter(dev) : NULL;
>  }
>  
> -static int match_spi_adap(struct device *dev, void *data)
> +static int match_spi_adap(struct device *dev, const void *data)
>  {
>  	return to_spi_device(dev) ? 1 : 0;
>  }

Reviewed-by: Hans Verkuil <hverkuil@xs4all.nl>

Regards,

	Hans

