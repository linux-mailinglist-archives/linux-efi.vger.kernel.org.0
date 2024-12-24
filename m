Return-Path: <linux-efi+bounces-2470-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2CF9FBE15
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 14:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F288516508D
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 13:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9C1DDC11;
	Tue, 24 Dec 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="02HJWJQW"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD64C1C3BFD
	for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045681; cv=none; b=pkLNLF6AN7+InoCq4aWdRVNXZXKff0R/5NeUVRGEsFqa9Vd3Qocizov9KTjFSH/uu80OjUDsrBZ3U6y+QOoVoaujHvrZbM85OUeMKlx3OxtyTDPc7nQKYxtKDrbo1Fo2IV6UBju7RlFSrhfJyBcJhQL9BYBLCsOIIOMBRiOeuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045681; c=relaxed/simple;
	bh=DYeVw/hwvCUJayebntCAsHcBgKf0+XhIP/c9hEfatOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QfC2khPPpUtEuSXCQSDvcwQeAQEMjZEacs+O4qv6P7lC25y4ybExquEgUnJAhGv++pbReji+91/4xZDIfBATKSH3LKQ+A2ldFdbYAANcu6KmmnuU5AU7NxMYN+zmjBBj4kMTIQBxLVS35emt4ysSIhT3Yt9G5NnAAMcyTJfbMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=02HJWJQW; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045678;
	bh=Xdmd4GC6rhW/Uh7S3n+f8KzvWTUMO/RUgVVrfahbelc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=02HJWJQW/isBieKHc4lHuOWm0sE6RVt3AnvajvFm1yFol+F4wqT/akMphrNu6cO3O
	 tRStEjxXnbWSoE4MlKkFF7vYy3xf35+66BCGJyh2Du1ZUMNZ2EacwYkZJ4u5ypP965
	 v/AH2LZy1yRwa6xJOA1V1Bv+jP1ShdU0I6IHd2xxKji7Wu2pUn7pj2WnGI8dygTnL9
	 2QBDyVZyjAndJfmvYtBeu2fpOfpZbM1DThemmGYeK+N4Bu588vmwl+0aPMmrAHUPUZ
	 RvxYwutbA+1plmvUG7dL5X+KLXh13AO6kFEqayP+A4O1R/VsH1T5Cm5RYkg+Av6Nna
	 gt+0DUgzWfvLQ==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id EFF298002E7;
	Tue, 24 Dec 2024 13:07:43 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:05:04 +0800
Subject: [PATCH v5 05/12] driver core: Simplify API
 device_find_child_by_name() implementation
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-const_dfc_done-v5-5-6623037414d4@quicinc.com>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: P4Ll-ia_XA5Ds8VjlM-P50WHH2PaNMoE
X-Proofpoint-ORIG-GUID: P4Ll-ia_XA5Ds8VjlM-P50WHH2PaNMoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=866 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify device_find_child_by_name() implementation by both existing
API device_find_child() and device_match_name().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bc3b523a4a6366080c3c9fd190e54c7fd13c8ded..8116bc8dd6e9eba0653ca686a90c7008de9e2840 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4110,18 +4110,7 @@ EXPORT_SYMBOL_GPL(device_find_child);
 struct device *device_find_child_by_name(struct device *parent,
 					 const char *name)
 {
-	struct klist_iter i;
-	struct device *child;
-
-	if (!parent)
-		return NULL;
-
-	klist_iter_init(&parent->p->klist_children, &i);
-	while ((child = next_device(&i)))
-		if (sysfs_streq(dev_name(child), name) && get_device(child))
-			break;
-	klist_iter_exit(&i);
-	return child;
+	return device_find_child(parent, name, device_match_name);
 }
 EXPORT_SYMBOL_GPL(device_find_child_by_name);
 

-- 
2.34.1


