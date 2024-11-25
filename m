Return-Path: <linux-efi+bounces-2194-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 997FB9D89EE
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 17:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A68B3C34E
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691111B3926;
	Mon, 25 Nov 2024 14:58:58 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82D1B219B;
	Mon, 25 Nov 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546738; cv=none; b=HaLG3qXyDDYNGtXgKkdx0jucjbJuTGOwjADxiV7S+aXWunSXBGN9KcDQLeBSVqKM5Tf45U1DMiWifszUfoLMI+d1H+ATX1N/q36BC9hAIXusjn7XCppSXGMwoaFbm/+o5grTs2Q3k2I1PD+gtsDud886hmTABpKPQVXhzouthGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546738; c=relaxed/simple;
	bh=w+tmBKjTFlCqvNT+igqcFRyelSN2n3t9IMQPDNdoSak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPO6WOe4gXouNRuxzA69IY+d7L1Gb6UAnd9FT306LTcvr2xOT1hqsqtp69WZwhHLsuCjHfDi0HvZ3UobkyGDzrX8uKBx3ikK1iebOZZ2v9yx18/r1Fycfiubye9R9Sf3M/CFkgpfNIO7lUJ/DFFz82RsUakjsHCjd2o864SJde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A56EE1756;
	Mon, 25 Nov 2024 06:59:25 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 532813F66E;
	Mon, 25 Nov 2024 06:58:53 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	sudeep.holla@arm.com,
	guohanjun@huawei.com,
	gshan@redhat.com,
	prarit@redhat.com,
	Jonathan.Cameron@huawei.com,
	dwmw@amazon.co.uk,
	ardb@kernel.org,
	hagarhem@amazon.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 1/2] arm64/acpi: panic when failed to init acpi table with acpi=force option
Date: Mon, 25 Nov 2024 14:58:47 +0000
Message-Id: <20241125145848.506347-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125145848.506347-1-yeoreum.yun@arm.com>
References: <20241125145848.506347-1-yeoreum.yun@arm.com>
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


