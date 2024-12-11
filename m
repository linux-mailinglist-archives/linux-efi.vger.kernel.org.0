Return-Path: <linux-efi+bounces-2358-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643159EC042
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 01:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB5E162937
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 00:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005191D86FB;
	Wed, 11 Dec 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vA5p8bYs"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD8374C4
	for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875831; cv=none; b=F4zB0wAsPxPSFr5Ml5M9HhydtYWeMaV0kCXsnT8s5cwOctCGhTPYJi8uxRjlNTJheK6bYwC3mnl0tCdiphyxC/ln8AVTLHoYAKVEBAlj/qx77ckV1BE+peXxiQ9Yltr1QS9h1qYhh7wokJRA3qZzjQTO6KXc4q39mz0ZQIg0xsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875831; c=relaxed/simple;
	bh=hZX6GmgaycLLvSrNAaJQ4LX/N2pXZ4pGuyXJuBX5tvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XC4cA1Q7Ig4ZiixVsa2oH/9ovbq1fLbbbTKdT+kV3/95tRaLfwUjBG/w8yJKtZvlLk4XX6tnOF6RCw7H2dEQFevdoZvCJtC+62S3INpmMAgedKLqOWbCAjR9R+ig5aEJcxgc9ywn0m+6MwKzMzDTEnrn9OwcSdAtshToY1yUaGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vA5p8bYs; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733875829;
	bh=suqKrIM+KUONMBw9F9mPxDsehAtDsQ8e9VrC2YoRZGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=vA5p8bYsK9EjQT/HfykLntIwkcIeL5U5zdJUnweNGrKwMpFAcYtvHrg2LjEWLk7gG
	 maFK6IPEY6J1fs8lZRaW5YM+q1pQYSpRtWDFPvWgDNz0d0/SWYA7+KUUGrx+HPTVWY
	 mbjXGV79kWLK9Z9NCV7hd0YFPLz4mNEIQMjugJblqeJhz/pgxNkvZdzLaJS48oTeBW
	 khdehV9gNRNSa/h+KegNOvq5KeTWpX7yepD1ZZ2Ih23ccsudTavH7hvoCyM85WCLgM
	 DESHfJ+JzzQdN2eBZ+7dQdl3gm6kBw9ouXeBZtLJqpYaR7cQX0vm2j7cOzSoJHbUa1
	 vK/ik5z7jHXSA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 00DE23A02D9;
	Wed, 11 Dec 2024 00:10:18 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 11 Dec 2024 08:08:09 +0800
Subject: [PATCH v4 07/11] slimbus: core: Remove of_slim_match_dev()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-const_dfc_done-v4-7-583cc60329df@quicinc.com>
References: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com>
In-Reply-To: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-sound@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux1394-devel@lists.sourceforge.net, 
 arm-scmi@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-hwmon@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: TTiMaCV2V6KyLhpt6uHzaGd1kkEGqQ7W
X-Proofpoint-GUID: TTiMaCV2V6KyLhpt6uHzaGd1kkEGqQ7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_13,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=861 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100174
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

static of_slim_match_dev() has same function as API device_match_of_node().

Remove the former and use the later instead.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/slimbus/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index ab927fd077cb4fe1e29c004269fe52b2896c302f..005fa2ef100f526df5603d212b6334c06a366c94 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -385,21 +385,13 @@ struct slim_device *slim_get_device(struct slim_controller *ctrl,
 }
 EXPORT_SYMBOL_GPL(slim_get_device);
 
-static int of_slim_match_dev(struct device *dev, const void *data)
-{
-	const struct device_node *np = data;
-	struct slim_device *sbdev = to_slim_device(dev);
-
-	return (sbdev->dev.of_node == np);
-}
-
 static struct slim_device *of_find_slim_device(struct slim_controller *ctrl,
 					       struct device_node *np)
 {
 	struct slim_device *sbdev;
 	struct device *dev;
 
-	dev = device_find_child(ctrl->dev, np, of_slim_match_dev);
+	dev = device_find_child(ctrl->dev, np, device_match_of_node);
 	if (dev) {
 		sbdev = to_slim_device(dev);
 		return sbdev;

-- 
2.34.1


