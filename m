Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51CC4701F1
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 14:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhLJNoA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 08:44:00 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33655 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229993AbhLJNn7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Dec 2021 08:43:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-ADOcC_1639143620;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V-ADOcC_1639143620)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 21:40:22 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, ardb@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH v2 0/3] ghes_edac: refactor memory error reporting to avoid code duplication
Date:   Fri, 10 Dec 2021 21:40:16 +0800
Message-Id: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ghes_edac_report_mem_error() in ghes_edac.c is Long Method and have
Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
cper_mem_err_type_str() in drivers/firmware/efi/cper.c. In addition, the
cper_print_mem() in drivers/firmware/efi/cper.c only reports the error
status and misses its description.

This patch set is to refactor ghes_edac_report_mem_error with:

- Patch 01 is to unify memory error report format with cper;
- Patch 02 is to introduces cper_*(), into ghes_edac_report_mem_error(),
  this can avoid bunch of duplicate code lines;
- Patch 02 is to wrap up error status decoding logics and reuse it in
    cper_print_mem().

Changes since v1:
https://lore.kernel.org/all/20211207031905.61906-2-xueshuai@linux.alibaba.com/

- add a new patch to unify ghes and cper before removing duplication.
- document the changes in patch description
- add EXPORT_SYMBOL_GPL()s for cper_*()
- document and the dependency and add UEFI_CPER dependency explicitly
Thanks Robert Richter for review comments.

Shuai Xue (3):
  ghes_edac: unify memory error report format with cper
  ghes_edac: refactor memory error location processing
  ghes_edac: refactor error status fields decoding

 drivers/edac/Kconfig        |   1 +
 drivers/edac/ghes_edac.c    | 196 +++++++-----------------------------
 drivers/firmware/efi/cper.c |  86 ++++++++++++----
 include/linux/cper.h        |   3 +
 4 files changed, 105 insertions(+), 181 deletions(-)

-- 
2.20.1.12.g72788fdb

