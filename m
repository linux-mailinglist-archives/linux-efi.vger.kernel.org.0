Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349383A7A59
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jun 2021 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFOJXP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Jun 2021 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhFOJXP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Jun 2021 05:23:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B21C061574
        for <linux-efi@vger.kernel.org>; Tue, 15 Jun 2021 02:21:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q5so17528031wrm.1
        for <linux-efi@vger.kernel.org>; Tue, 15 Jun 2021 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLzKJUYaFzEU6UHUOSxkYao39ZmOYBywHsiZQNyovJw=;
        b=R+7klAyKLwEFaN0tc+jZ1gMJRvmYdFJjeYgblO6mHQnDUPbeVsqYIx1p1EiB1I94sv
         Gu3CwVqmG7xfQOaR66787hQP0H0eJvFndgSxaqKpD4lDOLH4nn67h5VYJ/YfkMb7ESOm
         i4dIkZ1u9RA+BQCRXLctsbueaEwW0lul3+OL2Jff7kbRln2mt9sIAvB0De+IhtSRzg2X
         mzxPArHvw3EcHW4RkyDS3JysIm3MzMhIdZ54usw9Vwj/veAiwuzbM91iLKcbXe9N9Xou
         w9IJSDfk8X32Z4p41N4iz/s0xLegNTwt5ILvOV3DRSYRV1+jZEmJgM0iR8x9yuJ3Jp9P
         Dkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLzKJUYaFzEU6UHUOSxkYao39ZmOYBywHsiZQNyovJw=;
        b=KWt5nekyEOEZ2MaqbwniEDn59bvt1SjdTb3iglkOYCiKFoNNkl3uRrZrqZizAnaz2p
         YjYcwOtKgidnDtEksFjUTfSOeUc6bpaZ+5RksPsw9btCJ0sqwaiRcdtJ/HsjnLhBgHiw
         pGSPK+SogeArgTniWaqL0Wu/ev5ly/+d8x5wSO6Z7sQ9ro5CU22PqrVmuvLDODhA+WUO
         khqWz5H/wYzQ25hTzapUZIV2oBlHFbToE9nulXj11cLzGo5gicygqLTPo7FauBMfGGCg
         VdsOsCY16c9bjs8xulKuP+Z3JDYGIVOEgFygOTvjBDMPbEayuWnFztOC5yF3glNg4Kf5
         GUIg==
X-Gm-Message-State: AOAM531E1qfTjJZagzFxiD9x1u+Hk3N2lBj1YN8FCWL8w9YPrxoASni5
        VHbmk1BCjQv24nODFjIA9VAphiawSAV0uQ==
X-Google-Smtp-Source: ABdhPJy6L+e30o81TQs7v9SDwk2+N7N7BpVyYqvWWnDIBo6YuN1JpJ3syg1JeHIwBGKW/tLjhsK0Kw==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr23219154wrq.81.1623748869292;
        Tue, 15 Jun 2021 02:21:09 -0700 (PDT)
Received: from apalos.home ([2a02:587:4680:7ec2:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id h15sm18280113wrq.88.2021.06.15.02.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:21:08 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 0/4] efi/libstub: measurement initrd data loaded by the EFI stub
Date:   Tue, 15 Jun 2021 12:21:01 +0300
Message-Id: <20210615092105.288331-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi!

This is a respin of [1].
This enables initrd measurement when loaded directly by the kernel EFI stub.
It ensures that the initrd observed and used by the OS is the same one that
got measured into the TPM, which is more difficult to guarantee in the current
situation.

There's a couple of changes compared to the original RFC: 
- Ard fixed the x86 assembly for providing the extra arguments needed
- Instead of EV_IPL the logs are recorded with EV_EVENT_TAG. EV_IPL was marked
  as deprecated up until the latest PC client spec [2] and it's description
  reads "It may be used by Boot Manager Code to measure events."
  EV_EVENT_TAG on the other hand seems more appropriate as it's defined as:
  "Used for PCRs defined for OS and application usage.  Defined for use by Host
  Platform Operating System or Software."
- We are only measuring the initrd if it was loaded using the LOAD_FILE2
  protocol.  This is not what we probably want in the long run, but in an effort
  to keep current distros that rely on measurements unaffected, let's enable it
  only in the LOAD_FILE2 case.

Here's a (simple) eventlog using U-Boot and loading the initrd with LOAD_FILE2
version: 1
events:
- EventNum: 0
  PCRIndex: 0
  EventType: EV_NO_ACTION
  Digest: "0000000000000000000000000000000000000000"
  EventSize: 45
  SpecID:
  - Signature: Spec ID Event03
    platformClass: 0
    specVersionMinor: 0
    specVersionMajor: 2
    specErrata: 2
    uintnSize: 2
    numberOfAlgorithms: 4
    Algorithms:
    - Algorithm[0]:
      algorithmId: sha1
      digestSize: 20
    - Algorithm[1]:
      algorithmId: sha256
      digestSize: 32
    - Algorithm[2]:
      algorithmId: sha384
      digestSize: 48
    - Algorithm[3]:
      algorithmId: sha512
      digestSize: 64
    vendorInfoSize: 0
- EventNum: 1
  PCRIndex: 0
  EventType: EV_S_CRTM_VERSION
  DigestCount: 4
  Digests:
  - AlgorithmId: sha1
    Digest: "cb948776833ac1a6b1f7290a29798f6c6f3fe376"
  - AlgorithmId: sha256
    Digest: "cdc34410e11ad651c8aeb2705d889c80cf82a707d7471f140e1b6d7f1583e52f"
  - AlgorithmId: sha384
    Digest: "430ff24d1a65e81fef96771b7313b6622efe03d84d39faae0d0a7ee0b54a1222f3a2d99ebff5a2a31359ce1df618b3a5"
  - AlgorithmId: sha512
    Digest: "001cff096fbd9615c9039cb9785857f2bc586de42cea9da8471e4a782cd68ba879b8fe3d4410d74f70f2d83f506842b507afe4a89478b1841583e7bc4a1ef3a5"
  EventSize: 74
  Event: "552d426f6f7420323032312e30342d7263332d30303032322d67636434306530376666382d646972747920284d61722033302032303231202d2031353a30303a3234202b303030302900"
- EventNum: 2
  PCRIndex: 9
  EventType: EV_EVENT_TAG
  DigestCount: 4
  Digests:
  - AlgorithmId: sha1
    Digest: "a0d2c52d82ad30f5ca04e72153177179807dbef4"
  - AlgorithmId: sha256
    Digest: "5035f6ff3740e8462a30a9c65e45ea19d11d95cf286324be9d04378058abe6b3"
  - AlgorithmId: sha384
    Digest: "f414dfaa66ee06c234bf2341967999b59e3e33e091490f36cbb2a0830cdbf9663ed1b2adc5117d8b4f992c7c43774c83"
  - AlgorithmId: sha512
    Digest: "2654376c43e93ee4f2a7be231c35d207349587466e62d09803db6c7ab9da594f9ae8a21fa0f6f9496c61cf6b03ecb40bb019ad6112baaa5f7a9cbc20adea65da"
  EventSize: 21
  Event: "ec223b8f0d0000004c696e757820696e6974726400"
pcrs:
  sha1:
    0  : 0x99b6e79948ad34eb59882ab7cc46666e0ccdd783
    9  : 0x70c847a8dbc23693ecb3e341cb5ae745b6d07b29
  sha256:
    0  : 0xae32cb21ec1c654591be13f729ecfe7e71efe74c6b885e9aadc944df79ee722e
    9  : 0x099d14a1bfb6531ce2c3d807b8ad678a273dee0ea0ed88662943b97c03f99638
  sha384:
    0  : 0x1fe21137d71364096179281525719c3fd109363cff28ec191d7623620c3bc8609bd9534d5e31887d85664ef938abc5a6
    9  : 0xf848ece0a5e3f6a4c4194fd467a05a0b552a9e24d7360297bbe019fe980f9e29d71fbc45a0356c04c62f36906dcfb41b
  sha512:
    0  : 0xcba9c7c551179ce82a496a41629462836e4bc02fa1fe3922290e689a4d4a03264f14d00f2995d7091247a35cf4f54bc9ee3c594dd139c381fd6d0ccc0ed93e0c
    9  : 0xc62ebbeb16ea2ce0bca565866891be8496b8547254b13683ec0223394a402bd0c8758e0fe09742270fe7d31f00a960db8a70c4dfc0b2bfe7185e353eff67c489

[1] https://lore.kernel.org/linux-efi/20201102170634.20575-1-ardb@kernel.org/
[2] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient_PFP_r1p05_v22_02dec2020.pdf

Ard Biesheuvel (3):
  efi/libstub: add prototype of
    efi_tcg2_protocol::hash_log_extend_event()
  efi/libstub: x86/mixed: increase supported argument count
  efi/libstub: consolidate initrd handling across architectures

Ilias Apalodimas (1):
  efi/libstub: measure loaded initrd info into the TPM

 arch/x86/boot/compressed/efi_thunk_64.S       | 17 +++--
 arch/x86/include/asm/efi.h                    | 14 +++-
 arch/x86/platform/efi/efi_thunk_64.S          | 14 +++-
 .../firmware/efi/libstub/efi-stub-helper.c    | 73 ++++++++++++++++---
 drivers/firmware/efi/libstub/efi-stub.c       | 10 +--
 drivers/firmware/efi/libstub/efistub.h        | 30 +++++++-
 drivers/firmware/efi/libstub/x86-stub.c       | 26 +++----
 7 files changed, 135 insertions(+), 49 deletions(-)

-- 
2.31.0

