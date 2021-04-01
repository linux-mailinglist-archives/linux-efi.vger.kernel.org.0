Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8F351896
	for <lists+linux-efi@lfdr.de>; Thu,  1 Apr 2021 19:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhDARqH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Apr 2021 13:46:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:45441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234821AbhDARk1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617298826;
        bh=4R59ETiVwx32RTQREfmW8jBj2PC86uvlo6xuEHEcmQQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lqC6+uSE2ndkDAQRTdpoNaK5H1KOX0NMV2ZmEBCMKdvhMtoIzOlD4KL2J1/UuHJsX
         ZtJ6HDNPHFimHXj0XM87hSw0u/GfNqynmDMcV4WgEBd1XaEldX+ut940HhwVVcK5GT
         WitLNB2bRJwrNwDy3FESCrQbr7E3tuhFOiHeYIF0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from workstation4.fritz.box ([62.143.247.63]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MIx3C-1lD54N2tQo-00KNNk; Thu, 01 Apr 2021 18:58:41 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [efitools PATCH 1/1] Make.rules: enable building on riscv64
Date:   Thu,  1 Apr 2021 18:57:54 +0200
Message-Id: <20210401165754.131719-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gr1s9Gi1qQfIANGv++b4j1weLFzLgiUMHjU+mjubenB2RDFQjup
 oHu8tnmC1effknpZQe3A17hsAUe/gNaMUZ51CeRxrZdf5wh/PA2Pm4QvlrcW8xSz+4HH+3l
 hBBjYU/FTtIIoDO8f7ZUej5yK5oh6BgJIiQyzJ7cNf+uY2rAvwX8G/6rIqreuSbKUjvaskV
 +Wxn0gi7jD8wlUhLpDb0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z0Jq/O2arcM=:Qj4VhxejK4c81rhgZtYpP7
 GgraII5LUPW+pbBw0RmjBA9EVDNLVH+0Y4mRx8DDmGdWUOCO27poO7tgGm8zaI+VivD4R7wu2
 qlFo6I8mI8iJnuN3rcrxkMHttE4eIwpiHUQ00p4JyPPbY6YAYRkDo+H670NsC6xM1MNMOk9U/
 OXb5wiDDobBCIpvhAMn/Aemh3f7yarsk1uukuorPtDRVp72t3Efe4QgFfikBNpkCN0DNjzTx3
 0zQlwr3CEJgjLJoZUMU4/xSaIsxInN7XGcKSwPgZ6ecOpLLQG6/F1TTtt6Io+c04/2Q0CAt12
 oEk+bZBW4eTaQ44RIkTbJzb4YiFmX/OfhBPZt0p1M1KFKnbfYWWmyjONqpPUe/PNbcQdA0I68
 aqgVuPfzRHQ172gOcQfBNE456lS8g3T9uOEtWlWqDG7q5b6YEiB7rgYtN0iTQDTAHajd30coR
 Tx6wtLRjJB8IwdQzmtD5WCflwRKqknwILUMs1wyGSfbW1XZPAKQmKP/MJ0TU74g3TzcONClYV
 FHv9sF2rvfJoutdzIR7vlT1YvavW2GqEYsKReX42C3qo+fo+xiTDWy00vyj8r+K1fJdKpIQoW
 CqUlMrGRdJqjDxJbFX0Z/C4VGkf85uTCUjirABFKTODvnNzb8qsFbkay+CwbVQ4zn2m/6n96+
 SDoNQNfttrr4pK9v9XXev37m2kVRXzXWVa1b/nZ1li3oPOrsLIxG5fWC7ctzQZniBanmLD1S3
 t1QnRpsDAgGMT/MpvqKDgVJIQceu8eeKZWPqYM+8elO6ISBdRqn28oUXJ1xPvF0lm9t1Px3mf
 +xVDBtDD1zbMEmAQsO8I7bfFEh2uwl/m97Ut5cKFTfifB1bstHKdKmykbBGfkiZh/Pai8QF/7
 hpJ4/bp6N5/TRjLBatvX5Jca0d789l/6vPMmuCdVTFhurCV/eR+Yz4PBxD11Dabz4ldJXsnZM
 AsaRat9F9IjZwfMYnK/XBc15YBlVPFn4IWkSFBwFwfNIM9udgxpzHV1Ld+5dOzCXn8g+Ra5Cr
 cbnLDx1fCBpNynv8ArgtFrUU+hb4R6PhXXlybNKtdOqOwAtv5Dzpj9a5XS/1liNZrPDqCQSBt
 bZh8vRmUgq8Eq+/LWeWkTPxxZkq18oz+h13Kr/39+gQL5jxczPZABorweDRhfUTLGFJQmBokE
 AUJxRQAVNCXvJNdTGMRDU0VddKl8x2RXUCUU8zxl2gJ9yiX/beG+PD7rKzhVaXT+u08fI=
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We can use just the same flags as for aarch64.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
RISC-V patches for gnu-efi are not yet accepted in upstream. Cf.

[Gnu-efi-discuss] [PATCH 1/1] Initial support for RISCV64
https://sourceforge.net/p/gnu-efi/mailman/gnu-efi-discuss/thread/202104011=
53553.103286-1-xypron.glpk%40gmx.de/#msg37253360
[Gnu-efi-discuss] [PATCH 1/1] Undefined Status in LibGetVariableAndSize()
https://sourceforge.net/p/gnu-efi/mailman/gnu-efi-discuss/thread/202103191=
62557.334645-1-xypron.glpk%40gmx.de/#msg37243995

You can use
https://github.com/xypron/gnu-efi/releases/tag/riscv64-2021-04-01 for
building sbsigntools and efitools.
=2D--
 Make.rules | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Make.rules b/Make.rules
index 903a5a4..69bd3bd 100644
=2D-- a/Make.rules
+++ b/Make.rules
@@ -10,6 +10,8 @@ else ifeq ($(ARCH),aarch64)
 ARCH3264 =3D
 else ifeq ($(ARCH),arm)
 ARCH3264 =3D
+else ifeq ($(ARCH),riscv64)
+ARCH3264 =3D
 else
 $(error unknown architecture $(ARCH))
 endif
@@ -56,6 +58,11 @@ ifeq ($(ARCH),aarch64)
   FORMAT =3D -O binary
 endif

+ifeq ($(ARCH),riscv64)
+  LDFLAGS +=3D --defsym=3DEFI_SUBSYSTEM=3D0x0a
+  FORMAT =3D -O binary
+endif
+
 %.efi: %.so
 	$(OBJCOPY) -j .text -j .sdata -j .data -j .dynamic -j .dynsym \
 		   -j .rel -j .rela -j .rel.* -j .rela.* -j .rel* -j .rela* \
=2D-
2.30.2

