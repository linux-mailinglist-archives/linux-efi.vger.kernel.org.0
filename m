Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5637061102B
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 13:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJ1L5t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 07:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJ1L5r (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 07:57:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9BA1D2F53;
        Fri, 28 Oct 2022 04:57:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bp11so6279399wrb.9;
        Fri, 28 Oct 2022 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6TXMetWnpVwYHSPTFYs3mT2fLaW0Up+55RjBCRl8KU=;
        b=mvmaK9T8qwPNPB+J7se1Ff9zTxxeP5LLtleQPQy2l7Ig/MCTEFsrnWFwWD7izpJuDX
         OFjdnlq66bH7TMJzIUW2jFH/t+JtAqni85de4XJRnsuyWahj4y7ZQef9hvkcilHKIwJX
         9CBpP0OTuUDodmFUqc4VNfUlJzuzkJnzp/CTbLRQsT3Er27hbpQO7Af9jhUnpZn8Cw/7
         O9+hK8QKIRtVOUnvAlaMaRJhuj0GNA3qbF2cR78tBUoUk8ELZCMDWTZ7clljMjsNJqT0
         tHqkbcxREOVf0xpWkXPvJYZj63Hdx1+MxdBeJlfxIjK1ewNECpMl/LcVh+pxL0oS22N6
         R06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6TXMetWnpVwYHSPTFYs3mT2fLaW0Up+55RjBCRl8KU=;
        b=dammCV1/erP2hD3tUesLqG+u9ixNgQnuhAt7gtGijQryAKcBJ6Hkt3jMOdIjHjYDBs
         BQs0BQAhAWQ4WKtT5nv6N/JD2cCNnyGRX9L+sIOjCp54RjHJMkW3W88qmWnVMeyNoSXS
         3yful2Vx2dp6LmdpNEuQD2UV+3MeiF7+0nppjcvweQj//lY7EqXrqaPYCJKsozYhE2GP
         zPzMYslMxGDEog9rjwncpgk5a7IViu1vdIVS21Fj9SDgswUh1y50SJrYK6bZZ0p5U0+a
         vqubpQVbxbdyu5/MChFkcXjhM7gjK/HptWH82D/azTi0rySzIFa26jDoHVPuuJNOV5T/
         3Jbg==
X-Gm-Message-State: ACrzQf177XCJKQUXZexTqf2kVegFnj+c6v1KdG7DWytinlVP2/bsqNAm
        eouYfeglqfrcIdJafGXBeiQ=
X-Google-Smtp-Source: AMsMyM5hRnYbweXL1+XX4tNLxBdLLaib/s1w7MLS8s8E1AxKI0PtEVr2IixL3tBFIsXYWvEkZo2/Mg==
X-Received: by 2002:a5d:47a4:0:b0:230:20a1:2054 with SMTP id 4-20020a5d47a4000000b0023020a12054mr35753467wrb.299.1666958264871;
        Fri, 28 Oct 2022 04:57:44 -0700 (PDT)
Received: from felia.fritz.box (200116b826565c00108e11a5f898944c.dip.versatel-1u1.de. [2001:16b8:2656:5c00:108e:11a5:f898:944c])
        by smtp.gmail.com with ESMTPSA id h8-20020adffa88000000b0023538fb27c1sm3547623wrr.85.2022.10.28.04.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 04:57:43 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust entry after arm64 efi-entry.S file movement
Date:   Fri, 28 Oct 2022 13:56:19 +0200
Message-Id: <20221028115619.2814-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 6ed27461c9c8 ("arm64: efi: Move efi-entry.S into the libstub source
directory") moves arch/arm64/kernel/efi-entry.S to
drivers/firmware/efi/libstub/arm64-entry.S, but misses to adjust the
MAINTAINERS file.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken file pattern.

Adjust the file entry in EXTENSIBLE FIRMWARE INTERFACE (EFI) to this file
movement.

As the file drivers/firmware/efi/libstub/arm64-entry.S is already covered
by the entry drivers/firmware/efi/, simply remove the arm64 file entry.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4f908c28d7e..194ae5dd952e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7806,7 +7806,6 @@ F:	Documentation/admin-guide/efi-stub.rst
 F:	arch/*/include/asm/efi.h
 F:	arch/*/kernel/efi.c
 F:	arch/arm/boot/compressed/efi-header.S
-F:	arch/arm64/kernel/efi-entry.S
 F:	arch/x86/platform/efi/
 F:	drivers/firmware/efi/
 F:	include/linux/efi*.h
-- 
2.17.1

