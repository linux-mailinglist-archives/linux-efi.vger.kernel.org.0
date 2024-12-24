Return-Path: <linux-efi+bounces-2462-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A33D39FBDA7
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 13:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2DE17A1E2E
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB191D6DDC;
	Tue, 24 Dec 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EG3/2JQq"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB41C07FA
	for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2024 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735044954; cv=none; b=aEVyqJL9erqutaDvk/eUr+fE4nhsl/jfdRiSE0qSxvL8SLRhiQM500tMQqYOw9Rx6HQvrPMCmMnE85YG3H1jvXXoChd9sYK3L/fXpLlWsgRGHJERv4dWehC9tG3kqT1+KaVMI0rbvTfKXry25lq46iAZivQBNKnQ/SM7B0Pe7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735044954; c=relaxed/simple;
	bh=wJNmse+U2BcREgt6jHP5mffCCar/iqKYYB3PO3YxYco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZs+zZgWcYaH48z4jyc8Tq51fvxEOX3P9h3imDk8yHCjtIs/4bazijN3gPVMTsU6+LEUMpYrU/sXvvHw47RGVudN2auHJZw9kZ9lpzphQ3pe/DRSDpLkH9COlF8tY9UjsaTWn7FyHV1lq4GbcJLfMQdU+SXv3N5UkpdD3iK9Wh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EG3/2JQq; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735044950;
	bh=qcfWDpvVWNhEetxodKQbf9RhUrYXCg1pOSV/TOgjh8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=EG3/2JQqEx9JwRea3li9dBqaxu0my5/071veaECaERiiL2HaxnutzGeLfRCkdliQ+
	 l940chB1rDnqfX/zgUAMjMfCU9KCfBl50dd3AYHL+BCjR/LpEszClrwiiaaocUKdO0
	 Dl2mV4JdKdh/0YgEJ9BJeUrYbnqeEK32HyBu1kdqSpd48WyUj+xOOrG2TPE3uWXjqg
	 r0ghBcmj98blLsL7LbynIl9mcuoDXs3AWmbkxfj5bUUIay9lmZdqN/eU6kd0SaVrTM
	 GRnywuJAX30KYKqxhMDjwHXII0rz8Gc6kAVu3/J0Bdy+37cstoObgEcm810pSSyaY/
	 iCj0P90MAhf9w==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 7FC60A027E;
	Tue, 24 Dec 2024 12:55:41 +0000 (UTC)
Message-ID: <16a5d190-29b0-46f5-9845-a1d875211729@icloud.com>
Date: Tue, 24 Dec 2024 20:55:25 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] driver core: Simplify API
 device_find_child_by_name() implementation
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
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
 linux-serial@vger.kernel.org, netdev@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com>
 <20241211-const_dfc_done-v4-5-583cc60329df@quicinc.com>
 <20241223203935.00003de0@huawei.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241223203935.00003de0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TfHq9KcTAjJLJHGN7Cnpr8airBeAqUiz
X-Proofpoint-GUID: TfHq9KcTAjJLJHGN7Cnpr8airBeAqUiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=846 phishscore=0 mlxscore=0 spamscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240112

On 2024/12/24 04:39, Jonathan Cameron wrote:
> There is a subtle difference.  In theory old code could dereference a NULL
> if parent->p == NULL, now it can't.  Sounds at most like a harmless change but
> maybe you should mention it.
> 

i did not correct parameter checking for device_find_child_by_name() in
below commit

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/base/core.c?id=903c44939abc02e2f3d6f2ad65fa090f7e5df5b6

since this commit will come finally, actually, this commit is the
original motivation of this whole patch series.

> Otherwise LGTM
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


