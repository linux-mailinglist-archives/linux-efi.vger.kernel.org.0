Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3B4CBDC1
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 13:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiCCM1X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 07:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiCCM1W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 07:27:22 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289A5179274;
        Thu,  3 Mar 2022 04:26:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V67YNvg_1646310388;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V67YNvg_1646310388)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 20:26:32 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     bp@alien8.de, rric@kernel.org
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH v6 0/2] EDAC/ghes: refactor memory error reporting to avoid code duplication
Date:   Thu,  3 Mar 2022 20:26:24 +0800
Message-Id: <20220303122626.99740-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ghes_edac_report_mem_error() in ghes_edac.c is a Long Method and have
Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
cper_mem_err_type_str() in drivers/firmware/efi/cper.c. In addition, the
cper_print_mem() in drivers/firmware/efi/cper.c only reports the error
status and misses its description.

This patch set is to refactor ghes_edac_report_mem_error with:

- Patch 01 is to wrap up error status decoding logics and reuse it in
    cper_print_mem().
- Patch 02 is to introduces cper_*(), into ghes_edac_report_mem_error(),
  this can avoid bunch of duplicate code lines;
  
Changes since v5:
- Delete change summary in commit log
- Link: https://lore.kernel.org/all/20220126081702.55167-1-xueshuai@linux.alibaba.com/
- Thanks Borislav Petkov for review comments.

Changes since v4:
- Fix alignment and format problem
- Link: https://lore.kernel.org/all/20220125024939.30635-1-xueshuai@linux.alibaba.com/
- Thanks Borislav Petkov for review comments.

Changes since v3:

- make cper_mem_err_status_str table a lot more compact
- Fix alignment and format problem
- Link: https://lore.kernel.org/all/20220124024759.19176-1-xueshuai@linux.alibaba.com/
- Thanks Borislav Petkov for review comments.

Changes since v2:

- delete the unified patch
- adjusted the order of patches
- Link: https://lore.kernel.org/all/20211210134019.28536-1-xueshuai@linux.alibaba.com/
- Thanks Borislav Petkov for review comments.

Changes since v1:

- add a new patch to unify ghes and cper before removing duplication.
- document the changes in patch description
- add EXPORT_SYMBOL_GPL()s for cper_*()
- document and the dependency and add UEFI_CPER dependency explicitly
- Link: https://lore.kernel.org/all/20211207031905.61906-2-xueshuai@linux.alibaba.com/
- Thanks Robert Richter for review comments.

Shuai Xue (2):
  efi/cper: add cper_mem_err_status_str to decode error description
  EDAC/ghes: use cper functions to avoid code duplication

 drivers/edac/Kconfig        |   1 +
 drivers/edac/ghes_edac.c    | 196 +++++++-----------------------------
 drivers/firmware/efi/cper.c |  66 ++++++++----
 include/linux/cper.h        |   3 +
 4 files changed, 86 insertions(+), 180 deletions(-)

-- 
2.20.1.12.g72788fdb

