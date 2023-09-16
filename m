Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66A57A3069
	for <lists+linux-efi@lfdr.de>; Sat, 16 Sep 2023 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbjIPNDt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Sep 2023 09:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjIPND3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 Sep 2023 09:03:29 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532ADDD;
        Sat, 16 Sep 2023 06:03:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VsA36sM_1694869397;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsA36sM_1694869397)
          by smtp.aliyun-inc.com;
          Sat, 16 Sep 2023 21:03:20 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, robert.moore@intel.com
Cc:     linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        xueshuai@linux.alibaba.com, baolin.wang@linux.alibaba.com
Subject: [RFC PATCH 0/9] [RFC PATCH 0/9] Use ERST for persistent storage of MCE and APEI errors 
Date:   Sat, 16 Sep 2023 21:03:07 +0800
Message-Id: <20230916130316.65815-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In certain scenarios (ie. hosts/guests with root filesystems on NFS/iSCSI
where networking software and/or hardware fails, and thus kdump fails), it
is necessary to serialize hardware error information available for
post-mortem debugging. Save the hardware error log into flash via ERST
before go panic, the hardware error log can be gotten from the flash after
system boot successful again, which is very useful in production.

On X86 platform, the kernel has supported to serialize and deserialize MCE
error record by commit 482908b49ebf ("ACPI, APEI, Use ERST for persistent
storage of MCE"). The process involves two steps:

- MCE Producer: When a hardware error is detected, MCE raised and its
  handler writes MCE error record into flash via ERST before panic
- MCE Consumor: After system reboot, /sbin/mcelog run, it reads /dev/mcelog
  to check flash for error record of previous boot via ERST

After /dev/mcelog character device deprecated by commit 5de97c9f6d85
("x86/mce: Factor out and deprecate the /dev/mcelog driver"), the
serialized MCE error record, of previous boot in persistent storage is not
collected via APEI ERST.

This patch set include two part:

- PATCH 1-3: rework apei_{read,write}_mce to use pstore data structure and emit
  the mce_record tracepoint, enabling the collection of MCE records by the
  rasdaemon tool.
- PATCH 4-9: use ERST for persistent storage of APEI errors, and emit
  tracepoints for CPER sections, enabling the collection of MCE records by the
  rasdaemon tool.

Shuai Xue (9):
  pstore: move pstore creator id, section type and record struct to
    common header
  ACPI: APEI: Use common ERST struct to read/write serialized MCE record
  ACPI: APEI: ERST: Emit the mce_record tracepoint
  ACPI: tables: change section_type of generic error data as guid_t
  ACPI: APEI: GHES: Use ERST to serialize APEI generic error before
    panic
  ACPI: APEI: GHES: export ghes_report_chain
  ACPI: APEI: ESRT: kick ghes_report_chain notifier to report serialized
    memory errors
  ACPI: APEI: ESRT: print AER to report serialized PCIe errors
  ACPI: APEI: ESRT: log ARM processor error

 arch/x86/kernel/cpu/mce/apei.c | 82 +++++++++++++++-------------------
 drivers/acpi/acpi_extlog.c     |  2 +-
 drivers/acpi/apei/erst.c       | 51 ++++++++++++---------
 drivers/acpi/apei/ghes.c       | 48 +++++++++++++++++++-
 drivers/firmware/efi/cper.c    |  2 +-
 fs/pstore/platform.c           |  3 ++
 include/acpi/actbl1.h          |  5 ++-
 include/acpi/ghes.h            |  2 +-
 include/linux/pstore.h         | 29 ++++++++++++
 9 files changed, 150 insertions(+), 74 deletions(-)

-- 
2.41.0

