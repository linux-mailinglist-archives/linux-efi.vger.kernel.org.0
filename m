Return-Path: <linux-efi+bounces-5791-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69ACA29F3
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 08:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9322C3023578
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB4A2E2F0E;
	Thu,  4 Dec 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbeSIypn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031151D5178;
	Thu,  4 Dec 2025 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764833025; cv=none; b=fXDZc2AN0v6M8wcZq6fmndE2fgT+Mkju2n5xO4TVhVw+vDakSkUmMeDmaEGNqStyBmGNb3Y+OIbskIyuLAnbleSlWHdZDVz/diV8q3ohx26zE1EF1lYjeF9MoQT42jP5rMaxte4bln9KjsM4KWdEdi8eZrjs4ChDiQxNBU7oyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764833025; c=relaxed/simple;
	bh=3dJkqqvIDW3blo0AApoHWDPmByvZSTxMaD/dUBIdgNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaPZIrig5ADnPFRwizXZhCBEdidbj/tXrPra7v3D8NhkhpAcYikjV9KeNvAsOHafuZbwg24m8du13uLawHjN/TxlBvV7WMNdwpWqR2k/5L4zw7ogCISsu/88nBweA0XSBkoFsKlENMO9pCEoeOu5VNejgPalnrVOvLgK3G3lHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbeSIypn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764833024; x=1796369024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3dJkqqvIDW3blo0AApoHWDPmByvZSTxMaD/dUBIdgNM=;
  b=dbeSIypnalcKzA6jBwpKR4CD3meAKWqhcZtZ3um2s5PmUvQww5CiZ2J9
   EpTDegIMetsUHD6pdTYe0IMBaRnhNIp4PMwEmhGxKzoRrqriRRzcYZleK
   ma2dTCCXX/QyZCoQoIfR64kfadpkk6cYg2vAzNwmfeVlbKDU4N57QRqnt
   GyyBqP+u1Ccw6ka52EabdeY3kl0cPGOaG9xLRrVZV2Ohe5eMKHvXcNogA
   /ToAjHiB03uZzGGY1nt62aIuqyJ77TKLWtfGd4hzwMthibqf6O9kSr+cQ
   F30H6y3eJasqtqi3CZcThUqKJ3/Yn74ZMVX/ty95ltC48wLIn0OdrRb3E
   A==;
X-CSE-ConnectionGUID: 7IjXCD+/R7e/+3W0cTAm0w==
X-CSE-MsgGUID: XEN47Xb/QbaabVDCK9HUwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66804569"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="66804569"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 23:23:44 -0800
X-CSE-ConnectionGUID: APjSDX9dTMSMPEzIIiY2uw==
X-CSE-MsgGUID: hNXIueFnSdqcI/xMeEDeEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="199861624"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa004.fm.intel.com with ESMTP; 03 Dec 2025 23:23:42 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 0/3] x86: Extend LASS support to EFI configurations
Date: Wed,  3 Dec 2025 23:21:40 -0800
Message-ID: <20251204072143.3636863-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linear Address Space Separation (LASS) is currently disabled [1] when
support for vsyscall emulation or EFI is compiled in. This series
extends LASS support to EFI-enabled configurations.

Issues with EFI
---------------
EFI boot and runtime services are incompatible with LASS because they
end up accessing addresses with bit 63 cleared, which is blocked by LASS.

  1) The most obvious one is the SetVirtualAddressMap() runtime service,
  which is expected to be called in EFI physical mode [2]. 

  2) Boot services code and data are referenced long after
  ExitBootServices(). For example, efi_check_for_embedded_firmwares()
  accesses boot services memory even after SetVirtualAddressMap().

  3) Some runtime services fail to switch to virtual mode properly and
  continue referencing physical addresses [3]. The kernel maintains a
  1:1 mapping of all runtime services code and data regions to avoid
  breaking such firmware.

Solution
--------
These patches take LASS out of the path of all EFI boot and runtime
service interactions by:

  Patch 1: Deferring LASS enabling until userspace comes up, which
  ensures EFI has completed switching to virtual mode and all boot
  services memory has been freed [4]. 

  Patch 2: Temporarily disabling LASS every time a runtime service is
  executed after boot [5].

Please find more details in the respective patches.

Alternate options
-----------------
One option is to not support broken firmware implementations with LASS
by avoiding patch 2. That would trigger #GP faults when runtime calls
try to access the 1:1 mapped physical memory. However, most client
BIOSes typically get validated with Windows during development [3]. So,
some users could see in-field failures when they start running newer
Linux kernels with LASS enabled. 

In the long run, to encourage BIOSes to fix bad code, the kernel could
trap invalid accesses to 1:1 mapped physical memory and then warn about
buggy firmware. However, such an effort should be pursued independent of
LASS [6].

Links
-----
[1]: https://lore.kernel.org/lkml/20251118182911.2983253-1-sohil.mehta@intel.com/
[2]: https://uefi.org/specs/UEFI/2.10/08_Services_Runtime_Services.html#setvirtualaddressmap
[3]: https://lore.kernel.org/lkml/CAMj1kXGyTo=4Va1PevMQyCauEKSutfSPo6je0Ps09TabhTe4zQ@mail.gmail.com/
[4]: https://lore.kernel.org/lkml/ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com/
[5]: https://lore.kernel.org/lkml/6ab6e4d3-0caa-41e6-8231-2f3f45949876@intel.com/
[6]: https://lore.kernel.org/lkml/255724be-a6d8-4aa6-94f9-1e6ffba3a3cc@zytor.com/


Sohil Mehta (3):
  x86/cpu: Defer LASS enabling until userspace comes up
  x86/efi: Make runtime services compatible with LASS
  x86/cpu: Remove LASS restriction on EFI

 arch/x86/kernel/cpu/common.c   | 24 +++++++++++++++++-------
 arch/x86/platform/efi/efi_64.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 7 deletions(-)


base-commit: d61f1cc5db799f4e44a63418b2dc19396787427b
-- 
2.43.0


