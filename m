Return-Path: <linux-efi+bounces-2198-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B89D8B00
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EED1163DA7
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556761B85CC;
	Mon, 25 Nov 2024 17:08:08 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7491B6CF9;
	Mon, 25 Nov 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554488; cv=none; b=buSibhte6FHR6cQxWe8QjrWMh5ntOwDdp35wXdD0TksCHZ+Li+7B4KFHpUuorluEMl6wAVOOay5Inen4iu+GfSIZvzB4FwY2jSIXJSW7tzMfxNgYKxAfkCcmmSagYhuW97KEkrgSG9QP1FUmC6A1eA6FB5ByxrXGZVpf4Ri+L7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554488; c=relaxed/simple;
	bh=WK8XwBhog2gazbVx1u8et2pYQdTtGTcZtJv+0/1+sVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+awb5D+j7gV0UolG9pIEHj2lqi3yY53sVhrWNDecNlh2jRYQl3YZb5XcXegLDmez4kqyGoT018cHInYgNHpQEn+y/uueT65RpQu0W/9T0qGzHBEOoZYm6z4hY9oGsqS1ogGV0SPrlSv5Nl8VTwzFBSI03pSiQsHGWjCnB/OuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 868701756;
	Mon, 25 Nov 2024 09:08:35 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 73E8E3F58B;
	Mon, 25 Nov 2024 09:08:03 -0800 (PST)
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
Subject: [PATCH v2 1/2] arm64/acpi: panic when failed to init acpi table with acpi=force option
Date: Mon, 25 Nov 2024 17:07:57 +0000
Message-Id: <20241125170758.518943-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125170758.518943-1-yeoreum.yun@arm.com>
References: <20241125170758.518943-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when the acpi=force option is used,
the system does not fall back to the device tree (DT).
If it fails to initialize the ACPI table, it cannot proceed further.
In such cases, the system should invoke panic() to avoid contradicting
the user's explicit intent, as failing or
proceeding with unintended behavior would violate their wishes.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e6f66491fbe9..efdf24ed5c3e 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -225,6 +225,8 @@ void __init acpi_boot_table_init(void)
 		pr_err("Failed to init ACPI tables\n");
 		if (!param_acpi_force)
 			disable_acpi();
+		else
+			panic("Failed to boot with ACPI tables\n");
 	}

 done:
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


