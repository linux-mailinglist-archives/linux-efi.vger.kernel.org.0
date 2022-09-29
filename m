Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6F5EEBBE
	for <lists+linux-efi@lfdr.de>; Thu, 29 Sep 2022 04:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiI2CdM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 28 Sep 2022 22:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI2CdL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 28 Sep 2022 22:33:11 -0400
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFFF124777;
        Wed, 28 Sep 2022 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3959; q=dns/txt; s=iport;
  t=1664418788; x=1665628388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sRf5RAG3JLQO5OS02lrZ0M6fRZ+jF+1zY0KlIljIJaA=;
  b=UHaxnbRU6oQXGvAuG/oAq+HnqrUcKx9H5HjZkUbrosfWK96qekTG49aI
   O6lBhg6p6JntKVWgKb5DFCq8DINg8XmtTAZ7jakWbwLXMJILdkv6Bugnm
   zl97PZxJP8DPJ1n7Av8hlhTVQ551RVNEiKlCKpcUyEzjl8udpa1MqYqzw
   8=;
IronPort-Data: =?us-ascii?q?A9a23=3As18kNqNnhavSMavvrR1flsFynXyQoLVcMsEvi?=
 =?us-ascii?q?/4bfWQNrUon1TIGmjMZWG3SOPeDMGekeN13a9vg8h4A7JLRmodlTnM5pCpnJ?=
 =?us-ascii?q?55oRWUpJjg4wn8dtEp+F+WbJK5cx5hYO4CowPwcFCeG/E/wa+a59BGQ6InRL?=
 =?us-ascii?q?lbCIL+cUsxObVcMpBcJ0XqPqsZh6mJaqYHR7zCl4bsel/bi1GqNgFaYBI67B?=
 =?us-ascii?q?5Wr83uDtNyq0N8RU8dXifpj5DcynFFNZH4TyD3YEpf2fmVUNrbSq+fr1rq1+?=
 =?us-ascii?q?CbS+A0gT4PjmbfgeUpMSbnXVeSMoiMJAO753V4T/WprjvpT2Pk0MS+7jx2Fl?=
 =?us-ascii?q?tZwxdFSvLS7SBwiOevHn+F1vxxwSnkgZvQep+KZcBBTtuTWlSUqaUDEx/RoE?=
 =?us-ascii?q?VFzMIMZ0vh4DHsI9vECLj0JKBeZiIqexLO9V/kphc4+Lc3nFJ0Qt2smzjzDC?=
 =?us-ascii?q?/siB5fZTM3i6dJG3Tw9mtpDEN7AaMcDLzlidhLNZ1tIIFh/IJY/mvq4w3rya?=
 =?us-ascii?q?TtVrHqLqqctpWve1gp81P7qKtW9UtiLQ9hF20OZvnnu4Wv0GFcZOcaZxD7D9?=
 =?us-ascii?q?Wij7sfLnCXmSMcbDrj99fNwhlCX7mgSEwENE1q9r+OwhkO3V5RYMUN80iwio?=
 =?us-ascii?q?LM76UitT9TnRDW3p3mLuhNaUN1Ve8U68Ail2LvI5BzfDW8BJhZaZdUg8sYwS?=
 =?us-ascii?q?TEwzViPt8jkDjspu7qQIVqU9a+RhTezPzUFaGEFeCkIRBcE5N+lp5s85jrDR?=
 =?us-ascii?q?9BiHaqdgdzwATz0zi6Lpyh4nLwVyMAR3qOw/EvMhHSnr97UVWYd/ALdXkqm4?=
 =?us-ascii?q?xl/aYrjYJangXDQ7exBN5qeVlmM+nwJgc+PxOsVAouKiTTLTfhlNK6o4/KtM?=
 =?us-ascii?q?zDGh1NrWZ47+FyQF9SLFWxLyCt1KEEsOcEedHq5JkTSoghWopRUOROXgWZMS?=
 =?us-ascii?q?9rZI6wXIWLITLwJjszpU+c=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AbYRmYKGMxwiFcyQUpLqE58eALOsnbusQ8z?=
 =?us-ascii?q?AXPo5KJSC9Ffbo9fxG88506faZslwssRIb6LO90de7IE80nKQdieIs1NyZMz?=
 =?us-ascii?q?UO1lHEEGhK1/qG/9SZIU3DHio379YGT0C4Y+eAaWRHsQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BMAwBDbIJi/5BdJa1aHgEBCxIMggQ?=
 =?us-ascii?q?LgiuBSz2WHJxngXwLAQEBD0IEAQGFAoVAAiU0CQ4BAgQBAQESAQEFAQEBAgE?=
 =?us-ascii?q?HBIEJE4V1hnsBRoE+AYMPgxirVoIrgQGIGYFlFIEoiUSBAYRCHIFJRIQIi3Q?=
 =?us-ascii?q?Elh4DCQYHBYE+EoEhcQEIBgYHCgUyBgIMGBQEAhMSTQYMEgITDAoGFg4ONBI?=
 =?us-ascii?q?ZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyMLAgMYCQcKAx0IChwSEBQCBBMfCwg?=
 =?us-ascii?q?DGh8tCQIEDgNDCAsKAxEEAxMYCxYIEAQGAwkvDSgLAwUPDwEGAwYCBQUBAyA?=
 =?us-ascii?q?DFAMFJwcDIQcLJg0NBCMdAwMFJgMCAhsHAgIDAgYXBgICGScxCigNCAQIBBg?=
 =?us-ascii?q?EHiUOBQUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2GQEFXQY?=
 =?us-ascii?q?LCSMWBiwRBQYWAyZSBiIdlm9yAVo1gj6hCoIWnHqBMINWgUOeLRoxg3WkYpZ?=
 =?us-ascii?q?mIIIqnzWFKIFhPIFZMxoIGxWDJFAZD5wzAVwkbAIGCwEBAwmRGgEB?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1063107569"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Sep 2022 02:33:04 +0000
Received: from zorba.cisco.com ([10.25.129.98])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 28T2X1Yp007711;
        Thu, 29 Sep 2022 02:33:02 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     xe-linux-external@cisco.com, linux-efi@vger.kernel.org
Subject: [PATCH 0/8] generic command line v5
Date:   Wed, 28 Sep 2022 19:32:46 -0700
Message-Id: <20220929023301.3344694-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-8.cisco.com
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

v5 release changes. Generally a rebase from v4.

* Modified OF changes to move the ugly code into the cmdline.h

* Minor compliation update in arm64. Added ifndef __ASSEMBLY__ in
  a few places.

* Worked around arm64 kaslr_early.c.

	This code needs some additional review and consideration. 
	It appears this code is missing the opposite option to nokaslr
	which is kaslr.disabled=1/0 which would allow kaslr to be turn
	back on later in the command line. For example,

	console=ttyS0 nokaslr root=/dev/ram0 nosmp kaslr.disabled=0 loglevel=7
	
	On arm64 in arch/arm64/kernel/idreg-override.c this is parsed correctly
	to turn on kaslr, but the kaslr_early.c is missing this logic.
	Doing this results in kaslr getting disabled with the following message,

	KASLR disabled due to lack of seed

	Even when there is a seed in the device tree.	

	So change to the generic command line would leave built in command
	lines with nokaslr with no option to re-enable kaslr in in the bootloader
	arguments.


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
 arch/mips/configs/ar7_defconfig               |   9 +-
 arch/mips/configs/bcm47xx_defconfig           |   8 +-
 arch/mips/configs/bcm63xx_defconfig           |  15 +-
 arch/mips/configs/bmips_be_defconfig          |  11 +-
 arch/mips/configs/bmips_stb_defconfig         |   6 +-
 arch/mips/configs/ci20_defconfig              |   9 +-
 arch/mips/configs/cu1000-neo_defconfig        |  10 +-
 arch/mips/configs/cu1830-neo_defconfig        |  10 +-
 arch/mips/configs/generic_defconfig           |   6 +-
 arch/mips/configs/gpr_defconfig               |  18 +-
 arch/mips/configs/loongson3_defconfig         |  12 +-
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
 drivers/firmware/efi/libstub/x86-stub.c       |  13 +-
 drivers/of/fdt.c                              |  22 +-
 include/linux/cmdline.h                       | 137 ++++++++++
 init/Kconfig                                  |  78 ++++++
 lib/Kconfig                                   |   4 +
 lib/Makefile                                  |   3 +
 lib/generic_cmdline.S                         |  53 ++++
 lib/test_cmdline1.c                           | 139 ++++++++++
 scripts/Makefile                              |   2 +-
 .../{insert-sys-cert.c => insert-symbol.c}    | 243 ++++++++++++------
 38 files changed, 724 insertions(+), 355 deletions(-)
 create mode 100644 include/linux/cmdline.h
 create mode 100644 lib/generic_cmdline.S
 create mode 100644 lib/test_cmdline1.c
 rename scripts/{insert-sys-cert.c => insert-symbol.c} (72%)

-- 
2.25.1

