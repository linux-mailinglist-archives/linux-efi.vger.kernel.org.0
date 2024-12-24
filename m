Return-Path: <linux-efi+bounces-2473-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483A99FBE43
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 14:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576B91688A3
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9991DF75E;
	Tue, 24 Dec 2024 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EPgetQRh"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946781DBB0C
	for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2024 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045727; cv=none; b=mkWhLJARXFOqk+K7Wq2j5ztt2VOEx0hFSV0LcYYzqlPhMy5weNSmZHAgJio3SbEOreftbDk4dtnpwWf1h3Hhd3YzDXm+T/K2p/MnLzGV+7wx2fdah1E5umo3uNvrRJpLgrkW96Xsi0gcqAyE0uhKlvmWMJ7zBhbbowWuKKe4Ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045727; c=relaxed/simple;
	bh=O7t8wi1l6Ln6enlz1pSbdWfQNl2vSCBHt/xTDG7ftYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPwWoU3o3CEB2btzJXsjfiGo/N1lmpOzXmYgDotKsrKnE8S8+maxIjJdJDT5XKdOcaODhD79Yh68yfnRReO7yJ3b2k66r0J70fqFreOnJjJ3s9lv/buh4EmVIB53sqgB8O1Vbnj0WlcFTifPQ5VGSrkQDVuBwttvhMcxUjHkaCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EPgetQRh; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045723;
	bh=3cbbZRnsll3/xttXOfidW+WDEwQRRi+umnVXq/gwK74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=EPgetQRhE/W+/+t4rmY8JXnUbsESd7021pRoWHVIogw+YYJM7/pawE0imq+amsHax
	 RrBseVbMVFDUYWot2GB/0Vnmwn471VQrA6uUUXssb9vNkP0jyUxrDBjRUmP/uScVdI
	 yiu4AArKWDxX65tcnVR6TGmv0XPIU3m+6SI5zXtBvTGsRElZB7KfiqWCnohtO5Ri7m
	 AM5OX9IP1P86vjNpoxlizuVdoc9QvsbIPXp1GSWcD0j65iVKAydPWYvjkHc4vYbczH
	 GT6MILe6c2DeZr8cKkR5u8fFB2vQOwqNMEu7GvwKgvv1M6T6kJU/7K381ZO0HcKKzj
	 gFNoWZBxmHMvA==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 0F26F80021A;
	Tue, 24 Dec 2024 13:08:28 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:05:07 +0800
Subject: [PATCH v5 08/12] gpio: sim: Remove gpio_sim_dev_match_fwnode()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-const_dfc_done-v5-8-6623037414d4@quicinc.com>
References: <20241224-const_dfc_done-v5-0-6623037414d4@quicinc.com>
In-Reply-To: <20241224-const_dfc_done-v5-0-6623037414d4@quicinc.com>
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
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: sMaBfSD65NOr2696SHOaybmZpcJHhE1B
X-Proofpoint-ORIG-GUID: sMaBfSD65NOr2696SHOaybmZpcJHhE1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=814 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

gpio_sim_dev_match_fwnode() is a simple wrapper of API
device_match_fwnode().

Remove the needless wrapper and use the API instead.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


