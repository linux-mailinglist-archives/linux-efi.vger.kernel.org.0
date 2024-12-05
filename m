Return-Path: <linux-efi+bounces-2291-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED4D9E564A
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 14:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4319A1883BFC
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AD6218AD3;
	Thu,  5 Dec 2024 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MjPupEdG"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B51F6671
	for <linux-efi@vger.kernel.org>; Thu,  5 Dec 2024 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404587; cv=none; b=GJp8x7srOTOSd0MV+JPP1AbYldqmBbDQzoZn5FLHRGPz1nRbj5yoeONYp1kfCv56BpF8WcSpA6mm82A4Qi8bldyvwweFvmso18YCvL3oLnSvRRqwzcNHPsyH6IRMVRRE6nytDNURvOiSgxjbRJIMG+YHvu+37q16Azc2BiZJJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404587; c=relaxed/simple;
	bh=tn4WSJdpVgE9M2OBdZCoiMZKyp3FTNFC8afvj7cJt8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIzSs8XIpcfab/HoFu1hmujWt/z+/BZ8oqLYpsJYqotH5jD+lh0ihoiTqeftDXk2c5xcig1Cj/fCaiydOzUOPGKwNXwma2yTFCdNxtignX14I6Lkrk8uHvVY/wp9uzGEJrBYwWF/8e8lJzFs71vUj9uurfU6ROBdjvWVBDY5q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MjPupEdG; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733404584;
	bh=DV2DLIPPHvXQjlEWI+ismKBgnjP6WxidLPVJKGZHkhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=MjPupEdG3LXOunytThOaHzAK+bVhMpwfidC4n4MdvWKwaw8FV9EPV38plq0FTVN0C
	 xl5AJriUjHfG5OmhTjUfel+BiaQmCJ2o11t+HqLNUWEQy+m6PrJy5nTRDH5pAAFr3F
	 J4kdsm/wsRNS1dCZBzSVcqt6FSBCyESPY4vVf8wVpfRnxrXl+Z7US8BNL1A1OPWxLK
	 2GRk6Q02wvLPjNllCH4Kvi6WwRClOdscINadBncjANCtZiOXEyTZMT5H3N1gTMvQCq
	 3a3ozKHsj1VnZvyfYLPMLSg23wNQ6MfFLBXVef/l3ga5iNw4NVuLybECqVK+bdE1jb
	 2YeT4c6Wiec4A==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 5F7A7500292;
	Thu,  5 Dec 2024 13:16:16 +0000 (UTC)
Message-ID: <d4d49b0c-7766-4f06-b098-ceee54ceeefb@icloud.com>
Date: Thu, 5 Dec 2024 21:16:12 +0800
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
 <h4pndknfwvck5yjnbs5rdmrxkqeksfxldwj4qbjqyvdzs5cjbf@i4afsjsg3obw>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <h4pndknfwvck5yjnbs5rdmrxkqeksfxldwj4qbjqyvdzs5cjbf@i4afsjsg3obw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LL8r5U1rSRzQLinnfL26afznvBJlVJho
X-Proofpoint-GUID: LL8r5U1rSRzQLinnfL26afznvBJlVJho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_11,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412050096

On 2024/12/5 18:41, Uwe Kleine-König wrote:
> On Thu, Dec 05, 2024 at 08:10:13AM +0800, Zijun Hu wrote:
>> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
>> index 07933d75ac815160a2580dce39fde7653a9502e1..1a1a9d6b8f2e8dfedefafde846315a06a167fbfb 100644
>> --- a/arch/sparc/kernel/vio.c
>> +++ b/arch/sparc/kernel/vio.c
>> @@ -419,13 +419,13 @@ struct vio_remove_node_data {
>>  	u64 node;
>>  };
>>  
>> -static int vio_md_node_match(struct device *dev, void *arg)
>> +static int vio_md_node_match(struct device *dev, const void *arg)
>>  {
>>  	struct vio_dev *vdev = to_vio_dev(dev);
>> -	struct vio_remove_node_data *node_data;
>> +	const struct vio_remove_node_data *node_data;
>>  	u64 node;
>>  
>> -	node_data = (struct vio_remove_node_data *)arg;

existing code has such cast
>> +	node_data = (const struct vio_remove_node_data *)arg;
>
i just follow existing code here.

> You can just drop the cast here. But maybe that is better be done i a
> separate change.
> 

agree, removing such casts may be another topic.

>>  	node = vio_vdev_node(node_data->hp, vdev);
>>  
> 
> Best regards
> Uwe


