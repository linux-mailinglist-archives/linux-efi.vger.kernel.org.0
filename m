Return-Path: <linux-efi+bounces-789-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D4876C68
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 22:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29A8281FE3
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B852C5FB8A;
	Fri,  8 Mar 2024 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW7YYjfk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247A5EE96;
	Fri,  8 Mar 2024 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933469; cv=none; b=kd0ZqaCQ/HdueZAOLLO0kjlGOvAX6W+P9t+TDEWZDeydw5Q+NET3N2us/hR+7sfNc94O/JtkClDpNcic2hPfQMzsVgJdlw0yUJeVLuxSr5Nq9Qky2e+/RVqg+Spc/cEaH78UpsqAaRMDlz2ICe+VPZFgXVV84T6eZRLlS7SEs6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933469; c=relaxed/simple;
	bh=BIrlIu35U2rimElEMkh+0WBDV89ooLPXuL5UGm7857c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WqDf+6eDjBhyc77xsJzRG8S60GMdUwk+cR5vS4PxTgu/SNEWgYULthk0Jb/o8iIIhgaiqEBPiPOAPA4NvKdeFfnAL/pKXRsjYLPwp9TiUUcJTmh21PiuO31qXiKybRzjNTlumfonZsZMWIBLFz2+Eq/gMxrgqVw7bW+ORwCZDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW7YYjfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97843C43394;
	Fri,  8 Mar 2024 21:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709933468;
	bh=BIrlIu35U2rimElEMkh+0WBDV89ooLPXuL5UGm7857c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TW7YYjfkc2/7XCq1OsOk4JnkQ2Z4roe/55Aod6b+odn0SZoI1mh5iU4avPdsBAWNJ
	 vKBopD5GVzT90xHrQM+caKjUTuYrTM7tQ+t8f8Rtpg0do1sXZN4uug2ChAwfwUt8oD
	 FYO5MDsYtY3VOSDjGJM9RCJyjHti1KtmK4BjwP7C+HHelSf9pmB/FblcRkwN1JJygS
	 8cvT2c6sCebDAogOn97OZTUAmx5lOItuq5MiswxsqBTwwpFBq4sChVbLa+1RPGMnYF
	 PnJky00JFyo6T5VFhhxyakNMX6h7kcYchNcS/Xl5ww125XNcuXJ7pVUOeybv5tcaQm
	 78wmQeAI82sxA==
Date: Fri, 8 Mar 2024 15:31:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, netdev@vger.kernel.org,
	Oliver O'Halloran <oohall@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/4] PCI: Consolidate TLP Log reading and printing
Message-ID: <20240308213107.GA700934@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206135717.8565-1-ilpo.jarvinen@linux.intel.com>

On Tue, Feb 06, 2024 at 03:57:13PM +0200, Ilpo Järvinen wrote:
> This series consolidates AER & DPC TLP Log handling code. Helpers are
> added for reading and printing the TLP Log and the format is made to
> include E-E Prefixes in both cases (previously only one DPC RP PIO
> displayed the E-E Prefixes).
> 
> I'd appreciate if people familiar with ixgbe could check the error
> handling conversion within the driver is correct.
> 
> Ilpo Järvinen (4):
>   PCI/AER: Cleanup register variable
>   PCI: Generalize TLP Header Log reading

I applied these first two to pci/aer for v6.9, thanks, these are all
nice improvements!

I postponed the ixgbe part for now because I think we should get an
ack from those maintainers or just send it to them since it subtly
changes the error and device removal checking there.

>   PCI: Add TLP Prefix reading into pcie_read_tlp_log()
>   PCI: Create helper to print TLP Header and Prefix Log

I'll respond to these with some minor comments.

>  drivers/firmware/efi/cper.c                   |  4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 39 +++------
>  drivers/pci/ats.c                             |  2 +-
>  drivers/pci/pci.c                             | 79 +++++++++++++++++++
>  drivers/pci/pci.h                             |  2 +-
>  drivers/pci/pcie/aer.c                        | 28 ++-----
>  drivers/pci/pcie/dpc.c                        | 31 ++++----
>  drivers/pci/probe.c                           | 14 ++--
>  include/linux/aer.h                           | 16 ++--
>  include/linux/pci.h                           |  2 +-
>  include/ras/ras_event.h                       | 10 +--
>  include/uapi/linux/pci_regs.h                 |  2 +
>  12 files changed, 145 insertions(+), 84 deletions(-)
> 
> -- 
> 2.39.2
> 

