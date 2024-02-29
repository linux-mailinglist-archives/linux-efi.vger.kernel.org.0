Return-Path: <linux-efi+bounces-672-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3D86C1B0
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 08:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7C0289EAE
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3BA481AF;
	Thu, 29 Feb 2024 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7fcNErE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C245950;
	Thu, 29 Feb 2024 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190808; cv=none; b=ds5Yq/q6/5sZLflpZH/HdGaCitnu/V1W6Qf9YAw8SvkH9MPQWZUQDxOjIsjq96pKR8ElBVO3Do3JiXN8QSarUPxxw1wpizjuVpUNWICWFkhFkR96iKbrJcyUz6M9P1ZPKO+UUpgdx/33liibOgTE3XkiV2mM/LFwzVjVac/aZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190808; c=relaxed/simple;
	bh=x1aGCgFq02k93Mdw2reAcXjZLCdUEfh0lfFGNDEloKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UkAgTDWvv+Oh4eEMrG5LX0FCiPuZuvdCXQERo5ajqHNmq85OAP8uRhdmMu+gsa4dk6PoH5f0dqwfcoqIdy4SRmlSSEw7V+uHqiq8Z6oPQrpALND3IpLkXYaN9+JEDpUY7HRkPvAWXfO9IC35WJVtoILJKKYd1OAClDcCXZmuzuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7fcNErE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709190807; x=1740726807;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=x1aGCgFq02k93Mdw2reAcXjZLCdUEfh0lfFGNDEloKo=;
  b=n7fcNErEOOOd6Uw2aH5GmMrw9OlxLLNEIhGMNmzVchfHpIEFpci/2UVu
   Dp505rwQKydmq8tAjf9NA8Ev2W+t5H/J3Fqt/QXfgegT4RI75I4r0GuPa
   KhjMBQjfO3ogaVpwJ2aNXuur3WOUrzCO8QbSn33jH+Nojn2sx6FH/5NE9
   +0ap21/3w3rcNATKC+u+joixwLI5GNonoVQJ+c6sMg0Rw1uNPv+hL18Ou
   Oytug1DW8xp/zdRbdlzwa2Xa4DSmQxnD/KkfHp443nS97L4Zr4LHk9W2S
   4iV5yal6MtfILJ9AbCM9jcXNSGK8P4yCvkMzpUgOa3iOVtTE1MR9xtuYi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3519871"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3519871"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8283954"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.166.213])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:13:25 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 28 Feb 2024 23:13:18 -0800
Subject: [PATCH 3/4] cxl/pci: Register for and process CPER events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-cxl-cper3-v1-3-6aa3f1343c6c@intel.com>
References: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
In-Reply-To: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 Shiju Jose <shiju.jose@huawei.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709190800; l=3078;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=x1aGCgFq02k93Mdw2reAcXjZLCdUEfh0lfFGNDEloKo=;
 b=Hc+j7X+CQb6x5t3VaGt2xuCh8yHcqTF5bbPhMcdj23T1v3wWyZH2yhK64ynk1UrM2LS/hapc/
 ZiE+EB7FFEsBNojB1u0I3kLZ9WtRlw9rLtru3OuSc/cNHjn6GL1791X
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

If the firmware has configured CXL event support to be firmware first
the OS can process those events through CPER records.  The CXL layer has
unique DPA to HPA knowledge and standard event trace parsing in place.

CPER records contain Bus, Device, Function information which can be used
to identify the PCI device which is sending the event.

Add a CXL CPER callback to process events through the CXL trace
subsystem.

Future patches will provide additional region information such as HPA.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: Add back in after the revert in 6.8]
---
 drivers/cxl/pci.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..6cf8336d1b33 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -974,6 +974,73 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
-module_pci_driver(cxl_pci_driver);
+#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
+static void cxl_cper_event_call(enum cxl_event_type ev_type,
+				struct cxl_cper_event_rec *rec)
+{
+	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+	enum cxl_event_log_type log_type;
+	struct cxl_dev_state *cxlds;
+	unsigned int devfn;
+	u32 hdr_flags;
+
+	pr_debug("CPER event for device %u:%u:%u.%u\n",
+		 device_id->segment_num, device_id->bus_num,
+		 device_id->device_num, device_id->func_num);
+
+	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
+	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
+					   device_id->bus_num, devfn);
+	if (!pdev) {
+		pr_err("CPER event device %u:%u:%u.%u not found\n",
+			device_id->segment_num, device_id->bus_num,
+			device_id->device_num, device_id->func_num);
+		return;
+	}
+
+	dev_dbg(&pdev->dev, "Found device %u:%u.%u\n", device_id->bus_num,
+		device_id->device_num, device_id->func_num);
+
+	guard(device)(&pdev->dev);
+	if (pdev->driver != &cxl_pci_driver)
+		return;
+
+	cxlds = pci_get_drvdata(pdev);
+	if (!cxlds)
+		return;
+
+	/* Fabricate a log type */
+	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
+	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
+
+	dev_dbg(&pdev->dev, "Tracing %d\n", ev_type);
+	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
+			       &uuid_null, &rec->event);
+}
+
+static int __init cxl_pci_driver_init(void)
+{
+	int rc;
+
+	rc = pci_register_driver(&cxl_pci_driver);
+	if (rc)
+		return rc;
+
+	rc = cxl_cper_register_callback(cxl_cper_event_call);
+	if (rc)
+		pci_unregister_driver(&cxl_pci_driver);
+
+	return rc;
+}
+
+static void __exit cxl_pci_driver_exit(void)
+{
+	cxl_cper_unregister_callback(cxl_cper_event_call);
+	pci_unregister_driver(&cxl_pci_driver);
+}
+
+module_init(cxl_pci_driver_init);
+module_exit(cxl_pci_driver_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);

-- 
2.43.0


