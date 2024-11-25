Return-Path: <linux-efi+bounces-2197-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4479D8B4B
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744B4B330A4
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09051B3943;
	Mon, 25 Nov 2024 17:08:05 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D38178378;
	Mon, 25 Nov 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554485; cv=none; b=OMaaaTZpWHOHbArgQN4cVhDsEkFOo69hgdmYwcm5PR/49ZU3SVrid2jy1l933kLlKYWJxy3GrDnk2lHxXx/ZDGg+eFGZZhqAN3v9FTpL7HUegaYpnMjJpUk3YhfGyVIO1nbxniJcWbEcYfri5GYXXVzoUVyRunN7UchAcc0M15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554485; c=relaxed/simple;
	bh=livMxtHLQQFDWZamd9xynctckPyU9+CiEALRZxsigKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s84fv21E/r4khv5w4yl9HYkzaIj3whQF3W9Zm5ed6jd/rnEFReERS5JcZ9O8hIm+f1L3GBXmjfKIpdRIWSNbVj3tnYe82ut9TapIjnWSBjvx4RFM/dG2u2YbQAYuJBol/ZwVMryR3LzVFSfhPn5u2Ja9TzDLALrNqqPqGNBLF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 389F51692;
	Mon, 25 Nov 2024 09:08:33 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 237913F58B;
	Mon, 25 Nov 2024 09:08:01 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: ardb@kernel.org,
	broonie@kernel.org,
	sami.mujawar@arm.com,
	sudeep.holla@arm.com,
	pierre.gondois@arm.com,
	hagarhem@amazon.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	guohanjun@huawei.com,
	Jonathan.Cameron@huawei.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 0/2] small fixes when boot with acpi=force option
Date: Mon, 25 Nov 2024 17:07:56 +0000
Message-Id: <20241125170758.518943-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When acpi=force option is used, the dt should be ignored whether it's
invalid, passed from command line or from configuration table but it
doesn't so it produces error message
while scanning dt early time thou it isn't used in booting process.

Change to ignore dt when acpi=force option is used.

v2:
  - ignore getting dtb from configuration table when acpi=force option is used

Yeoreum Yun (2):
  arm64/acpi: panic when failed to init acpi table with acpi=force
    option
  efi/fdt: ignore dtb when acpi option is used with force

 arch/arm64/kernel/acpi.c           |  2 ++
 drivers/firmware/efi/libstub/fdt.c | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


