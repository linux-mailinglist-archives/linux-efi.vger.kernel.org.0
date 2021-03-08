Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF57331B38
	for <lists+linux-efi@lfdr.de>; Tue,  9 Mar 2021 01:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhCIABE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 19:01:04 -0500
Received: from alln-iport-5.cisco.com ([173.37.142.92]:53046 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhCIAAb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Mar 2021 19:00:31 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Mar 2021 19:00:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3040; q=dns/txt; s=iport;
  t=1615248031; x=1616457631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qOW1VpsX4fbS7pi7TUvKz3uyZUc7qjDe5+CAjX227XY=;
  b=Y2L3cvERcOHeSitiICEb9cdn1Q6EbxVvuxzlXwxkcn7a1oyyea1JxuZZ
   f6C+0nXj+e3jQGbcWNIW4TpeeInJ5kaDG1unQ/g9ejVS5TMVy7kFLzKZW
   LyBJOQFPLEkTTLvMMhGAB8o8MniyfFJfPhJWwz0sZ9uq4DrU/rTaznv+X
   Q=;
X-IPAS-Result: =?us-ascii?q?A0CAAQCat0ZgkIoNJK1iHAEBAQEBAQcBARIBAQQEAQGCD?=
 =?us-ascii?q?4N3ATmzHQsBAQEPNAQBAYRNgXwCJTgTAgMBAQEDAgMBAQEBBQEBAQIBBgQUA?=
 =?us-ascii?q?QEBAQEBhkWGfQFGgT4BgwKDCKwogiiJCYFFgTmIXHSEGByBSUKPHASCR2klA?=
 =?us-ascii?q?YEIZz+eQJwCgwiBH48qi04PIqNslF2iVYFrIYFZMxoIGxWDJU8ZDY44jXMBX?=
 =?us-ascii?q?CADZwIGCgEBAwmPJgEB?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.81,233,1610409600"; 
   d="scan'208";a="676271451"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Mar 2021 23:53:21 +0000
Received: from zorba.cisco.com ([10.24.7.91])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTP id 128NrKRh007218;
        Mon, 8 Mar 2021 23:53:20 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH v2 0/7] Generic Command Line changes
Date:   Mon,  8 Mar 2021 15:53:08 -0800
Message-Id: <20210308235319.2988609-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.24.7.91, [10.24.7.91]
X-Outbound-Node: alln-core-5.cisco.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This fixed some problem identified in my last release. I made updates
based on comments from Christophe Leroy.

I added scripted updates to the defconfig file for mips and powerpc.
This is required in order to maintain the status quo for those platforms
which used the prior builtin command line system.

These were tested on all effected architectures.

Daniel Walker (7):
  CMDLINE: add generic builtin command line
  CMDLINE: drivers: of: ifdef out cmdline section
  powerpc: convert config files to generic cmdline
  CMDLINE: powerpc: convert to generic builtin command line
  mips: convert config files to generic cmdline
  CMDLINE: mips: convert to generic builtin command line
  CMDLINE: x86: convert to generic builtin command line

 arch/mips/Kconfig                             |  4 +-
 arch/mips/Kconfig.debug                       | 44 ---------
 arch/mips/configs/ar7_defconfig               |  9 +-
 arch/mips/configs/bcm47xx_defconfig           |  8 +-
 arch/mips/configs/bcm63xx_defconfig           | 15 ++--
 arch/mips/configs/bmips_be_defconfig          | 11 +--
 arch/mips/configs/bmips_stb_defconfig         | 11 +--
 arch/mips/configs/capcella_defconfig          | 11 +--
 arch/mips/configs/ci20_defconfig              | 10 +--
 arch/mips/configs/cu1000-neo_defconfig        | 10 +--
 arch/mips/configs/cu1830-neo_defconfig        | 10 +--
 arch/mips/configs/e55_defconfig               |  4 +-
 arch/mips/configs/generic_defconfig           |  6 +-
 arch/mips/configs/gpr_defconfig               | 18 +---
 arch/mips/configs/loongson3_defconfig         | 13 +--
 arch/mips/configs/mpc30x_defconfig            |  7 +-
 arch/mips/configs/tb0219_defconfig            |  7 +-
 arch/mips/configs/tb0226_defconfig            |  7 +-
 arch/mips/configs/tb0287_defconfig            |  7 +-
 arch/mips/configs/workpad_defconfig           | 11 +--
 arch/mips/kernel/setup.c                      | 36 +-------
 arch/powerpc/Kconfig                          | 37 +-------
 arch/powerpc/configs/44x/fsp2_defconfig       | 33 ++++---
 arch/powerpc/configs/44x/iss476-smp_defconfig | 25 +++---
 arch/powerpc/configs/44x/warp_defconfig       | 17 ++--
 arch/powerpc/configs/holly_defconfig          | 13 +--
 arch/powerpc/configs/mvme5100_defconfig       | 23 ++---
 arch/powerpc/configs/skiroot_defconfig        | 12 ++-
 arch/powerpc/configs/storcenter_defconfig     | 18 ++--
 arch/powerpc/kernel/prom.c                    |  1 +
 arch/powerpc/kernel/prom_init.c               | 35 +++++---
 arch/x86/Kconfig                              | 44 +--------
 arch/x86/kernel/setup.c                       | 18 +---
 drivers/firmware/efi/libstub/x86-stub.c       |  2 +-
 drivers/of/fdt.c                              | 12 +++
 include/linux/cmdline.h                       | 89 +++++++++++++++++++
 init/Kconfig                                  | 68 ++++++++++++++
 37 files changed, 321 insertions(+), 385 deletions(-)
 create mode 100644 include/linux/cmdline.h

-- 
2.25.1

