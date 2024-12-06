Return-Path: <linux-efi+bounces-2307-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33659E6CC6
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 12:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639D528279F
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 11:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC4D1FCF62;
	Fri,  6 Dec 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MgjiqdzZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBED1FC7D8
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483333; cv=none; b=VH3z14kodM5H/CFIHhHbZ2MWXGVhke0omDe6P4mdBN9gmWmtZ+vIHl3QkHHML1NT+aVx7nb3VhD1GZZ1hH8Q1tgsTm87fn8L7Jxccsh3nEfdQXLgBtz4BVLSwRRYfiCh3ZUDeDzowroR+WD+uByAzAZ++Nf4SGMK/utRaORgVMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483333; c=relaxed/simple;
	bh=W4VuhT+Jm07xuaoOKTSneZ6zXj4xO3p37XsQxo6QhR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmcrlLNHC+kNug5KOAa2BbqNEbU6zGLgQKiMH7X9woqCjtGQQDpCDC6P7+Do5KFYF74vszzos3jxBVqmZ4v5szhKI3s7RoZyPMx97aRffZh64IysAE2EzmaX8mkSXXbJd6oEd2F/F8w7/Jpxi2ZmQRGB78+69sEn7o4EVOM2ieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MgjiqdzZ; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733483330;
	bh=NhyG+EmDBcuL7ITc5tFv2+rP51hoW90ADGxMFzERI+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=MgjiqdzZfTmb/mVFTbzsypOWruuPXKPmqalwnrapBSSPRX9ZBXWuKx/rXEQNHK2pa
	 Owdt0fT/DfIcknjmrc9RiPQm03DTgyCIfZaA0Ct84DRgRPn41GH/9ATt9WarD4oB7Z
	 kp1tye/lvFsVtcUt9wEaRY3KIi4c4XR2lvGXACZO95dn1BzrfkmojzfeVy6LNqPP4n
	 cuKwE61BSO3ibR5Zaj2OZLFYfkZ3aOGDENNFUeS+do+P7PcdFzPCx3SylOoxqhlQzu
	 3vBrnTd0dnstMjHvqU/2HZ8ig8tIq43Kbs7RsrkBBEg+Xa3q76Kaj+3nG3pAqDsniz
	 8LIg8qyWiAoMg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 604B31801BD;
	Fri,  6 Dec 2024 11:08:42 +0000 (UTC)
Message-ID: <71d9c99f-aa7d-4697-8561-17b54cfe97c6@icloud.com>
Date: Fri, 6 Dec 2024 19:08:37 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] driver core: Constify API device_find_child()
 then adapt for various usages
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
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
 linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-4-1611f1486b5a@quicinc.com>
 <7ylfj462lf6g3ej6d2cmsxadawsmajogbimi7cl4pjemb7df4h@snr73pd7vaid>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <7ylfj462lf6g3ej6d2cmsxadawsmajogbimi7cl4pjemb7df4h@snr73pd7vaid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UViy4Z1HSo-8jLvn8-7u7fwR8c_nYln5
X-Proofpoint-GUID: UViy4Z1HSo-8jLvn8-7u7fwR8c_nYln5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_07,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2412060082

On 2024/12/6 15:21, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Dec 05, 2024 at 08:10:13AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Constify the following API:
>> struct device *device_find_child(struct device *dev, void *data,
>> 		int (*match)(struct device *dev, void *data));
>> To :
>> struct device *device_find_child(struct device *dev, const void *data,
>>                                  device_match_t match);
>> typedef int (*device_match_t)(struct device *dev, const void *data);
>> with the following reasons:
>>
>> - Protect caller's match data @*data which is for comparison and lookup
>>   and the API does not actually need to modify @*data.
>>
>> - Make the API's parameters (@match)() and @data have the same type as
>>   all of other device finding APIs (bus|class|driver)_find_device().
>>
>> - All kinds of existing device match functions can be directly taken
>>   as the API's argument, they were exported by driver core.
>>
>> Constify the API and adapt for various existing usages by simply making
>> various match functions take 'const void *' as type of match data @data.
> 
> With the discussion that a new name would ease the conversion, maybe
> consider device_find_child_device() to also align the name (somewhat) to
> the above mentioned (bus|class|driver)_find_device()?
> i finally select this squashing method after considerations as shown by
link below:
https://lore.kernel.org/all/3a4de1bb-3eb2-469a-8ff7-ff706804f5bb@icloud.com

device_find_child() is consist with existing device_find_child_by_name()
and device_find_any_child, device's child is also a device, so we may
not need the tail _device().

> Do you have a merge plan already? I guess this patch will go through
> Greg's driver core tree?
> 

this patch series is already squashing solution.

yes. hope it move toward mainline by Greg's driver core tree.

(^^)(^^)

> Best regards
> Uwe


