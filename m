Return-Path: <linux-efi+bounces-958-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B9B8AD739
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 00:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D5C282B4F
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 22:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E562134A;
	Mon, 22 Apr 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRHStPHZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFC1F932;
	Mon, 22 Apr 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824750; cv=none; b=a4m66kvWWI/kST1znjSAUNKCHCq+qWSnk0+4sfCy04ChhB0ix9Prcj6inTR7W8RfAKTkSW5Xf7+XztANaa0XYvN3VzJW5B8ZpIbYURydlIHHtGcS5msZ88iXRDNnRrR8tX4JpN6oj7bdWXxEAeY5WyLAKtoPYzLTBdH99Q4m24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824750; c=relaxed/simple;
	bh=SwiACezMWqHX266+90+Ge6XaFW19AEBmAf6LpMnB9Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dy4REXSSqFZtjIjmjLNT4yJZ0k7BnzX40M9IVqWk0q/KO+7p8YaNLPuNwzXG1aAczn1yvfGNeB7rjhSHcnptSulR6lzvF15UtwGatAsn8JrDDpQ7fC6s+T8YdV2lyjO4hpGdgP22lpxNPNBuON22UhDQ/wHft2LdcnlaGEexYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRHStPHZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713824749; x=1745360749;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SwiACezMWqHX266+90+Ge6XaFW19AEBmAf6LpMnB9Ws=;
  b=iRHStPHZNbe8y98qFnrzlLnVLEoA/hVYGoI7B9DP/1/uDn4ydQ1ZSxBr
   FLRBUxeCIjKh9s7rjrwFFwsyT5L/EOI1MEyzQZLUTx44+Os6jmRZiR2TX
   bTvceRTjPOMgURiLrRbl09t4aQ90xsgllqYSYUEXylwKD5uAgFbjBUyKh
   gcbNfDEmPgRgX3aTXB3ah1gqn9u/Zf4W4nP/Ow2VxrOpFWG50YVHN1YPw
   psB+v+rooPPMJRdQ507L5ZtWFE3f6T53ABk2UT1CrQWjcQoD7rrRZIBVn
   y5/PrLBm9I8Bgk0/ToTiUamaXixkLWBTAsOGvwZRmQTtuF2sQqd9R/yCO
   A==;
X-CSE-ConnectionGUID: xnW7RO3uRzCUZJR/VTHUCw==
X-CSE-MsgGUID: +fe6PnTQQ2+yhkXgfHRzlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="19997731"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="19997731"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:25:48 -0700
X-CSE-ConnectionGUID: jlGTI0TWSIy3m5QmEkBO8A==
X-CSE-MsgGUID: aD7eD7qbS3u6na4w1qpfeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55094326"
Received: from iweiny-mobl.sc.intel.com (HELO localhost) ([10.144.160.117])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:25:47 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 22 Apr 2024 15:25:46 -0700
Subject: [PATCH v2 2/3] cxl/pci: Process CPER events
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-cxl-cper3-v2-2-5cdd378fcd0b@intel.com>
References: <20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com>
In-Reply-To: <20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713824744; l=2697;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=SwiACezMWqHX266+90+Ge6XaFW19AEBmAf6LpMnB9Ws=;
 b=uf0ksfGSbWSE89yY3i/Es2k7C2JjHr2TSqvW3IjKKx9yeuwHQH94fr9aUtG18HCgWQ9ZLngOZ
 J+TZ2qpZsYRAbmzK/VZCcHSeg6ziCvbc5Bzd2TSOJTNkreKVERerxMr
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

If the firmware has configured CXL event support to be firmware first
the OS will receive those events through CPER records.  The CXL layer has
unique DPA to HPA knowledge and existing event trace parsing in
place.[0]

Add a CXL CPER callback to process CPER events.

[0]
Link: https://lore.kernel.org/all/cover.1711598777.git.alison.schofield@intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[djbw: Clean up error and debug messages]
[iweiny: Clean up commit message]
[iweiny: Add back in after the revert in 6.8]
---
 drivers/cxl/pci.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..c0bc2e994a90 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -974,6 +974,65 @@ static struct pci_driver cxl_pci_driver = {
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
2.44.0


