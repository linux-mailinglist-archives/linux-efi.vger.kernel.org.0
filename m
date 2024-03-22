Return-Path: <linux-efi+bounces-850-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A45A886E51
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 15:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A8628B4B7
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 14:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96247A5D;
	Fri, 22 Mar 2024 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACJjhCFd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33646546;
	Fri, 22 Mar 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117013; cv=none; b=HLQ9Gocun+uKbD4nJZ9B57RFIXG3Pv17rMkSNLKksfS7LuIrazAJxDfDIsG5Z+Jq5HBZiyI4piJjsqlRqH6LI1m/aabpdSrzRQGrvIJt2gJvBajNHsIP/pjXRXW77F8wYsfFX3OH15dTwiEB0MwKP3fZDh47QLjZi27AjuML04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117013; c=relaxed/simple;
	bh=2KeOzt6+e2pFDwhqfLnCeh7Ap5am70wfBW1us6UaZEk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YQlnZyjF+smAPuA0iDqM162I+Q7pChE2/VxQbMhVHEEoG19xdqxcSlKrbO+m9C7mMSnOh+5+qmkePuEKSYDMG+vj2qNxa23n7cFoLbKp2UXVgR5gr/gO/QRbfYwoSdAFysFu4nENdktHxreRTlByhW0+Yz7vkn//wCn3/+7H9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACJjhCFd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711117012; x=1742653012;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2KeOzt6+e2pFDwhqfLnCeh7Ap5am70wfBW1us6UaZEk=;
  b=ACJjhCFd6/QVOSzMQM+vy17EH4uIHumSnJt1fgPSbhdDEhPPS6N2iCqf
   +79Mkw7iueVL/o4KnDoOmBAIn0GvXUr9et6ARzSVq2D14anKA72Iu0xjb
   7tdsDzeDFGhexuL0mX2zkGmkexz3/MwdhxDUnlKaKI70UEiatbe2u2gxN
   aUeTcG2TJqPdfCXWYoGayp3JhslgFrBntC/Annf7bGf3Ty7NiCg5HapZM
   8/SXXA0uaXstU2nvS7U0xd5XKVF9IIYlLX0jVYFNGa6Eg/Hbul15DftL2
   Fmzhf++yZIO/+mhBBs8PwmYBl+32RHWRw9SAfhNIlFpGvgP3JScocrEiT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5994961"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="5994961"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 07:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15352468"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 07:16:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Mar 2024 16:16:37 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
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
In-Reply-To: <cc3f6a32-a00d-3c68-bc89-c042d238e7fe@linux.intel.com>
Message-ID: <771bb522-c4eb-b515-e315-6ad1c622cbd9@linux.intel.com>
References: <20240308213107.GA700934@bhelgaas> <cc3f6a32-a00d-3c68-bc89-c042d238e7fe@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-20305305-1711116997=:1115"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-20305305-1711116997=:1115
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 Mar 2024, Ilpo J=C3=A4rvinen wrote:

> On Fri, 8 Mar 2024, Bjorn Helgaas wrote:
>=20
> > On Tue, Feb 06, 2024 at 03:57:13PM +0200, Ilpo J=C3=A4rvinen wrote:
> > > This series consolidates AER & DPC TLP Log handling code. Helpers are
> > > added for reading and printing the TLP Log and the format is made to
> > > include E-E Prefixes in both cases (previously only one DPC RP PIO
> > > displayed the E-E Prefixes).
> > >=20
> > > I'd appreciate if people familiar with ixgbe could check the error
> > > handling conversion within the driver is correct.
> > >=20
> > > Ilpo J=C3=A4rvinen (4):
> > >   PCI/AER: Cleanup register variable
> > >   PCI: Generalize TLP Header Log reading
> >=20
> > I applied these first two to pci/aer for v6.9, thanks, these are all
> > nice improvements!
> >=20
> > I postponed the ixgbe part for now because I think we should get an
> > ack from those maintainers or just send it to them since it subtly
> > changes the error and device removal checking there.
>=20
> Okay, I'll make sure they're separated properly for the remaining patches=
=20
> (I was already planning on doing that separation and posting v2 to avoid=
=20
> their input blocking the changed but you beat me to it).
>=20
> > >   PCI: Add TLP Prefix reading into pcie_read_tlp_log()
> > >   PCI: Create helper to print TLP Header and Prefix Log
> >=20
> > I'll respond to these with some minor comments.
>=20
> Did you forget to send those comments?

Ping.

I still haven't received those comments for patches 3 & 4.

--=20
 i.

--8323328-20305305-1711116997=:1115--

