Return-Path: <linux-efi+bounces-2273-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 531139E4A56
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 01:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2114A165FD1
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 00:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3586DA945;
	Thu,  5 Dec 2024 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="viUyMPDu"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C00EBE
	for <linux-efi@vger.kernel.org>; Thu,  5 Dec 2024 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357279; cv=none; b=XuP0LulSvfJ3HKiWl9iQee84ViblC/XfKtmVno74o+jzxS9ySzff6RP5HQmVl6nIVCqw33lJeaubhWyW0x5DQmRbp9hmg7XhjttHaCq+oVylHgTWtx+sPOSWdCI78HQlATQfFhOV+kczRRft9q9fF26+gWxGozpMs1wo/PGHw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357279; c=relaxed/simple;
	bh=jXDu8pWjhuYPdMP7VqE1gBu4NrjerabEKnAlH0ltUtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F97Cf+LqBrqXR3mz3LgVePm2r/CL74DgW0bPFFfhKNgSf3X+usOkbbr2x9K0G8Krw3VXAdWe/lr0NsQ5BFwCD93lN07ZUz2y5fAERCX5s48wHXJEdJJ8h7oLxYp+8N/4IDTk6iE+uZUpdHNO8/xKtA65sdwakIHOVr6HUUdhB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=viUyMPDu; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733357275;
	bh=T0i1UIwZu179fqDDvM1SaMgHe4/s268Ao/wTXHvJFpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=viUyMPDupWXi4CsrMrPO0pTZeZeGxPoM+enltzZDnkb+kI0qdByPZT5LU1xBetse2
	 NtaWPzW2mnfiL0cDcb5AxsMAlW09DyzC74O6RR3cBb+ZzhEN7re48DHO1hdcod+aXb
	 zbl3rMYxZGrv7wQqdRJsrWCp9PSwtE6uiLaNWgjCRsBT8D1ZUgFnCeCL+arYkrJDex
	 wriQVWYopBjYxrWk6ouKFvfzOLXBz2VSyl6NuyevHO9GGv1V4cTmquonLgabfDNxjR
	 5eSkEUOnbtt2Et4RjPSCmjNRxtqblo8cbQN/o+14zsvC0nuehSg5FcL9uofh/yy5ZC
	 z6tN/Ugl8ZG4Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 9CBA68001C9;
	Thu,  5 Dec 2024 00:07:24 +0000 (UTC)
Message-ID: <3a4de1bb-3eb2-469a-8ff7-ff706804f5bb@icloud.com>
Date: Thu, 5 Dec 2024 08:07:20 +0800
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
 <235ce0a9-1db1-4558-817b-6f92f22be5ab@icloud.com>
 <5c905df49a332b1136787a524955b46b6153c012.camel@HansenPartnership.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <5c905df49a332b1136787a524955b46b6153c012.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SnhSPaefh2SqVr4UPg8Q8Npi4W-Py9Af
X-Proofpoint-ORIG-GUID: SnhSPaefh2SqVr4UPg8Q8Npi4W-Py9Af
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_19,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412040186

On 2024/12/5 00:42, James Bottomley wrote:
>>>>  introduce extra device_find_child_new() which is constified  ->
>>>> use *_new() replace ALL device_find_child() instances one by one
>>>> -> remove device_find_child() -> rename *_new() to
>>>> device_find_child() once.
>>> Why bother with the last step, which churns the entire code base
>>> again?
>> keep the good API name device_find_child().
> Well, I think it's a good opportunity to rename the API better, but if
> that's the goal, you can still do it with _Generic() without churning
> the code base a second time.  The example is in
> slab.h:kmem_cache_create
> 

i understand these solutions _Generic()/_new/squashing.
every solutions have its advantages and disadvantages.

i decide to use squashing solution for this concrete scenario after some
considerations since:

1) it has the minimal patch count to achieve target.
2) every patch is valuable, but other solutions needs to undo beginning
  patch finally.
3) for the squashing patch, i will only make the least and simplest
changes for various match functions, that will compensate its
disadvantages.

>>> Why not call the new function device_find_child_const() and simply
>>> keep it (it's descriptive of its function).  That way you can have
>>> a patch series without merging and at the end simply remove the old
>>> function.
>> device_find_child is a good name for the API, 'find' already means
>> const.
> Not to me it doesn't, but that's actually not what I think is wrong
> with the API name: it actually only returns the first match, so I'd
> marginally prefer it to be called device_find_first_child() ... not
> enough to churn the code to change it, but since you're doing that
> anyway it might make sense as an update.

name device_find_child appeared 18 years ago, it is good to keep this
name developers known about.

the API only return one device *, it should be obvious that it is the
first device which meet matching condition.

Other device finding APIs (bus|class|driver)_find_device() does not have
concern about 'first'

So, IMO, current name is good.


