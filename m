Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F66605E5
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jan 2023 18:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjAFRrp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Jan 2023 12:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbjAFRra (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 Jan 2023 12:47:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A9CE18
        for <linux-efi@vger.kernel.org>; Fri,  6 Jan 2023 09:47:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6273161CB6
        for <linux-efi@vger.kernel.org>; Fri,  6 Jan 2023 17:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF22C433EF;
        Fri,  6 Jan 2023 17:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027248;
        bh=3vHzVE3ATz/h7AEpWm2ma7G8J5And5yeY2tgzOFOE5Y=;
        h=From:To:Cc:Subject:Date:From;
        b=O8GPmjBFagy7ddXg2XeflNlbBvWRc+u3i1TUQHDBYe861gkCa1d5rJLXAzYCalcHu
         lwpUF92hTumlNrUGPbsjOCSldm6xhTuwCIGFlcOUQEmdqdkpgSn38UbAkNO7wdNsJe
         rxX/qLI0k26kdYJwuGsYH2LemX4WLf+99/wgBlc2cEVb6y1AXR+oPfn5+XRCC2dmjP
         PRiLXTynmXgBk2KQ+PqhmHc/p+XZn1quMsGjUv2f3H1XWZQ42SVYuBLZ6uz+zx63+1
         s7b8cFzwAdvJRjd6aOG2y1Y0YTfHwFL6RsKV+FVsMC13aIBndqLNXVdfKymO6K4PZ+
         Udt91yh0dg5oA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee@kernel.org>
Subject: [PATCH v3 0/2] efi: Follow-up fixes for EFI runtime stack
Date:   Fri,  6 Jan 2023 18:47:01 +0100
Message-Id: <20230106174703.1883495-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=ardb@kernel.org; h=from:subject; bh=3vHzVE3ATz/h7AEpWm2ma7G8J5And5yeY2tgzOFOE5Y=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjuF6TummHytSd1zyVmT/ov5qlI1jUh+xm/m0B5bNg zuVQoA6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY7hekwAKCRDDTyI5ktmPJFyfDA CdOX79WZLHh2YWIE4pU356JwLs4OV+9kyM7WJwgcP5XQQRXUKP7yEuLLyEpYT+NV2/MDa/OpV2sik/ wcIfh73m8ClLvrDKJbjIJ2b9tQQePF6DXTZdGvK1T+Z17xJsd5tMbBRUlOaJVLuK+pEvB1g+14tvjc T+y7h8ix6ocCemfPAmE/BNxIFe1FKkwRKhoPOgAEjmGuq/7tHKa+mJb+mb/Q9O/Sw4/kSJjDoVVfB4 2c9WN4bx7lb5LSKpnkBVJQ5eauXxjPT1rdTCyiMah0ZR7K1pvbcOXvtNRkzN2v5VDY1eFdaoiqW1nL 6DLLdcKnfFaUMW0LiMM2vhpbN+zh9dq9xBy56g+MyqzXVMVohE7t9nQX3oWmLPurPoukzFLXBhB6zi PsU6YnV49CRZEcqq2GlXr1ZdFtPHQYtc94SznM19+ZT5YWDyvdd1xUzz0ADx1oZCmEuVy1PP8QcmEp MJq5q0CwQOpUXtT7riexUYWTju3bAxairwusradVYpDHE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit ff7a167961d1b ("arm64: efi: Execute runtime services from a
dedicated stack") introduced a dedicated stack for EFI runtime services,
in an attempt to make the execution of EFI runtime services more robust,
given that they execute at the same privilege level as the kernel.

However, this stack needs to be declared to the stacktrace machinery,
which is careful not to walk the stack when it leads into memory regions
that are not known to be allocated for stack use.

Also, given that the ACPI code may invoke the low-level EFI runtime call
wrapper without using the dedicated kernel thread and workqueue, we
should take this into account when trying to gracefully handle
synchronous exceptions.

Changes since v2:
- clear efi_rt_stack_top[-1] from asm code, and use READ_ONCE() to read
  its value when not holding the spinlock, to ensure that all accesses
  are safe under concurrency;
- add Mark's ack to patch #2

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lee Jones <lee@kernel.org>

Ard Biesheuvel (2):
  arm64: efi: Avoid workqueue to check whether EFI runtime is live
  arm64: efi: Account for the EFI runtime stack in stack unwinder

 arch/arm64/include/asm/efi.h        |  9 +++++++++
 arch/arm64/include/asm/stacktrace.h | 15 +++++++++++++++
 arch/arm64/kernel/efi-rt-wrapper.S  |  6 ++++++
 arch/arm64/kernel/efi.c             |  3 ++-
 arch/arm64/kernel/stacktrace.c      | 12 ++++++++++++
 5 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.39.0

