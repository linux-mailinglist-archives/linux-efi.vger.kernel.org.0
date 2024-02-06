Return-Path: <linux-efi+bounces-488-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A71F84B709
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 14:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9351F25682
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5DF131752;
	Tue,  6 Feb 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NATnf3AN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184C131736;
	Tue,  6 Feb 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227853; cv=none; b=izTd0iMQxkMtqAWfdUqZXizl4JuEUidFzFdqBJwRrZC+XyjHH533G55bsmORTyPdhBk8Elp+Nybjb3g7NkpDDJ5qzOfHhkBIF5Vz1Ec/FhrJJiYs4DwlKDR37iq7bh9L0wLUq4w1tvtb/7Z0PJkvSwZge5pZdG30WRmouf5rJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227853; c=relaxed/simple;
	bh=+6R/x2mXrJ2mSjnMfGMWqrnVr3TA5VqeovMhAdWHed8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AAjjkbuWPWp677Iyr7huj1jEFU6SehV5piguPFDxdqx9yS01aIhZNAqeEQpvvSQMnuaPcWonaU8mvNOkNX7jnH24pesrLy+o/tiASsmROTLWtqoGoo9eTIErtBgADsnsPosa1xIcg57jsNHgB/0yKhfL16ce5vPGzbqbxvs/iTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NATnf3AN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707227851; x=1738763851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+6R/x2mXrJ2mSjnMfGMWqrnVr3TA5VqeovMhAdWHed8=;
  b=NATnf3ANTLyC6QcTHm49O13AZElntwzSj54lDxd+JLnny25X7datHxb+
   SNobHDDa1LQq5TAQV5Dkw4FRbJzZdQU+zjHyI3PGfx0hoLH4eiq1m+mMJ
   qlWzSv4qBoYwIJpIvs8EZmSIRkvapIk+MW8xMe8BGRca04PFwBNSxR3j4
   M0Nss3qUj6+90Fi+pwGvVT++KhiihygFZCiW9/GO4YOztlckESh4WizNC
   vs9id2C+1+OKoyXcD+Bk0jh/ljuQF7vaBwjMVJ/54e7DtKMp/D4DeKGvu
   azCg89kS0G+oTWhi1r2cAO7rOYt6rQZ5AjG7v7PQ4B0uO+5D0QfEO1rs1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="905136"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="905136"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:57:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1309627"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:57:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	netdev@vger.kernel.org,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] PCI: Consolidate TLP Log reading and printing
Date: Tue,  6 Feb 2024 15:57:13 +0200
Message-Id: <20240206135717.8565-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series consolidates AER & DPC TLP Log handling code. Helpers are
added for reading and printing the TLP Log and the format is made to
include E-E Prefixes in both cases (previously only one DPC RP PIO
displayed the E-E Prefixes).

I'd appreciate if people familiar with ixgbe could check the error
handling conversion within the driver is correct.

Ilpo Järvinen (4):
  PCI/AER: Cleanup register variable
  PCI: Generalize TLP Header Log reading
  PCI: Add TLP Prefix reading into pcie_read_tlp_log()
  PCI: Create helper to print TLP Header and Prefix Log

 drivers/firmware/efi/cper.c                   |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 39 +++------
 drivers/pci/ats.c                             |  2 +-
 drivers/pci/pci.c                             | 79 +++++++++++++++++++
 drivers/pci/pci.h                             |  2 +-
 drivers/pci/pcie/aer.c                        | 28 ++-----
 drivers/pci/pcie/dpc.c                        | 31 ++++----
 drivers/pci/probe.c                           | 14 ++--
 include/linux/aer.h                           | 16 ++--
 include/linux/pci.h                           |  2 +-
 include/ras/ras_event.h                       | 10 +--
 include/uapi/linux/pci_regs.h                 |  2 +
 12 files changed, 145 insertions(+), 84 deletions(-)

-- 
2.39.2


