Return-Path: <linux-efi+bounces-2466-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2CE9FBDEF
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 14:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AB81884A90
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF41D79A0;
	Tue, 24 Dec 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eChWTMMI"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C01D7982
	for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045636; cv=none; b=BOi63abqPbCw+L5bDhE5kr8ISehS9eLS4htLAu4nE7G8SGI/hs5lWq/+fDyxO+/Ed/lU5+vePjRhpINIBox4JIU8RUDCEQXvP6wRPQhH8CR3qWqBAXqz7oEtAKLyQZx8pn11/objmG+VvzE6lvXNCYNHRT7Vq7PfGI8Wk37f7d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045636; c=relaxed/simple;
	bh=7MlXlbcmdN4nKZjmgJkJT0vfEGj3WrtEBJrSXE0LyRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIGeUyTKmJaQlTm11/wcpng4dfUmj3icZMqrrZwl2mdj7rsR9j2sIXVJrGBrO/Fp8/eHxFFlhUcgsTzfzRV9EBDvWH+hnx3lDlFkA0x8rfGZJ03YS41Lkfgb5uVzvb+09PXy39R30EDW1qnmIMHYy7OjUwu+ysua4pcvY26ToxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eChWTMMI; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045632;
	bh=Tt4InU9ECWo1vlqo+tRwvq1PmN9OePPjJcsttDYPSbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=eChWTMMIwxl32U1bXSofUk38xYqsUV4ca41i2WqCMpz8c3Z58pohxE72WqJBL02oo
	 115U9ARXbhViFjcsmpq3tBtB0hM7blF2m0zDbnVLy6h155iFbTcLP4Sur6PkdbRq1D
	 xw+/xM2HKq9vfiVFqsEwU5fG09XzrHYwOWU1sWZbEGjftOLg4xe4FVvPmt7GYQ7B7B
	 LlBY2uJ1b69DrxQF4g3HkktilO3RD06ARW6PWuEiyQy0HyFXIUOo7wG8e5MyIV1d7A
	 QYsjUcdteODQt9P+E9fQ/cej0S5Vd7nvkbzdLbJq2Ua0GKFKE4l6ZZB+XeEfT3zC5I
	 w1aGGGgLIAHEA==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 8A2D28001FD;
	Tue, 24 Dec 2024 13:06:56 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:05:01 +0800
Subject: [PATCH v5 02/12] slimbus: core: Constify slim_eaddr_equal()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-const_dfc_done-v5-2-6623037414d4@quicinc.com>
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
X-Proofpoint-GUID: qLypl6fkadNdQJijofw2ji5DGrHQTi80
X-Proofpoint-ORIG-GUID: qLypl6fkadNdQJijofw2ji5DGrHQTi80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=801 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

bool slim_eaddr_equal(struct slim_eaddr *a, struct slim_eaddr *b)
does not modify @*a or @*b.

To prepare for constifying API device_find_child() later.

Constify this comparison function by simply changing its
parameter type to 'const struct slim_eaddr *'.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


