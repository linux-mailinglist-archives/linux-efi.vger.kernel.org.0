Return-Path: <linux-efi+bounces-2463-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9F9FBDB1
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 13:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343BB163A8B
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E441D63DE;
	Tue, 24 Dec 2024 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lCyJhxt8"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83631C4A24
	for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045135; cv=none; b=NJUiZeWhO2e3umr890V0km1qLYif8KwXiytO7DvpKAfl7ZPdfow3NOraH6ypGDhYVJFFsirD6QPRrUehA+OaqvgXQUNnyZ/t6D5CZc+8bNaG6fedipqF7rE9/Zn75jDvOm2RcN+t8r8JFqi3tmTx3QA8ePiw4WsxPtN+rMT+mKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045135; c=relaxed/simple;
	bh=YU3YZf97/L0qbzYrDeLMvLHqQw13/e7gCq2HUp6m9EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCzjKWCi7exF/igqSTH9c122fVerK4kUd3Trgcb2/SGeUYGpOeiptF4MDnimXaIQ/sQVKq95sqNLi/+kFe0604PaS74gJvOFgN6dhXPzGO7SlIV6GhklZR00PNk1l3ZuPseiQIVc0UhduUM+uWroka5Se2vXfwaawNyFy6aOUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lCyJhxt8; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045132;
	bh=h3kiho8TfVhUdQIW4loxFW4A6GTk7CzgqqA6rmZLle8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=lCyJhxt8u8AX46T2X/wvu3PmNuUXKCcKs4cLekyBu/8uAMfnysIzbGe1AlUCBV4Uf
	 p0xefkStqlMGem4pR7zaumh1oJJUrgckAhBU5gPn3YZaqdSuC+g1hpDvQGSKVPXlUE
	 gVVAyGn7g10BMn4kokWDpQmaCH4LETsoPF2UCml5q50IPrfFe96UG1vZSL1JZ1jjfT
	 iQ9r04XiXcSIx0lDb1MRDBJYXuRgSi1nxnIwzLWnyg7rs3uK5Vnl7NMN6YPpri02uN
	 JQ6jRpFZ5EFje1YrJkMdYeBe92ukQdxhfilb5OrZFswHLC6M/j99Wf06JWIPJAXXhh
	 Fj/5wZNF7w3WQ==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 297F14A033A;
	Tue, 24 Dec 2024 12:58:41 +0000 (UTC)
Message-ID: <5d7531da-5ae9-4c31-93c6-f2bca4c2d814@icloud.com>
Date: Tue, 24 Dec 2024 20:58:38 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] cxl/pmem: Replace match_nvdimm_bridge() with API
 device_match_type()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
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
 Alison Schofield <alison.schofield@intel.com>
References: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com>
 <20241211-const_dfc_done-v4-10-583cc60329df@quicinc.com>
 <20241223204852.000021d5@huawei.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241223204852.000021d5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5BM9Ll3OJODDbXjCMiiEryY0SGhaSZXP
X-Proofpoint-GUID: 5BM9Ll3OJODDbXjCMiiEryY0SGhaSZXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=791 clxscore=1015
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240112

On 2024/12/24 04:48, Jonathan Cameron wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Static match_nvdimm_bridge(), as matching function of device_find_child()
>> matches a device with device type @cxl_nvdimm_bridge_type, and its task
>> can be simplified by the recently introduced API device_match_type().
>>
>> Replace match_nvdimm_bridge() usage with device_match_type().
>>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> I don't see any uses of is_cxl_nvdimm_bridge() other than this one
> Drop that as well?
> 
will add a optional patch to drop is_cxl_nvdimm_bridge() in next revision.

> This one is a bit of a trade off because the way is_cxl_nvdimm_bridge()
> is identified is kind of an internal detail, but it's been true for a long
> time so I'm fine with this change.
> 
> Jonathan


