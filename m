Return-Path: <linux-efi+bounces-2474-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF639FBE64
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 14:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A762B18898AF
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A41DC99D;
	Tue, 24 Dec 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="M7xRRJ5j"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043381DC19A
	for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2024 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045744; cv=none; b=VAwwXdBJ74N1TiaMXflE+DPPqIt52Qf/MH6BxsSaKDlclL9hr+Tz9/IQqyJTx472uXv6sUApPDcQOOXL6zKwXpclc4PcvynSYf0MhfXYARgf2TKWZs5pyUdc/eNNxJwt4PofRPhuSZisDSvYHjx+iTuCsfhXUiIAj5R0ytAG2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045744; c=relaxed/simple;
	bh=1LBt710KCNnScewYjE0V1oD/vKv6B5UoBNlSTt8XOuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAghzBVZ8r3NVOMOI65nDs6UkaBjPS408iIWmZIzJs+ZHCZlA3S6EoJNXDDFSgxwpiHmOUlnIbx68B8KM3eMbnXVkE8f7f9lt0TjgB2K7sqTowXXOEp13K5STJsQ7UB/IDypJN4MfZNiP+Oo+qu40d2sSaxe0A6E/rFC0uUqEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=M7xRRJ5j; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045740;
	bh=erbjjZhB2douri09I0i2ldgxqWL6bTpOhHwl8mpHl7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=M7xRRJ5jX9vLbEsOitYVmmHTSGUaX+sshkWGFu0txALItrq/wWXH9fqCsppVhxMdg
	 Pkp9RIOf69SF5kC9IcSPP/KwWUueDzIeyG2kCQcS+yN10Fy1XV2/hclV2QlzQ7H5El
	 8pdLKfWTyRAPCCo4+c9JjScC4rsqGM9DzTl3nbS3Hm/f8owWjBOB/A9XnB58XyIPD8
	 M2yPsKSrvLbb974F3Fn+AHl9jFjEDaLn4g9CyjYDyhAHZ+rlRU+FWb2zkJ6DDdDUi/
	 g/Q6BNlsmYOyxb6FUUWaj3/cbETWDNdCSCb6IS03CB3ZUo2UDhbWkGC28JIvaSueeo
	 PYrEBMThNQ9iw==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 350F380004D;
	Tue, 24 Dec 2024 13:08:43 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:05:08 +0800
Subject: [PATCH v5 09/12] driver core: Introduce an device matching API
 device_match_type()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-const_dfc_done-v5-9-6623037414d4@quicinc.com>
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
X-Proofpoint-GUID: DZeI5aU7SNbuR5SofPdSN15JXAFu3F91
X-Proofpoint-ORIG-GUID: DZeI5aU7SNbuR5SofPdSN15JXAFu3F91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Introduce device_match_type() for purposes below:

- Test if a device matches with a specified device type.
- As argument of various device finding APIs to find a device with
  specified type.

device_find_child() will use it to simplify operations later.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c        | 6 ++++++
 include/linux/device/bus.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 289f2dafa8f3831931d0f316d66ee12c2cb8a2e1..8bdbc9e657e832a063542391426f570ccb5c18b9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5228,6 +5228,12 @@ int device_match_name(struct device *dev, const void *name)
 }
 EXPORT_SYMBOL_GPL(device_match_name);
 
+int device_match_type(struct device *dev, const void *type)
+{
+	return dev->type == type;
+}
+EXPORT_SYMBOL_GPL(device_match_type);
+
 int device_match_of_node(struct device *dev, const void *np)
 {
 	return dev->of_node == np;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index cdc4757217f9bb4b36b5c3b8a48bab45737e44c5..bc3fd74bb763e6d2d862859bd2ec3f0d443f2d7a 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -131,6 +131,7 @@ typedef int (*device_match_t)(struct device *dev, const void *data);
 
 /* Generic device matching functions that all busses can use to match with */
 int device_match_name(struct device *dev, const void *name);
+int device_match_type(struct device *dev, const void *type);
 int device_match_of_node(struct device *dev, const void *np);
 int device_match_fwnode(struct device *dev, const void *fwnode);
 int device_match_devt(struct device *dev, const void *pdevt);

-- 
2.34.1


