Return-Path: <linux-efi+bounces-2361-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB8B9EC06B
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 01:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1C928582C
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 00:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281AC1DE4E7;
	Wed, 11 Dec 2024 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vy6Q87Zj"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735251DE3B5
	for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875866; cv=none; b=kcP7+5geB3NrwYwbxYPFG7uLPm6PKB8o91HoRgQJNBJtjKNm2W0lAW6l8NTVdY8xmdMFHCpX8iuv2KLQ+l+US2spwmE/vI/6BRvbJ0+Jzl7LB7mtReQcZPri5HiISWLeq0JIrZW+0yjUFZlFZkatbXS90AB2Jc+KENchbgiODX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875866; c=relaxed/simple;
	bh=IJANnshHGNRPjHK/ZL6NeKM3LmwYvWgvDO5OVdujO8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGkM2KU4FCE+0c1FKovUm8knh0ZZzjHqASSjsQEfUKrpf1a4B626zueNASGV8EBWUQnsfjAMF5QSZzUxporHjD4/slZI6trqM+KqxGX7k9JmBkFteQXgVwMfnNPa23JJ0kHktTHmcKoq/6SBzsgv7Kyi10nOivEvBxgORCSo1io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vy6Q87Zj; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733875863;
	bh=9MSW9rqSXzJ69ClHo2IWjPKz+ccuE6aWbD2rifbGZik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=vy6Q87ZjuTB9GdC440VwNzZOk/cxyDsOGEylrGXtaSUeqQHEj7iwsz9uAE5ILf/LG
	 WMC3epi2u0YhDblPJeuAZu3JCwZaPKFOCF0eXKBx2q05qAHATmhQLNGGgzRQJ+AULY
	 DksxKrVGNS2WXDh0r4mEBoYrd42SPWeh7QpEHKcYBnRTg7lXYT2i1a4zAKh3XetdFZ
	 JHNP4fTWLILYu5WhQS5ZOraTxTdEsjYNanjLkDhUablu7zwFkBDIM6uz8L7UmFQFOu
	 a6TMlHphCTFFQ1JCFOE8/cxgdGbmvdjNyfladDH73TFbf8GKUnEfPJTLeiqJ/90Kkt
	 GnlN7rFfSAdjg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 8BA1A3A03C7;
	Wed, 11 Dec 2024 00:10:52 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 11 Dec 2024 08:08:12 +0800
Subject: [PATCH v4 10/11] cxl/pmem: Replace match_nvdimm_bridge() with API
 device_match_type()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-const_dfc_done-v4-10-583cc60329df@quicinc.com>
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
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Alison Schofield <alison.schofield@intel.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: coH_R6R_LJ2sjDuwK8Bv3wz0TtGmmAM-
X-Proofpoint-GUID: coH_R6R_LJ2sjDuwK8Bv3wz0TtGmmAM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_13,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100174
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Static match_nvdimm_bridge(), as matching function of device_find_child()
matches a device with device type @cxl_nvdimm_bridge_type, and its task
can be simplified by the recently introduced API device_match_type().

Replace match_nvdimm_bridge() usage with device_match_type().

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/cxl/core/pmem.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index a8473de24ebfd92f12f47e0556e28b81a29cff7c..0f8166e793e14fc0b1c04ffda79e756a743d9e6b 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -57,11 +57,6 @@ bool is_cxl_nvdimm_bridge(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_nvdimm_bridge, "CXL");
 
-static int match_nvdimm_bridge(struct device *dev, const void *data)
-{
-	return is_cxl_nvdimm_bridge(dev);
-}
-
 /**
  * cxl_find_nvdimm_bridge() - find a bridge device relative to a port
  * @port: any descendant port of an nvdimm-bridge associated
@@ -75,7 +70,9 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port)
 	if (!cxl_root)
 		return NULL;
 
-	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
+	dev = device_find_child(&cxl_root->port.dev,
+				&cxl_nvdimm_bridge_type,
+				device_match_type);
 
 	if (!dev)
 		return NULL;

-- 
2.34.1


