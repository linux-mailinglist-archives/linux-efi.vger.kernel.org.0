Return-Path: <linux-efi+bounces-2284-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00D19E4AE5
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 01:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D7C284C63
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 00:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDCB1B87FF;
	Thu,  5 Dec 2024 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pdelZSHC"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901105FEE4
	for <linux-efi@vger.kernel.org>; Thu,  5 Dec 2024 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357580; cv=none; b=OnZFpVGZEWaE3H37/v4TYtQEt6m/ZjSQxxbd2TXKrslO2t65yg2555jqxKkS3UjL53P8XEDB/jDQr0JMxGPC1UZLBx5b8Auxuy8vlIvyRAiWMQPzzLwRpuzd87IbbkkF5ZIlcsDzwry4a7JruEJwmCIYKMor1HzaXht9pM5hd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357580; c=relaxed/simple;
	bh=2r8lfeJwBDJqYRCjeXZHsKNk6dNl7QW78eZi+XRRuiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bD64mWO2dewm1H+b+xfh9H/H7p68raDLKmBPjp12N9tN9QqZnlCsMdWcS/sgYsjlHy4fYKpd+54epRj5sF9hv0FJ1mWOMqngZf0ygddkig9Zu1JFL2D6/gwyXTCy67ONei/tckteHi4ea/gNOGCl+ZXqMEoyh7Xx3PHazh+f+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pdelZSHC; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733357578;
	bh=Zd4Z+LUSUmVX1tZxUu8GLb6CT3mj3LxDJVxQvX7Zpgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=pdelZSHCkQy9UkIa1tDGGVvjGOFtlRum9Qu0R9rrxX3gWsob9LEBbiMHdG6dJDHLw
	 znd4Tq7WXvNEmOvQ/7xyOSXBUCccIN0ruruz1rM07YdKirdc0Wz19qLPWYVyWDgKST
	 B5LhiGOiNZ9090RtiqOqqg6J6Y+/2mvKI710y4W/864dJrsRLcrRvGclfHUv17932d
	 JxGzYbj5npctkp3IjuRsw+xXtPtaQoyMWAeWNV5TzSRkTuU5u8mcFXu9TAAUtoLWey
	 SVCL+7LsD/sLX7d1AqQCQ9rjdCHqaRS7Bu4mS9PyAWcjHSbX/Cxm9TMDblZj8df0oG
	 mHev6O2EcHEYg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id B81CB800361;
	Thu,  5 Dec 2024 00:12:47 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 05 Dec 2024 08:10:19 +0800
Subject: [PATCH v3 10/11] cxl/pmem: Remove match_nvdimm_bridge()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-const_dfc_done-v3-10-1611f1486b5a@quicinc.com>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
In-Reply-To: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
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
 open-iscsi@googlegroups.com, linux-usb@vger.kernel.org, 
 linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: uSJRpr-uPiu2tTL8fSLiPLdSXYn6pdm7
X-Proofpoint-GUID: uSJRpr-uPiu2tTL8fSLiPLdSXYn6pdm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_19,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 mlxlogscore=952 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2412040186
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

match_nvdimm_bridge(), as matching function of device_find_child(), is to
match a device with device type @cxl_nvdimm_bridge_type, and is unnecessary

Remove it and use API device_match_type() plus the device type instead.

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


