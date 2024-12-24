Return-Path: <linux-efi+bounces-2465-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EE29FBDDE
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 14:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C431F1884860
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 13:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5651CDA09;
	Tue, 24 Dec 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QLhZUYFX"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E51C3BFD
	for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2024 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045620; cv=none; b=kt5rk+Bxb38NpnKrAjZ/kEIIe4tv5wOc+0FJf0XC2pAOr8/biPL2PM8DgHd28cjn62Z1++srZdLzy9/zL7Nhhcv5XKIfcl5Q84hwxZd99iNFVxHdxnbEWVs8n/CankVweEIA3/DVpBbsNTUUvqH13xKEpy9Mk5D3ApyWvac6IpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045620; c=relaxed/simple;
	bh=al04ahiJTfh/2gEXIsUvt3M4vWHBbMjofb89SPV1SLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IO7fc/z8Unn+Jgo2W6V9bASdhoemFKceMKmRPeIyRveBpHIIJwv/+wlMxpQEmRfvqyFJn4NCEut/SsupMdSVhaToJQObOC3PKiQyyf809gTocRMK5XUREdrbIGaNHOaEuRRc4BZMt5W2h4UR8RzFxcCszuQKdo7NYdJJ81LxhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QLhZUYFX; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045616;
	bh=Kt1uL1UKbjC507UMOf2V20V219iWVgBlVUBdSvdl19I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=QLhZUYFXHbpd6tKuebtKULRkFmIgUFXXvP13QypdTlZPcU1/5d6Rs613zeKtH+rfC
	 xca1owuccXp7xZQ5smYSNRoi0D/vQ2JuJdjXWXR4XoDwbSvSQGBCz+ShaF3x+nsxSJ
	 gP3p0r23a6R8S4DggwIKoRze9ZSgbiuB11azjwX+JbBPX3x8n6/UBJBSO16z1HIQu9
	 VM35LQ+/q3nmE7kXKA3uWzXtP4GS26Wa9reGmXNHQOTKDZqjiex/+8xJOhhy7iJyD6
	 Um00rXQ18GvuWvCHK0KpCvVu7td6E0YwaqQu6q3MBTBMplS6pJLTrf42DZzALSa25d
	 FSAxdp4I1HslA==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 76DA28001EA;
	Tue, 24 Dec 2024 13:06:40 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:05:00 +0800
Subject: [PATCH v5 01/12] libnvdimm: Replace namespace_match() with
 device_find_child_by_name()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-const_dfc_done-v5-1-6623037414d4@quicinc.com>
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
 Alison Schofield <alison.schofield@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: GCpl7ZpNu93FzAbAdUOcITSwTywob7fR
X-Proofpoint-ORIG-GUID: GCpl7ZpNu93FzAbAdUOcITSwTywob7fR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=893 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify nd_namespace_store() implementation by
using device_find_child_by_name().

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/nvdimm/claim.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 030dbde6b0882050c90fb8db106ec15b1baef7ca..9e84ab411564f9d5e7ceb687c6491562564552e3 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -67,13 +67,6 @@ bool nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
 	return claimed;
 }
 
-static int namespace_match(struct device *dev, void *data)
-{
-	char *name = data;
-
-	return strcmp(name, dev_name(dev)) == 0;
-}
-
 static bool is_idle(struct device *dev, struct nd_namespace_common *ndns)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
@@ -168,7 +161,7 @@ ssize_t nd_namespace_store(struct device *dev,
 		goto out;
 	}
 
-	found = device_find_child(dev->parent, name, namespace_match);
+	found = device_find_child_by_name(dev->parent, name);
 	if (!found) {
 		dev_dbg(dev, "'%s' not found under %s\n", name,
 				dev_name(dev->parent));

-- 
2.34.1


