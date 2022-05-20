Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57752F403
	for <lists+linux-efi@lfdr.de>; Fri, 20 May 2022 21:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353294AbiETTvL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 May 2022 15:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353347AbiETTvH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 May 2022 15:51:07 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B120033EA4;
        Fri, 20 May 2022 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BgOrrLzy3+iY/m80rMgrSBBVZ5V6g6WQYZdpSAfoBVk=; b=bUGz4UfufNoRpk61U41f1+nvQb
        aguqS4BFm/Jmp7KuaMklN4nvgaP8QoTpGTiVVZQp/zn3/TiCh2Z7mLD2QGtFuVJh521S1XaBuLxJe
        SWHaxcRgt0OyBMT27yhSLvmlkWI8NODetPdE3YATc/U9ePgC3pew49YSsweJjoLdLI8sKKikLFy3u
        EZptQstHe/0BoSbC5UbOvXW2kT3zHbBlInkDNl+a7mDj4910EvPrSqTdemX6Ig8ec9SC6IZEcefUH
        CH31jpBz9ccZluxwrMRwvsTYZ32JS81S44MdMWBvf9sZjTe4TZyZ0Prsr+Hw+mI+mgNRlkqKkaYXc
        eliHySJw==;
Received: from 200-161-159-120.dsl.telesp.net.br ([200.161.159.120] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ns8eF-00D3lC-5G; Fri, 20 May 2022 21:50:56 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, matt@codeblueprint.co.uk,
        matthew.garrett@nebula.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 0/2] UEFI panic notification mechanism
Date:   Fri, 20 May 2022 16:50:26 -0300
Message-Id: <20220520195028.1347426-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi folks, this patch set is about a mechanism to notify the UEFI
firmware about a panic event in the kernel, so the firmware is
enabled to take some action. The specific use case for us is to
show an alternative splash screen if a panic happened.
The base for the idea is to explore the panic notifiers mechanism,
that allows a callback to execute in the panic path.

Patch 1 is kind of a "clean-up" in a way; just taking a helper out
of efibc and adding it on generic efi.h header, so we have common
code used by 3 modules (efibc, efi-pstore and efi-panic).

Patch 2 is the efi-panic module itself; it is *strongly* based on
efibc, and for that I'd like to hereby thank to the authors.
The efibc code is very clear!


Some design decisions to be discussed:

(1) The variable name and value - I called it PanicWarn, and the
data it holds is just a byte, set by default to 0xFF (though users
can change that via module parameter). I have no attachment to
these, we can improve naming and the size of the data for example,
suggestions are appreciated!


(2) The 3 modules (efibc, efi-pstore and efi-panic) share a lot of
ideas or code; both efi-{pstore,panic} deal with panic events, and
both efi{bc,-panic} rely on notifiers and share code.
Should we unify some of them or anything like that? It seemed to me
the proper approach would be a simple and small standalone module,
but I'm open for suggestions.


(3) I've noticed a behavior that also happens in efi-pstore, I'm not
sure if that's something to care about. In the efi-panic module, after
a fresh boot, we check if PanicWarn is there an if so, we print a
message and _delete_ that variable from the NVRAM. But...the variable
is still present in sysfs, in the list created by efivars. Same happens
with efi-pstore, if we delete the dumps generated from /sys/fs/pstore.

In my case, I've used the __efivar_entry_delete() variant, so it doesn't
delete from any list, only from the firmware area. Should this be handled?
Or we just don't care with the empty variable reference in the sysfs tree?


I appreciate feedbacks and suggestions, thanks in advance for the attention!
Cheers,


Guilherme


Guilherme G. Piccoli (2):
  efi: Add a generic helper to convert strings to unicode
  efi-panic: Introduce the UEFI panic notification module

 drivers/firmware/efi/Kconfig      | 10 ++++
 drivers/firmware/efi/Makefile     |  1 +
 drivers/firmware/efi/efi-panic.c  | 97 +++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi-pstore.c |  5 +-
 drivers/firmware/efi/efibc.c      | 16 ++---
 include/linux/efi.h               | 16 +++++
 6 files changed, 130 insertions(+), 15 deletions(-)
 create mode 100644 drivers/firmware/efi/efi-panic.c

-- 
2.36.0

