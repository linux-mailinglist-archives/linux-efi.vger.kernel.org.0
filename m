Return-Path: <linux-efi+bounces-2359-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1F59EC051
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 01:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618EE285C09
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABCC1DC070;
	Wed, 11 Dec 2024 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bMOeH5p2"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA21DA633
	for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2024 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875844; cv=none; b=sXqvedjG+KayvfBkAbyt5lJAOWLRGy0OEo+IGUH3OegzvkdUbjvB5JOCsnH3C3RFqwgJkeWL9hS7pAP8Pi0xXQZr0S5Fs46xGlcrBfjHKV/sXQN/IhIG3yO/0crTMT2FYpfzS26eBt1YU2T2X4kG6WXjV18kesoKmTVyyIvAzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875844; c=relaxed/simple;
	bh=x1HfqnyP7HK+0qCWOd6bhcqvBCdq/ycHO7JT28/G4do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWPbTROoV+Y+s+FwP3CpSxbhZh+PkqE2xIXp4h6g7Q1V4e1dHJqR3w+w8Hvzg/8pAYLiVUVHeiGXWlb/YGF7XMv0lc+z+uCaA41tj6PbHJ/sa/Sxzoc4rU4JpW1xF0p8LHw15Kbms1Guo6O26RprUMsywbZEQXDFAsTwxObttF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bMOeH5p2; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733875840;
	bh=1rI1a5AIH1uXMzCw2VfoUY7iAdmXRhOEeW1I5hOno1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=bMOeH5p23YhW74AKFEpoLDsJW67U4HGkbBi3eM1Z+R2b0zLxCLhaKJtMeY58vnx4X
	 C6FxX6vhvMHi/ilwUgSScekcEdsyKxsqPwbTUU9CWZQlhd8+K8F6WAzUUJakJQ0kHv
	 hJMT67g2in+durnKqH9ESbnwtRE0r/S49L6o5t/MyFumoqc3U79NgbIylbXyLOOlez
	 2gHwBIERmEoQCgNIfsJHgqX65R/D69nZUTcwiW83rC+NSpH2iswHOKAecnWTLhdT8l
	 mk11aR6ZpZnd1L2SK5Ew+xwDMt/JKOYCNIyiZUR2lz8aT4UywmywB4OlyEVAvfaQgC
	 Ap1bw3HGMP3Rw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 11FED3A00AE;
	Wed, 11 Dec 2024 00:10:29 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 11 Dec 2024 08:08:10 +0800
Subject: [PATCH v4 08/11] gpio: sim: Remove gpio_sim_dev_match_fwnode()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-const_dfc_done-v4-8-583cc60329df@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qSPdOT9A5yTFi6DFCTYC3Xh7nIeW0dH9
X-Proofpoint-GUID: qSPdOT9A5yTFi6DFCTYC3Xh7nIeW0dH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_13,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=816 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100174
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

gpio_sim_dev_match_fwnode() is a simple wrapper of API
device_match_fwnode().

Remove the needless wrapper and use the API instead.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/gpio/gpio-sim.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 370b71513bdb529112e157fa22a5451e02502a17..b1f33cbaaaa78aca324f99c45a868e7e79a9d672 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -413,11 +413,6 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
 	return devm_add_action_or_reset(dev, gpio_sim_sysfs_remove, chip);
 }
 
-static int gpio_sim_dev_match_fwnode(struct device *dev, const void *data)
-{
-	return device_match_fwnode(dev, data);
-}
-
 static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 {
 	struct gpio_sim_chip *chip;
@@ -503,7 +498,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (ret)
 		return ret;
 
-	chip->dev = device_find_child(dev, swnode, gpio_sim_dev_match_fwnode);
+	chip->dev = device_find_child(dev, swnode, device_match_fwnode);
 	if (!chip->dev)
 		return -ENODEV;
 

-- 
2.34.1


