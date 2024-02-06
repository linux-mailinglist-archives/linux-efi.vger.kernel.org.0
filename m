Return-Path: <linux-efi+bounces-492-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7804E84B721
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 14:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA01287592
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE02132C35;
	Tue,  6 Feb 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGy0LUFo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EEC131E5A;
	Tue,  6 Feb 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227890; cv=none; b=fT73swC6xxPiJSmMu0khByrSLP5za3kpj5aZgo7RwXQajl0YBteKL8/zf9L6Isc/6qyDQ66PRjygI0SeHQWVUIIRKBd2LKNmzftSE7nTBJ8q2BMAljhLwXwDPbbFoYAwlaHT9CKkGYDt4NCBD0iG9MvKVbJonMJ/fAhkUc30jZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227890; c=relaxed/simple;
	bh=eWVd+iQjSnkkATuBAY8oLrtYHKAXW1b0jt18ycqn0UY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ke2t2knIXSRchAdo98sltZ2R9RYT4pT55hTyxOEPbVUNrQYq+2gfcSfOkieHEmVuP28wBv06ljSXBC729bSmak32SekcFuy1wnTmqZS7n6nuI4/vDK/sEZucyN1UNbwVFmHSSkrbGXVxBRVVmsUDbfNo+oMW/gIAzQbg3PHbJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGy0LUFo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707227889; x=1738763889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eWVd+iQjSnkkATuBAY8oLrtYHKAXW1b0jt18ycqn0UY=;
  b=RGy0LUFoawE1U5iUPG+XVNljGjTXJwT3j7jLlV+sDul0IceknsxCGZWV
   FOlyAA78ULx6esvoedyYDkKDVxOWwoRtBegPN+HwsvFwEbslvZYDKkrh7
   BwMJl6cu5Z6LiyX9GHcBoz43edFSoOJPvIbzdmeM/7SwwdOj7xDGy8nWg
   1Z3VGth64w5+DYapdAiIvz7IFZHOKAXPXlqRydPn4Ck9WYFSCGKm2zcio
   T45TIyZ9HxP37kayHaCIYSax3C+g512TCWrB7CFlmyimktTIWxlfz5nMz
   puVm0A9I1csszW9Ci55ekWsLEFmxrpFTUZlV6BlHJJ2iSygQtynWRtCfM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="905272"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="905272"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:58:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1008779"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:58:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/4] PCI: Create helper to print TLP Header and Prefix Log
Date: Tue,  6 Feb 2024 15:57:17 +0200
Message-Id: <20240206135717.8565-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206135717.8565-1-ilpo.jarvinen@linux.intel.com>
References: <20240206135717.8565-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add pcie_print_tlp_log() helper to print TLP Header and Prefix Log.
Print End-End Prefixes only if they are non-zero.

Consolidate the few places which currently print TLP using custom
formatting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 +--
 drivers/pci/pci.c                             | 28 +++++++++++++++++++
 drivers/pci/pcie/aer.c                        | 10 ++-----
 drivers/pci/pcie/dpc.c                        |  5 +---
 include/linux/aer.h                           |  2 ++
 5 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6ce720726a1a..73eabf3215e5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11355,8 +11355,8 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 
 		vf = FIELD_GET(0x7F, req_id);
 		e_dev_err("VF %d has caused a PCIe error\n", vf);
-		e_dev_err("TLP: dw0: %8.8x\tdw1: %8.8x\tdw2: %8.8x\tdw3: %8.8x\n",
-			  tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
+		pcie_print_tlp_log(pdev, &tlp_log, "");
+
 		switch (adapter->hw.mac.type) {
 		case ixgbe_mac_82599EB:
 			device_id = IXGBE_82599_VF_DEVICE_ID;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 268a5b9f1dff..d7974d25ae44 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/array_size.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -1118,6 +1119,33 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 }
 EXPORT_SYMBOL_GPL(pcie_read_tlp_log);
 
+/**
+ * pcie_print_tlp_log - Print TLP Header / Prefix Log contents
+ * @dev:	PCIe device
+ * @tlp_log:	TLP Log structure
+ * @pfx:	Internal string prefix (for indentation)
+ *
+ * Prints TLP Header and Prefix Log information held by @tlp_log.
+ */
+void pcie_print_tlp_log(const struct pci_dev *dev,
+			const struct pcie_tlp_log *tlp_log, const char *pfx)
+{
+	unsigned int i;
+
+	pci_err(dev, "%sTLP Header: %#010x %#010x %#010x %#010x",
+		pfx, tlp_log->dw[0], tlp_log->dw[1], tlp_log->dw[2], tlp_log->dw[3]);
+
+	if (tlp_log->prefix[0])
+		pr_cont(" E-E Prefixes:");
+	for (i = 0; i < ARRAY_SIZE(tlp_log->prefix); i++) {
+		if (!tlp_log->prefix[i])
+			break;
+		pr_cont(" %#010x", tlp_log->prefix[i]);
+	}
+	pr_cont("\n");
+}
+EXPORT_SYMBOL_GPL(pcie_print_tlp_log);
+
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ecc1dea5a208..efb9e728fe94 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -664,12 +664,6 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 	}
 }
 
-static void __print_tlp_header(struct pci_dev *dev, struct pcie_tlp_log *t)
-{
-	pci_err(dev, "  TLP Header: %08x %08x %08x %08x\n",
-		t->dw[0], t->dw[1], t->dw[2], t->dw[3]);
-}
-
 static void __aer_print_error(struct pci_dev *dev,
 			      struct aer_err_info *info)
 {
@@ -724,7 +718,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	__aer_print_error(dev, info);
 
 	if (info->tlp_header_valid)
-		__print_tlp_header(dev, &info->tlp);
+		pcie_print_tlp_log(dev, &info->tlp, "  ");
 
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
@@ -796,7 +790,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 			aer->uncor_severity);
 
 	if (tlp_header_valid)
-		__print_tlp_header(dev, &aer->header_log);
+		pcie_print_tlp_log(dev, &aer->header_log, "  ");
 
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f384d0b02aa0..9c93871fbe37 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -229,10 +229,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
 			  cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
 			  dpc_tlp_log_len(pdev), &tlp_log);
-	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
-		tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
-	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++)
-		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, tlp_log.prefix[i]);
+	pcie_print_tlp_log(pdev, &tlp_log, "");
 
 	if (pdev->dpc_rp_log_size < 5)
 		goto clear_status;
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 9a8845c01400..210f497e7cdd 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -41,6 +41,8 @@ struct aer_capability_regs {
 int pcie_read_tlp_log(struct pci_dev *pdev, int where, int where2,
 		      unsigned int tlp_len, struct pcie_tlp_log *tlp_log);
 unsigned int aer_tlp_log_len(struct pci_dev *dev);
+void pcie_print_tlp_log(const struct pci_dev *dev,
+			const struct pcie_tlp_log *tlp_log, const char *pfx);
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
-- 
2.39.2


