Return-Path: <linux-efi+bounces-2256-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FDA9E1024
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 01:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20F92834B5
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 00:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E0F558BA;
	Tue,  3 Dec 2024 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jXymdwgi"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A01CF8B
	for <linux-efi@vger.kernel.org>; Tue,  3 Dec 2024 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186230; cv=none; b=tOp/g4XpP7dk50PFm/tOynfq1zOepxQZXu1WkXD7e88mQU17PgHzFOUvehFlA2sTn7kZtcHvXGWjP3x0lRGIiV+FBlhR6JGQV+ip7HcBK9K/Q6s5TGj1F7/NYtWrMX7fBB0OXcItDpCGV4SqJjBstpBrAQFsRim7B2/2cFTOMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186230; c=relaxed/simple;
	bh=jSVeDV6ZkiM+64+Q5gavtblCa5TWc80K57jDUkyQphQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9atEDARkO1zecK7yx8PR66B3Osmz0Vxv3u6LTmOT59sd1rdR2B9FmWhZDlL4LVboMpwM1oILpqNvk8TMtzeGXqOyP814q2AedkD+rYyhhaXa1QxEirt5hwAmAh4WYQP4Q00o7kychQTO5gN6HLDQUvT1WzW1H3cCojKgAee41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jXymdwgi; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733186227;
	bh=TLSTsXB0mczbMt3mGzVPxQ8OhGxgNCZ6TAUMbiwY3B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=jXymdwgicR4eK64TnG8UOl/zIlCmDeKxoyug3tscaJQ6VYyjA9iiv14jOaoCtSZyZ
	 4fG29yUoEJmpPSdPiTAl1/TyLmaHumfqUUknIyeLxZXFixafQ3LkeoxcEf9HL/z74b
	 IHkvT3/Ae4Q1PGFtdQZdpM+x2Qzb5BpK73NlRAd2rwKGWP75FBWGV7T1YhV1/rcq1M
	 2RuoLGUjlvsnS44SgzdIfqWT8MBWHPeno3+o8SxAgh6uK7+v3i49Go1zRIub3hS2tl
	 EthoPgJROAtFCu/JVaNSaGiHCtJy5sTg6M+uel/G6l3zx8QG+mfAlvFbDi1LQRwZdl
	 IevFqEkUispHA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 5175C4A0429;
	Tue,  3 Dec 2024 00:36:46 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 03 Dec 2024 08:33:28 +0800
Subject: [PATCH v2 06/32] thunderbolt: Adapt for constified
 device_find_child()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-const_dfc_done-v2-6-7436a98c497f@quicinc.com>
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
X-Proofpoint-GUID: TeEtLogdLeVrzNxTk5Sn7v7tNnyO2_Qq
X-Proofpoint-ORIG-GUID: TeEtLogdLeVrzNxTk5Sn7v7tNnyO2_Qq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=701 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412030002
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

device_find_child() has been constified to take new match function type:
typedef int (*device_match_t)(struct device *dev, const void *data);

Make its match functions take a const pointer to adapt for the new type.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/thunderbolt/retimer.c | 2 +-
 drivers/thunderbolt/xdomain.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 89d2919d0193e8f5c68e669d054f3efc7abf78c8..21d2902c6102f0f593fb0c6d645acaff31ebb274 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -461,7 +461,7 @@ struct tb_retimer_lookup {
 	u8 index;
 };
 
-static int retimer_match(struct device *dev, void *data)
+static int retimer_match(struct device *dev, const void *data)
 {
 	const struct tb_retimer_lookup *lookup = data;
 	struct tb_retimer *rt = tb_to_retimer(dev);
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 11a50c86a1e4302968f44dafeab47977bac01dd5..b0630e6d94726f9069c20017876ec7e212071686 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1026,7 +1026,7 @@ static int remove_missing_service(struct device *dev, void *data)
 	return 0;
 }
 
-static int find_service(struct device *dev, void *data)
+static int find_service(struct device *dev, const void *data)
 {
 	const struct tb_property *p = data;
 	struct tb_service *svc;

-- 
2.34.1


