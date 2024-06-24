Return-Path: <linux-efi+bounces-1289-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559B391461E
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 11:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7584B242D4
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCFF130ACF;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDUDM/rc"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5812E1F6;
	Mon, 24 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220790; cv=none; b=ZYixsa4sKIPUTvHszCbmj/Vf5w7W5bG3BBOr4N1kVVZeFWirMUIQMQ/LjePCvu7scOVi0AveROfT+cGcMo7PIVKDwOD4FJ7/8c45U7XHPZ+sb9auH/XeFXWgr+m/4AVcpV0qHHayps3tQt5oODmZTr5kxf5urbHYzFsAkdZxJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220790; c=relaxed/simple;
	bh=oU/8r7bCLv97UE0Vbd5wfZPsGHSnpZEWps6OW3Re6iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mvvIm4NmKiWpASZoRitTo0dPQprgxEKwQ4h8fJ3CPGYpX8GArCf4egPKfaN2EJIVRhvPRsz/PiMyJIceq7ITwUKWTQ/yi7YGI1MvKKtPGcwU4ITc5wU8PrNLtZ5B0+lZNuBsf2UNelKSw6trzFep37ygmMmVD26aKb7NRwHCG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDUDM/rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB07C32789;
	Mon, 24 Jun 2024 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719220790;
	bh=oU/8r7bCLv97UE0Vbd5wfZPsGHSnpZEWps6OW3Re6iY=;
	h=From:To:Cc:Subject:Date:From;
	b=fDUDM/rcfjvVFi3bB/GzUkANTdmyfRJjUvwindo/e8azmI+AAma0IIVyCPla0ocxG
	 3Hx0HSaJcjENu71NAcnXuDVZfg/hW2n+/S22/ARbZdiUqWRFVR/C5ZZT3+ZiE/ECNf
	 CBjJwMMe/AECuukZUN/topehhHRVLeOxwYqkPrCmIDKb0ygf1KM5Epwqtzh6fZc5ET
	 SdBTWAAY+zbn4eQ3E0lVpUtWBbJmDfzRYJx7EhIYZveNHKg2cx08T19Wl9op6HBRdZ
	 429WVVaq49nkgWfbiJ6EWN/uWBu4uWdGBFaRr1d03vJWToyk4MretRZYHK0YriCMSI
	 pKHQ1HOLtaE+A==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sLfrX-000000085bc-1UbK;
	Mon, 24 Jun 2024 11:19:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 0/4] fix CPER issues related to UEFI 2.9A Errata
Date: Mon, 24 Jun 2024 11:19:17 +0200
Message-ID: <cover.1719219886.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

The UEFI 2.9A errata makes clear how ARM processor type encoding should
be done: it is meant to be equal to Generic processor, using a bitmask.

The current code assumes, for both generic and ARM processor types
that this is an integer, which is an incorrect assumption.

Fix it. While here, also fix a compilation issue when using W=1.

After the change, Kernel will properly decode receiving two errors at the same
message, as defined at UEFI spec:

[   75.282430] Memory failure: 0x5cdfd: recovery action for free buddy page: Recovered
[   94.973081] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[   94.973770] {2}[Hardware Error]: event severity: recoverable
[   94.974334] {2}[Hardware Error]:  Error 0, type: recoverable
[   94.974962] {2}[Hardware Error]:   section_type: ARM processor error
[   94.975586] {2}[Hardware Error]:   MIDR: 0x000000000000cd24
[   94.976202] {2}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x000000000000ab12
[   94.977011] {2}[Hardware Error]:   error affinity level: 2
[   94.977593] {2}[Hardware Error]:   running state: 0x1
[   94.978135] {2}[Hardware Error]:   Power State Coordination Interface state: 4660
[   94.978884] {2}[Hardware Error]:   Error info structure 0:
[   94.979463] {2}[Hardware Error]:   num errors: 3
[   94.979971] {2}[Hardware Error]:    first error captured
[   94.980523] {2}[Hardware Error]:    propagated error captured
[   94.981110] {2}[Hardware Error]:    overflow occurred, error info is incomplete
[   94.981893] {2}[Hardware Error]:    error_type: 0x0006: cache error|TLB error
[   94.982606] {2}[Hardware Error]:    error_info: 0x000000000091000f
[   94.983249] {2}[Hardware Error]:     transaction type: Data Access
[   94.983891] {2}[Hardware Error]:     cache error, operation type: Data write
[   94.984559] {2}[Hardware Error]:     TLB error, operation type: Data write
[   94.985215] {2}[Hardware Error]:     cache level: 2
[   94.985749] {2}[Hardware Error]:     TLB level: 2
[   94.986277] {2}[Hardware Error]:     processor context not corrupted

And the error code is properly decoded according with table N.17 from UEFI 2.10
spec:

	[   94.981893] {2}[Hardware Error]:    error_type: 0x0006: cache error|TLB error

The error injection logic was checked via QEMU using this patch:
https://lore.kernel.org/all/20240621165115.336-1-shiju.jose@huawei.com/

v5:
- Do some cleanups and minor fixes as suggested by Jonathan and Tony:
  - check errors at strscpy();
  - simplify cper_bits_to_str() function;
  - use FIELD_GET() and for_each_set_bit();
  - use ARRAY_SIZE() on infofx to let it clear that it should be size of newpfx + 1;
  - fix kernel-doc warning with W=1;
  - use kernel-doc for two exported functions at cper.c.

v4:
- The print function had some bugs on it, which was discovered with
  the help of an error injection tool I'm now using.

v3:
- It adds a helper function to produce a buffer describing the
  error bits at cper's printk and ghes pr_warn_bitrated. It also
  fixes a W=1 error while building cper.

v2:
- It fixes the way printks are handled on both cper_arm and ghes
  drivers.

v1: 
- (tagged as RFC) was mostly to give a heads up that the current 
  implementation is not following the spec. It also touches
  only cper code.




Mauro Carvalho Chehab (4):
  efi/cper: Adjust infopfx size to accept an extra space
  efi/cper: Add a new helper function to print bitmasks
  efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
  docs: efi: add CPER functions to driver-api

 .../driver-api/firmware/efi/index.rst         | 11 ++--
 drivers/acpi/apei/ghes.c                      | 15 +++---
 drivers/firmware/efi/cper-arm.c               | 52 +++++++++----------
 drivers/firmware/efi/cper.c                   | 41 ++++++++++++++-
 include/linux/cper.h                          | 12 +++--
 5 files changed, 89 insertions(+), 42 deletions(-)

-- 
2.45.2



