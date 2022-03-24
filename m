Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E4D4E626F
	for <lists+linux-efi@lfdr.de>; Thu, 24 Mar 2022 12:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348290AbiCXL1Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Mar 2022 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242795AbiCXL1Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Mar 2022 07:27:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9208F98E
        for <linux-efi@vger.kernel.org>; Thu, 24 Mar 2022 04:25:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so7016632wmb.4
        for <linux-efi@vger.kernel.org>; Thu, 24 Mar 2022 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HON75yKlLcLjQMxfILiHDZtc2ZUHcCFbq1pzqC9iTVw=;
        b=VxBbAmpgbVV9uu2w9d93bg+Dn5TJoAdBozzPG6eY9+pLTdqZVL8NO+NLBrfjH0ELgC
         IBWv5BkHs83Cnwwz1FSyVncnoDp/kt8/l4pSNYt2/NNWAJKI9vjWW6X+AckPVQD573eo
         x77+CJGpanods1R/S1BSO0hlnL4L15Rs12NBT1NPzPBI27HDbQ49LY5YAEvk6cRhynFG
         LIklyPEbcEubh69FSLNnrxNt+rWv9oUCUd2vt1ZsmUlpk/5HE87UFPA//gY8SnAmfDDz
         Cb8pSs5mCjpcmiWCInZU/aAUGOl6ArSpDfZjMErlK6yzaZP7st50AaqGQFQ5JjrBhsxX
         hWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HON75yKlLcLjQMxfILiHDZtc2ZUHcCFbq1pzqC9iTVw=;
        b=aYk75BTWAXP+WRWU7smD9vCRYCScevWzd9K26am2T2Kezuz+heS0z23uWAoKpuW2Ik
         SHCKkFiIUaIFIfITS+k8OuN6XhnIc3XIzi62XxhP7ZW5UVXFaq8cgTXK8SPdOT0Fp4Xv
         FT5iKY4dpJyjx4yXk7+BU8SePSBv7kPZ8AJqeX/c8FqP93CyeRidU7v2GHyaNuLGeEkq
         RkwZtM7zltQXbLYNYAWqd8eE1JNI4Mew25IMIVQvrXmqgzzJew3ERTpz0HiwcK+sQnrA
         EAuPYNtUs2h/mRIKluFxdJIGblBhObKguBgseKbW64BZZTSjp6pjEHNXaRH6Ays+TJHH
         0mdw==
X-Gm-Message-State: AOAM530OhfJAj7q+gOaeZCbBT+7QxLaZ1I7Uy3Fmr+BfbF/WAR/DXEm2
        udpzy5ob7eiAzoO0i4c11ih5wg==
X-Google-Smtp-Source: ABdhPJwInRBIMpTMz3jhpJ6WDusZ8UQcn5vjN+E8W2Td7HLiLU2maFKA2uPGJqZmMzQzd/igFk2LLw==
X-Received: by 2002:a7b:c24d:0:b0:38c:68a4:eb4b with SMTP id b13-20020a7bc24d000000b0038c68a4eb4bmr13501836wmj.108.1648121151030;
        Thu, 24 Mar 2022 04:25:51 -0700 (PDT)
Received: from localhost.localdomain ([49.206.7.17])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d64a3000000b00203ed35b0aesm3875350wrp.108.2022.03.24.04.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 04:25:50 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Abner Chang <abner.chang@hpe.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 0/1] RISCV_EFI_BOOT_PROTOCOL support in linux
Date:   Thu, 24 Mar 2022 16:55:33 +0530
Message-Id: <20220324112534.209959-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch adds support for getting the boot hart ID using new
RISCV_EFI_BOOT_PROTOCOL in linux efi stub. While there is an existing
solution of passing the boot hart ID through Device Tree, it doesn't work for
ACPI. Hence an EFI protocol protocol is recommended which works for both DT and ACPI
based platforms.

The frozen spec of this new protocol is available at
https://github.com/riscv-non-isa/riscv-uefi/releases/download/1.0-rc3/RISCV_UEFI_PROTOCOL-spec.pdf

This is tested in qemu with both u-boot and edk2.

Sunil V L (1):
  riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL

 drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
 drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
 include/linux/efi.h                       |  1 +
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.25.1

