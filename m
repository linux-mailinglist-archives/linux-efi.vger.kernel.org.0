Return-Path: <linux-efi+bounces-996-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE778B43F6
	for <lists+linux-efi@lfdr.de>; Sat, 27 Apr 2024 05:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6279B2253E
	for <lists+linux-efi@lfdr.de>; Sat, 27 Apr 2024 03:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D9C3D3AC;
	Sat, 27 Apr 2024 03:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LG27BsGx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746D3BBF8;
	Sat, 27 Apr 2024 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714188848; cv=none; b=DxFwVkEelypsuIghtoYR+wGECpaH0G2QhyEk27w6yD/GdWxOrhfqGVv7YLTMylU9GHTdEj/MRwjeIwqdIPXfc5AVV32EKp7PpBcxlVEcfCtFPTmpAjSd3uAs1qPm/bUZ4HrOdEFNA0PADF283ZLasOHN63l1IdM7lEIRPbsShM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714188848; c=relaxed/simple;
	bh=yakISgSJkVeGETZpCxJ2REBgvyi3LjNiXYh23/SQhB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TK/eotwvbJtdnet6a7+NXM3DOXgIWvbqiLOLHZjaxW59bx27YU2seVewQ93rj43Nho2P7/CW6u924cVXZ03fZ6lVLyCsFfkrAQDMdqcx3E1Fm5YsYB5CheuRgwGKXTFJDBApDWGhLcAYzgR2/itLCCk/C6fhzp8lo5ssj84b2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LG27BsGx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714188847; x=1745724847;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yakISgSJkVeGETZpCxJ2REBgvyi3LjNiXYh23/SQhB4=;
  b=LG27BsGxmhsSvG+Ttr3RAeO6MW1kZWCs9LIsMoaj8ftFHGeu+TkOlDQF
   RfQFIjBol5smoAD/07uw9GGqsZhh0SpmhpIq/4qsnmQb81jaAAQKqS5wc
   +Y/QDoKqhcdl91cz4k86972xqDMK2Q2D83eKTXr3p/Yj4k2+iq41R6I/G
   +0xHC9W5Yfuxw+evApfgbngPtSszcJ3cQWg53eY0yrWii3TE3FqLQPhYh
   B/IlNEYn8TXqQMNLajULTsXV1yMh5AG7LpuQP2o1viJhrlcN68DYtWTC1
   nKELmRGXDDhVOlwXjBm4VqXOfTRjv9Ih1s4jVp2Epak8WocAFrQCvRE8O
   g==;
X-CSE-ConnectionGUID: kpg6tla+SVmbe8k2ypc/Sw==
X-CSE-MsgGUID: cj3ypI2uRMa1ujb2AqHBYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20620073"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="20620073"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 20:34:05 -0700
X-CSE-ConnectionGUID: EWzyMmNzT2Kse7R8/H6fcA==
X-CSE-MsgGUID: l7XurTIXTi6Ht2h+w67V1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="25593991"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.80])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 20:34:04 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 26 Apr 2024 20:34:01 -0700
Subject: [PATCH v4 2/2] cxl/pci: Process CPER events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-cxl-cper3-v4-2-58076cce1624@intel.com>
References: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
In-Reply-To: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 Shiju Jose <shiju.jose@huawei.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714188842; l=2978;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=yakISgSJkVeGETZpCxJ2REBgvyi3LjNiXYh23/SQhB4=;
 b=W4amnZPGdmLSTt51xzju5mfp0cF6ITW+k1xlZ98cF7+XCODqQgvaphlKr3cYgwipg/WTl8tKa
 TvCcAa9FWByAFOxATABkxFUwwdmWbmgzbB7ZBw5dTDZGt1TBenfIwEZ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

If the firmware has configured CXL event support to be firmware first
the OS will receive those events through CPER records.  The CXL layer has
unique DPA to HPA knowledge and existing event trace parsing in
place.[0]

Add a CXL CPER work item and register it with the GHES code to process
CPER events.

Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes:
[iweiny: pick up tag]
[djbw: use proper link format]
---
 drivers/cxl/pci.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..74876c9835e8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -974,6 +974,75 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
-module_pci_driver(cxl_pci_driver);
+#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
+static void cxl_handle_cper_event(enum cxl_event_type ev_type,
+				  struct cxl_cper_event_rec *rec)
+{
+	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+	enum cxl_event_log_type log_type;
+	struct cxl_dev_state *cxlds;
+	unsigned int devfn;
+	u32 hdr_flags;
+
+	pr_debug("CPER event %d for device %u:%u:%u.%u\n", ev_type,
+		 device_id->segment_num, device_id->bus_num,
+		 device_id->device_num, device_id->func_num);
+
+	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
+	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
+					   device_id->bus_num, devfn);
+	if (!pdev)
+		return;
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
+	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
+			       &uuid_null, &rec->event);
+}
+
+static void cxl_cper_work_fn(struct work_struct *work)
+{
+	struct cxl_cper_work_data wd;
+
+	while (cxl_cper_kfifo_get(&wd))
+		cxl_handle_cper_event(wd.event_type, &wd.rec);
+}
+static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
+
+static int __init cxl_pci_driver_init(void)
+{
+	int rc;
+
+	rc = pci_register_driver(&cxl_pci_driver);
+	if (rc)
+		return rc;
+
+	rc = cxl_cper_register_work(&cxl_cper_work);
+	if (rc)
+		pci_unregister_driver(&cxl_pci_driver);
+
+	return rc;
+}
+
+static void __exit cxl_pci_driver_exit(void)
+{
+	cxl_cper_unregister_work(&cxl_cper_work);
+	cancel_work_sync(&cxl_cper_work);
+	pci_unregister_driver(&cxl_pci_driver);
+}
+
+module_init(cxl_pci_driver_init);
+module_exit(cxl_pci_driver_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);

-- 
2.44.0


