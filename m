Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F76263461
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgIIRTv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 13:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbgIIP1W (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:22 -0400
Received: from e123331-lin.nice.arm.com (adsl-204.109.242.29.tellas.gr [109.242.29.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B6BA22240;
        Wed,  9 Sep 2020 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599664602;
        bh=vLcbpNnan0Q9ikoYUFHXD8BV6Bv0VtlMkv6yFnjnxqo=;
        h=From:To:Cc:Subject:Date:From;
        b=bC20eOwYllY4VpagoF1zjyK8WcH8S9wOtNszc9xFAJvY1uyGUUDUGkYzgNa4og026
         EhZXztxmYuG4m/x6HWyrpkGtF3oJinzLDcTyozTaa21LsPHEwAQGdBuptkfOgpdUL0
         6Vsl13MHMhZ09SnVu5jdZYxT/xZ50Jz7Ub0Dyd/I=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Francois Ozog <francois.ozog@linaro.org>,
        Etienne CARRIERE <etienne.carriere@st.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Grant Likely <Grant.Likely@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christophe Priouzeau <christophe.priouzeau@linaro.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Patrick DELAUNAY <patrick.delaunay@st.com>
Subject: [PATCH RFC/RFT 0/3] efi/libstub: arm32: Remove dependency on dram_base
Date:   Wed,  9 Sep 2020 18:16:20 +0300
Message-Id: <20200909151623.16153-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Maxim reports boot failures on platforms that describe reserved memory
regions in DT that are disjoint from system DRAM, and which are converted
to EfiReservedMemory regions by the EFI subsystem in u-boot.

As it turns out, the whole notion of discovering the base of DRAM is
problematic, and it would be better to simply rely on the EFI memory
allocation routines instead, and derive the FDT and initrd allocation
limits from the actual placement of the kernel (which is what defines
the start of the linear region anyway)

Finally, we should be able to get rid of get_dram_base() entirely.
However, as RISC-V only just started using it, we will need to address
that at a later time.

Cc: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Francois Ozog <francois.ozog@linaro.org>
Cc: Etienne CARRIERE <etienne.carriere@st.com>
Cc: Takahiro Akashi <takahiro.akashi@linaro.org>
Cc: Patrice CHOTARD <patrice.chotard@st.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Grant Likely <Grant.Likely@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Christophe Priouzeau <christophe.priouzeau@linaro.org>
Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc: Patrick DELAUNAY <patrick.delaunay@st.com>

Ard Biesheuvel (3):
  efi/libstub: Export efi_low_alloc_above() to other units
  efi/libstub: Use low allocation for the uncompressed kernel
  efi/libstub: base FDT and initrd placement on image address not DRAM
    base

 arch/arm/include/asm/efi.h                |   6 +-
 arch/arm64/include/asm/efi.h              |   2 +-
 drivers/firmware/efi/libstub/arm32-stub.c | 177 ++++----------------
 drivers/firmware/efi/libstub/efi-stub.c   |   2 +-
 drivers/firmware/efi/libstub/efistub.h    |   3 +
 drivers/firmware/efi/libstub/relocate.c   |   4 +-
 6 files changed, 47 insertions(+), 147 deletions(-)

-- 
2.17.1

