Return-Path: <linux-efi+bounces-3022-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151E8A67A38
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 18:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58494188B457
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4238D20FA85;
	Tue, 18 Mar 2025 17:02:33 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0DB7DA95;
	Tue, 18 Mar 2025 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317353; cv=none; b=MX3n7LxutqSIxHodE1LTMGSwLqbP7tlv330dpA2h0jum84cvAdyCuHg+khl8CYRmifhrf+HrMdhIxpp/4CKJn+bhyUZazUv37qQMYL3AxeI/juJbrtKYZQxEzJtbmYWa6I335BT6LtCUAsHxj7+hoEjVOBcdZkO2BZC5TlyyFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317353; c=relaxed/simple;
	bh=t2GnSiDhEAc2jR0PhzuynsSMOQaft9R1wyxkUo9nGf0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MQf8/BHQH3sWma9stC48UOw+ZKCQXDsyVojqMX1HQ4NzpUjykHBp2WR9svnKo/eWi9co8dd/JflUoR7tJxBizF7XQVxeP732isbkYJasU7juV1WkYsjPyk4qNQpEaCJ3nf3xeZnuiGpHjFkhOr36h6n6ogVkvkKY95Ag2rbea3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E15113E;
	Tue, 18 Mar 2025 10:02:38 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DD803F673;
	Tue, 18 Mar 2025 10:02:27 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 0/8] drivers: Transition to the faux device interface
Date: Tue, 18 Mar 2025 17:01:38 +0000
Message-Id: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPOm2WcC/13M0QqDIBiG4VuJ/3gONSy3o+5jxDD9XcLK0CaN8
 N7ngp3s8P3ge3aIGBxGuFY7BEwuOj+X4KcK9KjmBxJnSgOnXNCaCbI81cqtem13g4lIzeVQiwE
 vjYLyWQJatx3erS89urj68D74xL7rT2r/pMQIJcJi02oqhTKiU2E6az9Bn3P+AKkR/06oAAAA
X-Change-ID: 20250315-plat2faux_dev-8c28b35be96a
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-crypto@vger.kernel.org, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, 
 Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=t2GnSiDhEAc2jR0PhzuynsSMOQaft9R1wyxkUo9nGf0=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn2acieVcuFHn7nofVPar556U8uqUx0UeOmvUB7
 8OjuFukCuOJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9mnIgAKCRAAQbq8MX7i
 mPWcD/9OhT5P2JtPLSEmgmvEEx5PdiAloyTNaOIxEEIseBHyRaSIrCKcADHd9YM+ERsTixMHTIi
 0d7nfnGoqpKXivC1B3c9ZZM2d+848ZxrknkKvMcN7kQQA9xA9DB+EgyQf8Q7muvrKmcijglHhGM
 Ak4zDULpR/J1qgtv4VPrRyTrbO1BDpQhvqRLAUq+w8swlkH7IZ7fdcK5TjHlyg7MXGiIEu7r0/E
 fTlX8RhbC2IL3kBzSEZpuDmBzi3YsVSzm6jv8lkP3p2EO34LP3lRzRtUHnVmWIXMtWf4cENSGZ0
 HMpUqFf8o86N34J2hWTAVIIOoYYDcPvVnZA9K7OEgHhsAAI0hOwpXQWySWE6S+6IQPvlvPMfYgc
 jtVGKJdZSi8IKTP4gx3a3qNkCWsXU96yvLO0KT2UhFWykIQ+jY3bDU1WaAkii3UmK66QmSpFeJL
 tMPitm6pCyVWMwda0RkW16xwj7c7g1Gj8ja6dyPT0GRYAuxxNa5DW3bDymlN0pl0pXTOJwZfeMi
 Rqo0Khp0PBB/sP2YP9+2pMDYGA/+1ZSDM9Bv+t7/DXfjZQob4XsKwbbXaAnD+IIu+s3IKDj9DhV
 AjVOWc8TBf8Y9eB/9SHEtzU+PX3svORoqc97F34HtkNgJTdUUalYVL/QeBM/FIBOfgH8xnYqrWG
 RlVakyMXJ9u+xTw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Recently when debugging why one of the scmi platform device was not
showing up under /sys/devices/platform/firmware:scmi instead was
appearing directly under /sys/devices/platform, I noticed the new
faux interface /sys/devices/faux.

Looking through the discussion and the background, I got excited and
took the opportunity to clear all the platform devices under
/sys/devices/platform on the Arm Juno/FVP platforms that are really
faux devices. Only the platform devices created for the device nodes
from the DT remain under /sys/devices/platform after these changes.

All the patches are independent of each other and are part of the series
just to demonstrate the use of macro module_faux_driver() where
applicable. The idea is to get the macro merged first and then push the
individual patches via respective subsystem later.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Changes in v2:
- Dropped all the modalias expect efivars(reason in the patch)
- Defined new helper macro module_faux_driver() and moved most of the
  drivers to use it
- Dropped already queued ASoC and regulator changes
- Link to v1: https://lore.kernel.org/r/20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com

---
Sudeep Holla (8):
      driver core: add helper macro for module_faux_driver() boilerplate
      cpuidle: psci: Transition to the faux device interface
      hwrng: arm-smccc-trng - transition to the faux device interface
      rtc: efi: Transition to the faux device interface
      virt: efi_secret: Transition to the faux device interface
      efi: efivars: Transition to the faux device interface
      ACPI: APEI: EINJ: Transition to the faux device interface
      net: phy: fixed_phy: transition to the faux device interface

 drivers/acpi/apei/einj-core.c             | 51 ++++---------------------------
 drivers/char/hw_random/arm_smccc_trng.c   | 19 +++++-------
 drivers/cpuidle/cpuidle-psci.c            | 32 +++----------------
 drivers/firmware/efi/efi-pstore.c         |  2 +-
 drivers/firmware/efi/efi.c                | 12 ++------
 drivers/firmware/smccc/smccc.c            | 17 -----------
 drivers/net/phy/fixed_phy.c               | 16 +++++-----
 drivers/rtc/rtc-efi.c                     | 16 +++-------
 drivers/virt/coco/efi_secret/efi_secret.c | 29 +++++-------------
 include/linux/device/faux.h               | 49 +++++++++++++++++++++++++++++
 10 files changed, 90 insertions(+), 153 deletions(-)
---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250315-plat2faux_dev-8c28b35be96a
-- 
Regards,
Sudeep


