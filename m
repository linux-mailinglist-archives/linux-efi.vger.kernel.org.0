Return-Path: <linux-efi+bounces-491-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8112384B718
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 14:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79B71F272CE
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62543131E49;
	Tue,  6 Feb 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hd35nP10"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2F13175D;
	Tue,  6 Feb 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227881; cv=none; b=DYFsBdePRCc+pIeJ838RgZoDMxnuNqUQ1xvb+UoTjSLbCI6KT0s8elI+Ao1M+5eR/n7QALZw+QwiYvjyYd7Gj18i8zsCrhkbWVrh3fc8oG8uf5N08EeqVGtTLXsZXNL+EYOeuM0ZNzTzaxD6x8FxOwUcvZltxTmX/kkJJbVI6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227881; c=relaxed/simple;
	bh=aYsde3sTVwA8yxr9f8GyAYn7fWOjA+YZlB6N5RztCXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKzB6+ln46HxA4YgylF+GvooMD6/2oK2B7gJAlas4m0XM689YcteIldi1hn2wFScMjaqbI8LdinKzdzDfYXy1Y1jZHQOIaBm39V6CU6r/uGeHtl8/wHTr49KpXLGo8sgMwuu40BEDxIa+twJI+b3OtpY83VTKJ5e9jcIbXtdj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hd35nP10; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707227879; x=1738763879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aYsde3sTVwA8yxr9f8GyAYn7fWOjA+YZlB6N5RztCXs=;
  b=hd35nP108D4V5mR6P+l9ADanKcRxu8WQj7B+q1w3cD2xq7c9RDj4rBcO
   ic16qL+FMeqQHdJwmUSc2BcRfl4l03PQeZ81HbLk4zsq/96odH9ljjM4Y
   rAN9jCTiFgpwED//UkSNn2KLVgzbGDdpAZZ55kljjnKLAGNm9DIItTvnd
   uTPkVE2meMFHNzHc2ia5Osvbt3g/4rBHOFGh46ILlSpRQ6dyUpUn2C75u
   Zjfx8spH8hcvnHdBkHBIGAu0lTnGvEAOEcYDwwfUFNWq9NCh+y/WNYVo6
   /Upiyr5HjA2hMT06kuDXpMimTe9dOePCpcB4WAxjOUiNY394rFgOihnqQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="905244"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="905244"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1008768"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:57:53 -0800
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
Subject: [PATCH 3/4] PCI: Add TLP Prefix reading into pcie_read_tlp_log()
Date: Tue,  6 Feb 2024 15:57:16 +0200
Message-Id: <20240206135717.8565-4-ilpo.jarvinen@linux.intel.com>
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

pcie_read_tlp_log() handles only 4 TLP Header Log DWORDs but TLP Prefix
Log (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.

Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
TLP Prefix Log. The layout of relevant registers in AER and DPC
Capability is not identical but the offsets of TLP Header Log and TLP
Prefix Log vary so the callers must pass the offsets to
pcie_read_tlp_log().

Convert eetlp_prefix_path into integer called eetlp_prefix_max and
make is available also when CONFIG_PCI_PASID is not configured to
be able to determine the number of E-E Prefixes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 +-
 drivers/pci/ats.c                             |  2 +-
 drivers/pci/pci.c                             | 37 ++++++++++++++++---
 drivers/pci/pcie/aer.c                        |  4 +-
 drivers/pci/pcie/dpc.c                        | 22 +++++++----
 drivers/pci/probe.c                           | 14 ++++---
 include/linux/aer.h                           |  5 ++-
 include/linux/pci.h                           |  2 +-
 include/uapi/linux/pci_regs.h                 |  2 +
 9 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5fdf37968b2d..6ce720726a1a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11336,7 +11336,9 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 	if (!pos)
 		goto skip_bad_vf_detection;
 
-	ret = pcie_read_tlp_log(pdev, pos + PCI_ERR_HEADER_LOG, &tlp_log);
+	ret = pcie_read_tlp_log(pdev, pos + PCI_ERR_HEADER_LOG,
+				pos + PCI_ERR_PREFIX_LOG,
+				aer_tlp_log_len(pdev), &tlp_log);
 	if (ret < 0) {
 		ixgbe_check_cfg_remove(hw, pdev);
 		goto skip_bad_vf_detection;
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c570892b2090..e13433dcfc82 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -377,7 +377,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
+	if (!pdev->eetlp_prefix_max && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0152f0144eec..268a5b9f1dff 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1068,23 +1068,48 @@ static void pci_enable_acs(struct pci_dev *dev)
 }
 
 /**
- * pcie_read_tlp_log - Reads TLP Header Log
+ * aer_tlp_log_len - Calculates TLP Header/Prefix Log length
+ * @dev:	PCIe device
+ *
+ * Return: TLP Header/Prefix Log length
+ */
+unsigned int aer_tlp_log_len(struct pci_dev *dev)
+{
+	return 4 + dev->eetlp_prefix_max;
+}
+EXPORT_SYMBOL_GPL(aer_tlp_log_len);
+
+/**
+ * pcie_read_tlp_log - Reads TLP Header and Prefix Log
  * @dev:	PCIe device
  * @where:	PCI Config offset of TLP Header Log
+ * @where2:	PCI Config offset of TLP Prefix Log
+ * @tlp_len:	TLP Log length (in DWORDs)
  * @tlp_log:	TLP Log structure to fill
  *
- * Fills @tlp_log from TLP Header Log registers.
+ * Fills @tlp_log from TLP Header and Prefix Log registers.
  *
  * Return: 0 on success and filled TLP Log structure, <0 on error.
  */
-int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *tlp_log)
+int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
+		      unsigned int tlp_len, struct pcie_tlp_log *tlp_log)
 {
-	int i, ret;
+	unsigned int i;
+	int off, ret;
+	u32 *to;
 
 	memset(tlp_log, 0, sizeof(*tlp_log));
 
-	for (i = 0; i < 4; i++) {
-		ret = pci_read_config_dword(dev, where + i * 4, &tlp_log->dw[i]);
+	for (i = 0; i < tlp_len; i++) {
+		if (i < 4) {
+			to = &tlp_log->dw[i];
+			off = where + i * 4;
+		} else {
+			to = &tlp_log->prefix[i - 4];
+			off = where2 + (i - 4) * 4;
+		}
+
+		ret = pci_read_config_dword(dev, off, to);
 		if (ret)
 			return pcibios_err_to_errno(ret);
 	}
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ac6293c24976..ecc1dea5a208 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1245,7 +1245,9 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 
 		if (info->status & AER_LOG_TLP_MASKS) {
 			info->tlp_header_valid = 1;
-			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG, &info->tlp);
+			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
+					  aer + PCI_ERR_PREFIX_LOG,
+					  aer_tlp_log_len(dev), &info->tlp);
 		}
 	}
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index d62d2da872c1..f384d0b02aa0 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -187,10 +187,19 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	return ret;
 }
 
+static unsigned int dpc_tlp_log_len(struct pci_dev *pdev)
+{
+	/* Remove ImpSpec Log register from the count */
+	if (pdev->dpc_rp_log_size >= 5)
+		return pdev->dpc_rp_log_size - 1;
+
+	return pdev->dpc_rp_log_size;
+}
+
 static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 {
 	u16 cap = pdev->dpc_cap, dpc_status, first_error;
-	u32 status, mask, sev, syserr, exc, log, prefix;
+	u32 status, mask, sev, syserr, exc, log;
 	struct pcie_tlp_log tlp_log;
 	int i;
 
@@ -217,20 +226,19 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	if (pdev->dpc_rp_log_size < 4)
 		goto clear_status;
-	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG, &tlp_log);
+	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
+			  cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
+			  dpc_tlp_log_len(pdev), &tlp_log);
 	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
 		tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
+	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++)
+		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, tlp_log.prefix[i]);
 
 	if (pdev->dpc_rp_log_size < 5)
 		goto clear_status;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
 	pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);
 
-	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
-		pci_read_config_dword(pdev,
-			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
-		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
-	}
  clear_status:
 	pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, status);
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b7335be56008..7a57b37e4f20 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2272,8 +2272,8 @@ static void pci_configure_ltr(struct pci_dev *dev)
 
 static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 {
-#ifdef CONFIG_PCI_PASID
 	struct pci_dev *bridge;
+	unsigned int eetlp_max;
 	int pcie_type;
 	u32 cap;
 
@@ -2285,15 +2285,19 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 		return;
 
 	pcie_type = pci_pcie_type(dev);
+
+	eetlp_max = FIELD_GET(PCI_EXP_DEVCAP2_EE_PREFIX_MAX, cap);
+	/* 00b means 4 */
+	eetlp_max = eetlp_max ?: 4;
+
 	if (pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
 	    pcie_type == PCI_EXP_TYPE_RC_END)
-		dev->eetlp_prefix_path = 1;
+		dev->eetlp_prefix_max = eetlp_max;
 	else {
 		bridge = pci_upstream_bridge(dev);
-		if (bridge && bridge->eetlp_prefix_path)
-			dev->eetlp_prefix_path = 1;
+		if (bridge && bridge->eetlp_prefix_max)
+			dev->eetlp_prefix_max = eetlp_max;
 	}
-#endif
 }
 
 static void pci_configure_serr(struct pci_dev *dev)
diff --git a/include/linux/aer.h b/include/linux/aer.h
index c0df7790c82d..9a8845c01400 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -20,6 +20,7 @@ struct pci_dev;
 
 struct pcie_tlp_log {
 	u32 dw[4];
+	u32 prefix[4];
 };
 
 struct aer_capability_regs {
@@ -37,7 +38,9 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
-int pcie_read_tlp_log(struct pci_dev *pdev, int where, struct pcie_tlp_log *tlp_log);
+int pcie_read_tlp_log(struct pci_dev *pdev, int where, int where2,
+		      unsigned int tlp_len, struct pcie_tlp_log *tlp_log);
+unsigned int aer_tlp_log_len(struct pci_dev *dev);
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index add9368e6314..dca7fbcfdb33 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -397,7 +397,7 @@ struct pci_dev {
 					   supported from root to here */
 #endif
 	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
-	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
+	unsigned int	eetlp_prefix_max:3;	/* Max # of End-to-End TLP Prefix, 0=not supported */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
 	struct device	dev;			/* Generic device interface */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..cf7a07fa4a3b 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -661,6 +661,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
 #define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
+#define  PCI_EXP_DEVCAP2_EE_PREFIX_MAX	0x00c00000 /* Max End-End TLP Prefixes */
 #define PCI_EXP_DEVCTL2		0x28	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
@@ -802,6 +803,7 @@
 #define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
 #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
 #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
+#define PCI_ERR_PREFIX_LOG	0x38	/* TLP Prefix LOG Register (up to 16 bytes) */
 
 /* Virtual Channel */
 #define PCI_VC_PORT_CAP1	0x04
-- 
2.39.2


