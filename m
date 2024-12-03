Return-Path: <linux-efi+bounces-2266-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B49E1CF9
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 14:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422A42821FB
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945421EF080;
	Tue,  3 Dec 2024 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Kc4yhuXu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mr85p00im-ztdg06021801.me.com (mr85p00im-ztdg06021801.me.com [17.58.23.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B861EC006
	for <linux-efi@vger.kernel.org>; Tue,  3 Dec 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231023; cv=none; b=NjFDTuWM7VGf+F6t+OydTgAZZxWr3rmG5mGblRXpNWG4MzQmyJ5dyq3bjUp51JcOIUoKCha9mpU+oy2OTNqdWbFtTHeLBwnYTdONjehumSpe359Q7oLJvbOsqAjSdwsVm5vKaaOiCg+zG7++UYq+dNw7t4M1FdzZxw7FLRH8cYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231023; c=relaxed/simple;
	bh=PMZl124fAJi/9a12repkCEPo/NdFlnbWHM0+eGs6QGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lul9/hltVfO8Te0SCeeKfs+8EmJrRxmx4eI1zsiUwW0kVVN4TDhXAVOpcDt+WLa9sF1sab5jl1oblGCN+ddFxUV0M3EoK/XtcKODkdBflIZyehY7k+TSoPIwaoqIDbPuDlLQ1NAieAwWH6tkbFm8epKndtPRqzuJA4rRoc6y+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Kc4yhuXu; arc=none smtp.client-ip=17.58.23.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733231020;
	bh=QEJ75x+TqYUJVxmVF6uQZZWFOEl0WJRfUhXN2h5KpKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=Kc4yhuXugc/D/qtZZ41v8wAnuwEzwggEWUway63IXkClqixwU1cfn/v3YVm8Qsiaw
	 28NLlORRwJjFZX7JY4DZlIgrQ1s8zKvPJAQ+RXHBAEkcNRuUPk0OyxBiAs9kB0GBL/
	 4jgwTolEa8TiqyUyeuv6tr/7DG898UMLRPOw8P2qzUVkHb/i6BK0gmuVjOCVuRaOL4
	 yVOUtS8ijY+iNGs/3oFthLPmtWg3RPz3zQCNIexvybyNTkT8kJ+0hPmRIWLu7xxlpo
	 9HqUza+TM66+s3TNEHqlu5QAj7PkxbSr1VPZfaRzmcsea2BKweNx4LzKqRftuLVcUB
	 Ma8BwRHqOq26Q==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPSA id 67D49442839;
	Tue,  3 Dec 2024 13:03:18 +0000 (UTC)
Message-ID: <b9885785-d4d4-4c72-b425-3dc552651d7e@icloud.com>
Date: Tue, 3 Dec 2024 21:02:59 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/32] driver core: Constify API device_find_child()
 and adapt for various existing usages
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
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
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024120320-manual-jockey-dfd1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CNFmwAOF9NCRr2KajfMjTjtFd_qlM54K
X-Proofpoint-GUID: CNFmwAOF9NCRr2KajfMjTjtFd_qlM54K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_02,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412030113

On 2024/12/3 20:41, Greg Kroah-Hartman wrote:
> On Tue, Dec 03, 2024 at 08:23:45PM +0800, Zijun Hu wrote:
>> On 2024/12/3 20:00, Uwe Kleine-König wrote:
>>> Hello,
>>>
>>> On Tue, Dec 03, 2024 at 08:33:22AM +0800, Zijun Hu wrote:
>>>> This patch series is to constify the following API:
>>>> struct device *device_find_child(struct device *dev, void *data,
>>>> 		int (*match)(struct device *dev, void *data));
>>>> To :
>>>> struct device *device_find_child(struct device *dev, const void *data,
>>>> 				 device_match_t match);
>>>> typedef int (*device_match_t)(struct device *dev, const void *data);
>>>
>>> This series isn't bisectible. With only the first two patches applied I
>>> hit:
>>
>> yes. such patch series needs to be merge as atomic way.
>>
>> Hi Greg,
>>
>> is it possible to ONLY merge such patch series by atomic way into your
>> driver-core tree?
> 
> Nope!
> 
>> or squash such patch series into a single patch ?
>>
>> various subsystem maintainers may not like squashing way.
> 
> Agreed, so look into either doing it in a bisectable way if at all
> possible.  As I don't see a full series here, I can't suggest how it
> needs to happen :(
> 

let me send you a full series later and discuss how to solve this issue.

> thanks,
> 
> greg k-h


