Return-Path: <linux-efi+bounces-2299-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C446F9E62EE
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 02:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85996280EC3
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 01:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E084E80BFF;
	Fri,  6 Dec 2024 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="O0gm/SRx"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B51DDD1
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446992; cv=none; b=qsxNTp90vumvSaTzkFWKYMHUrkjsG3T3k7l6CCDDqvk8RTBwxdX4I9R6WA3kiw4tW3+BiAbUaqq4ojTmYmyxxbO7b5f7iCe8TyJwDkf5HjEl6zX282CiMF2I/KXbfSHs/pWzV1vLr/mqb/8rlcnUbuTlkWdv33RTQEWregkeFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446992; c=relaxed/simple;
	bh=mXKzMLG9P0/fFy8yPc/3Wnedq5fjCqRwp/fSEiqY4jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPO6c8akFvk7WqzgqbTkGoVja5tZT4o+omoofkT4Vqgtvt2W8APaC87OKwep7N882nAkCr+hnMZH6WGmWPHeoMzukLrymG8LHAzSEk5K/yLidF7xfTLFudyt3Sprh/bzBuYIdol7GTqYQahOd4H49JcY/GW8xueytfHocHTeRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=O0gm/SRx; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446990;
	bh=MLA/o3eoWdFJOEkeLQDHb3UrBR7EySOllMZRXPDaXaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=O0gm/SRxvbNugGvJblrfWTbeL81Zh+NhIgrv+vxCeahtE+oxwN3nZC3HwwKuihfnx
	 4cXiY5M5FcD5fV/sMsHvjU5WBmCcNVT7ZwGkknlvZVnSXD+x6XGDkkFFIF/04e6gQZ
	 Zg2fxY0KWh5ofbG3L8rwEFb9qCszciEJ1vWxrZ9PoginG+0DqELBU5tErjcEkVaLcU
	 oGYsHPfXPbZWAglOVp26uGDUXsLkxY8ORVxthbd4ILpIbk0Z7w+bUHoMKXTrki4Gnv
	 JzRHbqv5bfO46l/pgkQl/5OuD1YtgQ+8yIZfoBNlV5SY0vot5qXT1Zg0ppVHga6NSk
	 Y07hiEdKxi0sw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id DC943740313;
	Fri,  6 Dec 2024 01:03:01 +0000 (UTC)
Message-ID: <9d2de147-8fc6-419f-bf3e-03f6b86cbb44@icloud.com>
Date: Fri, 6 Dec 2024 09:02:58 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] cxl/pmem: Remove match_nvdimm_bridge()
To: Alison Schofield <alison.schofield@intel.com>
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
 <20241205-const_dfc_done-v3-10-1611f1486b5a@quicinc.com>
 <Z1It83v8xuNuLrOt@aschofie-mobl2.lan>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z1It83v8xuNuLrOt@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Mj6KRfIlz3zE_ytOMK9rghPIY_t2GqYx
X-Proofpoint-ORIG-GUID: Mj6KRfIlz3zE_ytOMK9rghPIY_t2GqYx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060008

On 2024/12/6 06:49, Alison Schofield wrote:
> On Thu, Dec 05, 2024 at 08:10:19AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Suggest conveying more detail in the commit msg:
> 
> cxl/pmem> Replace match_nvdimm_bridge() w device_match_type()
> 

good suggestions
will take it in v4.

>>
>> match_nvdimm_bridge(), as matching function of device_find_child(), is to
>> match a device with device type @cxl_nvdimm_bridge_type, and is unnecessary
> 
> Prefer being clear that this function recently become needless.
> Something like:
> 
> match_nvdimm_bridge(), as matching function of device_find_child(),
> matches a device with device type @cxl_nvdimm_bridge_type. The recently
> added API, device_match_type, simplifies that task.
>  
> Replace match_nvdimm_bridge() usage with device_match_type().
> 

sure. will do it in v4 by following these good comments.

> With that you can add:
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/cxl/core/pmem.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
>> index a8473de24ebfd92f12f47e0556e28b81a29cff7c..0f8166e793e14fc0b1c04ffda79e756a743d9e6b 100644
>> --- a/drivers/cxl/core/pmem.c
>> +++ b/drivers/cxl/core/pmem.c
>> @@ -57,11 +57,6 @@ bool is_cxl_nvdimm_bridge(struct device *dev)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(is_cxl_nvdimm_bridge, "CXL");
>>  
>> -static int match_nvdimm_bridge(struct device *dev, const void *data)
>> -{
>> -	return is_cxl_nvdimm_bridge(dev);
>> -}
>> -
>>  /**
>>   * cxl_find_nvdimm_bridge() - find a bridge device relative to a port
>>   * @port: any descendant port of an nvdimm-bridge associated
>> @@ -75,7 +70,9 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port)
>>  	if (!cxl_root)
>>  		return NULL;
>>  
>> -	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
>> +	dev = device_find_child(&cxl_root->port.dev,
>> +				&cxl_nvdimm_bridge_type,
>> +				device_match_type);
>>  
>>  	if (!dev)
>>  		return NULL;
>>
>> -- 
>> 2.34.1
>>
>>


