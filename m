Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF39C5855AC
	for <lists+linux-efi@lfdr.de>; Fri, 29 Jul 2022 21:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbiG2TqI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Jul 2022 15:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbiG2TqI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Jul 2022 15:46:08 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A190865FD;
        Fri, 29 Jul 2022 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U4kyy3+iPq0es8I3IOuV/SecAyAqLgCBHGO4baBSJXY=; b=UPdILmC1M4E+vNWh+skga8xTtx
        0PhIN33ICezQxaE6dsPX2HxW7tZZw2jdmzxkugjqLiZHUEmL+GeSUmCJeJN9BfRveZy/RLVOLDaUS
        47Pq9nsJETnflbtM0ZwdWQSFusD6TgY75FM6RRA2FBU5rbDvCOCh5jnlwmFuqB+KXPLD7zc6pzkll
        pqQVQz+S/kYsM2Mhz+e/fT/J6P7HwuGCq+JHplCLgTFgd5XCWueYcJTuupLbxu8cXF8BTA1LgXNve
        Ak8NcHc8XfM8EgAz9+a2qR/06y+h9KcSHvCIeW+iLtKXHcZt4d8go5ntzyfMP2yv6IemNzhZzjCTM
        24ubXt2Q==;
Received: from [177.83.209.223] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oHVvk-00BM8Y-Lf; Fri, 29 Jul 2022 21:45:55 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, matt@codeblueprint.co.uk,
        mjg59@srcf.ucam.org, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v2 0/3] The UEFI panic notification mechanism, 2nd round
Date:   Fri, 29 Jul 2022 16:45:29 -0300
Message-Id: <20220729194532.228403-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hey folks, this is the 2nd iteration of the patchset adding a simple
mechanism to notify the UEFI firmware about a panic event in the kernel.
V1 here:
https://lore.kernel.org/lkml/20220520195028.1347426-1-gpiccoli@igalia.com/


First thing, the differences in this V2:

- Ardb response in V1 mentioned a refactor aimed for v5.20 that removes an
obsolete/confusing way of setting EFI variables - this led to a weird
condition, deleted variables stayed in sysfs after deletion. Well, I've
refactored the code based on efi/next, so I'm using the recommended API
now - thanks a bunch for the advice Ardb!

- I've changed NULL-terminating char in patch 1 to the format I've seen
in Ardb's code, L'\0'.

- Patch 2 is new, it's somewhat a fix for a patch only in efi/next, part
of the efivar refactor.


In the V1 review, it was mentioned we could maybe use efi-pstore as a way
to signal the firmware about a panic event - in the end, the efi-pstore
mechanism can collect a dmesg, so it's even richer in the information level.
But I disagree that it is the way to go, for 3 main reasons:

a) efi-pstore could be impossible to use, if the users are already using
another pstore backend (like ramoops), which is _exactly_ our case!
Of course, we could rework pstore and allow 2 backends, quite a bit of work,
but...see next points!

b) Even if (a) is a not an issue, we have another one, even more important:
signaling the firmware about a panic is *different* than collecting a bunch
of data, a full dmesg even. This could be considered a security issue for
some users; also, the dmesg collected consumes a bunch more memory in the
(potentially scarce) UEFI available memory.
Although related, the goal of pstore is orthogonal to our mechanism here:
users rely on pstore to collect data, our proposal is a simple infrastructure
to just let the firmware know about a panic. Our kernel module also shows a
message and automatically clears the UEFI variable, so it tracks a single
panic, whereas efi-pstore logs are kept by default, in order to provide
data to users.

c) Finally, it's faster and less "invasive"/risky to just write a byte in a
variable on a panic event than having a ksmg dumper collecting the full dmesg
and writing it to the UEFI memory; again, some users wish to have the logs,
but not all of them.


With all of that said, I think this module makes sense, it's a very simple
solution that opens doors to firmware panic handling approaches, like in our
proposed case (a different splash screen on panic).

Finally, the variable name (PanicWarn) and value (0xFF by default, can be
changed by a module parameter) are just my personal choices but I'm open to
suggestions, not strongly attached to them heh

Thanks again for the reviews/suggestions!
Cheers,


Guilherme


Guilherme G. Piccoli (3):
  efi: Add a generic helper to convert strings to unicode
  efi: efibc: Guard against allocation failure
  efi-panic: Introduce the UEFI panic notification mechanism

 drivers/firmware/efi/Kconfig      | 10 ++++
 drivers/firmware/efi/Makefile     |  1 +
 drivers/firmware/efi/efi-panic.c  | 89 +++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi-pstore.c |  4 +-
 drivers/firmware/efi/efibc.c      | 11 ++--
 include/linux/efi.h               | 18 +++++++
 6 files changed, 125 insertions(+), 8 deletions(-)
 create mode 100644 drivers/firmware/efi/efi-panic.c

-- 
2.37.1

