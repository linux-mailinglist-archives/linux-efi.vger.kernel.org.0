Return-Path: <linux-efi+bounces-18-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDCE7E76A4
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 02:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B578E1C20C6C
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 01:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CDBA46;
	Fri, 10 Nov 2023 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="CHJNTpVf"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5597E6;
	Fri, 10 Nov 2023 01:39:23 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Nov 2023 17:39:22 PST
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E723444A4;
	Thu,  9 Nov 2023 17:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3762; q=dns/txt; s=iport;
  t=1699580363; x=1700789963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PtUp1GjfEwZS61DxzSRMFo9GD7QWcRxAdJGBMTXDcM0=;
  b=CHJNTpVfqbPEflg+O6phpSNh0QOXm5wE1W5tLaNTfGH7e2TBUAyr+Ft8
   SteOPYyT+L6f6ROCXUCsomQwBQjfd/FD97smCNwfJezOf4zPtG0x2B6yN
   ihm+mFd2d47xGicvnR4wbqRHoOcdnIvtgUoMSaXG7W3FVx1flRah8n7tm
   4=;
X-CSE-ConnectionGUID: Tg5rtsM1RzKj3gJducQSPg==
X-CSE-MsgGUID: 2YLxlXJiRgOPNW/RlT7pzw==
X-IPAS-Result: =?us-ascii?q?A0ANAADbh01lmJtdJa1aHAEBAQEBAQcBARIBAQQEAQGBe?=
 =?us-ascii?q?wcBAQsBhAdAjTenQ4F+DwEBAQ9EBAEBhQaHKAImNAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBRAOJ4V1hwUBRoE+AYMQgl8Dr?=
 =?us-ascii?q?VeCLIEBsyiBaIFIAYxDgR6ENScbgUlEhAeLfASJJQcygUlZg1KDD4o8f0daF?=
 =?us-ascii?q?h0DBwNWKRArBwQtIgYJFC0jBlEEFxEkCRMSPgSDNAp/Pw8OEYI/IgI9NhlIg?=
 =?us-ascii?q?lsVQARGdhAqBBQXgRJuGxUeNxESFw0DCHQdAhEjPAMFAwQzChINCyEFFEIDQ?=
 =?us-ascii?q?gZJCwMCGgUDAwSBNgUNHgIQLScDAxNNAhAUAzsDAwYDCzEDMFVEDFEDbx8aH?=
 =?us-ascii?q?Ak8DwwfAhseDScoAjVDAxEFEgIWAyQZBEUDCQMHBUlAAwsYDUgRLDUGDhsGP?=
 =?us-ascii?q?3MHoGJyAS1igTCUODKPBIIdoEeEF4FfnyoaM4QBjHOZD5g/IKMJhSiBYzqBW?=
 =?us-ascii?q?zMaCBsVgyNRGQ+OOZMbAV0jbQIHCwEBAwmLSgEB?=
IronPort-Data: A9a23:xFsu3a1wctyYQEMMyPbD5aJ3kn2cJEfYwER7XKvMYLTBsI5bpzZWz
 mUXX2DXPvfZZmqhLtojO43goB8A6pbVztZhSAtu3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ1yFjmE4E71btANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXV4
 rsen+WFYAX+gmctajpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauG4ycbjG
 o4vZJnglo/o109F5uGNy94XQWVWKlLmBjViv1INM0SUbreukQRpukozHKJ0hU66EFxllfgpo
 DlGncTYpQvEosQglcxFOyS0HR2SMoV69+LdPWOa6PaB7E+dfFng3v5XN3k5aNhwFuZfWQmi9
 NQCIzwLKxuEne/znPSwS/JngYIoK8yD0IE34y47i2qGS6d9B8meHs0m5vcAtNs0rsxHG/fTY
 9UQQTFudx/HJRZIPz/7Dbpnx7v41iWuImMwRFS9/5sT82zj7g1L35/VFuWSQNi2Gt1HgRPNz
 o7B1z2pXk5FXDCF8hKB83SxlqrCkyLTRo0fDvu7++RsjVnVwXYcYDUSVF2msby6gFO/X953N
 UMZ4GwtoLI0+UjtScPyNzW0rWCFtRMAQdddO/M15RvLyafO5QudQG8eQVZpbN0gqd9zRjEw0
 FKNt83mCCYps7CPT3+ZsLCOoluaPSkTMH9HbDUBCAgI+d/upKk3jwnTVZBiFqCvh9H4ED22x
 CqFxAA4hr4UiccQ/6u59EvDjnShu/DhSAI4/QzKWmSk4xliTIGiYIOs5B7Q6vMoBICQUlmIu
 lAHltKY4eRICouC/ASNWOwlDqC14OzDOzrZ6XZrHp885yy18DuvcJ545DBlOFwvNdQAcDXyJ
 kjJtmt54J5VIWvvaK5veKqvBMkwi6vtD9LoUrbTdNUmSoghKieE8TtoaErW2Hri+GA3nKg5f
 56dfcu2FnEcIb9qxz3wTOAYuZc3wSU33iXWWJzh0hKk2JKRYXeUTfEON17mRvkk7aizuA/P+
 tZaPuOT1hRUUev1JCLQ9OY7JFMSKFA/BJbru4lZcfOFLgN6GWYnTfjLztsJd4VjnqlRvujJ+
 2mwXkJGyVH/w2bOL0CEcHllY7L0VpE5pnt9IDdEFUyv0XgLYou16qobMZwtctEP/+x5zOVoS
 OEFdoOED+5IWxzM4DsHaoTl6oF/HDy0hAaKFymoej4ye9hnXQOhxzP/VhHk+C9LBS2tuI5i5
 bahzQjcB5EEQmyOEfo6dtqTwA6roWM4wdhgfEmTLftfZU7Vy7BlfnmZYuAMH+kALhDKxz2/3
 gmQAAsFqeSln2PT2ISX7Uxjh9r0e9aSDna2DEGAsunrbXiyEn6LhN4fALzRLFgxQUutoP36D
 di52c0QJxHuobqnm5B3H7AuxqUk6p6z4bRb1Q9jWn7MajxH64+MwFHYgaGjVYUUm9e1XDdav
 GrTprG23p3VYKvY/KY5flZNUwh6/ah8dsPuxfo0Ol7mwyR84aCKV05fVzHV1n0MceYpbt91m
 rh90CLz1+BZokRzWjphpn4Mn1lg0lRcO0nanshAWdSy2lZDJq9qO8CGVEcaH61jm/0VYhV1f
 Vd4dYLJhq9XwQLZYmEvGH3WtdexdrxQ0C2mOGQqfgzT8vKc36df9EQIoVwfEF8Ppj0ZiL0bB
 4SeHxAvTUl412021JErsqHFM1wpOSB1DWSokAtRyD2GHxX4PoEPRUVkUduwEIki2zo0VlBmE
 HuwkQ4JjR6CkBnN4xYP
IronPort-HdrOrdr: A9a23:1pk2VKypleQTi517Rul2KrPwJb1zdoMgy1knxilNoNJuHvBw8P
 re/sjzuiWbtN98YhsdcLO7Scq9qA3nlKKdiLN5VdyftWLd11dAQrsO0WKb+V3d8+mUzJ846U
 +mGJIObeHNMQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A/Eqiz2mXSOSCeZI2EUGthTci2VnXOUHSkW3MOGr?=
 =?us-ascii?q?hM3RKSuaaa1ON85pfq8U7zg=3D=3D?=
X-Talos-MUID: 9a23:xtDHAwvI7ZhpOKvHds2n3gBGJMNYwaWUB2c1t6pBgc24ajRiJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,291,1694736000"; 
   d="scan'208";a="134884996"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 01:38:19 +0000
Received: from goliath.lan ([10.25.128.169])
	by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id 3AA1cHVG011466;
	Fri, 10 Nov 2023 01:38:17 GMT
From: Daniel Walker <danielwa@cisco.com>
To: Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratyush Brahma <quic_pbrahma@quicinc.com>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        Sean Anderson <sean.anderson@seco.com>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: linux-efi@vger.kernel.org
Subject: [PATCH 0/8] generic command line v6
Date: Thu,  9 Nov 2023 17:38:04 -0800
Message-Id: <20231110013817.2378507-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.25.128.169, [10.25.128.169]
X-Outbound-Node: rcdn-core-4.cisco.com

This release is an up-rev of the v5 patches. No additional features have
been added. Some changes were mode to function names and some changes to
Kconfig dependencies. Also updated the config conversion for mips.

There are a number of people who have expressed interest in these
patches either by asking for them to be merge or testing them. If
people are so inclined please continue to request them to be merge
or to ask the status of the next release. It's helpful to motivate me to
release them again and for the maintainers to see the interest
generated.

These patches have been used by Cisco Systems, Inc. on millions of
released products to great effect. Hopefully they can be used by the
entire Linux eco system.

My apologies on the length between releases. I will try to release more
often.


Daniel Walker (8):
  CMDLINE: add generic builtin command line
  scripts: insert-sys-cert: add command line insert capability
  scripts: insert-sys-cert: change name to insert-symbol
  CMDLINE: mips: convert to generic builtin command line
  drivers: firmware: efi: libstub: enable generic commandline
  CMDLINE: x86: convert to generic builtin command line
  of: replace command line handling
  CMDLINE: arm64: convert to generic builtin command line

 arch/arm64/Kconfig                            |  33 +--
 arch/arm64/include/asm/setup.h                |   4 +
 arch/arm64/include/uapi/asm/setup.h           |   2 +
 arch/arm64/kernel/idreg-override.c            |   9 +-
 arch/arm64/kernel/pi/kaslr_early.c            |  14 +-
 arch/mips/Kconfig                             |   4 +-
 arch/mips/Kconfig.debug                       |  44 ----
 arch/mips/configs/ar7_defconfig               |  12 +-
 arch/mips/configs/bcm47xx_defconfig           |  10 +-
 arch/mips/configs/bcm63xx_defconfig           |  21 +-
 arch/mips/configs/bmips_be_defconfig          |  17 +-
 arch/mips/configs/bmips_stb_defconfig         | 139 ++++------
 arch/mips/configs/ci20_defconfig              |   8 +-
 arch/mips/configs/cu1000-neo_defconfig        |  19 +-
 arch/mips/configs/cu1830-neo_defconfig        |  19 +-
 arch/mips/configs/generic_defconfig           |  15 +-
 arch/mips/configs/gpr_defconfig               |  33 +--
 arch/mips/configs/loongson3_defconfig         |  29 +--
 arch/mips/include/asm/setup.h                 |   2 +
 arch/mips/kernel/relocate.c                   |  17 +-
 arch/mips/kernel/setup.c                      |  36 +--
 arch/mips/pic32/pic32mzda/early_console.c     |   2 +-
 arch/mips/pic32/pic32mzda/init.c              |   3 +-
 arch/x86/Kconfig                              |  44 +---
 arch/x86/kernel/setup.c                       |  18 +-
 .../firmware/efi/libstub/efi-stub-helper.c    |  29 +++
 drivers/firmware/efi/libstub/efi-stub.c       |   9 +
 drivers/firmware/efi/libstub/efistub.h        |   1 +
 drivers/firmware/efi/libstub/x86-stub.c       |  14 +-
 drivers/of/fdt.c                              |  22 +-
 include/linux/cmdline.h                       | 137 ++++++++++
 init/Kconfig                                  |  79 ++++++
 lib/Kconfig                                   |   4 +
 lib/Makefile                                  |   3 +
 lib/generic_cmdline.S                         |  53 ++++
 lib/test_cmdline1.c                           | 139 ++++++++++
 scripts/Makefile                              |   2 +-
 .../{insert-sys-cert.c => insert-symbol.c}    | 243 ++++++++++++------
 38 files changed, 807 insertions(+), 482 deletions(-)
 create mode 100644 include/linux/cmdline.h
 create mode 100644 lib/generic_cmdline.S
 create mode 100644 lib/test_cmdline1.c
 rename scripts/{insert-sys-cert.c => insert-symbol.c} (72%)

-- 
2.39.2


