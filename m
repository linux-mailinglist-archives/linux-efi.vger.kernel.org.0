Return-Path: <linux-efi+bounces-490-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B51084B715
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 14:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD810B2890E
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B832131E3C;
	Tue,  6 Feb 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgO09+4W"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FB131E39;
	Tue,  6 Feb 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227871; cv=none; b=qmL4qKkCbYvC/qgRYFpMePeGGPnN6COPC5hmx5RCbcMKgBgupc8vJo7E6d7xySgWyZoxQpDMUBjM0KickRBVUyAet8KdVzE9Ec5Q8WCn9ecELuP5m9iONtckMRyVqyo9ehb/Zc6l1EJ5AQMqlsBc+Sxc2JwfcI0V2RhdnUyJJew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227871; c=relaxed/simple;
	bh=v9j+MTAa02s+PFccgXj2ISf0d4FR61XRjw7H46tP6n8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0HvPGAxdoBJZkH/iqal5In6XUlD0Qqr0/be+62zywnQfEFprOIihxyTmCiO6pkJt0jF8yTPmG/RRYQnVp8BO2MMB25ag3GyyFO0hJ7KHpgVbTJE44382cX5wHNpLM7qSSyNPzB0liSW5rmdce0jONHwA9c1A/j80bMwc5vZI9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgO09+4W; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707227870; x=1738763870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v9j+MTAa02s+PFccgXj2ISf0d4FR61XRjw7H46tP6n8=;
  b=mgO09+4WH9Bk2OnyGTX3sYkfSY40a64qFfwmXStkh6vJiaQPzPJnXCgd
   +getA9PXYyUBYl2Csli/yGukWBjYrIZJ4kE2ImOAN9eK7lGdXnGKx18fk
   5/2aLqbjFfxyVQ3Jg9tJfWnxyfi2whrvqg++ivbva5Ex4GtsMpX4l2J98
   pf6Qrq+FNrdPyXB3epp8yW7k6WXOSVdVz6WLVYrLVvOCXwT0zCfqLqafO
   pR8yZdeUmsPAvVHUSYkfIL/e9bRh9x/0T3XicNsf0762K3Cnp49zzarz6
   p0rKqt9Djlcv6/bPo5GqJYlwNfGcYVHls2wbW0V7mYhCMJ2hx94+qjilf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="905215"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="905215"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1008758"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:57:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-edac@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/4] PCI: Generalize TLP Header Log reading
Date: Tue,  6 Feb 2024 15:57:15 +0200
Message-Id: <20240206135717.8565-3-ilpo.jarvinen@linux.intel.com>
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

Both AER and DPC RP PIO provide TLP Header Log registers (PCIe r6.1
secs 7.8.4 & 7.9.14) to convey error diagnostics but the struct is
named after AER as the struct aer_header_log_regs. Also, not all places
that handle TLP Header Log use the struct and the struct members are
named individually.

Generalize the struct name and members, and use it consistently where
TLP Header Log is being handled so that a pcie_read_tlp_log() helper
can be easily added.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/firmware/efi/cper.c                   |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 37 +++++--------------
 drivers/pci/pci.c                             | 26 +++++++++++++
 drivers/pci/pci.h                             |  2 +-
 drivers/pci/pcie/aer.c                        | 14 ++-----
 drivers/pci/pcie/dpc.c                        | 14 ++-----
 include/linux/aer.h                           | 11 +++---
 include/ras/ras_event.h                       | 10 ++---
 8 files changed, 56 insertions(+), 62 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..d3f98161171e 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -445,8 +445,8 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk("%saer_uncor_severity: 0x%08x\n",
 		       pfx, aer->uncor_severity);
 		printk("%sTLP Header: %08x %08x %08x %08x\n", pfx,
-		       aer->header_log.dw0, aer->header_log.dw1,
-		       aer->header_log.dw2, aer->header_log.dw3);
+		       aer->header_log.dw[0], aer->header_log.dw[1],
+		       aer->header_log.dw[2], aer->header_log.dw[3]);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bd541527c8c7..5fdf37968b2d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 1999 - 2018 Intel Corporation. */
 
+#include <linux/aer.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -391,22 +392,6 @@ u16 ixgbe_read_pci_cfg_word(struct ixgbe_hw *hw, u32 reg)
 	return value;
 }
 
-#ifdef CONFIG_PCI_IOV
-static u32 ixgbe_read_pci_cfg_dword(struct ixgbe_hw *hw, u32 reg)
-{
-	struct ixgbe_adapter *adapter = hw->back;
-	u32 value;
-
-	if (ixgbe_removed(hw->hw_addr))
-		return IXGBE_FAILED_READ_CFG_DWORD;
-	pci_read_config_dword(adapter->pdev, reg, &value);
-	if (value == IXGBE_FAILED_READ_CFG_DWORD &&
-	    ixgbe_check_cfg_remove(hw, adapter->pdev))
-		return IXGBE_FAILED_READ_CFG_DWORD;
-	return value;
-}
-#endif /* CONFIG_PCI_IOV */
-
 void ixgbe_write_pci_cfg_word(struct ixgbe_hw *hw, u32 reg, u16 value)
 {
 	struct ixgbe_adapter *adapter = hw->back;
@@ -11332,8 +11317,8 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 #ifdef CONFIG_PCI_IOV
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct pci_dev *bdev, *vfdev;
-	u32 dw0, dw1, dw2, dw3;
-	int vf, pos;
+	struct pcie_tlp_log tlp_log;
+	int vf, pos, ret;
 	u16 req_id, pf_func;
 
 	if (adapter->hw.mac.type == ixgbe_mac_82598EB ||
@@ -11351,14 +11336,13 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 	if (!pos)
 		goto skip_bad_vf_detection;
 
-	dw0 = ixgbe_read_pci_cfg_dword(hw, pos + PCI_ERR_HEADER_LOG);
-	dw1 = ixgbe_read_pci_cfg_dword(hw, pos + PCI_ERR_HEADER_LOG + 4);
-	dw2 = ixgbe_read_pci_cfg_dword(hw, pos + PCI_ERR_HEADER_LOG + 8);
-	dw3 = ixgbe_read_pci_cfg_dword(hw, pos + PCI_ERR_HEADER_LOG + 12);
-	if (ixgbe_removed(hw->hw_addr))
+	ret = pcie_read_tlp_log(pdev, pos + PCI_ERR_HEADER_LOG, &tlp_log);
+	if (ret < 0) {
+		ixgbe_check_cfg_remove(hw, pdev);
 		goto skip_bad_vf_detection;
+	}
 
-	req_id = dw1 >> 16;
+	req_id = tlp_log.dw[1] >> 16;
 	/* On the 82599 if bit 7 of the requestor ID is set then it's a VF */
 	if (!(req_id & 0x0080))
 		goto skip_bad_vf_detection;
@@ -11369,9 +11353,8 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 
 		vf = FIELD_GET(0x7F, req_id);
 		e_dev_err("VF %d has caused a PCIe error\n", vf);
-		e_dev_err("TLP: dw0: %8.8x\tdw1: %8.8x\tdw2: "
-				"%8.8x\tdw3: %8.8x\n",
-		dw0, dw1, dw2, dw3);
+		e_dev_err("TLP: dw0: %8.8x\tdw1: %8.8x\tdw2: %8.8x\tdw3: %8.8x\n",
+			  tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
 		switch (adapter->hw.mac.type) {
 		case ixgbe_mac_82599EB:
 			device_id = IXGBE_82599_VF_DEVICE_ID;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..0152f0144eec 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1067,6 +1067,32 @@ static void pci_enable_acs(struct pci_dev *dev)
 	pci_disable_acs_redir(dev);
 }
 
+/**
+ * pcie_read_tlp_log - Reads TLP Header Log
+ * @dev:	PCIe device
+ * @where:	PCI Config offset of TLP Header Log
+ * @tlp_log:	TLP Log structure to fill
+ *
+ * Fills @tlp_log from TLP Header Log registers.
+ *
+ * Return: 0 on success and filled TLP Log structure, <0 on error.
+ */
+int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *tlp_log)
+{
+	int i, ret;
+
+	memset(tlp_log, 0, sizeof(*tlp_log));
+
+	for (i = 0; i < 4; i++) {
+		ret = pci_read_config_dword(dev, where + i * 4, &tlp_log->dw[i]);
+		if (ret)
+			return pcibios_err_to_errno(ret);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcie_read_tlp_log);
+
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2336a8d1edab..a59ba6fde2a0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -409,7 +409,7 @@ struct aer_err_info {
 
 	unsigned int status;		/* COR/UNCOR Error Status */
 	unsigned int mask;		/* COR/UNCOR Error Mask */
-	struct aer_header_log_regs tlp;	/* TLP Header */
+	struct pcie_tlp_log tlp;	/* TLP Header */
 };
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e31e6a9a7773..ac6293c24976 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -664,11 +664,10 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 	}
 }
 
-static void __print_tlp_header(struct pci_dev *dev,
-			       struct aer_header_log_regs *t)
+static void __print_tlp_header(struct pci_dev *dev, struct pcie_tlp_log *t)
 {
 	pci_err(dev, "  TLP Header: %08x %08x %08x %08x\n",
-		t->dw0, t->dw1, t->dw2, t->dw3);
+		t->dw[0], t->dw[1], t->dw[2], t->dw[3]);
 }
 
 static void __aer_print_error(struct pci_dev *dev,
@@ -1246,14 +1245,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 
 		if (info->status & AER_LOG_TLP_MASKS) {
 			info->tlp_header_valid = 1;
-			pci_read_config_dword(dev,
-				aer + PCI_ERR_HEADER_LOG, &info->tlp.dw0);
-			pci_read_config_dword(dev,
-				aer + PCI_ERR_HEADER_LOG + 4, &info->tlp.dw1);
-			pci_read_config_dword(dev,
-				aer + PCI_ERR_HEADER_LOG + 8, &info->tlp.dw2);
-			pci_read_config_dword(dev,
-				aer + PCI_ERR_HEADER_LOG + 12, &info->tlp.dw3);
+			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG, &info->tlp);
 		}
 	}
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e5d7c12854fa..d62d2da872c1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -190,7 +190,8 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 {
 	u16 cap = pdev->dpc_cap, dpc_status, first_error;
-	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix;
+	u32 status, mask, sev, syserr, exc, log, prefix;
+	struct pcie_tlp_log tlp_log;
 	int i;
 
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, &status);
@@ -216,16 +217,9 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	if (pdev->dpc_rp_log_size < 4)
 		goto clear_status;
-	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
-			      &dw0);
-	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 4,
-			      &dw1);
-	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 8,
-			      &dw2);
-	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
-			      &dw3);
+	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG, &tlp_log);
 	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
-		dw0, dw1, dw2, dw3);
+		tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
 
 	if (pdev->dpc_rp_log_size < 5)
 		goto clear_status;
diff --git a/include/linux/aer.h b/include/linux/aer.h
index ae0fae70d4bd..c0df7790c82d 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -18,11 +18,8 @@
 
 struct pci_dev;
 
-struct aer_header_log_regs {
-	u32 dw0;
-	u32 dw1;
-	u32 dw2;
-	u32 dw3;
+struct pcie_tlp_log {
+	u32 dw[4];
 };
 
 struct aer_capability_regs {
@@ -33,13 +30,15 @@ struct aer_capability_regs {
 	u32 cor_status;
 	u32 cor_mask;
 	u32 cap_control;
-	struct aer_header_log_regs header_log;
+	struct pcie_tlp_log header_log;
 	u32 root_command;
 	u32 root_status;
 	u16 cor_err_source;
 	u16 uncor_err_source;
 };
 
+int pcie_read_tlp_log(struct pci_dev *pdev, int where, struct pcie_tlp_log *tlp_log);
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index cbd3ddd7c33d..c011ea236e9b 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -300,7 +300,7 @@ TRACE_EVENT(aer_event,
 		 const u32 status,
 		 const u8 severity,
 		 const u8 tlp_header_valid,
-		 struct aer_header_log_regs *tlp),
+		 struct pcie_tlp_log *tlp),
 
 	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
 
@@ -318,10 +318,10 @@ TRACE_EVENT(aer_event,
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
 		if (tlp_header_valid) {
-			__entry->tlp_header[0] = tlp->dw0;
-			__entry->tlp_header[1] = tlp->dw1;
-			__entry->tlp_header[2] = tlp->dw2;
-			__entry->tlp_header[3] = tlp->dw3;
+			__entry->tlp_header[0] = tlp->dw[0];
+			__entry->tlp_header[1] = tlp->dw[1];
+			__entry->tlp_header[2] = tlp->dw[2];
+			__entry->tlp_header[3] = tlp->dw[3];
 		}
 	),
 
-- 
2.39.2


