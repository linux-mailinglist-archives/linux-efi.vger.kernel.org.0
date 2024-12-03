Return-Path: <linux-efi+bounces-2269-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765B9E2A56
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 19:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61AEFB44740
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1F1F7550;
	Tue,  3 Dec 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WJoHxyHP"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F913B5B6
	for <linux-efi@vger.kernel.org>; Tue,  3 Dec 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237855; cv=none; b=dllwoB5M2pTbEZk3OUB01qFDGeGbuUv7PTlq9zwoBiyd6VHyvCN9PmJai09/Qa/BXN2nR3O6tzMfUDTyHUBHs0+k0xxDYgngJjpJ1iSwP8lZGpJ+rhCg+RrC4bjmIkJuaWBUYSvwiBXT5b1/rvrRiHUrR4qFER7PByUJAcaT9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237855; c=relaxed/simple;
	bh=I1QE9YqXRd/95EuZ6shU92lVYpx6jSwp7U8UdDQ+eqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3X1y+hgAQJw9iepjAu/FOidBLXRzIVP6O+jR7ZmkVaddNBMrVu4CqoxueEq60ms2ftXHxvpl7o3RzgBWMIftJNESt6IF7oPK8UVJrbGf2N/2PG9/bh9ckWvQAZy4X0B0wkmx1E6h0bgRnx25yX427CZBOULFu5VyzaNUT4g9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WJoHxyHP; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733237853;
	bh=zPP2M6RHoQlxRDoHnjCsF/MyKgy2Hv/oTH6yXikXqgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=WJoHxyHPQic0UPYroDs8nCEAWsZm40sH8RhZy74XvLp/u3uVoK8y0NcRam0ip/lrx
	 bXSlxO0ATLyoBoLBgb1HPjJ6VzOkweGc3d49hUpXLFFHcJz2ky04rRviy7vj4V1Uv0
	 UrP8xtrDy605sSzzXJfwV92hCnmVSa/In2c5FK+QwsvdkOzwtlVoKR8MfrPuM+OkJ3
	 kTV9qWoS0uz7z4phORc7Uz1s0gw2Ayri2PFJ13eQLHgrebkECU60pYLHuubiEEJ1y+
	 pdLr+ixZhVq84c1mKgl9tDNm6hKdk1MRV7Fp8S0cKzjfCmv+0IlvKjaoM5N1+JgTTH
	 Pur3pBzgfGODA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 367E14A0413;
	Tue,  3 Dec 2024 14:56:59 +0000 (UTC)
Message-ID: <f5ea7e17-5550-4658-8f4c-1c51827c7627@icloud.com>
Date: Tue, 3 Dec 2024 22:56:54 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/32] driver core: Constify API device_find_child()
 and adapt for various existing usages
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Jiri Slaby <jirislaby@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Mike Christie <michael.christie@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>,
 Manish Rangankar <mrangankar@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Andreas Larsson <andreas@gaisler.com>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Jens Axboe <axboe@kernel.dk>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>, Ard Biesheuvel
 <ardb@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-pwm@vger.kernel.org, nvdimm@lists.linux.dev,
 linux1394-devel@lists.sourceforge.net, linux-serial@vger.kernel.org,
 linux-sound@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, linux-cxl@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241203-const_dfc_done-v2-0-7436a98c497f@quicinc.com>
 <g32cigmktmj4egkq2tof27el2yss4liccfxgebkgqvkil32mlb@e3ta4ezv7y4m>
 <9d34bd6f-b120-428a-837b-5a5813e14618@icloud.com>
 <2024120320-manual-jockey-dfd1@gregkh>
 <b9885785-d4d4-4c72-b425-3dc552651d7e@icloud.com>
 <8eb7c0c54b280b8eb72f82032ede802c001ab087.camel@HansenPartnership.com>
 <8fb887a0-3634-4e07-9f0d-d8d7c72ca802@t-8ch.de>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <8fb887a0-3634-4e07-9f0d-d8d7c72ca802@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JxnDC87bqdECTEQWZZVsnICFx4KSLLiI
X-Proofpoint-ORIG-GUID: JxnDC87bqdECTEQWZZVsnICFx4KSLLiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_04,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412030127

On 2024/12/3 22:07, Thomas Weißschuh wrote:
> On 2024-12-03 08:58:26-0500, James Bottomley wrote:
>> On Tue, 2024-12-03 at 21:02 +0800, Zijun Hu wrote:
>>> On 2024/12/3 20:41, Greg Kroah-Hartman wrote:
>>>> On Tue, Dec 03, 2024 at 08:23:45PM +0800, Zijun Hu wrote:
>> [...]
>>>>> or squash such patch series into a single patch ?
>>>>>
>>>>> various subsystem maintainers may not like squashing way.
>>>>
>>>> Agreed, so look into either doing it in a bisectable way if at all
>>>> possible.  As I don't see a full series here, I can't suggest how
>>>> it needs to happen :(
>>>>
>>>
>>> let me send you a full series later and discuss how to solve this
>>> issue.
>>
>> It's only slightly more complex than what we normally do: modify all
>> instances and then change the API.  In this case you have an additional
>> problem because the prototype "const void *" will cause a mismatch if a
>> function has "void *".  The easiest way to solve this is probably to
>> make device_find_child a macro that coerces its function argument to
>> having a non const "void *" and then passes off to the real function. 
>> If you do that in the first patch, then you can constify all the
>> consumers and finally remove the macro coercion in the last patch.
> 
> Casting function pointers like that should be detected and trapped by
> control flow integrity checking (KCFI).
> 
> Another possibility would be to use a macro and _Generic to dispatch to
> two different backing functions. See __BIN_ATTR() in
> include/linux/sysfs.h for an inspiration.

this way may fix building error issue but does not achieve our purpose.
our purpose is that there are only constified device_find_child().


> This also enables an incremental migration.
> 
> 

change the API prototype from:
device_find_child(..., void *data_0, int (*match)(struct device *dev,
void *data));

to:
device_find_child(..., const void *data_0, int (*match)(struct device
*dev, const void *data));

For @data_0,  void * -> const void * is okay.
but for @match, the problem is function pointer type incompatibility.

there are two solutions base on discussions.

1) squashing likewise Greg mentioned.
   Do all of the "prep work" first, and then
   do the const change at the very end, all at once.

2)  as changing platform_driver's remove() prototype.
Commit: e70140ba0d2b ("Get rid of 'remove_new' relic from platform
driver struct")

 introduce extra device_find_child_new() which is constified  -> use
*_new() replace ALL device_find_child() instances one by one ->  remove
device_find_child() -> rename *_new() to device_find_child() once.

> Thomas


