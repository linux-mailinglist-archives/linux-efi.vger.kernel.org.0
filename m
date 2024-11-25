Return-Path: <linux-efi+bounces-2193-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F559D8897
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 15:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BF71665EF
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90C1B2192;
	Mon, 25 Nov 2024 14:58:56 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012321ABED8;
	Mon, 25 Nov 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546736; cv=none; b=GJ7S7RR3zf5ioh5uID475mqXYy46ebENZDK3RezPIlqDV1+pJRt4WnGVinZwWAYiYZih4tL0HVEeB5xyTZQqr4Rw/MDMyPeLmtw8mLqaP+7BrrjhM9dupzdq7h/UeJwjD71PKR2JTWgIldFPGjHHPWS5InWU0NEi/2NyUL5azLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546736; c=relaxed/simple;
	bh=N5in6cm+5+4X/12tSzL6BoHj6mjjkVXB0lL1tBYvXGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KQ/lwUdlxgk3c6OT+w0w7F8Hk6zd43pmEOT6+9EqrByxd3/LpzmZjV+zQd4GLoQMAyIsM6OG55SLQaFBipbqtvVw0szVyVij5NEXu4JQ0+XzgK/SPYMgDrlOfGzisRkR3nQJT/Fpt0BDQBeXSsxVn6tj24XlHlH2uh1QxnxBd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 177BF1692;
	Mon, 25 Nov 2024 06:59:23 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B7D983F66E;
	Mon, 25 Nov 2024 06:58:50 -0800 (PST)
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
Subject: [PATCH 0/2] small fixes when boot with acpi=force option
Date: Mon, 25 Nov 2024 14:58:46 +0000
Message-Id: <20241125145848.506347-1-yeoreum.yun@arm.com>
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

Yeoreum Yun (2):
  arm64/acpi: panic when failed to init acpi table with acpi=force
    option
  efi/fdt: ignore dtb when acpi option is used with force

 arch/arm64/kernel/acpi.c           |  2 ++
 drivers/firmware/efi/libstub/fdt.c | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


