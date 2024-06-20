Return-Path: <linux-efi+bounces-1258-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF68911072
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 20:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD271C23D68
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910CE1BD8F1;
	Thu, 20 Jun 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="symNHpEQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D11B4C3A;
	Thu, 20 Jun 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906515; cv=none; b=EZ5CgqKIbArrftQPSiz/1MlL3b70DIWyfegpH1+G9M/AdgQ0xiS9xzy7dWndn3ASDHi+pA5oDUO02+YoMt0lf0yS5A9laOgg/bUxQu7GyikZFv0957SJtq4DR3iZOfDPr9tCSQUmTbzFuaza+dUR4BuN/kuhCoz7smF81C4jPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906515; c=relaxed/simple;
	bh=CFgn74JVfqJnl7/jRSJZfwKA4G00LCTZSAG3MnmmnY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iQqQYXUkHJ5l2BrSdKd6NHdg4Ex/pPIQI197Omsh3vlqdGtZ6F7AF5QVgdGcptA2Yt5ZdwkrdB8otmJUPTy6F1QS8Jcs0YH6x5HLl4tAgh6bQZaagtxoxUtomC1MtAlJBUVoHaUh+fUTzheFz9LmKyO2P76kqjQJaUY703w1ZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=symNHpEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E612C4AF09;
	Thu, 20 Jun 2024 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718906515;
	bh=CFgn74JVfqJnl7/jRSJZfwKA4G00LCTZSAG3MnmmnY4=;
	h=From:To:Cc:Subject:Date:From;
	b=symNHpEQyNcEny4fqOlFVpQj36ZBbwpre/gAG8+2EfbRr92+jO8VUiEnSthLnD/rV
	 yuCkw5vAYcoOwx+2LAeOXdD/I9vzn12ft97tmWI0ON3ipxNi2dhl6VdguEObXUWyUO
	 RSUzfIKwEWXmF+Vp75EuIaFt7Lt0EAyeQAWoc6/8G+2Jp5r0Ncfjzm/qycxRoagOaL
	 kD0OL91/8yz5L3Hlvxj8hrWQl+L+oMpqv9MGu7Vkzi/Ks8hum1hjShBK4P8t3hzf3C
	 Mxbq+e37sHO6OrOyvuF68hTQh73bPGResYZAxeVNgpPZdpzR1tteVfc+c1CdmxkPEA
	 kgu80ErTwzTAA==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sKM6a-00000006MRf-0ly3;
	Thu, 20 Jun 2024 20:01:52 +0200
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
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v4 0/3] Fix CPER issues related to UEFI 2.9A Errata
Date: Thu, 20 Jun 2024 20:01:43 +0200
Message-ID: <cover.1718906288.git.mchehab+huawei@kernel.org>
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

Mauro Carvalho Chehab (3):
  efi/cper: Adjust infopfx size to accept an extra space
  efi/cper: Add a new helper function to print bitmasks
  efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs

 drivers/acpi/apei/ghes.c        | 10 +++---
 drivers/firmware/efi/cper-arm.c | 48 ++++++++++++---------------
 drivers/firmware/efi/cper.c     | 59 +++++++++++++++++++++++++++++++++
 include/linux/cper.h            | 13 +++++---
 4 files changed, 94 insertions(+), 36 deletions(-)

-- 
2.45.2



