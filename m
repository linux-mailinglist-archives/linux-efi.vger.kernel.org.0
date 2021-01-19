Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB8C2FC228
	for <lists+linux-efi@lfdr.de>; Tue, 19 Jan 2021 22:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbhASSrx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jan 2021 13:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730575AbhASS22 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 Jan 2021 13:28:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1A55233F6;
        Tue, 19 Jan 2021 17:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611076129;
        bh=SE1NMK5fvJvyNvqabMXY13DNF4OW3HIGDw8InwrIXfE=;
        h=From:To:Cc:Subject:Date:From;
        b=ElWU/pCZkAInmDvvrp9szKelgDNhBULx0DXCrmlysIxA3N1wOJZaSZGXODpumAde5
         V5IhGsxSxdyBrALGLlKiAon5xkjnc+ckplZUo11Rfb9SWNbsuE4um9jY9MWYmbxO4L
         Rmw50zl2X8dbh+4fjWzGmgxT3wOeOVRLgg7dp3ceZcFeW1NKcy4tERJU4YUha2zFLY
         Upil52NJe3sfmY06o49Ictd0u4nIbxab89OMKH0HvwQ9e1S/fMz6RbUqHPVxHKtTuK
         UOds/PSbbpMo/b3tVjsNW7psJwolM2xhiJ5+aVILh1F+15ngD/QmVmZPXB4b0jd41C
         npnMuXO7bieNA==
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] efi/arm64: Update debug prints to reflect other entropy sources
Date:   Tue, 19 Jan 2021 17:07:42 +0000
Message-Id: <20210119170742.20969-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=aP0pzg/uUgyYUFApbkz+o2kgBrbJSgojob0ss4jpM3I=; m=icJ+UjacPuZqRBhrCr2irjc7zETb8PEBcyLTP3O9t5o=; p=fFREB8h8DT8dGBOnA++AhgD8Dvv+C7Uqzi4b4EPoWdg=; g=9ccc32bbac25a8d851d5d02f81d13f18eb634756
X-Patch-Sig: m=pgp; i=broonie@kernel.org; s=0xC3F436CA30F5D8EB; b=iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAHEdsACgkQJNaLcl1Uh9CeDQf8CNC e/x5qoO/bPa2faRszsQ1QUvysQSLo1PVAOZBkxwglaKK8O01gNuLr0iwf2FdiLZi+ExXnlNG2y2n6 IohjwBWeWjrSqVeSRPECxKzzhYKbwVhKlT6CVZSbsKy5O6J7/DOE+hAl41vhrgfMXX6vdTxioHYJI LCPGWqqmHIIp1TUxbBJZKPHvWNUcFq39FZBOjwwNKcIDBXGb/8I/ySyrMarwlOpUs7nnQL2WBUj0e HdPDe4WXFeBz31Pqfd/giL6amn9Gpw91SCEbbvLgEiZckJ1dk5jejuiTSRE/tD3ZNYSygVIZXnNpg Q1aOlQRkdjVRKh7qTWJDortqwM/+9KA==
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently the EFI stub prints a diagnostic on boot saying that KASLR will
be disabled if it is unable to use the EFI RNG protocol to obtain a seed
for KASLR. When this code was originally added there were no other entropy
sources which KASLR would be able to obtain entropy from so this was
accurate but with the addition of support of v8.5-RNG and the SMCCC RNG
protocol it is now possible for KASLR to obtain entropy even if the EFI
RNG protocol is unsupported in the system. This has been seen in emulated
systems with EFI.

Weaken the diagnostic to reflect the fact that KASLR may not be disabled,
the warning is still useful as other sources may not be available and newer
versions of both SBBR and EBBR require the RNG protocol and recommend that
it be able to provide sufficient entropy for seeding KASLR.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 22ece1ad68a8..94ade08b1054 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -61,10 +61,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			status = efi_get_random_bytes(sizeof(phys_seed),
 						      (u8 *)&phys_seed);
 			if (status == EFI_NOT_FOUND) {
-				efi_info("EFI_RNG_PROTOCOL unavailable, KASLR will be disabled\n");
+				efi_info("EFI_RNG_PROTOCOL unavailable, KASLR may be disabled\n");
 				efi_nokaslr = true;
 			} else if (status != EFI_SUCCESS) {
-				efi_err("efi_get_random_bytes() failed (0x%lx), KASLR will be disabled\n",
+				efi_err("efi_get_random_bytes() failed (0x%lx), KASLR may be disabled\n",
 					status);
 				efi_nokaslr = true;
 			}
-- 
2.20.1

