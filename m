Return-Path: <linux-efi+bounces-2298-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F9D9E62CF
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 02:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6530228491A
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBD013AA4C;
	Fri,  6 Dec 2024 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="G1yK0/3Y"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89C76048
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446851; cv=none; b=GxCCQiMA46saVJIBnB20VBcGpMYN9MMlVD6fZPbhSYjBhG6QIRSDjq/dA7YFZEV+Q/6wgx0Hp1/cvQh2riFhE6jkvrU2rZJEr/IEVlzfw12ozXrl/XAnts4QI3fxCCLZNsEAySK/0vL4TEEDZb29s7c+uxO7LGwkO0E1CZVaNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446851; c=relaxed/simple;
	bh=BllzfyJKzSwiUMnAWZVlcX0N+XiDfGCLEzInEB6bL4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COvEEX8jZh3POmbqnluJmtvS2QoCcTn3A/ru0RxGW/KPzE29upqomc7YO8O8rUqL/iuiu3qfR1ICPwYmIUWPLAACM2wAxzH7WVQRqYZ1Deo1M38n73BEzyvsqNkvF69k87Za045zn3PkjZvAqvs1GMAXzl/w7IGFGQR0Z2JldGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=G1yK0/3Y; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446848;
	bh=YgEIWxk2/e/iYW5sknXjbn6nIFGLK2sO7NKKDe0RmG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=G1yK0/3YSKhJBjyAzf3EDn2bwsIP/TQQaRq1+pHJTcb2xhFy2oJ0HZEOPVqoRVZ1E
	 OCmrwAZ0Pelc2A+d5SIf+o2wTYc5YRsN5C08BDyF81reWnJwkQ8WCcrN+rg8/iFkLY
	 COKgxB3az9ZDQQfgx+wkVQVP1xHK3X2EYQ6noCH1ngqsophyDhSnN2eP9f7VpeeOYq
	 w4RWgmn8cNyUjoenz34MjLIeG58YJJcIhoEN0ew9sEcgFtgARBItj5vel2yJFWvOYb
	 prUp0wWigkT1r8rtSAhXkqyZ2q0gfpXZjzSPoxNR8nP7Va9VvM54ECluqJtancf2m4
	 2NX8HkzdAMjtw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 15B785002B3;
	Fri,  6 Dec 2024 01:00:37 +0000 (UTC)
Message-ID: <8c89163d-2fac-42ef-acd3-76c0f298e8cb@icloud.com>
Date: Fri, 6 Dec 2024 09:00:33 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] gpio: sim: Remove gpio_sim_dev_match_fwnode()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-sound@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-gpio@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-8-1611f1486b5a@quicinc.com>
 <CAMRc=Mf--vRm15N2au-zvP89obcxRuk+3OOLqFtrjgg61_LotA@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAMRc=Mf--vRm15N2au-zvP89obcxRuk+3OOLqFtrjgg61_LotA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zbowhbFmvtzwQ1zQJwPzLroNMq0mmr26
X-Proofpoint-ORIG-GUID: zbowhbFmvtzwQ1zQJwPzLroNMq0mmr26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=915 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060007

On 2024/12/6 00:24, Bartosz Golaszewski wrote:
> On Thu, Dec 5, 2024 at 1:15 AM Zijun Hu <zijun_hu@icloud.com> wrote:
>>
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> gpio_sim_dev_match_fwnode() is a simple wrapper of device_match_fwnode()
>> Remvoe the unnecessary wrapper.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/gpio/gpio-sim.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
>> index 370b71513bdb529112e157fa22a5451e02502a17..b1f33cbaaaa78aca324f99c45a868e7e79a9d672 100644
>> --- a/drivers/gpio/gpio-sim.c
>> +++ b/drivers/gpio/gpio-sim.c
>> @@ -413,11 +413,6 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
>>         return devm_add_action_or_reset(dev, gpio_sim_sysfs_remove, chip);
>>  }
>>
>> -static int gpio_sim_dev_match_fwnode(struct device *dev, const void *data)
>> -{
>> -       return device_match_fwnode(dev, data);
>> -}
>> -
>>  static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
>>  {
>>         struct gpio_sim_chip *chip;
>> @@ -503,7 +498,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
>>         if (ret)
>>                 return ret;
>>
>> -       chip->dev = device_find_child(dev, swnode, gpio_sim_dev_match_fwnode);
>> +       chip->dev = device_find_child(dev, swnode, device_match_fwnode);
>>         if (!chip->dev)
>>                 return -ENODEV;
>>
>>
>> --
>> 2.34.1
>>
>>
> 
> Please use get_maintainers.pl to get the complete list of addresses to Cc.

thanks for code review.
will fix it in v4.

> 
> Bartosz


