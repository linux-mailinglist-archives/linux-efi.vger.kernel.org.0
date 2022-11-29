Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12B163C6E1
	for <lists+linux-efi@lfdr.de>; Tue, 29 Nov 2022 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiK2R4f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Nov 2022 12:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiK2R42 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Nov 2022 12:56:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85BC5CD38
        for <linux-efi@vger.kernel.org>; Tue, 29 Nov 2022 09:56:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DCAF61881
        for <linux-efi@vger.kernel.org>; Tue, 29 Nov 2022 17:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D6EC433C1;
        Tue, 29 Nov 2022 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669744583;
        bh=9d6sUw5COnID70QdMt4VYurjHIAB8ZbWdw/eMBa+Htw=;
        h=From:To:Cc:Subject:Date:From;
        b=jJ3nmOt8VyL3iE4VcCuE0FbIk4khCt76O+z1E0Lt7vbQV270Y7N7X6CLKDGQMjgEC
         v0d6Y/c0CryWr28akV4qcuEU5QTQexBwUW/J3/D9w4bwb/YQ4zjRVw9uD9fU/tf9Sd
         0w7So+1MPxokuEMmIsPEyMuYi3zo3C3VMe/8n330858xUh655f//RMT8XyEOcR42K6
         Gt23qoZpIPR2H9wimMlAX/Yul0ljh3nj2ediR8pl/Ci4Oynq8N5s+KPoqwsE2wOEyx
         DOlxgY/W7gpkVNGhFHFTwXDU3RY/c/XoK0GAVx1810NM1GN9SA+vYmjNQigamzoMTL
         J5bQsM9iIC1GQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     grub-devel@gnu.org, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Subject: [PATCH v2 0/2] efi: Add generic magic number in header
Date:   Tue, 29 Nov 2022 18:56:14 +0100
Message-Id: <20221129175616.2089294-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2138; i=ardb@kernel.org; h=from:subject; bh=9d6sUw5COnID70QdMt4VYurjHIAB8ZbWdw/eMBa+Htw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjhke7h6jKcGeiiQc98Apo55ZI03S76gsJOX05aVaK YnAdzeuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY4ZHuwAKCRDDTyI5ktmPJOmVDA CGA0peXgsRkQv9ksDrqXYJOBUR0wyl3ApWn2IWUq+har6y7pp5Af5CoAv3OIfHIOKI13AXEt1ItKJx JpDDsc27ily5jp/yPhX5NHVEFmpVi7oOBoApDTInYVyO5W1t3j5MNf/zYk7EhHMwhlrLdW73DvxBPk i99bJnurj9KvLGHDQP75+Uw9sL+PriGP+vVt84ghJmlLPLwVuGTfCeRr7rL1WE22Z2kOkXdplROM3X Zpo/bk3akiey8N2FBnyeADWFcoxrGri+q5H+RMLhSJhXzUkKkXsUf8K8R+BwN1msjcDh48RQF/urbN tz3HMFSz5gmCXIJP5LChpRHMoLeYH2m/NquLvnxoMGrjKjwun2kqJREk46d/ANI/e1B3q7OKkHbgEs yOvhcYhzt5UKwp9eOiEIor8cw9SZxoeInJmbCYUB0U0RK9SrPAZ5lbfNQgDxDUJY94Bj8YtLdkIdEx QVmacZTb/GIjN67qkPB0BN0HOhd3jQruErZ5cGHtesm8s=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a minimal respin of the RFC patch I sent out a few week ago. No
changes were applied except the /0x30/0x38 typo fix and some additional
wording in the commit log. I also added a patch to make the command line
initrd loader always built-in.

The purpose of all of this is to create *and document* a common baseline
for EFI booting of Linux. (I know I promised some documentation myself,
but I simply don't have time for that, so if anyone feels so inclined,
please go ahead).

The idea is that EFI images with the LINUX_PE_MAGIC number are
guaranteed to support:
- initrd loading via LoadFile2
- initrd loading via the command line
- (on x86) mixed mode boot via the .compat entry point
- other things I missed?

Architectures such as arm64 and RISC-V already have their own magic
numbers, in which case the PE/COFF major/minor image version should be
inspected, where 1.1 corresponds with the set described above.

If other architectures want to create hybrid images as well, it would be
better to use a different offset to store the magic number, so that the
generic EFI one can be carried as well. The reason for deviating from
this for arm64 and RISC-V is the simple fact that existing images
already exist, so for those architectures, we have to consider both
anyway.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Atish Patra <atishp@rivosinc.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Leif Lindholm <quic_llindhol@quicinc.com>

Ard Biesheuvel (2):
  efi: libstub: Always enable initrd command line loader and bump
    version
  efi: Put Linux specific magic number in the DOS header

 arch/loongarch/kernel/head.S                   |  3 ++-
 arch/x86/boot/header.S                         |  3 ++-
 drivers/firmware/efi/Kconfig                   | 15 ---------------
 drivers/firmware/efi/libstub/efi-stub-helper.c |  3 +--
 drivers/firmware/efi/libstub/zboot-header.S    |  3 ++-
 include/linux/pe.h                             |  9 ++++++++-
 6 files changed, 15 insertions(+), 21 deletions(-)

-- 
2.35.1

