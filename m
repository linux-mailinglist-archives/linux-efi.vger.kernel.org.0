Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A58469492
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 11:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242015AbhLFLCB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 06:02:01 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48408
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241972AbhLFLCA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 06:02:00 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EAA933F1AF
        for <linux-efi@vger.kernel.org>; Mon,  6 Dec 2021 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638788310;
        bh=vaFAezChlajkTZ7fI5kVmIBThbHyfEUEZ5Atc7Q1k0c=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bHfm6d6hMwr9/pqH6cSF7vpsVAZdrWbO5cgm4I6uBsfJ3QCBoAMVLJCWSDqC5a07c
         wkxqQu4gJtatnrEjb14aP6Kjg9uWuhY6GK4CndVp4TJ9QbD2G3cotZ1i+yC5SHIcD2
         bWzHJSrqs153FvhoGdXWZkfepHlwDuG2GIC6cBekQ3tfwvqIcsRSwsLi3IVqlmBu0K
         +uPgPlxR/91DYLsGWGpkClDHXK8kjQTBiVe7lVebeQbBpN1hwTSnx2ifXMnklaQHet
         5Ommud6u9eb3nv3BDkFEB9WDv71KbzDbTsob4OluQcTl2fOjsDbCkX+sv3QplMqyrJ
         0j6eZ3BYn2hkw==
Received: by mail-wm1-f72.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso5916653wmd.8
        for <linux-efi@vger.kernel.org>; Mon, 06 Dec 2021 02:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vaFAezChlajkTZ7fI5kVmIBThbHyfEUEZ5Atc7Q1k0c=;
        b=g38oSsLqbUPjtUrhMUmnM0RNfVCYo1OA10qLXZNRBuPKsrem82nzG7tHGAtgtH/Hem
         QO+93YUyNoqXOlWVPmPIf6eIFDwesZZApU6hmtqVMp8gxwBRWOAEvO9YdKUeQbwwBzrH
         KcpHemjDxOEC0G/Mpacz0AlQJkPxxHMijuEQoOOezDmI+lPwQQIkgS2yofldre3+lY/C
         0DFSCc0qyRgmoODNAEvJGLSVEQW8Q5jMVK9cp2VKnYmAGDzwu7aE5XPpUebDWFH1UCNH
         dm56QpbPZKAESenHK61/yH3oftkA+Da36dQau9Mn3G6n5vXG0dh+3tHOzHJDn/GjQUpP
         p91g==
X-Gm-Message-State: AOAM532hUTRuzc8LhXgh8cMnOcEzq/18Wn+tHXPgbnNj+nqHaNB2Q6xc
        XRkgWbYOxnp5v/j0x5sZ+TrUhNFIeH6UsXqzK41ifKW4+MtHKhaSD3cZMgqQCgqaCxgN/DGRZjz
        UdqpltjIvizzh6yg1f2wle9nLuA5jj7Gk91jSnQ==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr42470478wrs.108.1638788310551;
        Mon, 06 Dec 2021 02:58:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTo58Hg1PMnpuTdwL1M+XagtJxq1YdEIKgI5MBOpZMxGV21fm3kTBfxG4m0nNb6mKYd2DewQ==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr42470463wrs.108.1638788310400;
        Mon, 06 Dec 2021 02:58:30 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id p27sm10378487wmi.28.2021.12.06.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:58:30 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v3 11/13] Documentation: riscv: Add sv48 description to VM layout
Date:   Mon,  6 Dec 2021 11:46:55 +0100
Message-Id: <20211206104657.433304-12-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

sv48 was just introduced, so add its virtual memory layout to the
documentation.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 Documentation/riscv/vm-layout.rst | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index 1bd687b97104..5b36e45fef60 100644
--- a/Documentation/riscv/vm-layout.rst
+++ b/Documentation/riscv/vm-layout.rst
@@ -61,3 +61,39 @@ RISC-V Linux Kernel SV39
    ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | modules, BPF
    ffffffff80000000 |   -2    GB | ffffffffffffffff |    2 GB | kernel
   __________________|____________|__________________|_________|____________________________________________________________
+
+
+RISC-V Linux Kernel SV48
+------------------------
+
+::
+
+ ========================================================================================================================
+      Start addr    |   Offset   |     End addr     |  Size   | VM area description
+ ========================================================================================================================
+                    |            |                  |         |
+   0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm
+  __________________|____________|__________________|_________|___________________________________________________________
+                    |            |                  |         |
+   0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
+                    |            |                  |         | virtual memory addresses up to the -128 TB
+                    |            |                  |         | starting offset of kernel mappings.
+  __________________|____________|__________________|_________|___________________________________________________________
+                                                              |
+                                                              | Kernel-space virtual memory, shared between all processes:
+  ____________________________________________________________|___________________________________________________________
+                    |            |                  |         |
+   ffff8d7ffee00000 |  -114.5 TB | ffff8d7ffeffffff |    2 MB | fixmap
+   ffff8d7fff000000 |  -114.5 TB | ffff8d7fffffffff |   16 MB | PCI io
+   ffff8d8000000000 |  -114.5 TB | ffff8f7fffffffff |    2 TB | vmemmap
+   ffff8f8000000000 |  -112.5 TB | ffffaf7fffffffff |   32 TB | vmalloc/ioremap space
+   ffffaf8000000000 |  -80.5  TB | ffffef7fffffffff |   64 TB | direct mapping of all physical memory
+   ffffef8000000000 |  -16.5  TB | fffffffeffffffff | 16.5 TB | kasan
+  __________________|____________|__________________|_________|____________________________________________________________
+                                                              |
+                                                              | Identical layout to the 39-bit one from here on:
+  ____________________________________________________________|____________________________________________________________
+                    |            |                  |         |
+   ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | modules, BPF
+   ffffffff80000000 |   -2    GB | ffffffffffffffff |    2 GB | kernel
+  __________________|____________|__________________|_________|____________________________________________________________
-- 
2.32.0

