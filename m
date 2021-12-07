Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8DC46B16D
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 04:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhLGDZC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 22:25:02 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:38459 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233757AbhLGDZC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 22:25:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UziBEeD_1638847288;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0UziBEeD_1638847288)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Dec 2021 11:21:29 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, ardb@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH 0/2] ghes_edac: refactor memory error reporting to avoid code duplication
Date:   Tue,  7 Dec 2021 11:21:23 +0800
Message-Id: <20211207032123.76226-1-xueshuai@linux.alibaba.com>
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

- Patch 01 is to introduces cper_*(), into ghes_edac_report_mem_error(),
  this can avoid bunch of duplicate code lines;
- Patch 02 is to wrap up error status decoding logics and reuse it in
  cper_print_mem().


Shuai Xue (2):
  ghes_edac: refactor memory error location processing
  ghes_edac: refactor error status fields decoding

 drivers/edac/ghes_edac.c    | 197 +++++++-----------------------------
 drivers/firmware/efi/cper.c |  49 ++++++++-
 include/linux/cper.h        |   3 +
 3 files changed, 85 insertions(+), 164 deletions(-)

-- 
2.20.1.12.g72788fdb

