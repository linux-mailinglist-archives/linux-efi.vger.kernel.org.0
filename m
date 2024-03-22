Return-Path: <linux-efi+bounces-859-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2098873EF
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 20:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0961C227EB
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32D7A15E;
	Fri, 22 Mar 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI4W6i26"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7787A157;
	Fri, 22 Mar 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135813; cv=none; b=giOnuV2bUfdRzRm399Re2dvoBREVgcfnEo5Tv9xeGUu7i5emumD1erKCPKu33RHL2aXQuABPdX2hpu2IFmKp4rYJRFT/Pm5REQ0yQc2GrCEIZ5JsGxZxuWKeWF8tchpfEwsPTmq+nVpJEGc/fLCWIDrvpx0DVt4ID1jRe79t/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135813; c=relaxed/simple;
	bh=9R6ki8LkQLAWyMMmV+81/0KXBdxdkaUt91oUyJxHRXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IYiU374NgAm5WgNqJKJUa0icEVzud0W4KOGo5y5dGAGfSCB9pcJ/G02TB71+Uk9ygIdUaQfIBo2ikyZyPUEdqVIXHFPIkT9bJRcdl+CehvksJCft5MmyW+alRyMYOv9yoCEdxO+hR9QsBTTXXKfY5xfLxtxAJvylCD2EO2G00Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI4W6i26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D41C433F1;
	Fri, 22 Mar 2024 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711135813;
	bh=9R6ki8LkQLAWyMMmV+81/0KXBdxdkaUt91oUyJxHRXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GI4W6i26GH4YKoxcLI7lQ8yf1CYz3gnsVS5q/50obT5c+RAjHWdIx+1+1fcYFuMSK
	 z7tq2Hy8gsByyk1C6HLUmIdEjEMjPlAEd5SPyoRNSsS1HUrAS8NtMtMQaTjVj8XtIP
	 GfI5wwIhfK2ZdvFH8yfESIP4RXcrOtJGRVvTmGJafpDdRsj5RvAbXWu2XtvMvItr/Z
	 Zoq9QazCmln///YbTsHQqQmawt8pLZ8s+57149iivVTAWIDAH/W5Cm1wZubwMH+tEE
	 0i08O00EIoJelk5Ubc024aZSDXEmpIUnVRa35wSfyaEC/x0wB3d6Rabg6Z8TigwMBO
	 GVbz6krwT5hCg==
Date: Fri, 22 Mar 2024 14:30:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 3/4] PCI: Add TLP Prefix reading into pcie_read_tlp_log()
Message-ID: <20240322193011.GA701027@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206135717.8565-4-ilpo.jarvinen@linux.intel.com>

On Tue, Feb 06, 2024 at 03:57:16PM +0200, Ilpo Järvinen wrote:
> pcie_read_tlp_log() handles only 4 TLP Header Log DWORDs but TLP Prefix
> Log (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.

s/TLP Header Log/Header Log/ to match spec terminology (also below)

> Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
> TLP Prefix Log. The layout of relevant registers in AER and DPC
> Capability is not identical but the offsets of TLP Header Log and TLP
> Prefix Log vary so the callers must pass the offsets to
> pcie_read_tlp_log().

s/is not identical but/is identical, but/ ?

The spec is a little obtuse about Header Log Size.

> Convert eetlp_prefix_path into integer called eetlp_prefix_max and
> make is available also when CONFIG_PCI_PASID is not configured to
> be able to determine the number of E-E Prefixes.

I think this eetlp_prefix_path piece is right, but would be nice in a
separate patch since it's a little bit different piece to review.

> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -11336,7 +11336,9 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
>  	if (!pos)
>  		goto skip_bad_vf_detection;
>  
> -	ret = pcie_read_tlp_log(pdev, pos + PCI_ERR_HEADER_LOG, &tlp_log);
> +	ret = pcie_read_tlp_log(pdev, pos + PCI_ERR_HEADER_LOG,
> +				pos + PCI_ERR_PREFIX_LOG,
> +				aer_tlp_log_len(pdev), &tlp_log);
>  	if (ret < 0) {
>  		ixgbe_check_cfg_remove(hw, pdev);
>  		goto skip_bad_vf_detection;

We applied the patch to export pcie_read_tlp_log(), but I'm having
second thoughts about it.   I don't think drivers really have any
business here, and I'd rather not expose either pcie_read_tlp_log() or
aer_tlp_log_len().

This part of ixgbe_io_error_detected() was added by 83c61fa97a7d
("ixgbe: Add protection from VF invalid target DMA"), and to me it
looks like debug code that probably doesn't need to be there as long
as the PCI core does the appropriate logging.

Bjorn

