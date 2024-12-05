Return-Path: <linux-efi+bounces-2281-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B8C9E4AC1
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 01:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F0818802D8
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 00:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C9219342D;
	Thu,  5 Dec 2024 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eeZ2XF97"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1A282F4
	for <linux-efi@vger.kernel.org>; Thu,  5 Dec 2024 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357547; cv=none; b=dVTXW3AK4w9IS3d+ukeFGfp+4IgNEjxTf5D632g0FEX9sFw/zEuyxRoaj34+tbarOferkMmUbKHO7totaFY0/2V6HykbC15jmiQlzN6Bxv5wn+rbpCZf/D9GRkp/DLnqME2++yB7axHLzovJytWSw+6cG+x57G5txZybin52uyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357547; c=relaxed/simple;
	bh=aqJ9eoPPa8OOOh32wZYRxgdRy4YcjZ2E5IS28yYIKYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JuQm2D1SpEUfAk8EXQsiJ4818qox9y+jq5esBTfB/R3RlkHoyr9Ab28UYtvkT8GDlXFZVZDnHYIiQXHaBWeKfc0OaBtWqTi0+5WI8pvCDQyIUunWdPJ1C7npOcS/yO9R/EMCvUZd/nyi7oNuZdNtKXtZKHfhpezADbq9oUkuorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eeZ2XF97; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733357544;
	bh=+hQoPBEqfvYVUdmuiivYhmF78DtBLM3+FjVAAqudA1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=eeZ2XF978TocDnLvYVePUFkZh400KiGF0uy1CI+80u4NNivmK/1ZTsD8aGdY77B/b
	 4FlfVQiXwC60tsrx3iXfdwbp0KhzUzlGCCR92PtiOWRCcWFaz6+YilRtkBFlYJqA6e
	 zmiY1FvVhTn0dlwU4khUfTWuaeP9T9diJDemzvvRqbTFFElUwHmA7rsx+IKG54DI/z
	 Anactc5LZXbj61yO/T+AXdgQqGsclQ7iJDDWJjjhdhjwEdVZFzXklUupbArmw+1B8e
	 h4y3bJ9nEsptyHupvpMGlws6B89RuMVTtxtb3BH269bHuASstz4w4KTCloKnV9dz96
	 1Cp7aXEEAq9pg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 0532C800244;
	Thu,  5 Dec 2024 00:12:13 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 05 Dec 2024 08:10:16 +0800
Subject: [PATCH v3 07/11] slimbus: core: Simplify of_find_slim_device()
 implementation
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-const_dfc_done-v3-7-1611f1486b5a@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dJJDXavx1M32TEUDR81XI7OMWXU6vXXl
X-Proofpoint-GUID: dJJDXavx1M32TEUDR81XI7OMWXU6vXXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_19,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 mlxlogscore=948 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2412040186
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify of_find_slim_device() implementation by device_match_of_node().

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


