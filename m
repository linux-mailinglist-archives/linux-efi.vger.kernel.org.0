Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495B9497783
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jan 2022 03:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbiAXCsI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 Jan 2022 21:48:08 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40244 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235357AbiAXCsI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 23 Jan 2022 21:48:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2cQ9l9_1642992481;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V2cQ9l9_1642992481)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Jan 2022 10:48:03 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     bp@alien8.de, rric@kernel.org
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [RESEND PATCH v3 0/2] EDAC/ghes: refactor memory error reporting to avoid
Date:   Mon, 24 Jan 2022 10:47:57 +0800
Message-Id: <20220124024759.19176-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ghes_edac_report_mem_error() in ghes_edac.c is a Long Method and have
Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
cper_mem_err_type_str() in drivers/firmware/efi/cper.c. In addition, the
cper_print_mem() in drivers/firmware/efi/cper.c only reports the error status
and misses its description.

This patch set is to refactor ghes_edac_report_mem_error with:

- Patch 01 is to wrap up error status decoding logics and reuse it in
    cper_print_mem().
- Patch 02 is to introduces cper_*(), into ghes_edac_report_mem_error(),
  this can avoid bunch of duplicate code lines;


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
 drivers/firmware/efi/cper.c |  82 +++++++++++----
 include/linux/cper.h        |   3 +
 4 files changed, 102 insertions(+), 180 deletions(-)

-- 
2.20.1.12.g72788fdb

