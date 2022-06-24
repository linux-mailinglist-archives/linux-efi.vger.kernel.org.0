Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997ED559D30
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiFXPXs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiFXPXq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 11:23:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A114244A00;
        Fri, 24 Jun 2022 08:23:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DF521042;
        Fri, 24 Jun 2022 08:23:44 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41C443F534;
        Fri, 24 Jun 2022 08:23:43 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Subject: [PATCH 0/3] ACPI: Enable Platform Runtime Mechanism(PRM) support on ARM64
Date:   Fri, 24 Jun 2022 16:23:28 +0100
Message-Id: <20220624152331.4009502-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
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

Sudeep Holla (3):
  arm64: efi: Simplify arch_efi_call_virt macro by not using efi_##f##_t type
  ACPI: Enable Platform Runtime Mechanism(PRM) support on ARM64
  ACPI: Move PRM config option under the main ACPI config

 arch/arm64/include/asm/efi.h |  4 +---
 drivers/acpi/Kconfig         | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 18 deletions(-)

--
2.36.1

