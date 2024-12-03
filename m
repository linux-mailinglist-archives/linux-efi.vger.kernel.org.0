Return-Path: <linux-efi+bounces-2250-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A349E0FCD
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 01:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB166282189
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 00:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5957C2A8D0;
	Tue,  3 Dec 2024 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="miqyYlVd"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6012B94
	for <linux-efi@vger.kernel.org>; Tue,  3 Dec 2024 00:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186103; cv=none; b=dzn+We5CRaeCXTFhBYDULVN60V4SNlh/SPYbLc/QFFTKXAresCNhDBjgUqg2ZEYgBk8PEVOAEW7Loux953dN5tmpylfI9Y3YQyKAKz0elXaKX8T8Vyw3CANLqJ+4frNF+F8HgcMffVDK2PZih0WMN3xVm5UJZ+Y1TveDBa54u3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186103; c=relaxed/simple;
	bh=90Z3uIVjxiaduJ4fj5p/v/pFRaVs8rKzXxaWEN8s1Fs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jJLHz+DhdYA44HMsS0SVnwnyf05bn8QaBuf3ot4Jv690B+8otuSqIwIsdzI9jemv6lINn1btfQ7DvhEFbJY03u+wcfSTDOTIkwNelPhxj2yJla+fIJifyiDRITEY0btAHReGgPFbTYLXLcvB8MJ+jq+A08ncfqyFwbJgtm/JyyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=miqyYlVd; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733186099;
	bh=oHbx7nufqBC9FciDzS/LGxt7hmN8dQX6iuRN6cbwUA4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=miqyYlVd243flQ1IvVsliQiE9DHrrSD+z1j3Ao2U3BsVp7icRgsik+yX27rSCj4D+
	 T5K/safPmJG6H2G4WE9j7bBQvaFexypWm7FZEDou1MHIH9tDRRWMiQ1UPriELs/+hg
	 sXJNUkBBU1moy8uzw4v/v66n2uZ4nRbGFXnHbTcyy0JERpSfQmvHQ8NAx4kDoEqPtw
	 K44qvDlYPQIBfuW/hOl+sPtWJcXOrD96VbESU02KGCiiJXJdFSzYBJ54ViTlBPnRB9
	 QOAY9cdzyUWJL5EMG594jIK63Bf2SXcNzUNd7nw2qi11pPaZME4OnmSK9qWoRG15E/
	 2icgiJHx3EH4g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id A517C4A0115;
	Tue,  3 Dec 2024 00:34:38 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 00/32] driver core: Constify API device_find_child() and
 adapt for various existing usages
Date: Tue, 03 Dec 2024 08:33:22 +0800
Message-Id: <20241203-const_dfc_done-v2-0-7436a98c497f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANJRTmcC/2XMQQ6CMBCF4auQWVvTFozgynsYQsp0KrOwxRaJh
 vTuVrYu/5e8b4NEkSnBpdog0sqJgy+hDxXgZPydBNvSoKVulJZKYPBpGazDwQZPwhjCs6J6HMl
 AOc2RHL938NaXnjgtIX52f1W/dadkq/6oVQkpOtueqHZdU+N4fb4Y2eMRwwP6nPMXYHxV6a4AA
 AA=
X-Change-ID: 20241201-const_dfc_done-aaec71e3bbea
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
X-Proofpoint-GUID: cTyu1VL48UqVhY7zPwUQPPYeAfZYowdo
X-Proofpoint-ORIG-GUID: cTyu1VL48UqVhY7zPwUQPPYeAfZYowdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412030002
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

How to constify the API?

- Now, no (@match)() argument of the API usages is modifying its match
  data @*data after previous cleanup, so it is easy and safe to make its
  parameter @data take const void * as type.

- Simplify involved codes further if it is possbile with benefits
  brought by constifying the API.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Series v1 have no code review comments and are posted a long time ago, so may ignore differences.
- Link to v1: https://lore.kernel.org/r/20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com
- Motivation link: https://lore.kernel.org/lkml/917359cc-a421-41dd-93f4-d28937fe2325@icloud.com

---
Zijun Hu (32):
      driver core: Constify API device_find_child()
      driver core: Introduce device_match_type() to match device with a device type
      drm/mediatek: Adapt for constified device_find_child()
      hwmon: Adapt for constified device_find_child()
      media: pci: mgb4: Adapt for constified device_find_child()
      thunderbolt: Adapt for constified device_find_child()
      gpio: sim: Remove gpio_sim_dev_match_fwnode()
      net: dsa: Adapt for constified device_find_child()
      pwm: Adapt for constified device_find_child()
      nvdimm: Adapt for constified device_find_child()
      libnvdimm: Simplify nd_namespace_store() implementation
      firewire: core: Adapt for constified device_find_child()
      serial: core: Adapt for constified device_find_child()
      usb: typec: class: Remove both cable_match() and partner_match()
      usb: typec: class: Adapt for constified device_find_child()
      slimbus: core: Simplify of_find_slim_device() implementation
      slimbus: core: Constify slim_eaddr_equal()
      slimbus: core: Adapt for constified device_find_child()
      scsi: iscsi: Constify API iscsi_find_flashnode_sess()
      scsi: qla4xxx: Adapt for constified iscsi_find_flashnode_sess()
      scsi: iscsi: Adapt for constified device_find_child()
      cxl/region: Adapt for constified device_find_child()
      cxl/pmem: Remove match_nvdimm_bridge()
      cxl/core/pci: Adapt for constified device_find_child()
      cxl/test: Adapt for constified device_find_child()
      sparc: vio: Adapt for constified device_find_child()
      bus: fsl-mc: Adapt for constified device_find_child()
      block: sunvdc: Adapt for constified device_find_child()
      firmware: arm_scmi: Adapt for constified device_find_child()
      efi: dev-path-parser: Adapt for constified device_find_child()
      rpmsg: core: Adapt for constified device_find_child()
      driver core: Simplify API device_find_child_by_name() implementation

 arch/sparc/kernel/vio.c                |  6 +++---
 drivers/base/core.c                    | 30 ++++++++++--------------------
 drivers/block/sunvdc.c                 |  6 +++---
 drivers/bus/fsl-mc/dprc-driver.c       |  6 +++---
 drivers/cxl/core/pci.c                 |  4 ++--
 drivers/cxl/core/pmem.c                |  9 +++------
 drivers/cxl/core/region.c              | 21 ++++++++++++---------
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
 30 files changed, 89 insertions(+), 119 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241201-const_dfc_done-aaec71e3bbea

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


