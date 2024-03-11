Return-Path: <linux-efi+bounces-793-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE6877F16
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 12:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7341F21A5B
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8D3AC10;
	Mon, 11 Mar 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2d5ZUNn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0EA3A268;
	Mon, 11 Mar 2024 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156909; cv=none; b=NRbxAccQ0wFywY1yJ1y3Tr5uuK/dXgkTc3DD1W/Zyp1/CFawjPu2VFg8p4O3ihdIpellpRgLe9uiRQf3TdfwIqTKjqF8cW2PajeUjEp/6mkpVA56MgOr74jY8baIw/MBbsWPofCGAw2RzVAvL+gcdvcE3hwcO9FwL5+cUipX3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156909; c=relaxed/simple;
	bh=pYF/44sGUvtGohJefbieCblrNnn6V9de0G2M8//jghE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F3xnnmL4txap7Izznelqs+0JTV1bMI+mT43R1c9dN5QcLmYyP9m2dss4ERCZw6T6BIbQHq4aouXY/T2l32X77RMOJ4dif4ua/h08A+2wr3ClxCboN/D34eewOgLPYr/G7x+TsOzhPWcE1tm+PdPp5ymVJ7ODdruPxs6xEdGirdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2d5ZUNn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710156907; x=1741692907;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pYF/44sGUvtGohJefbieCblrNnn6V9de0G2M8//jghE=;
  b=V2d5ZUNnGrt+BrL0WUPF3Uv4SIE+Ho0HR0sRFsqpef7G7sslDpMlG2Le
   /DHWAQjupw7P0pqfJS0EDitUgtRdzUTip87MaN91a9a7miZu8lWvjH3jM
   DTXZ5LzfGx7AYVsXn2W+M0d2tvwU0dNIDQNGOveMdRhbVm8Idy8xkElKq
   dnIOEEgAOb7zEbDGfzXGP8YpxMlolvn0V9/tvIihMuxRiYdpGuMo5rY8g
   xvRPcDpWR8MTRWRJ9zukH3GISglrR+JuLVteh0awMV0JnXOi7pFii69Kc
   waUB6v8sGIJukpVQsTPBXGVhHXfJhFFpr6P83UGFNjkq1WCAAcHNAGJa4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4656318"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4656318"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 04:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15784787"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 04:34:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 13:34:54 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
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
In-Reply-To: <20240308213107.GA700934@bhelgaas>
Message-ID: <cc3f6a32-a00d-3c68-bc89-c042d238e7fe@linux.intel.com>
References: <20240308213107.GA700934@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-141571146-1710156894=:1142"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-141571146-1710156894=:1142
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 8 Mar 2024, Bjorn Helgaas wrote:

> On Tue, Feb 06, 2024 at 03:57:13PM +0200, Ilpo J=C3=A4rvinen wrote:
> > This series consolidates AER & DPC TLP Log handling code. Helpers are
> > added for reading and printing the TLP Log and the format is made to
> > include E-E Prefixes in both cases (previously only one DPC RP PIO
> > displayed the E-E Prefixes).
> >=20
> > I'd appreciate if people familiar with ixgbe could check the error
> > handling conversion within the driver is correct.
> >=20
> > Ilpo J=C3=A4rvinen (4):
> >   PCI/AER: Cleanup register variable
> >   PCI: Generalize TLP Header Log reading
>=20
> I applied these first two to pci/aer for v6.9, thanks, these are all
> nice improvements!
>=20
> I postponed the ixgbe part for now because I think we should get an
> ack from those maintainers or just send it to them since it subtly
> changes the error and device removal checking there.

Okay, I'll make sure they're separated properly for the remaining patches=
=20
(I was already planning on doing that separation and posting v2 to avoid=20
their input blocking the changed but you beat me to it).

> >   PCI: Add TLP Prefix reading into pcie_read_tlp_log()
> >   PCI: Create helper to print TLP Header and Prefix Log
>=20
> I'll respond to these with some minor comments.

Did you forget to send those comments?


--=20
 i.

--8323328-141571146-1710156894=:1142--

