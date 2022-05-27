Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A3A5358B1
	for <lists+linux-efi@lfdr.de>; Fri, 27 May 2022 07:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbiE0FRw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 May 2022 01:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiE0FRw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 May 2022 01:17:52 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F23B3135E
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 22:17:51 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e66so3033901pgc.8
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 22:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bo7vfeOGvTqy7+ek2jm2BgVJNmJVKnDylnVmJnH5dBQ=;
        b=A0e0u/vU8sFpcECwKUCSMHshNFrNpB5C7Jw3L6/3VzvT/hnFEoZulzlvFpSjOuTwIo
         woirevymLuyT0zzsHC0l+19jSxJcQaIT5idqdWueuzzVVvGUAIBu5K3/FCqfFAWH3IyX
         fIyzG7ztJFLkiouA7HSviJpPb5KAmCc1aP+iZZmDsd1zW3WZDNaTRcHRSPMq/rwPaiwd
         dyHIbFS1gBFAOJVAjD7bc1BAJrtMydXmQm6DOJp2MCIUb6kQKp92U2PuTdt8bWQTe3+k
         eLMZJZeJo/F0AlGZP+N3SHc0MW77t1iSbQ7kY54mVeDKJeTCpZwIZ3kWcSaQxHQ8wYEC
         P/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bo7vfeOGvTqy7+ek2jm2BgVJNmJVKnDylnVmJnH5dBQ=;
        b=Vs8rNFVau1k6bbRhaMdEAoeKZ5fPLyO7iupbt8gkIJJl/fFEMtjLGoOgjOa65l4ynp
         RXMFVxSpV1fzB2Ih0IV8uy5Yh7RmVct59Ph9KSCt2O4tQV0obXR1CQ8N7vwSEFFbAF4J
         wRrf1LOhlzmCwpy6VXbIFdAJZ+7QbcGM7n5YcLkOEFZ2yB+xTLHp6pOGIW0og7zSjScx
         bhqBSiXdGdW5Bx+nx9tX63zsEJ+EG9tjrSLJ5ylmYZYPqrEwaaStxsQXYPNsBZUcBiAy
         Q5pIz32VGbBj/zSoJzq5/b8Eqt7c6bXAbWRkYcuMqdz9bfTw8Jc/S4fRWC/u5AM88M03
         r2Ow==
X-Gm-Message-State: AOAM531TNCOppavpGYze8aexkPbx99dPZexk2/MmYBzt3vYhTKStG4dD
        +kPXRz1T9cLHmB3v+kphAhotBA==
X-Google-Smtp-Source: ABdhPJxVlb+cwlsnxtpW82xCW2ZFvh8bXchHJ9vgdGIceBcAGSwcVX6HjV+NMWc5hDe7LkQbcjvr3g==
X-Received: by 2002:a05:6a00:1487:b0:518:b952:889b with SMTP id v7-20020a056a00148700b00518b952889bmr20154031pfu.43.1653628670792;
        Thu, 26 May 2022 22:17:50 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id j34-20020a634a62000000b003c14af5063fsm2459003pgl.87.2022.05.26.22.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 22:17:50 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V3 0/5] Support for 64bit hartid on RV64 platforms
Date:   Fri, 27 May 2022 10:47:38 +0530
Message-Id: <20220527051743.2829940-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The hartid can be a 64bit value on RV64 platforms. This series updates
the code so that 64bit hartid can be supported on RV64 platforms.

The series has been tested on both RV32 and RV64 qemu platforms.

Changes since V2:
	1) Modified commit messages to mention RV64 and add RB tags.

Changes since V1:
	1) Updated RB tag for PATCH 1 and PATCH3
	2) Type Casting NR_CPUS before comparing with hartid in PATCH 2
	3) Changed commit message of PATCH 2 to provide details about
	   the bug it is fixing.
	4) Updated PATCH 5 for unaligned 64bit read


Sunil V L (5):
  riscv: cpu_ops_sbi: Add 64bit hartid support on RV64
  riscv: spinwait: Fix hartid variable type
  riscv: smp: Add 64bit hartid support on RV64
  riscv: cpu: Add 64bit hartid support on RV64
  riscv/efi_stub: Add 64bit boot-hartid support on RV64

 arch/riscv/include/asm/processor.h        |  4 ++--
 arch/riscv/include/asm/smp.h              |  4 ++--
 arch/riscv/kernel/cpu.c                   | 26 +++++++++++++----------
 arch/riscv/kernel/cpu_ops_sbi.c           |  4 ++--
 arch/riscv/kernel/cpu_ops_spinwait.c      |  4 ++--
 arch/riscv/kernel/cpufeature.c            |  6 ++++--
 arch/riscv/kernel/smp.c                   |  4 ++--
 arch/riscv/kernel/smpboot.c               |  9 ++++----
 drivers/clocksource/timer-riscv.c         | 15 +++++++------
 drivers/firmware/efi/libstub/riscv-stub.c | 13 +++++++++---
 drivers/irqchip/irq-riscv-intc.c          |  7 +++---
 drivers/irqchip/irq-sifive-plic.c         |  7 +++---
 12 files changed, 60 insertions(+), 43 deletions(-)

-- 
2.25.1

