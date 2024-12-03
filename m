Return-Path: <linux-efi+bounces-2262-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E99E1145
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 03:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E91FB22C83
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3828813D52B;
	Tue,  3 Dec 2024 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RRde32nS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6A10E3;
	Tue,  3 Dec 2024 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193045; cv=none; b=G1W25i7/xbWAD0An+FCidiOfLR1T5DfqN6OicrvpFNguRJjScKq0QFzcj+4HB8u1cBFQpTL1DSzvYBsRjn/90fS2IUgYPCu5Qyh8tdtnjJN8kIu0/N3wFsNMPbCI+R1ZfS9sCUZTFxlgTL+oQO1i8nF1p2mTxO7h0n3hcetC09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193045; c=relaxed/simple;
	bh=J6kCfI3+mWerd7aq/zsBLPHGDZ8UEOfEIHFUtwzbGYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=THvaf7nkKNs5jwVRSsgjadtwflQxKiCvIkPiPPApeum0jne3H3cWuxL4Q8ZM3tw0qWLNuwMeFbzbtQMWO8ndAofffOJ8kS5MqF2PA+mn3RNGKYWeecAI4PwP73o7eL6XrTwjhFKRq+d4ApfV/8qSq+ioTGX2JY2OQ/Q2mhRAIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RRde32nS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2JiNhx002455;
	Tue, 3 Dec 2024 02:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NIaI2elXEkKBTIlhVG0Yzqw6Bciw63poFYlLyhXrzLk=; b=RRde32nSzcRxMrSK
	3YY48p5GhAm/mS3vg+lg0D3FxoLRUoXHl6L6mFOiaFQ0NUs64z4qP9NXbiSaNwuW
	UPDyDFwFPQRU0EmYGW3R+htK2LnFtwBpcL9NYc0cTlJz6+KZ7RnCcKlcHFXgdSBs
	4hOmhReGBmYd+L5FIw+NNGPXBf4XxY1kh1YFOaRQ5bgqAurrXjKPjHQqP8meWo1S
	FxVJCDc7TPr9tPzg/n2iO1FNFr5TavnqdSHOfxEULmMuF/LuNqWO63aXcR4VMQ/m
	y/SzLtMKr0fs+aWdYnMz7AWmptfUSpVYKhOKRFY2AAOYWY0RgRGpiI0Fn4re0YZO
	4VrQfg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437ufe6ers-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 02:29:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B32TTh9004144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 02:29:29 GMT
Received: from [10.253.34.13] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 2 Dec 2024
 18:29:13 -0800
Message-ID: <e14311a5-6461-4834-9770-e74314d11f44@quicinc.com>
Date: Tue, 3 Dec 2024 10:29:07 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/32] driver core: Constify API device_find_child()
 and adapt for various existing usages
To: Zijun Hu <zijun_hu@icloud.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Jean
 Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Martin Tuma
	<martin.tuma@digiteqautomotive.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael
 Jamet <michael.jamet@intel.com>,
        Mika Westerberg
	<mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean
	<olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Dan Williams
	<dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave
 Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Takashi
 Sakamoto <o-takashi@sakamocchi.jp>,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki
 Krogerus <heikki.krogerus@linux.intel.com>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Lee Duncan <lduncan@suse.com>, Chris Leech
	<cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish
 Rangankar <mrangankar@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron
	<jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Andreas Larsson <andreas@gaisler.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jens Axboe <axboe@kernel.dk>, Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-hwmon@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux1394-devel@lists.sourceforge.net>,
        <linux-serial@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20241203-const_dfc_done-v2-0-7436a98c497f@quicinc.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <20241203-const_dfc_done-v2-0-7436a98c497f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lKi-wmQMsP51n4Wn2N7vwhZDjLiVDpwn
X-Proofpoint-GUID: lKi-wmQMsP51n4Wn2N7vwhZDjLiVDpwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030019

On 12/3/2024 8:33 AM, Zijun Hu wrote:
> This patch series is to constify the following API:
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> To :
> struct device *device_find_child(struct device *dev, const void *data,
> 				 device_match_t match);
> typedef int (*device_match_t)(struct device *dev, const void *data);
> 
> Why to constify the API?
> 
> - Protect caller's match data @*data which is for comparison and lookup
>   and the API does not actually need to modify @*data.
> 
> - Make the API's parameters (@match)() and @data have the same type as
>   all of other device finding APIs (bus|class|driver)_find_device().
> 
> - All kinds of existing device matching functions can be directly taken
>   as the API's argument, they were exported by driver core.
> 
> How to constify the API?
> 
> - Now, no (@match)() argument of the API usages is modifying its match
>   data @*data after previous cleanup, so it is easy and safe to make its
>   parameter @data take const void * as type.
> 
> - Simplify involved codes further if it is possbile with benefits
>   brought by constifying the API.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Series v1 have no code review comments and are posted a long time ago, so may ignore differences.
> - Link to v1: https://lore.kernel.org/r/20240811-const_dfc_done-
> v1-0-9d85e3f943cb@quicinc.com
> - Motivation link: https://lore.kernel.org/lkml/917359cc-a421-41dd-93f4-d28937fe2325@icloud.com
> 
> ---
> Zijun Hu (32):
>       driver core: Constify API device_find_child()
>       driver core: Introduce device_match_type() to match device with a device type
>       drm/mediatek: Adapt for constified device_find_child()
>       hwmon: Adapt for constified device_find_child()
>       media: pci: mgb4: Adapt for constified device_find_child()
>       thunderbolt: Adapt for constified device_find_child()
>       gpio: sim: Remove gpio_sim_dev_match_fwnode()
>       net: dsa: Adapt for constified device_find_child()
>       pwm: Adapt for constified device_find_child()
>       nvdimm: Adapt for constified device_find_child()
>       libnvdimm: Simplify nd_namespace_store() implementation
>       firewire: core: Adapt for constified device_find_child()
>       serial: core: Adapt for constified device_find_child()
>       usb: typec: class: Remove both cable_match() and partner_match()
>       usb: typec: class: Adapt for constified device_find_child()
>       slimbus: core: Simplify of_find_slim_device() implementation
>       slimbus: core: Constify slim_eaddr_equal()
>       slimbus: core: Adapt for constified device_find_child()
>       scsi: iscsi: Constify API iscsi_find_flashnode_sess()
>       scsi: qla4xxx: Adapt for constified iscsi_find_flashnode_sess()
>       scsi: iscsi: Adapt for constified device_find_child()
>       cxl/region: Adapt for constified device_find_child()
>       cxl/pmem: Remove match_nvdimm_bridge()
>       cxl/core/pci: Adapt for constified device_find_child()
>       cxl/test: Adapt for constified device_find_child()
>       sparc: vio: Adapt for constified device_find_child()
>       bus: fsl-mc: Adapt for constified device_find_child()
>       block: sunvdc: Adapt for constified device_find_child()
>       firmware: arm_scmi: Adapt for constified device_find_child()
>       efi: dev-path-parser: Adapt for constified device_find_child()
>       rpmsg: core: Adapt for constified device_find_child()
>       driver core: Simplify API device_find_child_by_name() implementation

sorry for that only part of this series [0/32, 11/32] were sent out due
to mail account capability limitation.

will solve the limitation and send out whole patch series as v3.

thanks (^^)


