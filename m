Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4F58F9E0
	for <lists+linux-efi@lfdr.de>; Thu, 11 Aug 2022 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiHKJRa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Aug 2022 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiHKJR3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Aug 2022 05:17:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E83A3DBCD;
        Thu, 11 Aug 2022 02:17:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7779113E;
        Thu, 11 Aug 2022 02:17:27 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (unknown [10.169.212.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F3D73F70D;
        Thu, 11 Aug 2022 02:17:21 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, toshi.kani@hpe.com, Jia He <justin.he@arm.com>
Subject: [PATCH 0/2] Modularize ghes_edac driver
Date:   Thu, 11 Aug 2022 09:17:11 +0000
Message-Id: <20220811091713.10427-1-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in
apci_init()") introduced a bug that ghes_edac_register() would be invoked
before edac_init(). Because at that time, the bus "edac" hasn't been even
registered, this created sysfs /devices/mc0 instead of
/sys/devices/system/edac/mc/mc0 on an Ampere eMag server.

The solution is modularizing the ghes_edac driver.

I tested the cases as follows:
1. build test with ghes_edac built-in and module on Aarch64
2. build test with ghes_edac built-in and module on x86_64
3. boot test with ghes_edac built-in and module on Aarch64
4. modprobe and -r for multiple times on Aarch64.
 
Jia He (2):
  efi/cper: export several helpers for ghes edac to use
  EDAC/ghes: Modularize ghes_edac driver to remove the dependency on
    ghes

 drivers/acpi/apei/ghes.c    | 49 ++++++++++++++++++++++--
 drivers/edac/Kconfig        |  4 +-
 drivers/edac/ghes_edac.c    | 74 ++++++++++++++++++++++++++-----------
 drivers/firmware/efi/cper.c |  3 ++
 include/acpi/ghes.h         | 33 ++++-------------
 5 files changed, 110 insertions(+), 53 deletions(-)

-- 
2.25.1

