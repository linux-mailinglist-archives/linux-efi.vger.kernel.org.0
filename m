Return-Path: <linux-efi+bounces-2288-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 717E09E4FDB
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 09:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B75D28451B
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D691D416A;
	Thu,  5 Dec 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dK0lvjtG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DACA1CFEDB;
	Thu,  5 Dec 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387873; cv=none; b=YY0MnwC1aUeaQGD88PMHN0tLq81LyITaZiZ6ERmzuJMMvm1ak6uxEz3LMD0RD7DnRgcPl9Vh3Q2WgREp+ZFNQoItaZcSrBq+aEx851r5wGr2P+fWmjxTGwkq1bB1ATL9+Jsn9D2ayTEw2jOy+KJdBAhgFWmOQdz4SuGU76070Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387873; c=relaxed/simple;
	bh=mctLKh1HBPvhJPCxL0haUfZI9CQS/hI5kanVx+wEyjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p5hks9hxJlt7uisceyqa3nYFVtZslAvIyA8CdM4nAwji5VhmEmcoQEYhl6qWjaD5ARJbtPrw1M3h1OeZfyQDNr0rfGAq+PDREJtVFK9V9gEUUQKAe+6/ypBUxde10rSm/sbWnqRIgEk7TLtq/TGrdgsps3qWH2vKD2awvXP929U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dK0lvjtG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4LxkhO025995;
	Thu, 5 Dec 2024 08:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	213mBrUk+y/1ibPAKpU6OsCBJaEAPIxeYJYRsyQLYbY=; b=dK0lvjtG6ep82U6v
	O+DX8WlahlhTpWMVNB2lo+NaMThOr8266xF5D94B18Jjh3fUzFp7FpUnauq1R7qz
	LA2EdZRmGKTNNOjLBeUwG/L4a9Iw2AMF2060yI9R8I0EcrgfMjT5lftee8FnlNfR
	mKJGN13l8WqW83s5jJYKj/976i7VEnMaZiJ40tifxpS329tNJllJU4lrHllbarQZ
	WsLqA0+c8NEJm9HU7WG3rEgmlryRT+/I1N/+5xKTy8CHgdyfdZ2nUDzwKnuaC+rn
	3wdFKra2MGDmGsgg+FEITJ1AmKb9Wg0ZePiYrJxRQiJmtSmiqSLTsvCPYmyKD1UG
	EzXezQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439yr9pbau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 08:37:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B58bGIs027939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 08:37:16 GMT
Received: from [10.253.36.87] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Dec 2024
 00:37:10 -0800
Message-ID: <ac42e652-4128-44ea-976e-5234360d8183@quicinc.com>
Date: Thu, 5 Dec 2024 16:37:08 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] gpio: sim: Remove gpio_sim_dev_match_fwnode()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Zijun Hu
	<zijun_hu@icloud.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Bottomley
	<James.Bottomley@hansenpartnership.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
	<thomas@t-8ch.de>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-sound@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux1394-devel@lists.sourceforge.net>, <arm-scmi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <linux-hwmon@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <open-iscsi@googlegroups.com>, <linux-usb@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-8-1611f1486b5a@quicinc.com>
 <7ugfaj2h3sy77jpaadco5xtjalnten3gmvozowcle3g7zcdqs4@sqf5l47onbsi>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <7ugfaj2h3sy77jpaadco5xtjalnten3gmvozowcle3g7zcdqs4@sqf5l47onbsi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bJlz_v1qF-bCF6eUa5_F4ikzt3TVpUVI
X-Proofpoint-GUID: bJlz_v1qF-bCF6eUa5_F4ikzt3TVpUVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=575 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050062

On 12/5/2024 4:10 PM, Uwe Kleine-König wrote:
> On Thu, Dec 05, 2024 at 08:10:17AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> gpio_sim_dev_match_fwnode() is a simple wrapper of device_match_fwnode()
>> Remvoe the unnecessary wrapper.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/gpio/gpio-sim.c | 7 +------
> 
> I think if you move this patch before patch #4 in your series, you only
> have to touch this file once.

the precondition of this change is patch #4, it will have building error
if moving it before #4.

actually, we can only do simplifications with benefits brought by #4.
> 
> Best regards
> Uwe


