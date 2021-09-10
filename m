Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471B64072FC
	for <lists+linux-efi@lfdr.de>; Fri, 10 Sep 2021 23:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhIJVfr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Sep 2021 17:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbhIJVfh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Sep 2021 17:35:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CEAC061764
        for <linux-efi@vger.kernel.org>; Fri, 10 Sep 2021 14:34:21 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id u21so2803047qtw.8
        for <linux-efi@vger.kernel.org>; Fri, 10 Sep 2021 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=D+i2AnwxDkTLpcWnVONgSwNuAMh+694TDo7hwMxSXcw=;
        b=Wifgrll/PAir/lmfOitnGq4WqkX1FjzwWJz5yE220OkszS7zCqKt5Y74FMSTORh2q8
         PjvJHDWgt6mDfqVoYMNeZsAZP6OmZFG0MbseCFPWVU+q24KFZcpyWHkWJMt+mmrFfXr+
         C+TU6leZk0m/pM5t1CvYd5lE6/axpwTWVTjuHJ+x4FeELp0sKvx+UwoIwV/WfbVQ9/Od
         tCZRfTYUHxVfEs/MU/D+WhdCXg4j7HRdfvmmXrHGsDIr+qe+VVwOZPFcgAlsNo49uTC9
         AyVBOYeHFNmCJv2ftFu+Lh9RqeAca08HmelUso55yopE5zlFNHjox1sr4unIavT2nTfG
         o4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=D+i2AnwxDkTLpcWnVONgSwNuAMh+694TDo7hwMxSXcw=;
        b=ZdGRkvAF+0A3fFXOfuc7hvswLB2CCEAoSPOusyNg/8q+xqR9PXMkaHU+U5LEG9iaKX
         Ks8Y5moLSaJVvGbZJ1cxTZN+TDeSOoyitEDak9l4HLdjyV554wte9+Us4Y+1/oWPZZoX
         o5XoR6NsG40UTaOMleCHIG4fXYHRysJqbsAM+Rp59FjzKo5vZT8tUFi+fszYKU3a7u9G
         4IbA67Z44g1F639fIw1vmPnsaGyHrqK9t/WRyd+5OXp8988ockUvBX5W4OAt10G0TRty
         5MwWDjlbmB0TMB3c3SGG8hpcfc40TOUN//V8BbKP7H8M4OYC5wXmLQp+GSsFFpJLw/jy
         WNDw==
X-Gm-Message-State: AOAM532LllVaE2GaXVn5FAAz9Nk4TmHQ8505ixogN7/pM3gvC4bs8tuC
        q2IQngUPoq5VeoNei182x1vqxHeX2CoXt4uH9F/zpj3rm/+yZsGxs+QGfH47gOK9R2IDKpUjKBL
        c3UKJ3f68QpxO95g7Osjgym/GoJXyMwLaEEllrnYzNLdnJ7W7ogNNKiHRbr8j0hmCYoWPJpQHtI
        wkWuCKmml4jZmVS/k=
X-Google-Smtp-Source: ABdhPJxCoGqCE+G+GSa7HwHqRzLNs+NCqRuwXnyBTsr8rbTQk2wr2+tC8tzvMHHx7QLSrjYprJILWQ==
X-Received: by 2002:ac8:60d9:: with SMTP id i25mr9889314qtm.406.1631309659565;
        Fri, 10 Sep 2021 14:34:19 -0700 (PDT)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id b7sm3932191qtt.12.2021.09.10.14.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 14:34:19 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com
Subject: [PATCH 0/1] [RFC] x86: Export information about hardware memory encryption to sysfs
Date:   Fri, 10 Sep 2021 18:33:36 -0300
Message-Id: <20210910213337.48017-1-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Show the value of EFI_MEMORY_CPU_CRYPTO of the system memory as a whole
on each memory node in sysfs.

This is a first step in a serie of patches for exporting the needed
information to userspace to determine if a machine is doing using
Intel's TME or MKTME.

In a next patch I'm going to export if TME/MKTME is activated by the
BIOS to sysfs, since right now for the user, this information is only
available in the kernel logs, and it's not appropiate for fwupd to scan
the boot logs just to parse an integer. I'm looking for suggestions
for where to store this value.

Martin Fernandez (1):
  x86: Export information about hardware memory encryption to sysfs

 Documentation/ABI/testing/sysfs-devices-node | 11 +++
 arch/x86/include/asm/numa.h                  |  2 +
 arch/x86/mm/numa.c                           |  5 ++
 arch/x86/mm/numa_emulation.c                 |  2 +-
 arch/x86/platform/efi/efi.c                  | 27 +++++++
 drivers/base/node.c                          | 80 +++++++++++++++++++-
 include/linux/efi.h                          |  7 ++
 include/linux/node.h                         |  5 ++
 8 files changed, 137 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node


base-commit: 0bcfe68b876748762557797a940d0a82de700629
--
2.30.2

-- 


This e-mail and any attachments may contain information that is 
privileged, confidential,  and/or exempt from disclosure under applicable 
law.  If you are not the intended recipient, you are hereby notified that 
any disclosure, copying, distribution or use of any information contained 
herein is strictly prohibited. If you have received this transmission in 
error, please immediately notify the sender and destroy the original 
transmission and any attachments, whether in electronic or hard copy 
format, without reading or saving.












