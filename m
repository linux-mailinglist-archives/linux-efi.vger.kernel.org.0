Return-Path: <linux-efi+bounces-2271-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2607F9E3A2A
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2024 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB06B22E22
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2024 12:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A581BD9E9;
	Wed,  4 Dec 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="aDx0LVkM"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680231B87D6
	for <linux-efi@vger.kernel.org>; Wed,  4 Dec 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315229; cv=none; b=dQeYFRGcvGmEjc+V6qIWOsgnlqrrf4mGLEhvYDM+U/KO6kf3hSoN9JneaIWSQ1Hi+qi/JZWlQAmywAVEpLUXcs+/laZ8PBnd19qQXwNa5PfyPwHbD+86ggVCSh6PDyJy1YNgeNKQwZG078yDQrhMQsWjGPdi5wg/wkO4tNDPWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315229; c=relaxed/simple;
	bh=b3cKO8E37kdGEfPQBy2NupErjAuGZ0w9V7NN+3pjucc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ljmp1b/5+tF9ZJuHMlfBSzbs0l/qF1QxvPJ2F67j/Lga35tzO0K1Er5ORwPDqVH3yVpNGTzuOUMkxxEsSO3DJAMtGZAgyaSmVuiG+Q0LuarVkO/F+tyIuRL9cJ/gb1BxRIppJJqPYV9HDc8hijuCl5eBf9iJ1velblp4yv6RGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=aDx0LVkM; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733315226;
	bh=tDbYa+5DWmHdZ9lmVLNA7xMZvJoZ/PCpc6Zau1xliNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=aDx0LVkMUXFI75QpCfQtwEzziTl2NnjdGJ/9Nl6EjkD9AoNOPkj0pNJDmDS0yOxmo
	 cFAXLbMOmPcOl5uunRBBrqBVYZF5ppxfVoWTl3S1fXUPYvDXVgmxgrfgiOzuzDhljR
	 JXz5mSklSuuNIhx7A4INyoL4v8SXD0un9r9AkY3EWP5hUjq0cVMBNRe3UAI+WH+UEp
	 aQcXPRWXKjSKZb3dQybv2/fEczrg8mOY6isUSLdmtOWnHvZ0W1/xlosR4mnRECds2h
	 6Ay6kSNLijQWwdsoHl1pqn9BntMizpWoDbFHr5J8zkhSqKMjCSXP0KeQ2EZIN5IQ7P
	 WHMoRxUFUJF5Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id B793434BA6BD;
	Wed,  4 Dec 2024 12:26:37 +0000 (UTC)
Message-ID: <235ce0a9-1db1-4558-817b-6f92f22be5ab@icloud.com>
Date: Wed, 4 Dec 2024 20:26:22 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/32] driver core: Constify API device_find_child()
 and adapt for various existing usages
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
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
 <f5ea7e17-5550-4658-8f4c-1c51827c7627@icloud.com>
 <108c63c753f2f637a72c2e105ac138f80d4b0859.camel@HansenPartnership.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <108c63c753f2f637a72c2e105ac138f80d4b0859.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ptou9-aUclkqdkvBrep0JqLqpE5OAxzN
X-Proofpoint-GUID: Ptou9-aUclkqdkvBrep0JqLqpE5OAxzN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_09,2024-12-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412040096

On 2024/12/3 23:34, James Bottomley wrote:
>>> This also enables an incremental migration.
>> change the API prototype from:
>> device_find_child(..., void *data_0, int (*match)(struct device *dev,
>> void *data));
>>
>> to:
>> device_find_child(..., const void *data_0, int (*match)(struct device
>> *dev, const void *data));
>>
>> For @data_0,  void * -> const void * is okay.
>> but for @match, the problem is function pointer type incompatibility.
>>
>> there are two solutions base on discussions.
>>
>> 1) squashing likewise Greg mentioned.
>>    Do all of the "prep work" first, and then
>>    do the const change at the very end, all at once.
>>
>> 2)  as changing platform_driver's remove() prototype.
>> Commit: e70140ba0d2b ("Get rid of 'remove_new' relic from platform
>> driver struct")
>>
>>  introduce extra device_find_child_new() which is constified  -> use
>> *_new() replace ALL device_find_child() instances one by one -> 
>> remove device_find_child() -> rename *_new() to device_find_child()
>> once.
> Why bother with the last step, which churns the entire code base again?

keep the good API name device_find_child().

> Why not call the new function device_find_child_const() and simply keep
> it (it's descriptive of its function).  That way you can have a patch
> series without merging and at the end simply remove the old function.

device_find_child is a good name for the API, 'find' already means const.


