Return-Path: <linux-efi+bounces-2476-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4B9FBE85
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 14:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C4F188ABB7
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A51DDA2D;
	Tue, 24 Dec 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="D42QO5Jp"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F61BFE06
	for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045776; cv=none; b=dZ28dTsK/rkVwqTrrFGPS3sweQ5IA3Z7rs7S16DVj7d63tHzkiXlkImYNp+mAh7n/HjorbdIuLvapIfM3R+AQNDlEtbcCI2hGwtvz78UhanIAdFG5iksWinD8x1kmk6MYPx18SjQ1F/LOGHfUrLWJVsymyWwujiHIwSodMzWVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045776; c=relaxed/simple;
	bh=r5C++9CNyo69cdbD06S21pQt5g6QPNol1rawfF/2fro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKf2oblvRevmBHGHkVbAM+kY8YQvt6aorEpJI9Gb7UmHzsUlci1Mw8vW3zx9SQ6hFyQrPldZmLOdQLoH/AyqwGPsMoDjCCp9PXSAh5B2BBN5JE2p8V05zjiECBY0t8/Zr+n0qWXqbPjRz0B7lk8+Ib24/sZwWPh5PH7AeeY4+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=D42QO5Jp; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045773;
	bh=W6hKFz3jI/fKIGjdW+aEgqinuBcUdnSmulnNtvSMSNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=D42QO5JpRgId3k2OgSjgsoUEPLuQW5L7BJi3jf5ALKfW43PZdub91g1FieMZ5JEkn
	 tuJmy3JWIGP3G2g1GKlU740j2HM0JrGEeZ4bkv7vQXT/tKpPAZzaVoXiV6Wj0L68mV
	 28/36LBfPOPezhw4wF97AzW/ZepVC9frjSbKf+7InVtBmR2M+ybe4GIBTHqq3Vl0Sh
	 WKdIfYt1VVy6eIjlpJvjEhLRkwJYonZpolco1tbmcKdKTnShjvMuavKB9xg3zGmGKa
	 SZq1Khd1FKJj5yt+Nuebau9Ph6IIqNyrQYDoN4xTt30kHR/5bmI3GjM1r8EKZksXyG
	 sWsrVpNuxVVJg==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 2E299800265;
	Tue, 24 Dec 2024 13:09:17 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:05:10 +0800
Subject: [PATCH v5 11/12] cxl/pmem: Remove is_cxl_nvdimm_bridge()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-const_dfc_done-v5-11-6623037414d4@quicinc.com>
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
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: -L6nySq_kXObOyTkXfn6veJLGJ_xFgS3
X-Proofpoint-ORIG-GUID: -L6nySq_kXObOyTkXfn6veJLGJ_xFgS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=779 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Remove is_cxl_nvdimm_bridge() which has no caller now.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/cxl/core/pmem.c | 6 ------
 drivers/cxl/cxl.h       | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 0f8166e793e14fc0b1c04ffda79e756a743d9e6b..8853415c106a98d0822f0a9f6d313937e8fe3614 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -51,12 +51,6 @@ struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_nvdimm_bridge, "CXL");
 
-bool is_cxl_nvdimm_bridge(struct device *dev)
-{
-	return dev->type == &cxl_nvdimm_bridge_type;
-}
-EXPORT_SYMBOL_NS_GPL(is_cxl_nvdimm_bridge, "CXL");
-
 /**
  * cxl_find_nvdimm_bridge() - find a bridge device relative to a port
  * @port: any descendant port of an nvdimm-bridge associated
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6015f24ad3818966571e0aaea2b974f09af5f7c..064a15cf559f284f380b04011131c99a8f538cab 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -864,7 +864,6 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 						     struct cxl_port *port);
 struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm(struct device *dev);
-bool is_cxl_nvdimm_bridge(struct device *dev);
 int devm_cxl_add_nvdimm(struct cxl_port *parent_port, struct cxl_memdev *cxlmd);
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
 

-- 
2.34.1


