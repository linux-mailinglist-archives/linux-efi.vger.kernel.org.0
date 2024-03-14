Return-Path: <linux-efi+bounces-813-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744D987C1FB
	for <lists+linux-efi@lfdr.de>; Thu, 14 Mar 2024 18:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5B4283285
	for <lists+linux-efi@lfdr.de>; Thu, 14 Mar 2024 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007EF745FA;
	Thu, 14 Mar 2024 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLCoITag"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DD7745EF;
	Thu, 14 Mar 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436573; cv=none; b=pa5eWWCTUVu23gIu9DLdzyelcGH3Rdm1Spjc+ExPpMzA7qTQbSxpnT4ofO1PC+fKVGud2yCg/OcnzAPTGIxZLgYKdvQai7IXBJDjmsP8u4hjkoATW3L+5MqQtmISZrzIG5JJic7o6/yRIIYStNaGPevFBvJu2HA2R5AOvLScq74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436573; c=relaxed/simple;
	bh=L79tdLUwzaaRgRXL97CbprC3UX8xdukYNWJfNJ9rn8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eBmoVrhdHceeTiln6lyCinqE3bVDfq996CBG3VRinT4YLK99VnL1K/ar3uGeh3607Mr4uFXuNS8PTw4inT/hP6rfpCTCPQrJbTLfwqUY8204avPwyGdVzJURS7mhGENp4R3RFFBpd7SzKVEowT2uoM0UylC9mg0an/i43m3HP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLCoITag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C6BC433F1;
	Thu, 14 Mar 2024 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710436573;
	bh=L79tdLUwzaaRgRXL97CbprC3UX8xdukYNWJfNJ9rn8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bLCoITag/SuEtTrsO/sMEjHd4BnWeVtJvXB6210xjO0cdkxYMA8vA1JIb6pEd2Kfy
	 Id8hEuP4GShaNC+PpogaxARWBhxMId5O2Cie8lL7/14MzwoABw+v7vAtpZtvsqvwVm
	 j+7ReyKeR/gEjByLQxpMlRsVYXDEGyGeHFdCK6t+sjpJtjaZP9s/5wAN9lzVmWJr7r
	 pLa+CQidixlNP3GHezj2k/ubGEQYBhmB8PMTnGZbFPbhqQ4aFXAmuJp6RUqrSv3XnA
	 050p8/o022AJfkYOdhHhi7dvoS2VTcsuMhDFAH55Xucdvzdz4Rqw4PKJtaUCOfiv+R
	 zUf5Dv5K5Grxg==
Date: Thu, 14 Mar 2024 12:16:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-edac@vger.kernel.org, Greg Rose <gvrose8192@gmail.com>,
	Jeff Kirsher <tarbal@gmail.com>
Subject: Re: [PATCH 2/4] PCI: Generalize TLP Header Log reading
Message-ID: <20240314171611.GA958323@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206135717.8565-3-ilpo.jarvinen@linux.intel.com>

[+cc Greg, Jeff -- ancient history, I know, sorry!]

On Tue, Feb 06, 2024 at 03:57:15PM +0200, Ilpo Järvinen wrote:
> Both AER and DPC RP PIO provide TLP Header Log registers (PCIe r6.1
> secs 7.8.4 & 7.9.14) to convey error diagnostics but the struct is
> named after AER as the struct aer_header_log_regs. Also, not all places
> that handle TLP Header Log use the struct and the struct members are
> named individually.
> 
> Generalize the struct name and members, and use it consistently where
> TLP Header Log is being handled so that a pcie_read_tlp_log() helper
> can be easily added.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index bd541527c8c7..5fdf37968b2d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 1999 - 2018 Intel Corporation. */
>  
> +#include <linux/aer.h>
>  #include <linux/types.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -391,22 +392,6 @@ u16 ixgbe_read_pci_cfg_word(struct ixgbe_hw *hw, u32 reg)
>  	return value;
>  }
>  
> -#ifdef CONFIG_PCI_IOV
> -static u32 ixgbe_read_pci_cfg_dword(struct ixgbe_hw *hw, u32 reg)
> -{
> -	struct ixgbe_adapter *adapter = hw->back;
> -	u32 value;
> -
> -	if (ixgbe_removed(hw->hw_addr))
> -		return IXGBE_FAILED_READ_CFG_DWORD;
> -	pci_read_config_dword(adapter->pdev, reg, &value);
> -	if (value == IXGBE_FAILED_READ_CFG_DWORD &&
> -	    ixgbe_check_cfg_remove(hw, adapter->pdev))
> -		return IXGBE_FAILED_READ_CFG_DWORD;
> -	return value;
> -}
> -#endif /* CONFIG_PCI_IOV */
> -
>  void ixgbe_write_pci_cfg_word(struct ixgbe_hw *hw, u32 reg, u16 value)
>  {
>  	struct ixgbe_adapter *adapter = hw->back;
> @@ -11332,8 +11317,8 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
>  #ifdef CONFIG_PCI_IOV
>  	struct ixgbe_hw *hw = &adapter->hw;
>  	struct pci_dev *bdev, *vfdev;
> -	u32 dw0, dw1, dw2, dw3;
> -	int vf, pos;
> +	struct pcie_tlp_log tlp_log;
> +	int vf, pos, ret;
>  	u16 req_id, pf_func;
>  
>  	if (adapter->hw.mac.type == ixgbe_mac_82598EB ||
> @@ -11351,14 +11336,13 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
>  	if (!pos)
>  		goto skip_bad_vf_detection;
>  
> -	dw0 = ixgbe_read_pci_cfg_dword(hw, pos + PCI_ERR_HEADER_LOG);
> -	dw1 = ixgbe_read_pci_cfg_dword(hw, pos + PCI_ERR_HEADER_LOG + 4);
> -	dw2 = ixgbe_read_pci_cfg_dword(hw, pos + PCI_ERR_HEADER_LOG + 8);
> -	dw3 = ixgbe_read_pci_cfg_dword(hw, pos + PCI_ERR_HEADER_LOG + 12);
> -	if (ixgbe_removed(hw->hw_addr))
> +	ret = pcie_read_tlp_log(pdev, pos + PCI_ERR_HEADER_LOG, &tlp_log);
> +	if (ret < 0) {
> +		ixgbe_check_cfg_remove(hw, pdev);
>  		goto skip_bad_vf_detection;
> +	}
>  
> -	req_id = dw1 >> 16;
> +	req_id = tlp_log.dw[1] >> 16;
>  	/* On the 82599 if bit 7 of the requestor ID is set then it's a VF */
>  	if (!(req_id & 0x0080))
>  		goto skip_bad_vf_detection;
> @@ -11369,9 +11353,8 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
>  
>  		vf = FIELD_GET(0x7F, req_id);
>  		e_dev_err("VF %d has caused a PCIe error\n", vf);
> -		e_dev_err("TLP: dw0: %8.8x\tdw1: %8.8x\tdw2: "
> -				"%8.8x\tdw3: %8.8x\n",
> -		dw0, dw1, dw2, dw3);
> +		e_dev_err("TLP: dw0: %8.8x\tdw1: %8.8x\tdw2: %8.8x\tdw3: %8.8x\n",
> +			  tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
>  		switch (adapter->hw.mac.type) {
>  		case ixgbe_mac_82599EB:
>  			device_id = IXGBE_82599_VF_DEVICE_ID;

The rest of this patch is headed for v6.10, but I dropped this ixgbe
change for now.

These TLP Log registers are generic, not device-specific, and if
there's something lacking in the PCI core that leads to ixgbe reading
and dumping them itself, I'd rather improve the PCI core so all
drivers will benefit without having to add code like this.

83c61fa97a7d ("ixgbe: Add protection from VF invalid target DMA") [1]
added the ixgbe TLP Log dumping way back in v3.2 (2012).  It does do
some device-specific VF checking and so on, but even back then, it
looks like the PCI core would have dumped the log itself [2], so I
don't know why we needed the extra dumping in ixgbe.

So what I'd really like is to remove the TLP Log reading and printing
from ixgbe completely, but keep the VF checking.

Bjorn

[1] https://git.kernel.org/linus/83c61fa97a7d
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/aer/aerdrv_errprint.c?id=83c61fa97a7d#n181

