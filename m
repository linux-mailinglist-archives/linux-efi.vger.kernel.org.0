Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242F655E3CB
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbiF1Mxz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 08:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiF1Mxy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 08:53:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16DE12ED50;
        Tue, 28 Jun 2022 05:53:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B90C152B;
        Tue, 28 Jun 2022 05:53:54 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 971A53F5A1;
        Tue, 28 Jun 2022 05:53:52 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 0/4] ACPI: Enable Platform Runtime Mechanism(PRM) support on ARM64
Date:   Tue, 28 Jun 2022 13:53:42 +0100
Message-Id: <20220628125346.693304-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.0
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

Hi,

This tiny series is to enable Platform Runtime Mechanism(PRM) support on
ARM64. Not much changes. Just enabling the build and moving the config
option so that it is not listed under the topmost menu for ARM64.

Regards,
Sudeep

v1[1]->v2:
	- Changed arch_efi_call_virt() to use typeof instead of forced
	  typecasting to void pointer
	- Added change in PRMT driver to move handler_addr type to void
	  pointer

[1] https://lore.kernel.org/linux-acpi/20220624152331.4009502-1-sudeep.holla@arm.com

Sudeep Holla (4):
  ACPI: PRM: Change handler_addr type to void pointer
  arm64: efi: Simplify arch_efi_call_virt() macro by using typeof()
  ACPI: Enable Platform Runtime Mechanism(PRM) support on ARM64
  ACPI: Move PRM config option under the main ACPI config

 arch/arm64/include/asm/efi.h |  3 +--
 drivers/acpi/Kconfig         | 30 +++++++++++++++---------------
 drivers/acpi/prmt.c          |  4 ++--
 3 files changed, 18 insertions(+), 19 deletions(-)

--
2.37.0

