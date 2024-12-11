Return-Path: <linux-efi+bounces-2354-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE989EC004
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 01:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE84280A68
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 00:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49308494;
	Wed, 11 Dec 2024 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jFAPFshP"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4A18C31
	for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2024 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875783; cv=none; b=lWkrFGE/rlSRhD/OVdz/8BYukphILvB2c+uABIl5OMPrXRhggwJf7KSL7C89sHtVYnbgJsWqsKoioBnQ1z0/xsSKDmqCEjjLGi10XYZpjewFLf5PYuoE3cFB5/A2vjTX5sUOfnQGRCESUm0Ru8+nQFRRDRJmyQFNfrp4BR4p+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875783; c=relaxed/simple;
	bh=Txz+DMIu0HjYpVAknikfDcPuYhSiW9S4S4zdgwMhpwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTwuENqRH4ORSnC0SwG6poi6UA3jyDhOH4u2xbhAujzqTbuk28Bkz66+JPV+2TCwV/QIkz5oo7vvPSaZdQ5RC5h+GQF0z36pSzic7q+jXOYvAO5vfktkYqh58HRHcnrVLQCv++QtBSVRpGGy2fSu3ogO6tGAz88m7+yJ7Lc/Cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jFAPFshP; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733875781;
	bh=s27I9OiFEC5wqMAA52fLVTkJnWq/1PJykguAupy9zqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=jFAPFshP9LdNUWn5AP28+7Q3wU4AIC01ITEIbZjLVe+90JZnAY71+DnWBuenkUePN
	 +uqAYymNhgA3xmuwaf7wvfMbX0d1Igr2DbeADqoI+E4cTDpiHHoSP1V46Maj4FUuF3
	 D4wTFC58ndB9QvhZO2Xr1axOXJFMAz3lo+IkjCRWk4WmYfqCt83p+RK7JmTnFW8O7x
	 Lq3GRh8OQ85KY1t6JlkgbPXP644wtZP3Tcb2S5OA2TCvG7sKsG8vrbqlV00Sag38oG
	 QvJDEp2wJLpQMBzly+AzEqMpOJLRUX5BEUy6z6cBgINSzHi/jJMNPxNJEikHxFY3u5
	 UGT46/D53aZtw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 0E1DF3A02D6;
	Wed, 11 Dec 2024 00:09:30 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 11 Dec 2024 08:08:05 +0800
Subject: [PATCH v4 03/11] bus: fsl-mc: Constify fsl_mc_device_match()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-const_dfc_done-v4-3-583cc60329df@quicinc.com>
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
X-Proofpoint-ORIG-GUID: b2_KzaPQwtCWuWd8vqvGNLcCjrmN2v0u
X-Proofpoint-GUID: b2_KzaPQwtCWuWd8vqvGNLcCjrmN2v0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_13,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=882 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100174
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

fsl_mc_device_match() does not modify caller's inputs.

Constify it by simply changing its parameter types to const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 4b68c84ef485055c9b300b4f7912a20f959b8ac1..11c8fadcf85148b4e4ea6b97b7efb6d4ddf22d3c 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -22,8 +22,8 @@ struct fsl_mc_child_objs {
 	struct fsl_mc_obj_desc *child_array;
 };
 
-static bool fsl_mc_device_match(struct fsl_mc_device *mc_dev,
-				struct fsl_mc_obj_desc *obj_desc)
+static bool fsl_mc_device_match(const struct fsl_mc_device *mc_dev,
+				const struct fsl_mc_obj_desc *obj_desc)
 {
 	return mc_dev->obj_desc.id == obj_desc->id &&
 	       strcmp(mc_dev->obj_desc.type, obj_desc->type) == 0;

-- 
2.34.1


