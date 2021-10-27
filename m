Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9535A43D1EE
	for <lists+linux-efi@lfdr.de>; Wed, 27 Oct 2021 21:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbhJ0T6f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Oct 2021 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbhJ0T6f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Oct 2021 15:58:35 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C56C061745
        for <linux-efi@vger.kernel.org>; Wed, 27 Oct 2021 12:56:09 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h11so2522080qvk.4
        for <linux-efi@vger.kernel.org>; Wed, 27 Oct 2021 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RxkC08Ya/onM0Zfgr9OBmgvN+l1f5cx6s4UfOynb4lM=;
        b=gL2MvQADekNF0oWYA/nHaYiSskDTD4/GFGqSLL+sU/zw0tjVfoVOdGitXjG9lVSV4R
         4IQy3vz9mRPmZe4oajS8NQMMV3p8mrv7Ng5+bckrLwDH0Sk8FHJx2ZSp+lQ4sc+eqcHV
         QOHQixCcD3mPv45+19nqwd7NNzppdNBGkHw+COxCnP5EO66fNW5gbZm4mQ7TyF895d2T
         WqndopvTOkygXXo+fVYKvNrUO/dHw/4yszp/2XxaALGoFHWoo/AhcsedGmj8wmnPR+8o
         trWznpYreSwGQMq7eHzibHYkHD70NWDctVFMOaH4J34kaQv0NpslI6edpK+D/SELnuNr
         7aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RxkC08Ya/onM0Zfgr9OBmgvN+l1f5cx6s4UfOynb4lM=;
        b=Z1/fts+XDYdJPoSugjm3xrFJ38OauL+s1JE0DAVk9VSuv5XBCmqiYT+f3P/blm29Kc
         bjC2BVPxtOKQA3Va5eROxG5zMnl+sQ0nTMMy8BVWgg0zhoE3jqDAWCYj+bkMb/pgnR3H
         fdoZ63k9MI+PYtfCto91EFpUF/gpJTuIyIvRVqjv6vvF1Ksyj/UpSwEW/jBDSSn/2JKG
         UOran0EzCJtdC0LT7YnEW3fIcr/bJ6cEyHXWyD1qMa5gj73F4bdSDPcysUCgwW635Z4L
         UIxNTgOhbCSYhtZ28evKpnI8V1gezIaFltI4D5KPq39YLieWO5wRAzp25SMsDYFWlPg3
         hYSQ==
X-Gm-Message-State: AOAM533KPQShjgZiJ2u/TALwjLKjj2Cf+dux6pY9/WKzgTgdI8OIanif
        xqMHy5yh7l3pY5nrWIMQ/6a502M8ZNUSq9EBu3lbz+61YsXP4c7JtbIohJb0LT/eBED1I5zChv6
        l0GgIjzEJL0RzmXHPh4ekyuzCFq1TVQahGiU6IAAeD7rp1Grgz1JUxs8VuicGRjntO+M+D3y/Nm
        qhwvS5YINS2aZt+TA=
X-Google-Smtp-Source: ABdhPJxehUt/tNtBSMoMFfzAS98h4RXEoiQRAuOspNlEsHA1/ZCVCGvCHKvMvsSLfk46ontQtgtW1Q==
X-Received: by 2002:a05:6214:e84:: with SMTP id hf4mr31700576qvb.38.1635364567977;
        Wed, 27 Oct 2021 12:56:07 -0700 (PDT)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id c13sm594483qtc.42.2021.10.27.12.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 12:56:07 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com
Subject: [PATCH v2 0/5] [RFC] x86: Export information about hardware memory encryption to sysfs
Date:   Wed, 27 Oct 2021 16:55:06 -0300
Message-Id: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Show for each NUMA node the value of EFI_MEMORY_CPU_CRYPTO in its
memory.

This is a serie of patches for exporting the needed information to
userspace to determine if a machine is using Intel's TME or MKTME.

In a next patch I'm going to export if TME/MKTME is activated by the
BIOS to sysfs, since right now for the user, this information is only
available in the kernel logs, and it's not appropriate for fwupd to
scan the boot logs just to parse an integer. I'm looking for
suggestions for where to store this value.

Changelog v2:

The value shown in each node now only corresponds to memory in that
node in particular

Martin Fernandez (5):
  Extend memblock to support memory encryption
  Extend pg_data_t to hold information about memory encryption
  Extend e820_table to hold information about memory encryption
  Mark e820_entries as crypto capable from EFI memmap
  Show in sysfs if a memory node is able to do memory encryption

 Documentation/ABI/testing/sysfs-devices-node |  12 +++
 arch/x86/include/asm/e820/api.h              |   2 +
 arch/x86/include/asm/e820/types.h            |   1 +
 arch/x86/include/asm/numa.h                  |   7 ++
 arch/x86/kernel/e820.c                       |  32 +++++-
 arch/x86/mm/numa.c                           |   5 +
 arch/x86/mm/numa_emulation.c                 |   2 +-
 arch/x86/platform/efi/efi.c                  | 108 +++++++++++++++++++
 drivers/base/node.c                          |  72 ++++++++++++-
 include/linux/memblock.h                     |   6 ++
 include/linux/mmzone.h                       |   2 +
 include/linux/node.h                         |   1 +
 mm/memblock.c                                |  74 +++++++++++++
 mm/page_alloc.c                              |   1 +
 14 files changed, 321 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node


base-commit: 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
--
2.30.2

