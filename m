Return-Path: <linux-efi+bounces-2251-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C549E0FE1
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 01:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED05FB23E44
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 00:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EEE7DA88;
	Tue,  3 Dec 2024 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pr4JiGbg"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D204558BC
	for <linux-efi@vger.kernel.org>; Tue,  3 Dec 2024 00:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186124; cv=none; b=d2B6vHWoe/AYlRtiyhVTaAYy7dijh74WomEKdigcpHRoUyb4pROdQDvGBeCSAF6F2feBe+ziSx3aX6MPfwICdVw0okwe/TnpvT6BGBP5VL3JZ7JOW0OEhBVMS7FxdCT/l/ZjprA/gRRYGiR7yBZ3+7SF+GiEzAcDzc8O6CVJvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186124; c=relaxed/simple;
	bh=iw6gaObvgoK4xPTJIhFVAQ3lR2MbnHW598a95SEbCWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARlS5ERjeL4axISFqNHNbf6StXDkJnvo9ykBSilJDiANQt3h9Z76wR4o94rVh9/t/AuVJDas/4YR+YSfkaZRAdt77rRUEtbSNjVNKQ0YyJfPs+Oj7lpynrOAGu2uM1oKiAmhuQd86emox2l2PcigUNVKtZSdTrpsTaT+aEn4czE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pr4JiGbg; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733186120;
	bh=yQGAFPv+pJbBj/iId65BhA8VYlqddAV7eyST3/hbPmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=pr4JiGbgDRl4jH5Qb0VGGx2xr1KK4cmnjROfS3UObcXGX0xG13I89d21nJ34wwAgJ
	 g1qp3I97bvrYHBPEfpAH8pIdDnEZrpRcqKTfaxxMfx3oPrbV8789mePOysUhjEv9aL
	 oEhjTy2bDoa7ZmHPC94SyJ1BDof/W7B8eOcW/iGV7waR3E7wB0AsIyjgaTFxhSTJz8
	 DqB4yc2WFjsPgjq/Yiemk5zagt8izivWEqBpJXmqr54sAXeTX4O5DirjiMJQf3si1P
	 cGbukMI6SId4TX2iOzTEZiFUsp05rYzqtmjKqVLHWJtjb5jBN3F7u2lHOBVDaoCsw0
	 uNAEOMMXdssPQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 04AE54A0549;
	Tue,  3 Dec 2024 00:34:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 03 Dec 2024 08:33:23 +0800
Subject: [PATCH v2 01/32] driver core: Constify API device_find_child()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-const_dfc_done-v2-1-7436a98c497f@quicinc.com>
References: <20241203-const_dfc_done-v2-0-7436a98c497f@quicinc.com>
In-Reply-To: <20241203-const_dfc_done-v2-0-7436a98c497f@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Andreas Noever <andreas.noever@gmail.com>, 
 Michael Jamet <michael.jamet@intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, 
 Mike Christie <michael.christie@oracle.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Nilesh Javali <njavali@marvell.com>, 
 Manish Rangankar <mrangankar@marvell.com>, 
 GR-QLogic-Storage-Upstream@marvell.com, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Andreas Larsson <andreas@gaisler.com>, Stuart Yoder <stuyoder@gmail.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Jens Axboe <axboe@kernel.dk>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Ard Biesheuvel <ardb@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pwm@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux1394-devel@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 linux-sound@vger.kernel.org, open-iscsi@googlegroups.com, 
 linux-scsi@vger.kernel.org, linux-cxl@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 6SgCLfUyKpGAcB9NyJdr1xbmKY272C_F
X-Proofpoint-ORIG-GUID: 6SgCLfUyKpGAcB9NyJdr1xbmKY272C_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412030002
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Constify the following API:
struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
To :
struct device *device_find_child(struct device *dev, const void *data,
                                 device_match_t match);
typedef int (*device_match_t)(struct device *dev, const void *data);
with the following reasons:

- Protect caller's match data @*data which is for comparison and lookup
  and the API does not actually need to modify @*data.

- Make the API's parameters (@match)() and @data have the same type as
  all of other device finding APIs (bus|class|driver)_find_device().

- All kinds of existing device match functions can be directly taken
  as the API's argument, they were exported by driver core.

Now, no (*match)() argument of the API usages is modifying @*data in
current kernel tree, so it is safe to constify the API.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c    | 11 +++--------
 include/linux/device.h |  4 ++--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 94865c9d8adcf5f2ce5002ffd7bf0ef4fc85e4d7..a122ea1d84a3b08fce16dd1abdfa7746d31dc430 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4079,8 +4079,8 @@ EXPORT_SYMBOL_GPL(device_for_each_child_reverse_from);
  *
  * NOTE: you will need to drop the reference with put_device() after use.
  */
-struct device *device_find_child(struct device *parent, void *data,
-				 int (*match)(struct device *dev, void *data))
+struct device *device_find_child(struct device *parent, const void *data,
+				 device_match_t match)
 {
 	struct klist_iter i;
 	struct device *child;
@@ -4125,11 +4125,6 @@ struct device *device_find_child_by_name(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(device_find_child_by_name);
 
-static int match_any(struct device *dev, void *unused)
-{
-	return 1;
-}
-
 /**
  * device_find_any_child - device iterator for locating a child device, if any.
  * @parent: parent struct device
@@ -4141,7 +4136,7 @@ static int match_any(struct device *dev, void *unused)
  */
 struct device *device_find_any_child(struct device *parent)
 {
-	return device_find_child(parent, NULL, match_any);
+	return device_find_child(parent, NULL, device_match_any);
 }
 EXPORT_SYMBOL_GPL(device_find_any_child);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 667cb6db9019349c9db0233acf9e78ff6a6d9625..0e0bc9bfe0d15a8734bf3d34106300f4df6b5364 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1081,8 +1081,8 @@ int device_for_each_child_reverse(struct device *dev, void *data,
 int device_for_each_child_reverse_from(struct device *parent,
 				       struct device *from, const void *data,
 				       int (*fn)(struct device *, const void *));
-struct device *device_find_child(struct device *dev, void *data,
-				 int (*match)(struct device *dev, void *data));
+struct device *device_find_child(struct device *dev, const void *data,
+				 device_match_t match);
 struct device *device_find_child_by_name(struct device *parent,
 					 const char *name);
 struct device *device_find_any_child(struct device *parent);

-- 
2.34.1


