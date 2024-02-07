Return-Path: <linux-efi+bounces-494-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E29984C9EF
	for <lists+linux-efi@lfdr.de>; Wed,  7 Feb 2024 12:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105D81F25C47
	for <lists+linux-efi@lfdr.de>; Wed,  7 Feb 2024 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982501B7FF;
	Wed,  7 Feb 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6Wu6pno"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78181D525;
	Wed,  7 Feb 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306652; cv=none; b=PuC4UoJrIip7A6X7+dOyGA5tF/hkLqyxYCdKAtZ6ZJXW+6IH8aJ8skxiURgKSGQ5vbeHkXIXgsIjMu+c0XFSyvHSGqeiRAhLOrl+OCUB4v8hLli2lgFrH4HHwx5Q3odC37hbuWf9v4q2KR4NdH8jLfryVzccgeGN8wkpo0tyvcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306652; c=relaxed/simple;
	bh=SfvJn+xoupBR1MbkXFoDnA5hLXb3/g/1CcV8cOlXD/A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WZW8MG3XeH3TMiXgw10eaJRkwKploy7wNFKikXB/icvEZ5WUdhIOZEYP1M19EYNJCN5RonR9GhPOqOYLP3/rBcemNPEa0piFGok/nFAV1Yh1kYC/XoQ9dvYM/OZXLLfRNhj2mIcjq1k7TRvOfhCwKtFF177P3lC5dR7jkx5aDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6Wu6pno; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707306651; x=1738842651;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=SfvJn+xoupBR1MbkXFoDnA5hLXb3/g/1CcV8cOlXD/A=;
  b=Y6Wu6pnom9XLv6poGlDiUWQsebH+Dk2elTYCJDQzn3C8DC7ZvXyiHmw5
   yobsVvVo8LysAr9PllLlEbmlFK0ipHXwjPHdvOimsaWtILkwFEV1osbHM
   V1YTvfQJLtH4ScELhVy9wRdhogHLfIT6bMONwwjB1QcUPtroN7l5BlcaS
   oLjcflRgYAqzeoophCcahRcxi/DnkSdOvpZqoI/+ZPVPrpjxewKSIv19K
   TTv0IqubjZa9V3orFBAtyE7PJcN1H5MNakjo1sZJr4uVGZwhSLv7AXT5M
   1hV4HZP74SThZU5OWmJSSzYITj3rhvGnarjK8ILnyr30g92TAhrUxWksF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4837019"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="4837019"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 03:50:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="909976005"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="909976005"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.96])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 03:50:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 7 Feb 2024 13:50:37 +0200 (EET)
To: linux-pci@vger.kernel.org, 
    "Wang, Qingshun" <qingshun.wang@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Jesse Brandeburg <jesse.brandeburg@intel.com>, 
    intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
    Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    linux-edac@vger.kernel.org, linux-efi@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Netdev <netdev@vger.kernel.org>, Oliver O'Halloran <oohall@gmail.com>, 
    Paolo Abeni <pabeni@redhat.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/4] PCI: Consolidate TLP Log reading and printing
In-Reply-To: <20240206135717.8565-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <d1168e4a-c766-b3c2-bb74-c8dbae984cff@linux.intel.com>
References: <20240206135717.8565-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2015099635-1707302934=:1119"
Content-ID: <ca89eb14-5052-c712-0d3b-dae8e97234e8@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2015099635-1707302934=:1119
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <5d24dca6-e3dc-f4f5-8d6c-ee0d65616a2f@linux.intel.com>

Adding Cc Quigshun which I ended up forgotting despite thinking it at one=
=20
point.

--=20
 i.

On Tue, 6 Feb 2024, Ilpo J=E4rvinen wrote:

> This series consolidates AER & DPC TLP Log handling code. Helpers are
> added for reading and printing the TLP Log and the format is made to
> include E-E Prefixes in both cases (previously only one DPC RP PIO
> displayed the E-E Prefixes).
>=20
> I'd appreciate if people familiar with ixgbe could check the error
> handling conversion within the driver is correct.
>=20
> Ilpo J=E4rvinen (4):
>   PCI/AER: Cleanup register variable
>   PCI: Generalize TLP Header Log reading
>   PCI: Add TLP Prefix reading into pcie_read_tlp_log()
>   PCI: Create helper to print TLP Header and Prefix Log
>=20
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
>=20
>=20
--8323328-2015099635-1707302934=:1119--

