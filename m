Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521D7CC4B6
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 15:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjJQNZY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 09:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjJQNZX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 09:25:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF439F2
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 06:25:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7ba10cb90so83064577b3.3
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697549120; x=1698153920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mebhHyamM3s8vUgCsBZhr4L6mGmwC1SwYKrh7yA/Jjg=;
        b=l+yzdkbMC466OO0P2Cwot6KA0pTgWJitQO54JXZSHcjppBsJao6Hz/05m59a5O6qR0
         G6XdUAwp8p4qGyVIhwPJBbxcLPEfOVhOdsIYPTSuON1nQUbMHjvxvi55owIinPvJgK8p
         Ldk6m3T3yLBquisGIH6Vw0SB2rJUZoeXzh6DVLfCADTaxJjaWRDFg9QQcZ2R+BtlKuyq
         a0fpII/ouyMruNoVqe753tT6/OXJq5iL8U65+AiCR4i9LhJDUcjlmadZZyfbwCQ6emUl
         tqSJoxKJ7u9KJMn6FMzCTLaZP/lUkfG69FoM2aFsNMJr2lkhXEEEDUlw6pPZKbk4yNwn
         JvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697549120; x=1698153920;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mebhHyamM3s8vUgCsBZhr4L6mGmwC1SwYKrh7yA/Jjg=;
        b=qJ7i3dgeCco+rSRUnjhLclbZlW9sLKLbwjVWUkY4kScrEaYq5nAqWESsDFguX0t1hK
         3DXjCbCyIwpbTxfqtKVd15uyJsCyz5GFOsFDwqpyuzKhe4vZXM0mz+A20sj/kriSEq9+
         0qH8SNhCXpMSMJVXmyGAuuDceV60mImg8TKICis3fXWwbjioECYGp0H/MJ9UobJqJV4f
         kCdumvLfVNbnVbHwPPaUymV9rWdRop4wG2+gUzSH+Jyuf9ut+h0hJY5gxsPOGJ+QTOeT
         J3tHb2vRCtuxaYGLbmLp5l4b1W7/CSXnUC9MSCzCHirqVLOc/f2XuHd0SK69iqjU5pIs
         xH1A==
X-Gm-Message-State: AOJu0Yz2x5/ceL95d5aYnTex00S+owe6g56R5VNJJLGcujJ5q9ak6JzG
        OvfvoDBYIqL0CZdyfdVbSIwPXDvZ8/27w1WN+Z2qRRdrS+1sb9prhaeqg943KTKOQm+sOIJx3ET
        cRh29Z4zbl5P6bOamQCnfq/pWkNHqtrOZXNyVZoIIU/g/7RM9jGO9hWdVDS52
X-Google-Smtp-Source: AGHT+IHHEAaDuK3VD202DLW7mwKPAqhoaIhUTYoHHvKa7xeAYa3kckKo4KUBsYUpuz3CzgAX7voJNhCS
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1825:b0:d9a:c3a2:48a3 with SMTP id
 cf37-20020a056902182500b00d9ac3a248a3mr41378ybb.6.1697549120179; Tue, 17 Oct
 2023 06:25:20 -0700 (PDT)
Date:   Tue, 17 Oct 2023 15:25:11 +0200
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=ardb@kernel.org;
 h=from:subject; bh=jF97UhA348Jyu0eliBymC6WLB2krTQJ+DMPzQvofZZk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIVWv29xAN3PRS31p0caPsWsKdvMtYb58UvV3SbPZYUmrd
 VsvGEt0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIm0KjD8s2PT488Uz7u7abfj
 Nna2u8p7LdWeXvz3xHPJpWKb730aCgz/vSo9b4okK76dkDvlx667sjZhJUpXn8ROvh22tUBJ1v8 yKwA=
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017132510.3845531-4-ardb@google.com>
Subject: [PATCH v2 0/2] x86/boot: Fix boot_params init in EFI stub
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org, mingo@kernel.org
Cc:     x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

v2:
add separate patch to rename the decompressor's version of the
boot_params global variable

Ard Biesheuvel (2):
  x86/boot: Rename conflicting boot_params pointer to boot_params_p
  x86/boot: efistub: Assign global boot_params variable

 arch/x86/boot/compressed/acpi.c         | 14 +++++------
 arch/x86/boot/compressed/cmdline.c      |  4 +--
 arch/x86/boot/compressed/ident_map_64.c |  7 +++---
 arch/x86/boot/compressed/kaslr.c        | 26 ++++++++++----------
 arch/x86/boot/compressed/mem.c          |  6 ++---
 arch/x86/boot/compressed/misc.c         | 24 +++++++++---------
 arch/x86/boot/compressed/misc.h         |  1 -
 arch/x86/boot/compressed/pgtable_64.c   |  9 +++----
 arch/x86/boot/compressed/sev.c          |  2 +-
 arch/x86/include/asm/boot.h             |  2 ++
 drivers/firmware/efi/libstub/x86-stub.c |  2 ++
 11 files changed, 50 insertions(+), 47 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

