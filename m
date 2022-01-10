Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E845548A16A
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 22:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbiAJVIb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 16:08:31 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:4773 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343748AbiAJVIb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 16:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1641848911; x=1673384911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yjO6U4uKoARUGKtvAbqdxTxSWwveKOu34rLs2Z2ZGuM=;
  b=qLL9EhyfLOK1ylePavhAzjwfK0+DZAgpm3REyXKgB1vE36X34AI/ubRP
   bMT4RDkd/VwBno/dpcars0qQVv9jKD0eC0WEF9AlmgfgkfIBZYCtMna4C
   BK2L7zV3RyrKl3IV5BQ5uS9cRQfpB7UHIM7Ih0fbbkRt2oNPywgWVUSD8
   8=;
X-IronPort-AV: E=Sophos;i="5.88,278,1635206400"; 
   d="scan'208";a="164755166"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 10 Jan 2022 21:08:30 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com (Postfix) with ESMTPS id 62C99C387B;
        Mon, 10 Jan 2022 21:08:27 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 10 Jan 2022 21:08:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 10 Jan 2022 21:08:26 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.26 via Frontend Transport; Mon, 10 Jan 2022 21:08:25
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 82869A1; Mon, 10 Jan 2022 21:08:25 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-arm-kernel@lists.infradead.org>, <rppt@kernel.org>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>, <ardb@kernel.org>,
        <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kexec@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <geert+renesas@glider.be>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 0/3] usable memory range fixes (arm64/fdt/efi)
Date:   Mon, 10 Jan 2022 21:08:06 +0000
Message-ID: <20220110210809.3528-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
moved capping memory ranges using the FDT-specified linux,usable-memory-range
to the FDT code. This property is used to specify the memory range that
a crash kernel runs in.

While this correctly filters any memory ranges that come from the DT,
this breaks crash kernels on arm64 EFI systems. In these cases, DT is used
for the usable-memory-range property, but the actual memory ranges
come from EFI. Since the call to filter them was moved to the FDT
code, which runs before the EFI init code, the EFI ranges are not
filtered anymore, leading to the crash kernel using memory that
it shouldn't.

This set fixes the the issue by having the EFI code cap its
memory ranges too, and defining a common interface for both the
DT and EFI code to use.

These changes stick to the "firmware code should cap its own memory ranges"
idea, using a common memblock interface. An alternative would be to
use an FDT-specific interface as before, called from arm64_memblock_init,
but having things a little more generalized seemed like a good idea.

This is only a functional change on architectures that have both
DT and EFI, and a usable-memory-range property (which is just arm64).
On any other architecture, usable_size will not be set, leading to a
memblock_cap_memory_range call with 0 size, which is a no-op.

Frank van der Linden (3):
  memblock: define functions to set the usable memory range
  of: fdt: use memblock usable range interface
  efi: enforce usable memory range after reserving regions

 drivers/firmware/efi/efi-init.c |  7 +++++++
 drivers/of/fdt.c                |  3 ++-
 include/linux/memblock.h        |  2 ++
 mm/memblock.c                   | 37 +++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.32.0

