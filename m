Return-Path: <linux-efi+bounces-2464-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A709FBDC0
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 14:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82ECC163811
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC81C3C15;
	Tue, 24 Dec 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pB0Z/8sw"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227C1B4126
	for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2024 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045602; cv=none; b=X/pj0LIHXrElpnxQOAdOtuY0epAeqey/J19codaLxkCeW662Gxp8YAXWuYLmyH4VTqLXBaJQt23ACsZnQe2ci5ehcTxZAnzaLjaCiM/kdcmZvSC5a65CXOeNg0KDFtp+8/6/EQFAuOauJ0S/7J0Fctw3miX1ntWEAUSLRWpBOc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045602; c=relaxed/simple;
	bh=viK7/qzPOLCwLDjZGaOfO4oeKv+S9LAIjFRjiFhbr88=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XdUCAnRgv/QpwpqLarc80yvX31m5KJMpqLnA8poREcUoXueOjkpKqf7XT7l1F51vu7GUlZNxCok6yftl1LLmbfNoHh21Q4nBpxG+U568QkCshIfX3SsPAE3GYdNgDQZALY37C4CFKOM3DiPuGC8esYAFGsAxHnBHOty5hCaXOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pB0Z/8sw; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045600;
	bh=taup17gEiAEsf+cah/8Joa7N14dglDeb7sEjabu8hj8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=pB0Z/8swJAjQrPlWTx2Z4ll8ub1T49Dvoz5Gkh07h0Z+451UY850E/A5gNUDNUBr8
	 DVe/Urzf4hsZn9ZyyZcpFQZvjkkWmBXeGGpOTFPxRITzQKuJz2zP92ObU6dO9TZ7P/
	 seeZ+AmVWqTJDCkygBTKuCJpigSGUdLw5mAq7aW86+MnQFjhWLMQQL3YjeDEd79d/B
	 nKX6Sxz3RdFfQABEoL8MRXny07yCxxUcsCCUZCLQWmApa8/9xmJDPy83Kd7TvY19KY
	 6wonyIK03/gBqxBQCG4WjSBk5IpQnqHCOhtwc+Rp2nwaGG5Xk0v+5KcIOjrRTURvte
	 by6OFOx5DiOPQ==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 68BB48002D2;
	Tue, 24 Dec 2024 13:06:23 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v5 00/12] driver core: Constify API device_find_child()
Date: Tue, 24 Dec 2024 21:04:59 +0800
Message-Id: <20241224-const_dfc_done-v5-0-6623037414d4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHuxamcC/23PwWrDMAwG4FcJPi/Diu3E6WnvMUqxZHn1IckWp
 2Gj9N2npjA2Mt1+gT70X1XhOXNRh+qqZl5zydMowT1Vis5hfOM6R8mq0Y2FRkNN01iWU0x0itP
 IdQhMHbBB5KDk6H3mlD838PUo+ZzLMs1fm7/CfbtR2sOOWqHWdR+9Y5N6awhfPi6Z8kjPNA3qj
 q3mB5Bf3A4wAkALkMD6Fl3YA/YX8M8HVgDnDVGrTdPH9Be4PfrNLNuSl0dJhaGwQMOQl0PV+Wi
 TsSy4QwcdEibumHTU4FGmTT1q9ILdvgGthM31fAEAAA==
X-Change-ID: 20241201-const_dfc_done-aaec71e3bbea
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: SGXobGO8o4jJ5A7b0w5xfm7rZAtJxm6L
X-Proofpoint-ORIG-GUID: SGXobGO8o4jJ5A7b0w5xfm7rZAtJxm6L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to constify the following API:
struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
To :
struct device *device_find_child(struct device *dev, const void *data,
				 device_match_t match);
typedef int (*device_match_t)(struct device *dev, const void *data);

Why to constify the API?

- Protect caller's match data @*data which is for comparison and lookup
  and the API does not actually need to modify @*data.

- Make the API's parameters (@match)() and @data have the same type as
  all of other device finding APIs (bus|class|driver)_find_device().

- All kinds of existing device matching functions can be directly taken
  as the API's argument, they were exported by driver core.

What to do?

- Patches [1/11, 3/11] prepare for constifying the API.

- Patch 4/11 constifies the API and adapt for its various subsystem usages.

- Remaining do cleanup for several usages with benefits brought above.

---
Changes in v5:
- Correct tile and commit messages based on Jonathan comments.
- Add one more optional patch 11/12 based on Jonathan proposal.
- Link to v4: https://lore.kernel.org/r/20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com

Changes in v4:
- Correct title and commit messages according to review comments
- Link to v3: https://lore.kernel.org/r/20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com

Changes in v3:
- Solve build broken issue by squashing changes of various subsystem.
- Reduce recipients to try to send out full patch serial.
- Correct tiles and commit messages.
- Link to v2: https://lore.kernel.org/all/20241203-const_dfc_done-v2-0-7436a98c497f@quicinc.com

Changes in v2:
- Series v1 have no code review comments and are posted a long time ago, so may ignore differences.
- Link to v1: https://lore.kernel.org/r/20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com
- Motivation link: https://lore.kernel.org/lkml/917359cc-a421-41dd-93f4-d28937fe2325@icloud.com

---
Zijun Hu (12):
      libnvdimm: Replace namespace_match() with device_find_child_by_name()
      slimbus: core: Constify slim_eaddr_equal()
      bus: fsl-mc: Constify fsl_mc_device_match()
      driver core: Constify API device_find_child() and adapt for various usages
      driver core: Simplify API device_find_child_by_name() implementation
      driver core: Remove match_any()
      slimbus: core: Remove of_slim_match_dev()
      gpio: sim: Remove gpio_sim_dev_match_fwnode()
      driver core: Introduce an device matching API device_match_type()
      cxl/pmem: Replace match_nvdimm_bridge() with API device_match_type()
      cxl/pmem: Remove is_cxl_nvdimm_bridge()
      usb: typec: class: Remove both cable_match() and partner_match()

 arch/sparc/kernel/vio.c                |  6 +++---
 drivers/base/core.c                    | 30 ++++++++++--------------------
 drivers/block/sunvdc.c                 |  6 +++---
 drivers/bus/fsl-mc/dprc-driver.c       |  8 ++++----
 drivers/cxl/core/pci.c                 |  4 ++--
 drivers/cxl/core/pmem.c                | 15 +++------------
 drivers/cxl/core/region.c              | 21 ++++++++++++---------
 drivers/cxl/cxl.h                      |  1 -
 drivers/firewire/core-device.c         |  4 ++--
 drivers/firmware/arm_scmi/bus.c        |  4 ++--
 drivers/firmware/efi/dev-path-parser.c |  4 ++--
 drivers/gpio/gpio-sim.c                |  7 +------
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 +-
 drivers/hwmon/hwmon.c                  |  2 +-
 drivers/media/pci/mgb4/mgb4_core.c     |  4 ++--
 drivers/nvdimm/bus.c                   |  2 +-
 drivers/nvdimm/claim.c                 |  9 +--------
 drivers/pwm/core.c                     |  2 +-
 drivers/rpmsg/rpmsg_core.c             |  4 ++--
 drivers/scsi/qla4xxx/ql4_os.c          |  3 ++-
 drivers/scsi/scsi_transport_iscsi.c    | 10 +++++-----
 drivers/slimbus/core.c                 | 17 +++++------------
 drivers/thunderbolt/retimer.c          |  2 +-
 drivers/thunderbolt/xdomain.c          |  2 +-
 drivers/tty/serial/serial_core.c       |  4 ++--
 drivers/usb/typec/class.c              | 31 ++++++++++++++-----------------
 include/linux/device.h                 |  4 ++--
 include/linux/device/bus.h             |  1 +
 include/scsi/scsi_transport_iscsi.h    |  4 ++--
 net/dsa/dsa.c                          |  2 +-
 tools/testing/cxl/test/cxl.c           |  2 +-
 31 files changed, 90 insertions(+), 127 deletions(-)
---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241201-const_dfc_done-aaec71e3bbea

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


