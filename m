Return-Path: <linux-efi+bounces-2468-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652E09FBE08
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 14:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B8816565E
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC61DDC2C;
	Tue, 24 Dec 2024 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bDJo1aK3"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB61B5ECB
	for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045667; cv=none; b=J36dgckOwl/UX6arFMJT6pCjts8fA8ayTii+3TVRjHHUeJD11VC7Ul/CxZsWR680q76QdVNirDsS0PseoQHcv61yLngdM5j2FK1mQnYWWqgqKZ/d55Px+y0gi4f0XMhAUYWBFkqJ/bGr7QxcRl8hiEdgVC4sbXtVbsbVeGq/UPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045667; c=relaxed/simple;
	bh=hQ3pt6KCj+VNZeye3C2oc8EGBgjz+I2LqJpsVt4Qk/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3EgKo+rghIeQSf5IchPYKxRbMmZDgFAlYQV15iSm0JZsh2999BAiprFgT+6rxJfAMOyhZFozMQM7ZPqSIhNNFKZusdQ+K878FykucxLz0eIb0TnKCaNvhVF79HPifaM/o0Pwh5Qkbkj+xVjaaV21ohcBW0RxJ9cr7B32Ibb/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bDJo1aK3; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045663;
	bh=9+eHhoN9BwBVO2kcWKyQg7rz5+sDk0CN4HmpL8tDEDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=bDJo1aK3bW8Sg5VZyshcTueddv4CXV6xhCHKvr5juY8meQJmcMSbINVvZ287XXF8Q
	 AtVKhNAN6x3VBTL9Jx2W0B1LPnkKSl7LND3xFChzlJ7EVjk00PSKCsV4XcFIpbCnUx
	 51nOTp4+7BvUwfqn76Z3bR8aNOEYZGuO/KMfWKKdmwFZFc3Ca8sZNb0QBmJWcfh/sx
	 b+jAF7CPzUTsKP3I13SYh+DNw+RV1NZuR6tElSPz9bRDtOBsEV4TH5r8VhZ8xBpVPh
	 AroaAKk8cUmJI4SoFesWznlphUVwg9B4ogYND9h22148byzZYJcXe2wv57sUrBwY3/
	 zDlBFm5fvxsMQ==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 85A6E8002ED;
	Tue, 24 Dec 2024 13:07:27 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:05:03 +0800
Subject: [PATCH v5 04/12] driver core: Constify API device_find_child() and
 adapt for various usages
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241224-const_dfc_done-v5-4-6623037414d4@quicinc.com>
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
 Takashi Sakamoto <o-takashi@sakamocchi.jp>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: VtuUJhVrjD5HtA615G7QgqybBL8U5zNm
X-Proofpoint-ORIG-GUID: VtuUJhVrjD5HtA615G7QgqybBL8U5zNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240113
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

Constify the API and adapt for various existing usages.

BTW, various subsystem changes are squashed into this commit to meet
'git bisect' requirement, and this commit has the minimal and simplest
changes to complement squashing shortcoming, and that may bring extra
code improvement.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Acked-by: Uwe Kleine-König <ukleinek@kernel.org> # for drivers/pwm
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 arch/sparc/kernel/vio.c                |  6 +++---
 drivers/base/core.c                    |  6 +++---
 drivers/block/sunvdc.c                 |  6 +++---
 drivers/bus/fsl-mc/dprc-driver.c       |  4 ++--
 drivers/cxl/core/pci.c                 |  4 ++--
 drivers/cxl/core/pmem.c                |  2 +-
 drivers/cxl/core/region.c              | 21 ++++++++++++---------
 drivers/firewire/core-device.c         |  4 ++--
 drivers/firmware/arm_scmi/bus.c        |  4 ++--
 drivers/firmware/efi/dev-path-parser.c |  4 ++--
 drivers/gpio/gpio-sim.c                |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 +-
 drivers/hwmon/hwmon.c                  |  2 +-
 drivers/media/pci/mgb4/mgb4_core.c     |  4 ++--
 drivers/nvdimm/bus.c                   |  2 +-
 drivers/pwm/core.c                     |  2 +-
 drivers/rpmsg/rpmsg_core.c             |  4 ++--
 drivers/scsi/qla4xxx/ql4_os.c          |  3 ++-
 drivers/scsi/scsi_transport_iscsi.c    | 10 +++++-----
 drivers/slimbus/core.c                 |  8 ++++----
 drivers/thunderbolt/retimer.c          |  2 +-
 drivers/thunderbolt/xdomain.c          |  2 +-
 drivers/tty/serial/serial_core.c       |  4 ++--
 drivers/usb/typec/class.c              |  8 ++++----
 include/linux/device.h                 |  4 ++--
 include/scsi/scsi_transport_iscsi.h    |  4 ++--
 net/dsa/dsa.c                          |  2 +-
 tools/testing/cxl/test/cxl.c           |  2 +-
 28 files changed, 66 insertions(+), 62 deletions(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 07933d75ac815160a2580dce39fde7653a9502e1..1a1a9d6b8f2e8dfedefafde846315a06a167fbfb 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -419,13 +419,13 @@ struct vio_remove_node_data {
 	u64 node;
 };
 
-static int vio_md_node_match(struct device *dev, void *arg)
+static int vio_md_node_match(struct device *dev, const void *arg)
 {
 	struct vio_dev *vdev = to_vio_dev(dev);
-	struct vio_remove_node_data *node_data;
+	const struct vio_remove_node_data *node_data;
 	u64 node;
 
-	node_data = (struct vio_remove_node_data *)arg;
+	node_data = (const struct vio_remove_node_data *)arg;
 
 	node = vio_vdev_node(node_data->hp, vdev);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 94865c9d8adcf5f2ce5002ffd7bf0ef4fc85e4d7..bc3b523a4a6366080c3c9fd190e54c7fd13c8ded 100644
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
@@ -4125,7 +4125,7 @@ struct device *device_find_child_by_name(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(device_find_child_by_name);
 
-static int match_any(struct device *dev, void *unused)
+static int match_any(struct device *dev, const void *unused)
 {
 	return 1;
 }
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 2d38331ee66793402e803ec0cc82e9e71c991c84..386643ceed59921203828844aa070833c44c67fb 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -918,12 +918,12 @@ struct vdc_check_port_data {
 	char	*type;
 };
 
-static int vdc_device_probed(struct device *dev, void *arg)
+static int vdc_device_probed(struct device *dev, const void *arg)
 {
 	struct vio_dev *vdev = to_vio_dev(dev);
-	struct vdc_check_port_data *port_data;
+	const struct vdc_check_port_data *port_data;
 
-	port_data = (struct vdc_check_port_data *)arg;
+	port_data = (const struct vdc_check_port_data *)arg;
 
 	if ((vdev->dev_no == port_data->dev_no) &&
 	    (!(strcmp((char *)&vdev->type, port_data->type))) &&
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 11c8fadcf85148b4e4ea6b97b7efb6d4ddf22d3c..52053f7c6d9a654ba46c6579c6a3c5c3faaa75c1 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -112,9 +112,9 @@ void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
 }
 EXPORT_SYMBOL_GPL(dprc_remove_devices);
 
-static int __fsl_mc_device_match(struct device *dev, void *data)
+static int __fsl_mc_device_match(struct device *dev, const void *data)
 {
-	struct fsl_mc_obj_desc *obj_desc = data;
+	const struct fsl_mc_obj_desc *obj_desc = data;
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
 	return fsl_mc_device_match(mc_dev, obj_desc);
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d58ab9d33c554e05ddfa2610269e6d08bfaa8e9..a3c57f96138a28c9f30562d554c42cb5224bcf4b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -252,9 +252,9 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 }
 
 /* require dvsec ranges to be covered by a locked platform window */
-static int dvsec_range_allowed(struct device *dev, void *arg)
+static int dvsec_range_allowed(struct device *dev, const void *arg)
 {
-	struct range *dev_range = arg;
+	const struct range *dev_range = arg;
 	struct cxl_decoder *cxld;
 
 	if (!is_root_decoder(dev))
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index b3378d3f6acb4c9e3601683119754e3cd6329df2..a8473de24ebfd92f12f47e0556e28b81a29cff7c 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -57,7 +57,7 @@ bool is_cxl_nvdimm_bridge(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_nvdimm_bridge, "CXL");
 
-static int match_nvdimm_bridge(struct device *dev, void *data)
+static int match_nvdimm_bridge(struct device *dev, const void *data)
 {
 	return is_cxl_nvdimm_bridge(dev);
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d778996507984a759bbe84e7acac3774e0c7af98..bfecd71040c2f4373645380b4c31327d8b42d095 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -792,7 +792,7 @@ static int check_commit_order(struct device *dev, const void *data)
 	return 0;
 }
 
-static int match_free_decoder(struct device *dev, void *data)
+static int match_free_decoder(struct device *dev, const void *data)
 {
 	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_decoder *cxld;
@@ -824,9 +824,9 @@ static int match_free_decoder(struct device *dev, void *data)
 	return 1;
 }
 
-static int match_auto_decoder(struct device *dev, void *data)
+static int match_auto_decoder(struct device *dev, const void *data)
 {
-	struct cxl_region_params *p = data;
+	const struct cxl_region_params *p = data;
 	struct cxl_decoder *cxld;
 	struct range *r;
 
@@ -1722,10 +1722,12 @@ static struct cxl_port *next_port(struct cxl_port *port)
 	return port->parent_dport->port;
 }
 
-static int match_switch_decoder_by_range(struct device *dev, void *data)
+static int match_switch_decoder_by_range(struct device *dev,
+					 const void *data)
 {
 	struct cxl_switch_decoder *cxlsd;
-	struct range *r1, *r2 = data;
+	const struct range *r1, *r2 = data;
+
 
 	if (!is_switch_decoder(dev))
 		return 0;
@@ -3176,9 +3178,10 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_root_decoder_by_range(struct device *dev, void *data)
+static int match_root_decoder_by_range(struct device *dev,
+				       const void *data)
 {
-	struct range *r1, *r2 = data;
+	const struct range *r1, *r2 = data;
 	struct cxl_root_decoder *cxlrd;
 
 	if (!is_root_decoder(dev))
@@ -3189,11 +3192,11 @@ static int match_root_decoder_by_range(struct device *dev, void *data)
 	return range_contains(r1, r2);
 }
 
-static int match_region_by_range(struct device *dev, void *data)
+static int match_region_by_range(struct device *dev, const void *data)
 {
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct range *r = data;
+	const struct range *r = data;
 	int rc = 0;
 
 	if (!is_cxl_region(dev))
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index a99fe35f1f0d1a2e585ac49b86cc6fd0807cffb6..ec3e21ad202520dda745064b954c853a26d03e3d 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -988,7 +988,7 @@ int fw_device_set_broadcast_channel(struct device *dev, void *gen)
 	return 0;
 }
 
-static int compare_configuration_rom(struct device *dev, void *data)
+static int compare_configuration_rom(struct device *dev, const void *data)
 {
 	const struct fw_device *old = fw_device(dev);
 	const u32 *config_rom = data;
@@ -1039,7 +1039,7 @@ static void fw_device_init(struct work_struct *work)
 	//
 	// serialize config_rom access.
 	scoped_guard(rwsem_read, &fw_device_rwsem) {
-		found = device_find_child(card->device, (void *)device->config_rom,
+		found = device_find_child(card->device, device->config_rom,
 					  compare_configuration_rom);
 	}
 	if (found) {
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 157172a5f2b577ce4f04425f967f548230c1ebed..a3386bf36de508d312e2c4fa2e27ba62ba3776a0 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -238,10 +238,10 @@ static int scmi_dev_match(struct device *dev, const struct device_driver *drv)
 	return 0;
 }
 
-static int scmi_match_by_id_table(struct device *dev, void *data)
+static int scmi_match_by_id_table(struct device *dev, const void *data)
 {
 	struct scmi_device *sdev = to_scmi_dev(dev);
-	struct scmi_device_id *id_table = data;
+	const struct scmi_device_id *id_table = data;
 
 	return sdev->protocol_id == id_table->protocol_id &&
 		(id_table->name && !strcmp(sdev->name, id_table->name));
diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index 937be269fee86d5d71256758aed94741e794431c..13ea141c0defb5e80d5af43cca73cf527444a238 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -47,9 +47,9 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
 	return 0;
 }
 
-static int __init match_pci_dev(struct device *dev, void *data)
+static int __init match_pci_dev(struct device *dev, const void *data)
 {
-	unsigned int devfn = *(unsigned int *)data;
+	unsigned int devfn = *(const unsigned int *)data;
 
 	return dev_is_pci(dev) && to_pci_dev(dev)->devfn == devfn;
 }
diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index f387dad81f2960b5ec3c1b5fd04081ee501cc75b..370b71513bdb529112e157fa22a5451e02502a17 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -413,7 +413,7 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
 	return devm_add_action_or_reset(dev, gpio_sim_sysfs_remove, chip);
 }
 
-static int gpio_sim_dev_match_fwnode(struct device *dev, void *data)
+static int gpio_sim_dev_match_fwnode(struct device *dev, const void *data)
 {
 	return device_match_fwnode(dev, data);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 0829ceb9967ca5d03509c52a559494d58776077b..4aeb393b58e636225ba3b529e4529f3028219e62 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -359,7 +359,7 @@ static const struct of_device_id mtk_drm_of_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
 
-static int mtk_drm_match(struct device *dev, void *data)
+static int mtk_drm_match(struct device *dev, const void *data)
 {
 	if (!strncmp(dev_name(dev), "mediatek-drm", sizeof("mediatek-drm") - 1))
 		return true;
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index bbb9cc44e29fbc635706db5bed21f3b8a1cd4987..6552ee5186896e9290658a26d8f230849aacafa6 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -341,7 +341,7 @@ static int hwmon_attr_base(enum hwmon_sensor_types type)
 
 static DEFINE_MUTEX(hwmon_pec_mutex);
 
-static int hwmon_match_device(struct device *dev, void *data)
+static int hwmon_match_device(struct device *dev, const void *data)
 {
 	return dev->class == &hwmon_class;
 }
diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
index bc63dc81bcae0d20924174be74b93a2139d5879f..697d50bedfe285d74c702efde61e510df87c1229 100644
--- a/drivers/media/pci/mgb4/mgb4_core.c
+++ b/drivers/media/pci/mgb4/mgb4_core.c
@@ -123,7 +123,7 @@ static const struct hwmon_chip_info temp_chip_info = {
 };
 #endif
 
-static int match_i2c_adap(struct device *dev, void *data)
+static int match_i2c_adap(struct device *dev, const void *data)
 {
 	return i2c_verify_adapter(dev) ? 1 : 0;
 }
@@ -139,7 +139,7 @@ static struct i2c_adapter *get_i2c_adap(struct platform_device *pdev)
 	return dev ? to_i2c_adapter(dev) : NULL;
 }
 
-static int match_spi_adap(struct device *dev, void *data)
+static int match_spi_adap(struct device *dev, const void *data)
 {
 	return to_spi_device(dev) ? 1 : 0;
 }
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 2237715e42eb32a14a4134746739a0df5ca27414..0ccf4a9e523a52ef52a96a339ecff0bcb51b214b 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -1212,7 +1212,7 @@ enum nd_ioctl_mode {
 	DIMM_IOCTL,
 };
 
-static int match_dimm(struct device *dev, void *data)
+static int match_dimm(struct device *dev, const void *data)
 {
 	long id = (long) data;
 
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 675b252d9c8ce74705ef245faae42e2c1330ed15..14144d0fa38e0c4e0bc34b9c929e127f1b2e96b6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1276,7 +1276,7 @@ static int pwm_export_child(struct device *pwmchip_dev, struct pwm_device *pwm)
 	return 0;
 }
 
-static int pwm_unexport_match(struct device *pwm_dev, void *data)
+static int pwm_unexport_match(struct device *pwm_dev, const void *data)
 {
 	return pwm_from_dev(pwm_dev) == data;
 }
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 712c06c02696663821c8c884bcbd83036098899b..207b64c0a2fe9ccdb03b4ed66d1cee81e6f4c1ae 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -377,9 +377,9 @@ EXPORT_SYMBOL(rpmsg_get_mtu);
  * this is used to make sure we're not creating rpmsg devices for channels
  * that already exist.
  */
-static int rpmsg_device_match(struct device *dev, void *data)
+static int rpmsg_device_match(struct device *dev, const void *data)
 {
-	struct rpmsg_channel_info *chinfo = data;
+	const struct rpmsg_channel_info *chinfo = data;
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 
 	if (chinfo->src != RPMSG_ADDR_ANY && chinfo->src != rpdev->src)
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index d91f54a6e752f2feb68da69f474375f1415f33a2..133f36457b283a53b4dca29adf081f385a371368 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -7189,7 +7189,8 @@ static void qla4xxx_build_new_nt_list(struct scsi_qla_host *ha,
  *	1: if flashnode entry is non-persistent
  *	0: if flashnode entry is persistent
  **/
-static int qla4xxx_sysfs_ddb_is_non_persistent(struct device *dev, void *data)
+static int qla4xxx_sysfs_ddb_is_non_persistent(struct device *dev,
+					       const void *data)
 {
 	struct iscsi_bus_flash_session *fnode_sess;
 
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index fde7de3b1e55381f7cd468ad308a3e4ee9417c8c..0d474de2d960a865c52c9e7253f173d70ddd8f16 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1324,7 +1324,7 @@ EXPORT_SYMBOL_GPL(iscsi_create_flashnode_conn);
  *  1 on success
  *  0 on failure
  */
-static int iscsi_is_flashnode_conn_dev(struct device *dev, void *data)
+static int iscsi_is_flashnode_conn_dev(struct device *dev, const void *data)
 {
 	return dev->bus == &iscsi_flashnode_bus;
 }
@@ -1335,7 +1335,7 @@ static int iscsi_destroy_flashnode_conn(struct iscsi_bus_flash_conn *fnode_conn)
 	return 0;
 }
 
-static int flashnode_match_index(struct device *dev, void *data)
+static int flashnode_match_index(struct device *dev, const void *data)
 {
 	struct iscsi_bus_flash_session *fnode_sess = NULL;
 	int ret = 0;
@@ -1344,7 +1344,7 @@ static int flashnode_match_index(struct device *dev, void *data)
 		goto exit_match_index;
 
 	fnode_sess = iscsi_dev_to_flash_session(dev);
-	ret = (fnode_sess->target_id == *((int *)data)) ? 1 : 0;
+	ret = (fnode_sess->target_id == *((const int *)data)) ? 1 : 0;
 
 exit_match_index:
 	return ret;
@@ -1389,8 +1389,8 @@ iscsi_get_flashnode_by_index(struct Scsi_Host *shost, uint32_t idx)
  *  %NULL on failure
  */
 struct device *
-iscsi_find_flashnode_sess(struct Scsi_Host *shost, void *data,
-			  int (*fn)(struct device *dev, void *data))
+iscsi_find_flashnode_sess(struct Scsi_Host *shost, const void *data,
+			  device_match_t fn)
 {
 	return device_find_child(&shost->shost_gendev, data, fn);
 }
diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index b5d5bbb9fdb6614ffd578f5754226b50e394f0df..ab927fd077cb4fe1e29c004269fe52b2896c302f 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -337,9 +337,9 @@ static bool slim_eaddr_equal(const struct slim_eaddr *a,
 		a->instance == b->instance);
 }
 
-static int slim_match_dev(struct device *dev, void *data)
+static int slim_match_dev(struct device *dev, const void *data)
 {
-	struct slim_eaddr *e_addr = data;
+	const struct slim_eaddr *e_addr = data;
 	struct slim_device *sbdev = to_slim_device(dev);
 
 	return slim_eaddr_equal(&sbdev->e_addr, e_addr);
@@ -385,9 +385,9 @@ struct slim_device *slim_get_device(struct slim_controller *ctrl,
 }
 EXPORT_SYMBOL_GPL(slim_get_device);
 
-static int of_slim_match_dev(struct device *dev, void *data)
+static int of_slim_match_dev(struct device *dev, const void *data)
 {
-	struct device_node *np = data;
+	const struct device_node *np = data;
 	struct slim_device *sbdev = to_slim_device(dev);
 
 	return (sbdev->dev.of_node == np);
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
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 74fa02b237729931928b2ae4902c699ec017af94..8e0aa2c76d4037047a16f6c631eccaa066d8f230 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2365,9 +2365,9 @@ struct uart_match {
 	struct uart_driver *driver;
 };
 
-static int serial_match_port(struct device *dev, void *data)
+static int serial_match_port(struct device *dev, const void *data)
 {
-	struct uart_match *match = data;
+	const struct uart_match *match = data;
 	struct tty_driver *tty_drv = match->driver->tty_driver;
 	dev_t devt = MKDEV(tty_drv->major, tty_drv->minor_start) +
 		match->port->line;
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 4b3047e055a3737d3eb841e00fc976a70f8c9c3e..601a81aa1e1024265f2359393dee531a7779c6ea 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -229,10 +229,10 @@ static const char * const usb_modes[] = {
 /* ------------------------------------------------------------------------- */
 /* Alternate Modes */
 
-static int altmode_match(struct device *dev, void *data)
+static int altmode_match(struct device *dev, const void *data)
 {
 	struct typec_altmode *adev = to_typec_altmode(dev);
-	struct typec_device_id *id = data;
+	const struct typec_device_id *id = data;
 
 	if (!is_typec_altmode(dev))
 		return 0;
@@ -1282,7 +1282,7 @@ const struct device_type typec_cable_dev_type = {
 	.release = typec_cable_release,
 };
 
-static int cable_match(struct device *dev, void *data)
+static int cable_match(struct device *dev, const void *data)
 {
 	return is_typec_cable(dev);
 }
@@ -2028,7 +2028,7 @@ const struct device_type typec_port_dev_type = {
 /* --------------------------------------- */
 /* Driver callbacks to report role updates */
 
-static int partner_match(struct device *dev, void *data)
+static int partner_match(struct device *dev, const void *data)
 {
 	return is_typec_partner(dev);
 }
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
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index bd1243657c019962853849b07fc2ae190ec3b557..4d3baf324900f4b2b1ff3a5724b7ca7d122dc468 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -497,8 +497,8 @@ extern void iscsi_destroy_all_flashnode(struct Scsi_Host *shost);
 extern int iscsi_flashnode_bus_match(struct device *dev,
 				     const struct device_driver *drv);
 extern struct device *
-iscsi_find_flashnode_sess(struct Scsi_Host *shost, void *data,
-			  int (*fn)(struct device *dev, void *data));
+iscsi_find_flashnode_sess(struct Scsi_Host *shost, const void *data,
+			  device_match_t fn);
 extern struct device *
 iscsi_find_flashnode_conn(struct iscsi_bus_flash_session *fnode_sess);
 
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 5a7c0e565a894545ee14f0e0186ed3c46b809b16..e827775baf2ee1d0e1c0ce5807c2cca5c372fc75 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1367,7 +1367,7 @@ static int dsa_switch_parse_of(struct dsa_switch *ds, struct device_node *dn)
 	return dsa_switch_parse_ports_of(ds, dn);
 }
 
-static int dev_is_class(struct device *dev, void *class)
+static int dev_is_class(struct device *dev, const void *class)
 {
 	if (dev->class != NULL && !strcmp(dev->class->name, class))
 		return 1;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index d0337c11f9ee675b0c461c8ae28e50957dc644ce..cc8948f49117a98086b3ef2ea7a8de0ce1ec36a5 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -725,7 +725,7 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 	cxld->reset = mock_decoder_reset;
 }
 
-static int first_decoder(struct device *dev, void *data)
+static int first_decoder(struct device *dev, const void *data)
 {
 	struct cxl_decoder *cxld;
 

-- 
2.34.1


