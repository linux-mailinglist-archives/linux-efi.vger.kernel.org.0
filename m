Return-Path: <linux-efi+bounces-6024-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPxPOKEUcGlyUwAAu9opvQ
	(envelope-from <linux-efi+bounces-6024-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 00:49:53 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A98004E1C7
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 00:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CE609A0D44
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jan 2026 23:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA83EFD1E;
	Tue, 20 Jan 2026 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTxkHi1M"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE492E5B27;
	Tue, 20 Jan 2026 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952972; cv=none; b=gNNkBfxnf55xn4iHyPA1RAWa89gcuG9DhA4DMAGjvzTyAvrE+zMhE/7LWF2ssQhQZhDs1+zO1ROuhjp+9XqR/s410Yv31mDis4UfBvrdJizOUaXDfVc8r/24BRijZdl38pvW3J3xTebAEU6Vuhqnak8LYBYzcRoAwI7+7UNzRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952972; c=relaxed/simple;
	bh=HMf//lqGmHKx48HnGjA75U+ftMTYXBpg+g/yTz4QRWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xtdwd7epy76lb4fadZO/8+4dipvf4gkBV7r6hqVvZPBboPircwWy0efeYn3pAPqkHmp4ryGXh0lyBk74EH+tTpHWpG3PMm52CK/L3l7STV6tx10AuwGtFXLFnV0HJ4GhHCDjrDxEMa5nNFMB+784M3M5rwvDMaKUiFodSW6XUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTxkHi1M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768952970; x=1800488970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HMf//lqGmHKx48HnGjA75U+ftMTYXBpg+g/yTz4QRWM=;
  b=LTxkHi1MmZV2yXyQK8dEb5J0GkPcgQpdcdozUr3N5wwcdBzoMRu9ccMu
   YxrTiju2LSmA+TyHr8PohjioCSEwLH62bKUoVVENWVzjQ1wG4unmdCooE
   xPdN4A9jrANNX74BzdLIraI6P9lolX0W1qNqHzdEBBQctlJs86xoH0POE
   zr5Cwg2bG9wsp5FofgFJQf9Cc9r3jsm0Pg2YVFVsfgPQVfEXzuit4pEgb
   +wKgPvU+iofhQu/zzlCYycroaF3OiPJ4WhptHrAfD5FgX3AUt5j8AOw89
   bNpWzkg0l6C23aFmyQPdI6LaoHWlap80OP5grOZyA1QfUsPugbiDG3zmq
   w==;
X-CSE-ConnectionGUID: hO1/vyRPT7KxI8+6BaBubQ==
X-CSE-MsgGUID: zko37k7GRFy4FkVWmQQUHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87752940"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="87752940"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 15:49:29 -0800
X-CSE-ConnectionGUID: IkCwHzwAT0iKo45Kp6v5mw==
X-CSE-MsgGUID: 5j3E5Q2TT4yA6tfSM2Wgug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="236932638"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2026 15:49:28 -0800
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
	"Kirill A . Shutemov" <kas@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v2 0/3] x86: Extend LASS support to EFI configurations
Date: Tue, 20 Jan 2026 15:47:27 -0800
Message-ID: <20260120234730.2215498-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6024-lists,linux-efi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,linux-efi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: A98004E1C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Linear Address Space Separation (LASS) is currently disabled [1] when
support for vsyscall emulation or EFI is compiled in. This series
extends LASS support to EFI-enabled configurations.

Changes in v2
-------------
- Rebased the series to v6.19-rc5
- Improved commit messages and code comments based on feedback

v1: https://lore.kernel.org/lkml/20251204072143.3636863-1-sohil.mehta@intel.com/

Issues with EFI
---------------
EFI boot and runtime services are incompatible with LASS because they
end up accessing addresses with bit 63 cleared, which is blocked by LASS.

  1) The most obvious one is the SetVirtualAddressMap() runtime service,
  which is expected to be called in EFI physical mode [2]. 

  2) Some runtime services fail to switch to virtual mode properly and
  continue referencing physical addresses even after SVAM. The kernel
  maintains a 1:1 mapping of all runtime services code and data regions
  to avoid breaking such firmware.

  3) Some boot services code and data regions are referenced long after
  ExitBootServices(). Most of these access use the kernel direct map so
  bit 63 is expected to be set. But some odd firmware implementation
  could access that memory via a mapping in the lower range.

Solution
--------
These patches take LASS out of the path of all EFI boot and runtime
service interactions by:

  Patch 1: Deferring LASS enabling until userspace comes up, which
  ensures EFI has completed switching to virtual mode and all boot
  services memory has been freed [3]. 

  Patch 2: Temporarily disabling LASS every time a runtime service is
  executed after boot. Runtime services execute in a special efi_mm
  which doesn't have userspace mapped. So, the security implications of
  disabling LASS are fairly limited [4].

Please find more details in the respective patches.

Alternate options
-----------------
One option is to not support broken firmware implementations (by
avoiding patch 2) starting with systems that support LASS. That would
trigger #GP faults if runtime calls try to access the 1:1 mapped
physical memory. Even though this is expected to be rare in modern
platforms, there isn't a clear benefit of keeping LASS active during
runtime calls executing under efi_mm.

Also, client BIOSes typically get validated with Windows during
development. So, some users could see in-field failures when they start
running newer Linux kernels with LASS enabled. Though Ard suggests that
things have improved on the Windows side, it doesn't seem worth taking
the risk to me.

In the long run, to encourage BIOSes to fix bad code, the kernel could
trap invalid accesses to 1:1 mapped physical memory and then warn about
buggy firmware. However, such an effort should be pursued independent of
LASS [5].

Links
-----
[1]: https://lore.kernel.org/lkml/20251118182911.2983253-1-sohil.mehta@intel.com/
[2]: https://uefi.org/specs/UEFI/2.10/08_Services_Runtime_Services.html#setvirtualaddressmap
[3]: https://lore.kernel.org/lkml/ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com/
[4]: https://lore.kernel.org/lkml/F707CA45-DA37-460A-AEFF-C11AC6AB6A05@zytor.com/
[5]: https://lore.kernel.org/lkml/255724be-a6d8-4aa6-94f9-1e6ffba3a3cc@zytor.com/


Sohil Mehta (3):
  x86/cpu: Defer LASS enabling until userspace comes up
  x86/efi: Disable LASS while executing runtime services
  x86/cpu: Remove LASS restriction on EFI

 arch/x86/kernel/cpu/common.c   | 30 ++++++++++++++++++++++-------
 arch/x86/platform/efi/efi_64.c | 35 ++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 7 deletions(-)


base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.43.0


