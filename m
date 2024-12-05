Return-Path: <linux-efi+bounces-2292-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3379E5672
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 14:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F511884109
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C743218EB6;
	Thu,  5 Dec 2024 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="IN6sqLn/"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5ED218AA8
	for <linux-efi@vger.kernel.org>; Thu,  5 Dec 2024 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404771; cv=none; b=Cmn1E+2n4emToGXwVETgthVbCAPHgl0wRqDlH9AQD0t7EuZHk2bZ56ukVFHgo34kaHOsFHayJx5kgAI5Ssvqzyarfmsx7L24JMsNcOManu3NSuohbWO0ZPOsE9GsQqdkkptDtdAXl+DEyxpo/ayvG5U4PZOWSWWw1nLeuqL2Pxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404771; c=relaxed/simple;
	bh=Y8SH9YRW4Y+tbLnxz2fC5g3ZDI0vc4mItkQNyvm6VZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+/BaCfdi/l0wSnn3Cz5KisOTiPhWdUqXoKYnry6p5Mrr5yutDi39ritT0VEVerYT4reOSSI3BwT5AJy5omV99TgqLKwItqxyWIN0IlWIUrw70rD8apAKGZJfgSVDmSOrNyv8rLwKlOu9qO/JDbnZZDmzEaqkHy9FvWGm2mJ33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=IN6sqLn/; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733404763;
	bh=DeIIq7By5hb3j6D6u79xafAimRNm6W+G83In10fjfT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=IN6sqLn/x5OCaqJO4vF5gn/fcjmZc3fZlyeytDMJnKp7XQ3de7PoFnmqSe0zeC9a5
	 vUwI0Tptt7E+4Q3DWUqdgUpD0xOI9lBpQ4RQvwZlnJGvBh2ctgzycf7q159ExifH7K
	 a8AIRvkTNSgebMbC7lLYAk5B4kjmGYrIRQclMfECHJrJ1+KGG+jAbVUk+xSHPoDbnh
	 1e9j8QEBXLJX5ZxwWzRD/5Q41qX+s8eZZmLJoAKcnBcHGPNxbbfWDhHq6Q/v1949Vm
	 rVciEGx0K4GT+eFIHW+pi7hnAXPVyGUzlxkEJ6XEG1lJhoSlPxkPp1AOo8we43GZSE
	 xVpU9Q2Rr6i5g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id C58AC3A1052;
	Thu,  5 Dec 2024 13:19:06 +0000 (UTC)
Message-ID: <f150fd45-7f84-4036-aa0e-32bd04fbeb67@icloud.com>
Date: Thu, 5 Dec 2024 21:19:02 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] gpio: sim: Remove gpio_sim_dev_match_fwnode()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, netdev@vger.kernel.org
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-8-1611f1486b5a@quicinc.com>
 <7ugfaj2h3sy77jpaadco5xtjalnten3gmvozowcle3g7zcdqs4@sqf5l47onbsi>
 <ac42e652-4128-44ea-976e-5234360d8183@quicinc.com>
 <eyu7nm5hvwfqxgysnrzsvianzf7abvlovpxfo7snsxowmuuhpj@tah3gkqm5ldj>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <eyu7nm5hvwfqxgysnrzsvianzf7abvlovpxfo7snsxowmuuhpj@tah3gkqm5ldj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2qHgOEYCHFJo6csSrQf0NeEl1TvG8_uZ
X-Proofpoint-ORIG-GUID: 2qHgOEYCHFJo6csSrQf0NeEl1TvG8_uZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_11,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=736 spamscore=0
 phishscore=0 clxscore=1011 suspectscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412050096

On 2024/12/5 18:37, Uwe Kleine-König wrote:
> On Thu, Dec 05, 2024 at 04:37:08PM +0800, quic_zijuhu wrote:
>> On 12/5/2024 4:10 PM, Uwe Kleine-König wrote:
>>> On Thu, Dec 05, 2024 at 08:10:17AM +0800, Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> gpio_sim_dev_match_fwnode() is a simple wrapper of device_match_fwnode()
>>>> Remvoe the unnecessary wrapper.
> 
> Just spotted: s/Remvoe/Remove/
> 

this typo error is my mistake, will correct it.

>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>>  drivers/gpio/gpio-sim.c | 7 +------
>>>
>>> I think if you move this patch before patch #4 in your series, you only
>>> have to touch this file once.
>>
>> the precondition of this change is patch #4, it will have building error
>> if moving it before #4.
>>
>> actually, we can only do simplifications with benefits brought by #4.
> 
> Ah I see. I thought that device_match_fwnode only got the const for the
> 2nd parameter in patch #4.
> 
> Best regards
> Uwe


