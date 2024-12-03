Return-Path: <linux-efi+bounces-2257-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E933C9E102B
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 01:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482EEB23F4E
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 00:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877FA136341;
	Tue,  3 Dec 2024 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="RdJmst+O"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A343AB0
	for <linux-efi@vger.kernel.org>; Tue,  3 Dec 2024 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186251; cv=none; b=S5tEguCknvST+jZpf2NkLUQR/JzdetwjlVfYilKK7Sw+YJKPiNqo0/W76nGXpuDJvNq1pvr05YLR2LL+RPx2hI9MXYtXs6JQQbX4G8AHeUDYoQwO/bA0d+5qfJ0ki1uCnQ8m2aKf8sCunONPESA6QyNLXFnvRIxLKX2JdFdkT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186251; c=relaxed/simple;
	bh=7FciL78UUlibZsHod7F7YNBV/ooO8nagTnWXq3BkucY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yk9xF+SBkiUBzHd7F704DP4nuOpRcJISSNK2vaQVZe/95o6wHaTMIusi8JeFbb4A1OISyUx5QqWEvM8XLmMuL5BJWdTaaTwKHFY3d+ii02/d7dsrStu6B5tD9o9TApUHKzVOGaNPPwADrQoDaCriAmWogRnkhrb7oN23MtQlsvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=RdJmst+O; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733186249;
	bh=+s67f8n4U38kNtBzbNjBtNPtsaYtVPWfyTOydyoL87U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=RdJmst+OGS1bX18zihPRnq3E4k8Mn0X9gd0De5cMNzdIENXb3O8qhxJoISLLIHPnX
	 SmVWOv6lgiW8uxFqHQVn6CIL8UWhU+SQ5/c/GaDeD/ZBOanvXDqxIB47dCFo4/Mg9S
	 Y7nXCVjY03OUPd8tAeu/s13OFpuatFHhJ9ranKymnlfaFEXP5HHYhXF0dGVFb7uXqO
	 U1Tfsb6uMZjwNnqQJ47gVvxhIu5AP5uoR1PmpdGvjUdq7Oan2xvuwvvrb3ROxUCIGX
	 4JXq2krogrKZuYlhTFe06UWFxW1I8oIFHJR9yuwEC6FRuV/L//g7Y+QppMj7DwPT6C
	 BvaISGX1MT84g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 626224A0614;
	Tue,  3 Dec 2024 00:37:08 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 03 Dec 2024 08:33:29 +0800
Subject: [PATCH v2 07/32] gpio: sim: Remove gpio_sim_dev_match_fwnode()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-const_dfc_done-v2-7-7436a98c497f@quicinc.com>
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
X-Proofpoint-GUID: LUw6jrNTlWvafXG6SgNBaGnBoiXYHqLl
X-Proofpoint-ORIG-GUID: LUw6jrNTlWvafXG6SgNBaGnBoiXYHqLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412030002
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

device_find_child() has been constified to take new match function type:
typedef int (*device_match_t)(struct device *dev, const void *data);

So device_match_fwnode() is applicable for the new type directly, and
remove its unnecessary wrapper gpio_sim_dev_match_fwnode().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/gpio/gpio-sim.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index f387dad81f2960b5ec3c1b5fd04081ee501cc75b..b1f33cbaaaa78aca324f99c45a868e7e79a9d672 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -413,11 +413,6 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
 	return devm_add_action_or_reset(dev, gpio_sim_sysfs_remove, chip);
 }
 
-static int gpio_sim_dev_match_fwnode(struct device *dev, void *data)
-{
-	return device_match_fwnode(dev, data);
-}
-
 static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 {
 	struct gpio_sim_chip *chip;
@@ -503,7 +498,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (ret)
 		return ret;
 
-	chip->dev = device_find_child(dev, swnode, gpio_sim_dev_match_fwnode);
+	chip->dev = device_find_child(dev, swnode, device_match_fwnode);
 	if (!chip->dev)
 		return -ENODEV;
 

-- 
2.34.1


