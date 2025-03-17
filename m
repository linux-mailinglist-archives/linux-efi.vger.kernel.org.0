Return-Path: <linux-efi+bounces-2996-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF53A64917
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 11:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76BB188C7DB
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1650231CB1;
	Mon, 17 Mar 2025 10:13:54 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24C322257F;
	Mon, 17 Mar 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206434; cv=none; b=sVqPf1uq/1G2DjJ+WAiI5W+Hha/aHzDlzUIX6W7E9doOGNPYn2gE1gZR9+gxM3HbQ1yMdHJ1uBfMJibLs/lqe4fuflvfdenKIDmltnxpeLrNrQkOc2IUfd9juQoQ5ucra3iB+nDuXiH3DBvYWwM2wQRSWamOHd/OtqMi6GJSJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206434; c=relaxed/simple;
	bh=/Q8Aa9fYv9wbyrx2wObs4CMSJP+hTNYqKzlwyrJhFsM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YN9l0KVFSyecyFL1B7mn2mSxeHeYsdL4XmU6fNVw+mPMuJ9yisgVUGw9yhOg2QXbOZryB/AFq8d1x0POIy9Bw6uk1TEW1L1I4GiHbKMTglIDfGL588XAaIDPqjYkUitMiqHnXCZBuDQafn3RA8RO+FH+naSqTiTUHp37qxmPyfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3E2813D5;
	Mon, 17 Mar 2025 03:14:00 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B7D03F673;
	Mon, 17 Mar 2025 03:13:47 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 0/9] drivers: Transition to the faux device interface
Date: Mon, 17 Mar 2025 10:13:12 +0000
Message-Id: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALv112cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0NT3YKcxBKjtMTSiviU1DJdi2QjiyRj06RUS7NEJaCegqLUtMwKsHn
 RsbW1AJ+HYAdfAAAA
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
 Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-rtc@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 netdev@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
 linux-acpi@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=/Q8Aa9fYv9wbyrx2wObs4CMSJP+hTNYqKzlwyrJhFsM=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn1/XaXg/cczfp9LKToTU0Xvg1jjtICG+G14QuE
 jF8HdVkidyJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9f12gAKCRAAQbq8MX7i
 mL+sEACUOKVk2OIBxRBYI5oleTH4ttn1o568PHz46upYDllAy68d3qhxx0E4xnIdB60mEjQBzDu
 pZD62v90A+KDS4L4tmUprsU7NWILTGj7z8ga03muX133xHYBl3IBUvax/9o/+bum82neHCv1Pba
 d8H+us51UfUHU9RNZlv0RBm5VVa/c8Uw1HgXOr5pKwbjSb8e3qQCqNIHDnZlch9Nieifbsr/76z
 gG6mbYz1uW4/b7QLjmoUjKSeUxVj+2GPLep8+YRtNuA1S4RPJK5HAWWzuehomacfsXjmB58nG+q
 RnT2Myy8yJNRXSJ2M4hQ4q0xSovkDs1Fs3BsAWVhnk34koAzgflqjj2nSvvviGN1NfHBDbkbsIn
 ICmtLUmPDj6wh+Iuh95Z7TR2a2bxv4ZcvOdEjiSE3ePYG3mtX71NIGCtGLT/U+heYKLFl80Q288
 NDDOuKCfChTKQnT1TO4A3iHJBUcm2GH5eQfKisbIr0fGMwWJmzfkkbw/JRUDDgsPLZf+gg4zpbg
 YuDDMuht91nrSsN6M3frGjU78FZxQBTizKPNnlYBi9rEhb+sN0amzbmmQHOiOLtx/CWe71UQuQu
 xZRpzua8GypLhrf83niYHYJRoY3H6cihvbNg4Yh/mS87pjun48IYIRWWPRW8PyPsuDd+Zfow2uU
 2BgXIq8hNqRm+cw==
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

All the patches are independent of each other.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Greg Kroah-Hartman (1):
      regulator: dummy: convert to use the faux device interface

Sudeep Holla (8):
      cpuidle: psci: Transition to the faux device interface
      hwrng: arm-smccc-trng - transition to the faux device interface
      efi: Remove redundant creation of the "efivars" platform device
      rtc: efi: Transition to the faux device interface
      virt: efi_secret: Transition to the faux device interface
      ASoC: soc-utils: Transition to the faux device interface
      net: phy: fixed_phy: transition to the faux device interface
      ACPI: APEI: EINJ: Transition to the faux device interface

 drivers/acpi/apei/einj-core.c             | 32 +++++++++---------------
 drivers/char/hw_random/arm_smccc_trng.c   | 40 +++++++++++++++++++++---------
 drivers/cpuidle/cpuidle-psci.c            | 26 +++++++-------------
 drivers/firmware/efi/efi.c                | 10 --------
 drivers/firmware/smccc/smccc.c            | 21 ----------------
 drivers/net/phy/fixed_phy.c               | 16 ++++++------
 drivers/regulator/dummy.c                 | 37 +++++++---------------------
 drivers/rtc/rtc-efi.c                     | 31 ++++++++++++++++-------
 drivers/virt/coco/efi_secret/efi_secret.c | 41 ++++++++++++++++++-------------
 sound/soc/soc-utils.c                     | 34 +++++++++----------------
 10 files changed, 124 insertions(+), 164 deletions(-)
---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250315-plat2faux_dev-8c28b35be96a
-- 
Regards,
Sudeep


