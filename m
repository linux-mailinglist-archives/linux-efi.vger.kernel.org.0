Return-Path: <linux-efi+bounces-4721-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F29B5131B
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9694E2839
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B11DFF7;
	Wed, 10 Sep 2025 09:46:38 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571854A21;
	Wed, 10 Sep 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497598; cv=none; b=Lc2ocACOrY3pTH6TgjsEVoPwyzwhchGaKH6bTVpbSk3CYcnlr6tP/WEPkIwpgfEaWY4Q1MKz4Z8rD5kefH3uL39BhmAmIJ9APg1p01kuTaveLq5PEF+PXXCYE1hW9iIkYwNgM3LHu3GddkV9xWRytdc2y7CdWy7RVNB56mgjYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497598; c=relaxed/simple;
	bh=TSFLMel7oCuezsYmG5MWz4klu2efMEfmF/XM9BvIWIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hEUSu4DWYnnQR7wPtS9z6DzphGoaYguVNo7zLuFP9Oqpwoflu6jkT4ZIvOs9/F35P/JHCFP0jLpWV6p+X6vA2+L+wTXpsgiKhd3hISxStL19NbOmIQLHUrJFuERkL+qU8x4uD9QjS8Y/zV9BMgJHMOPNXjfUqab/COVRee+wU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B1D116F8;
	Wed, 10 Sep 2025 02:46:27 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 384DA3F63F;
	Wed, 10 Sep 2025 02:46:30 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 0/3] arm64/ptdump: Add cmdline 'early_ptdump'
Date: Wed, 10 Sep 2025 15:16:20 +0530
Message-Id: <20250910094623.2356282-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable early kernel page table dump for debug purpose when required through
a new kernel command line option 'early_ptdump'. But first this reorganizes
ptdump_init() separating out the debugfs creation, so that it can be called
early on in setup_arch(). This also adds kernel dmesg console print support
for existing pt_dump_seq_[printf|puts]() helpers.

This series applies on v6.17-rc5

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org

Changes in V1:

- Dropped ARM64_PTDUMP_CONSOLE and instead enabled cmdline 'early_ptdump'

Changes in RFC:

https://lore.kernel.org/all/20250818091436.938517-1-anshuman.khandual@arm.com/

Anshuman Khandual (3):
  arm64/ptdump: Re-organize ptdump_init()
  arm64/ptdump: Enable console output in pt_dump_seq_[printf|puts]()
  arm64/ptdump: Add 'early_ptdump' kernel command line option

 .../admin-guide/kernel-parameters.txt         |  4 ++
 arch/arm64/include/asm/ptdump.h               |  4 ++
 arch/arm64/kernel/setup.c                     |  3 ++
 arch/arm64/mm/ptdump.c                        | 51 +++++++++++++++----
 drivers/firmware/efi/arm-runtime.c            |  4 +-
 5 files changed, 53 insertions(+), 13 deletions(-)

-- 
2.25.1


