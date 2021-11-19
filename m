Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6C456E70
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 12:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhKSLvG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Nov 2021 06:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSLvG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Nov 2021 06:51:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79238C061574
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 03:48:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n29so17639095wra.11
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 03:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sY5v4T/gDIggLv1A8yXTdIuNMs6lSlPYKPKW7ORnlqw=;
        b=A4vOjZufXgPYw/7VqKRnzhqFt3oprng/7P1/tYF+A6XvdFOV7zo/aN/h+/mZ+w6vDz
         PPqCg7/4VnzZvN1u+d2ZF2k/62Tzedqe6sfXptTULdGXNo9lJM6QquvwE5PRkwvnCv60
         I/MUnL23y+nVRFOUTG18rL1lxcboc3ZdARXvw4S7V0Hk5W8QaWTrhrJ3QfpqSXa+YeIR
         +V724SxlRBHUNVEnFSRppUHv6rzLtLDbVN9ZWQt2G9qwDbWA9k0S73MhRkxJni91vgly
         sPqA+v/+f479MQ66OU68lDHsjTRLJFnK5RiqjmqwjqdLH40hhC0AycQqph95uOTAyb/1
         7R/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sY5v4T/gDIggLv1A8yXTdIuNMs6lSlPYKPKW7ORnlqw=;
        b=5gBeNylo28c7q4W8VWZNxwo8Kye0sLSunIAgja7eFYnLObdHdDgVhEM1+9LoEcWuF4
         gU4GbdbHxo5A01FXNPd20m7AAIFAxqoMZXLMsU0560UpHWVDnJ1/K4PLc0ZNIFimUg4H
         tTb/97bylAMDhtwDvm9LwVGbApR2NsOzuqXOFvuHeujhiveDuKuXzuiRzAIQinEAPplw
         EoGhwvl5vOPanyszbhSSt/9A86RT7VZKufXv2PPiK0SaHdNz4P8GWw3UBOEwhD3wgQ6x
         oMbPX5tzKwec/pJp6LrN8WOecMz7MC3OT07ijERpWK4RT9yIxMO6AHDUwzYEUeVq6hh3
         al9g==
X-Gm-Message-State: AOAM532DIphjtweWuhyM30yGFKzbn+XmAAGvWvnkPJ9t9bghLRKdjh3C
        bxLqC0PPfS/AF3fSizk/sFlg/wyeuqqe2g==
X-Google-Smtp-Source: ABdhPJwhup/wg1NEiHjIHM1Al6X12LJR6vhqdMdRug/OHQdi02HknXa4Nnxlw9xsmckZeDD6UuSgJA==
X-Received: by 2002:adf:fed0:: with SMTP id q16mr6754859wrs.276.1637322482968;
        Fri, 19 Nov 2021 03:48:02 -0800 (PST)
Received: from apalos.home ([2a02:587:4627:18c0:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id c4sm2688039wrr.37.2021.11.19.03.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:48:02 -0800 (PST)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        jroedel@suse.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 0/4 v3] measure initrd data loaded by the EFI stub
Date:   Fri, 19 Nov 2021 13:47:41 +0200
Message-Id: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi!

This is a respin of [1].
This enables initrd measuring when loaded directly by the kernel EFI stub.
It ensures that the initrd observed and used by the OS is the same one that
got measured into the TPM, which is difficult to guarantee in the current
otherwise.

There's a couple of changes compared to the original RFC:
- Ard fixed the x86 assembly for providing the extra arguments needed and I
  rebased it on top of 
  commit 22aa45cb465b ("x86/efi: Restore Firmware IDT before calling ExitBootServices()")
- Instead of EV_IPL we are now using EV_EVENT_TAG. EV_IPL was marked
  as deprecated up until the latest PC client spec [2] (and deprecated  in
  older revisions [3]).  It's current description is: 
  "It may be used by Boot Manager Code to measure events."

  EV_EVENT_TAG on the other hand seems more appropriate as it's defined as:
  "Used for PCRs defined for OS and application usage.  Defined for use by
  Host Platform Operating System or Software."
- We are only measuring the initrd if it was loaded using the LOAD_FILE2
  protocol.  This is not what we probably want in the long run, but let's
  only enforce the measurement on the new way of loading an initrd for now.

Questions:
- Since GRUB seems to be using PCRs 8/9 for it's EV_IPL events, maybe we should
  use something completely different?

I did test this on arm64 and x86_64 (incl mixed mode). Here's a snip of the
EventLog
<snip>
  - EventNum: 23
    PCRIndex: 9
    EventType: EV_EVENT_TAG
    DigestCount: 4
    Digests:
      - AlgorithmId: sha1
        Digest: "53fe403e0d763f6a4e3384e8112d6463e7ddf12b"
      - AlgorithmId: sha256
        Digest: "28f24eab8cb433e4b8cbce0f96b7ad0aa541a4b905f748491139e42f0adc8026"
      - AlgorithmId: sha384
        Digest: "848389ab172267dcf9a0b873c7534b3d969e915b525c9fe2b57db47f4ecd8283b18d6e0cff84099893d589447c2bea55"
      - AlgorithmId: sha512
        Digest: "438b254c92e6716a5a1ba0338f5e751f3dd27782481e5698911b4cd33a98efdd776459d56781c5ae4a8d0b9945246d04ab243d4dbe03f49542e2455ac66db584"
    EventSize: 21
    Event: "ec223b8f0d0000004c696e757820696e6974726400"
<snip>

[1] https://lore.kernel.org/linux-efi/20201102170634.20575-1-ardb@kernel.org/
[2] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient_PFP_r1p05_v23_pub.pdf
[3] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientSpecPlat_TPM_2p0_1p04_pub.pdf

Ard Biesheuvel (3):
  efi/libstub: add prototype of
    efi_tcg2_protocol::hash_log_extend_event()
  efi/libstub: x86/mixed: increase supported argument count
  efi/libstub: consolidate initrd handling across architectures

Ilias Apalodimas (1):
  efi/libstub: measure loaded initrd info into the TPM

 arch/x86/boot/compressed/efi_thunk_64.S       | 14 +++-
 arch/x86/include/asm/efi.h                    | 14 +++-
 arch/x86/platform/efi/efi_thunk_64.S          | 14 +++-
 .../firmware/efi/libstub/efi-stub-helper.c    | 73 ++++++++++++++++---
 drivers/firmware/efi/libstub/efi-stub.c       | 10 +--
 drivers/firmware/efi/libstub/efistub.h        | 30 +++++++-
 drivers/firmware/efi/libstub/x86-stub.c       | 26 +++----
 7 files changed, 134 insertions(+), 47 deletions(-)

-- 
2.33.1

