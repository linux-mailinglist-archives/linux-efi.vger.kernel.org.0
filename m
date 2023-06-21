Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B757382AF
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jun 2023 14:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjFULop (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jun 2023 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjFULoo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jun 2023 07:44:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6913A1AC
        for <linux-efi@vger.kernel.org>; Wed, 21 Jun 2023 04:44:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-311099fac92so6756078f8f.0
        for <linux-efi@vger.kernel.org>; Wed, 21 Jun 2023 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687347882; x=1689939882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHn9t4zMhJxxvPoRVF2VtnqYo/UVxkvWAxyDQV5WVfE=;
        b=E1avIA9iFt+MBS8GQNcN3VKRL+WvabL4YWMug9M85jOqFCJQKSA5FY+vr6OUMsQfBn
         Sg3QZkk1tAzdbD1pP46Ta0Ni0UYk1fR3HlQr7SXsQgJgdyA1pPfZ7BU3siVqo2eM/Ns3
         FcCY5GW0V43NrMMwNfg7xOmjuWL3YDmsW/PvW5reoqtybhivRJ506NEoyvCEee8ozGMj
         /UG5/ptCroa0uQY112o44OaAxj5tTdWUs1/2UuLXk6dSveHGaXuaZppX4vTJW+ernkko
         g6W93n6cvaEdJQJewJPpbOQ98TFyKOLFmPTQelX+nI7FoYmOfLOFtnw0Rxi8He/cLf3p
         D4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687347882; x=1689939882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHn9t4zMhJxxvPoRVF2VtnqYo/UVxkvWAxyDQV5WVfE=;
        b=CeNFRwQ6fj23/epwk8nfNc0RcK5KVEmJ5RaRY40/f2SSTPpfpkQWbtPk1aimeuDH6h
         0rSh8vbCmdFxv6DPcbjXFoRmhxyoOsJMjLHOoCq1n0lKDhFJJlc3KxjpkQO302cD11lf
         c5Wtl+8PCzwpv+7UuwPtnNMVHq5oKzINMY4X92iY5yWZVyNhqeS2XsnQ75WX8CNgB+KR
         HyF/qspZ5jmUTDyIy0pPrnO6TwMfISiPN1HVgGINDWo67k/jeK6scf2rUFuAOQaYFLhY
         ky2TgxGi6s/IBh7XYuKZqJHpE2HlU/PZpFVfU8L+mrYbLOhRCCdb2Xc/cgrm2c21J1EE
         9lzw==
X-Gm-Message-State: AC+VfDy9nUaqOjVKRj8Qa8AByVGZpCTMndplEdKbzkp1HebgR/vSqjnq
        Kd10C20RKO9oQBdFxRUVed2bLQ==
X-Google-Smtp-Source: ACHHUZ51vzxDs7AjU8ndh3RMVYQWxD6gTSkurFeCPCmv6odOxecoJJxIcYdY4XsWYRhOUtTUhwgPHA==
X-Received: by 2002:adf:fa06:0:b0:311:15e3:e09d with SMTP id m6-20020adffa06000000b0031115e3e09dmr13371125wrr.36.1687347881744;
        Wed, 21 Jun 2023 04:44:41 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d674f000000b003112f836d4esm4254272wrw.85.2023.06.21.04.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:44:41 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [RFC PATCH 0/1] zboot: Garbage collect unused functions
Date:   Wed, 21 Jun 2023 13:44:38 +0200
Message-Id: <20230621114439.42851-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch is meant to solve the issue reported by lkp in [1] with the KASLR
series support for RISC-V.

The problem in [1] is caused by the addition of new functions in
efi-stub-helper.c which reference symbols that are not defined in the context
of zboot. Those functions are not used in zboot but it causes those link
errors.

I can move those new functions around so that the problem disappears, but I
believe that fixing that using the linker garbage collection is more sane.

That's an RFC, I'll include it in my KASLR series if that's the right
direction.

[1] https://lore.kernel.org/oe-kbuild-all/202306080741.ArdxyO6n-lkp@intel.com/

Alexandre Ghiti (1):
  libstub: zboot: Use -ffunction-sections + --gc-sections

 drivers/firmware/efi/libstub/Makefile       | 1 +
 drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.39.2

