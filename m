Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6A534D00
	for <lists+linux-efi@lfdr.de>; Thu, 26 May 2022 12:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346951AbiEZKLm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 May 2022 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243558AbiEZKLl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 May 2022 06:11:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2CEFEB
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 03:11:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q4so1045034plr.11
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbrC9viuiEeW+uauQj8WIm89oteJmbW6JLoMguTugSc=;
        b=n1tlol/XpCiFEfS35l5rjijwg4/uYJ7U9MDrjL2y7sQad9b2Gx/Anu2oswESXCWZfd
         DEaLurPWlXY+iTlhl+GwrL2gvQfB5oyIxpPuLHfGaHtU1Y+7arw1Pd6nQf5Aiqi4kqYj
         B6XYxw5p21vJXiPEM8+p8Mu+v0hnX1QCno2lQ8gJK7GoBpS1IvPXapBLJ5//C28agcLN
         LZGHaXJ2tx+8B9l0tqZyYQf+CnRVlEAq76lOoNMXcoarjy0Mt+DtYlpAZrUzIAf9m2g3
         NdrLi7TAmT+9uRXXV+I5T7ha65tXXvT96hGl+LrbG0pbjmovcBsbs/tWDxBFe6/T2dz/
         XvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbrC9viuiEeW+uauQj8WIm89oteJmbW6JLoMguTugSc=;
        b=Pkgpi7aAzakIfQ4R4f+kx5kSxnE6oN/CoSjAHs9LQUCjPO1kA+NrApZggHCueq+Wtz
         xuWIZg1yFInTSf8CSouPQTrD+sNN82kJF+kwr1N5z3DfGd/mGwoOcG6x6XTZtVAxzrjp
         c/5gLHLEBVhtI8fjgmVUS/Sq6Njxk3gj081Y0RhQLQ+KvT6IQD1HvgPky/gGUUVdRgcx
         a4rysVpbAD/4bHYCma3bLGGWPwnzvCfhoygVxOm3h8pOKsZO4/SKsq6Qc6Kq9Wvcvht+
         rfQMi+9YgcIYe70P6O8GaKKMu5qZVRhLSOshZCKZ5orfo4qPVlKhc8xBHlgZVvZkoBkK
         I8Bw==
X-Gm-Message-State: AOAM5320LFL++vjVAhFIubltmRKDjEnrCYnCpBYB+70lLAnCA0ms+pUr
        zKC5FqjFNQywdtA5K3/3Mk0g9Q==
X-Google-Smtp-Source: ABdhPJwngscKF0Sla2DrywGR0AnX4WF8e0baEvHwkduL7GDyUFbJRTykeW8a50dtGoiNMzsjjD40GA==
X-Received: by 2002:a17:903:2586:b0:163:5b96:d901 with SMTP id jb6-20020a170903258600b001635b96d901mr7254897plb.151.1653559898794;
        Thu, 26 May 2022 03:11:38 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b0015f309f14d0sm1114861plf.56.2022.05.26.03.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:11:38 -0700 (PDT)
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
Subject: [PATCH V2 0/5] Support for 64bit hartid on RV64 platforms
Date:   Thu, 26 May 2022 15:41:26 +0530
Message-Id: <20220526101131.2340729-1-sunilvl@ventanamicro.com>
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

Changes since V1:
	1) Updated RB tag for PATCH 1 and PATCH3
	2) Type Casting NR_CPUS before comparing with hartid in PATCH 2
	3) Changed commit message of PATCH 2 to provide details about
	   the bug it is fixing.
	4) Updated PATCH 5 for unaligned 64bit read


Sunil V L (5):
  riscv: cpu_ops_sbi: Support for 64bit hartid
  riscv: spinwait: Fix hartid variable type
  riscv: smp: Support for 64bit hartid
  riscv: cpu: Support for 64bit hartid
  riscv/efi_stub: Support for 64bit boot-hartid

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

