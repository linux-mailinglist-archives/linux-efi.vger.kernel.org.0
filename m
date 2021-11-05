Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1C7446A8C
	for <lists+linux-efi@lfdr.de>; Fri,  5 Nov 2021 22:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhKEVa2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Nov 2021 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhKEVa2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Nov 2021 17:30:28 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657EAC061714
        for <linux-efi@vger.kernel.org>; Fri,  5 Nov 2021 14:27:48 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id bj27so8313659qkb.11
        for <linux-efi@vger.kernel.org>; Fri, 05 Nov 2021 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PulCwB12eNyvVEFqfF1lDlnZ5ON1wVcjCswJOmxvPxI=;
        b=D0kLYLFdl4MswKTPvO4QmFGg2ItyugmtfMXGFL8069wSG+VpNbJ0pavoIxyKQZByov
         bY4/sScWY4M3Z2IVoFq7YT7VpAxcimUHFpFTLONjhlD0gHbfExesEYHL5wSJucOVNbes
         X0wBAszJil8Vdf1HfwjWDZ4e6k5pa+Ibw0z1Z6ILXBXrcbJ6uIDjpWIsOlBzHWS80nIs
         oiBLqcANcdnUncpon9MfQA7Kro7vrFH3nYS+qC3Ukd2rxEMasmR84/s11tbLK6ZjwMzA
         8vlbrA0eTw619lg8RCqHKzF+5noSyULxPNh2Rbg2YfdxvvCBbvc3KqNtdZOtxJ4cyk5V
         s+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PulCwB12eNyvVEFqfF1lDlnZ5ON1wVcjCswJOmxvPxI=;
        b=YjrpQOiFdhWNGAV+zOeTdyotAFQamCHiPRsFXRX2dgPOGOX3PMfP8ShfM456cv4dm6
         KM4JK5CYtIwGkHl5zATs9WbfpBbpLceibvppl+HB/BR2q7Q6BzZp4OAKe06Yni+famFp
         DqYCI50EY+evIurkSBbNlnWHeZMtImX+m1PJNXSHt/W59ZnYIj/eI/StR8Ia17RocQMn
         Yi5E5LWrL8dTVftIJrpFlaBTxayrTSWluvHk3zPc0i2EtrmPvHaby7CMoMqnbQagcume
         HpjcB/WZBbStF2dQ7vbU0zfs1hCdM/wKtVi+9Ue9EJLgUR1k1+Tyk3yBN9yPs9YccP6q
         D6YQ==
X-Gm-Message-State: AOAM531vsNI169D9Ad+MrvCXvJbYY/dbkgBy6YrJLavrls7kHopPJVQz
        yQ5oc/WZt6BgsdZY63xdIQORzrnD7P0BwJz9VGIUWr7fRO7XCH7JODVM+1XL8Pis4y4Tf6Q8Jum
        qLcCBglvdbLuYe+1YDADFFGU6sBerKGmsTKUrHg+8QSOgczhoo2tUuAeiCXKa1luAWjNy1YC1gF
        n7jYZgX6iWqhJLH5hVgQ==
X-Google-Smtp-Source: ABdhPJyXQC8B9UDQtCWTq67NcoKtKWyQcGGHOwZGp8s7uPWR8ItLhtVghzJrFUdGK8jEvA73H46f4A==
X-Received: by 2002:a05:620a:199b:: with SMTP id bm27mr14183990qkb.298.1636147667359;
        Fri, 05 Nov 2021 14:27:47 -0700 (PDT)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id i6sm6686469qkn.14.2021.11.05.14.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 14:27:46 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alison.schofield@intel.com, alex@eclypsium.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH 0/5] x86: Show in sysfs if a memory node is able to do encryption
Date:   Fri,  5 Nov 2021 18:27:19 -0300
Message-Id: <20211105212724.2640-1-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Show for each node if every memory descriptor in that node has the
EFI_MEMORY_CPU_CRYPTO attribute.

fwupd project plans to use it as part of a check to see if the users
have properly configured memory hardware encryption capabilities. It's
planned to make it part of a specification that can be passed to
people purchasing hardware. It's called Host Security ID:
https://fwupd.github.io/libfwupdplugin/hsi.html

This also can be useful in the future if NUMA decides to prioritize
nodes that are able to do encryption.

Martin Fernandez (5):
  Extend memblock to support memory encryption
  Extend pg_data_t to hold information about memory encryption
  Extend e820_table to hold information about memory encryption
  Mark e820_entries as crypto capable from EFI memmap
  Show in sysfs if a memory node is able to do encryption

 Documentation/ABI/testing/sysfs-devices-node |  10 ++
 arch/x86/include/asm/e820/api.h              |   2 +
 arch/x86/include/asm/e820/types.h            |   1 +
 arch/x86/kernel/e820.c                       |  32 +++++-
 arch/x86/platform/efi/efi.c                  | 109 +++++++++++++++++++
 drivers/base/node.c                          |  10 ++
 include/linux/memblock.h                     |   6 +
 include/linux/mmzone.h                       |   2 +
 mm/memblock.c                                |  74 +++++++++++++
 mm/page_alloc.c                              |   1 +
 10 files changed, 245 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node


base-commit: 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
--
2.30.2

