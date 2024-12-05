Return-Path: <linux-efi+bounces-2277-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9E9E4B10
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 01:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEB918811E7
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 00:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA37E0FF;
	Thu,  5 Dec 2024 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="AaMBReMo"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B9D531
	for <linux-efi@vger.kernel.org>; Thu,  5 Dec 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357503; cv=none; b=UxQ4oFNfuodhfy6glx8EMwr1mIx3KbMq8ojCojJ4uVxjDsthkUips64ouFiQ+253EvLlrc0Rop3kb6enwjORzqe1g6vqPOvScm4QRr1TuikEVT+fUH4aqP0sM6Q+qqBwJoGbfjurLnz6yYuol9gvfVuDGLmpgCOs5IDdQs4LYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357503; c=relaxed/simple;
	bh=Txz+DMIu0HjYpVAknikfDcPuYhSiW9S4S4zdgwMhpwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yfv3UXbhSe8iVkn3nwamE3FWjMXIX9UgT+HwXWrVZa/lO/ZICACfn/tSIqDw6TUwxqF3hlcJ/qa7OyG4M2/dIJ3ER32o5ptL4FbhF8TaUn3JOeDGs31YgPA4WwSOhoV8OeApm3c40GvVBIgrZ60Ke02tcTgra2TiuNWQtIXAbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=AaMBReMo; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733357498;
	bh=s27I9OiFEC5wqMAA52fLVTkJnWq/1PJykguAupy9zqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=AaMBReMoVb0lSqAfWtIUZpyS48WBzfGTBOJ4idA3UTiHPD2VtroZkQ2LBN26ektJg
	 fWn3prREbzLFl1KoR6iEfktUfII9bNpwImON/ESQxnnCGdIvgrdRLSaWxJFHci1T3+
	 7NybdpqcQ0yv26rJDrTmYi/hddtW8/+6dXAto5WBo0rAWD88KO7IIA5ZvyFOLXoS3q
	 ehVekwdLcpYLutCiajjJFG3pTCbtr0jk8alc/U2FFnmyq/Bb6zygfMsypJ4uBM5ZI9
	 tbuNaRvpVXLTsvhH4fEp6taGKZ0GU8hvEvaOfF2yRIJtK2DzKbEZ48vUsP4jrfOc3O
	 hELDsSGo1WePQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id C8B2580027B;
	Thu,  5 Dec 2024 00:11:27 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 05 Dec 2024 08:10:12 +0800
Subject: [PATCH v3 03/11] bus: fsl-mc: Constify fsl_mc_device_match()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-const_dfc_done-v3-3-1611f1486b5a@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 7Q8uF-g7w7uKUYtHNcd92_FB_Q-fmK-F
X-Proofpoint-GUID: 7Q8uF-g7w7uKUYtHNcd92_FB_Q-fmK-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_19,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 mlxlogscore=820 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2412040186
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


