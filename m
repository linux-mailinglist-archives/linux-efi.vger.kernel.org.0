Return-Path: <linux-efi+bounces-2353-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E439EBFFA
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 01:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F888188A2E7
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 00:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01122EAF7;
	Wed, 11 Dec 2024 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="h5uCX71K"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AD1EEDE
	for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875773; cv=none; b=j+EvIR+bRdzaD547VuNBjCO64F4qfP7LBXFt4f+09AAH/8Ed3qCfe0yDJfDlksN4u3eFeelyZv5tEFymx/qoWiOsTI0P5wfjVGdKzjSRdibRjrX2rMYQTvfFxNXdgZ/TnQ23oO0RjK0n17tmM+ahEchsBvNiMUHC2cOMI1ZGxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875773; c=relaxed/simple;
	bh=REZF6/hkKTlwm2A1iapKIp3QBE0n/m1TORFl69tFs5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BubvsvIe0Pq481JRpFAJ5FnzjC2NAbq+vrtVhHbi+I4w36ZR9CMb2QDEI8vwAEt6VxiEsN9Nt58Rr3UqVeIJJ5KF+DTXWr9zBRoZRG14UgMTgxVYGuvOoborlZaAoDKk7NYqxehODeXMA1N7wN5uC3Cnu0oxyfGBGdy8L6zAd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=h5uCX71K; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733875770;
	bh=J5dZErqHWkqkbiTZ/fetJ0ewz9CCUgVEnKPjhnCoIqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=h5uCX71KaoqjttyxxxBBZkRuCY/xCKlWfvm5VkK7M7tjorjC0Lx5kpTveCDSVGPKF
	 y3uqTwfspdkO8ul25dx8XwmxPgBzh43acNX6T1HkiVY3ic/5i6AFaNrpaQbxwFGmHp
	 xLsXXYU8cXn6yJNWGiIa70bmnDlYeHgp90BkqU8E+vNFPadzAX8W/uHg0QuZQkgDPu
	 bTxnA20WLIJD+t7OF739o4GZcHbI1QD8OKWxZNNlCDf9ZQv1eFx2eLw0PJf1NKkT9g
	 CKt68nFpZDFzvt+6N0yx8hMjxS3NNjyHdpr065FW8pLaCt8UY8nhfTPDFAvj07BIb6
	 TEP/5staPWZYw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 7CF213A0325;
	Wed, 11 Dec 2024 00:09:19 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 11 Dec 2024 08:08:04 +0800
Subject: [PATCH v4 02/11] slimbus: core: Constify slim_eaddr_equal()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-const_dfc_done-v4-2-583cc60329df@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -RBj_0rSQfxVrOHKN2vr1VUQTEeP3WNu
X-Proofpoint-GUID: -RBj_0rSQfxVrOHKN2vr1VUQTEeP3WNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_13,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=801 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100174
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

bool slim_eaddr_equal(struct slim_eaddr *a, struct slim_eaddr *b)
does not modify @*a or @*b.

Constify it by simply changing its parameter type to
'const struct slim_eaddr *'.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/slimbus/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 65e5515f7555e2eb840fedaf2dc4cc5d76dbc089..b5d5bbb9fdb6614ffd578f5754226b50e394f0df 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -328,7 +328,8 @@ void slim_report_absent(struct slim_device *sbdev)
 }
 EXPORT_SYMBOL_GPL(slim_report_absent);
 
-static bool slim_eaddr_equal(struct slim_eaddr *a, struct slim_eaddr *b)
+static bool slim_eaddr_equal(const struct slim_eaddr *a,
+			     const struct slim_eaddr *b)
 {
 	return (a->manf_id == b->manf_id &&
 		a->prod_code == b->prod_code &&

-- 
2.34.1


