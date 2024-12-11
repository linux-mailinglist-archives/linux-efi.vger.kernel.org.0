Return-Path: <linux-efi+bounces-2362-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC19EC07D
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 01:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7D2282107
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D2C1CD0C;
	Wed, 11 Dec 2024 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="A2G4Fr6G"
X-Original-To: linux-efi@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD4137C2A
	for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2024 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875878; cv=none; b=qOeLGe2j/Ud6E38FPIJDthT//dbj0ukf/m1nzCnfjFOewLCfjWoec3fmG5t27/DOqWtb0kCg7Ah/Yvvf1TFEHOIgKQGn7t3UkaUTeRKP7emeYP/gIwunVw0Wmxg4GO3pB4Oe4cqaiwyzLQUkMCJoK9jpBffU2IKJmVptoVFTCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875878; c=relaxed/simple;
	bh=d3RWbfmtjm10GAZA1NaOSKX3f3hNp1vr+fuyWoNuJcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXQlS6hka0VHv9HoiNRw/aQZ2+kxyDKuogZdeNwD7cfleIvrkBrATIKfQUDGhJ0SfiqLkTggphuVtButsBTohziiaiyayV3S9gut4t1PhPMgb6qnQNsOaqwFcaaNAd+m2IOQ9jmTUaqwP6iyI/OIgxGO88MMAixe88qJ0MVeckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=A2G4Fr6G; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733875874;
	bh=+P6kTmCwDbC0RwMmjYjZfzPZ5o9SCTkxH8bGJ/DVcdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=A2G4Fr6Ga6cVgux12r3mj2O9uL5jIcyFXHdjjqLRUtrEdEAwO7iZHiUi5FF6UPVWo
	 hkulrf+wv/Im1f51OENPnQuBkzjqse1+qZAWDlM/Ma/ogIYBbBc5z987he4q/Jfl/j
	 jqoFvMwL1Dxn9aXwXtEZHj1xbx0kYWW9yoj14b+sc93PJCVGG73JrsnCffz2e+UQam
	 moqZ3JxqtqDb6QrUFF3T4ZHUf07FMnmWcCqxambSLziZyyUYRBLY1FDHbpm8nZRlL4
	 b1ndYET1hWQUqdrGPGb1qMfeSNR//QUsLeZ1GaVoFEHlo6HuTD5NfJJdJ3tCpxtcTt
	 akO3dQKO/do/A==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id E9BCD3A0349;
	Wed, 11 Dec 2024 00:11:03 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 11 Dec 2024 08:08:13 +0800
Subject: [PATCH v4 11/11] usb: typec: class: Remove both cable_match() and
 partner_match()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-const_dfc_done-v4-11-583cc60329df@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qwQLilRFtH8fzUdgAlR9P2gaSWkwiO3A
X-Proofpoint-GUID: qwQLilRFtH8fzUdgAlR9P2gaSWkwiO3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_13,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=950 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100174
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

cable_match(), as matching function of device_find_child(), matches
a device with device type @typec_cable_dev_type, and its task can be
simplified by the recently introduced API device_match_type().

partner_match() is similar with cable_match() but with a different
device type @typec_partner_dev_type.

Remove both functions and use the API plus respective device type instead.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/usb/typec/class.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 601a81aa1e1024265f2359393dee531a7779c6ea..3a4e0bd0131774afd0d746d2f0a306190219feec 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1282,11 +1282,6 @@ const struct device_type typec_cable_dev_type = {
 	.release = typec_cable_release,
 };
 
-static int cable_match(struct device *dev, const void *data)
-{
-	return is_typec_cable(dev);
-}
-
 /**
  * typec_cable_get - Get a reference to the USB Type-C cable
  * @port: The USB Type-C Port the cable is connected to
@@ -1298,7 +1293,8 @@ struct typec_cable *typec_cable_get(struct typec_port *port)
 {
 	struct device *dev;
 
-	dev = device_find_child(&port->dev, NULL, cable_match);
+	dev = device_find_child(&port->dev, &typec_cable_dev_type,
+				device_match_type);
 	if (!dev)
 		return NULL;
 
@@ -2028,16 +2024,12 @@ const struct device_type typec_port_dev_type = {
 /* --------------------------------------- */
 /* Driver callbacks to report role updates */
 
-static int partner_match(struct device *dev, const void *data)
-{
-	return is_typec_partner(dev);
-}
-
 static struct typec_partner *typec_get_partner(struct typec_port *port)
 {
 	struct device *dev;
 
-	dev = device_find_child(&port->dev, NULL, partner_match);
+	dev = device_find_child(&port->dev, &typec_partner_dev_type,
+				device_match_type);
 	if (!dev)
 		return NULL;
 
@@ -2170,7 +2162,9 @@ void typec_set_pwr_opmode(struct typec_port *port,
 	sysfs_notify(&port->dev.kobj, NULL, "power_operation_mode");
 	kobject_uevent(&port->dev.kobj, KOBJ_CHANGE);
 
-	partner_dev = device_find_child(&port->dev, NULL, partner_match);
+	partner_dev = device_find_child(&port->dev,
+					&typec_partner_dev_type,
+					device_match_type);
 	if (partner_dev) {
 		struct typec_partner *partner = to_typec_partner(partner_dev);
 
@@ -2334,7 +2328,9 @@ int typec_get_negotiated_svdm_version(struct typec_port *port)
 	enum usb_pd_svdm_ver svdm_version;
 	struct device *partner_dev;
 
-	partner_dev = device_find_child(&port->dev, NULL, partner_match);
+	partner_dev = device_find_child(&port->dev,
+					&typec_partner_dev_type,
+					device_match_type);
 	if (!partner_dev)
 		return -ENODEV;
 
@@ -2361,7 +2357,8 @@ int typec_get_cable_svdm_version(struct typec_port *port)
 	enum usb_pd_svdm_ver svdm_version;
 	struct device *cable_dev;
 
-	cable_dev = device_find_child(&port->dev, NULL, cable_match);
+	cable_dev = device_find_child(&port->dev, &typec_cable_dev_type,
+				      device_match_type);
 	if (!cable_dev)
 		return -ENODEV;
 

-- 
2.34.1


