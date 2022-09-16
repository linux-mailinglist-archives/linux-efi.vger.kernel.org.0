Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F525BB23E
	for <lists+linux-efi@lfdr.de>; Fri, 16 Sep 2022 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIPShh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Sep 2022 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIPShg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Sep 2022 14:37:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C766814D0E
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 11:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 733E0B82912
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 18:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CCEC43140
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663353453;
        bh=macHYw5z0ez1mkfuxXlyjzQ83GJ/wDauwItDipbke9c=;
        h=From:Date:Subject:To:Cc:From;
        b=Nx0CznjhziQNWjeq1FZ5ZqqOMZn/1AreraoMGX1cqKuPIsB6xRh7yut/jMNYh1rQ7
         RtCxg7VtXnNMZR9LQoGFghPGAeG1NXzxLTyY+1zI41nwWZ+6DyLpsTNA4tt9z3T/8g
         jIiwJYU6k3ovS0ZbC6/NAkURgTlTeDzdtBWb9gAIEDoLBFBBrDF0OTAKszMlB55RdR
         SAhLs20pCWgXaeFu89K4uZFa3eT+ALNQAcYcMm5XFOgaS9mfucZIjBswcIPDNIcMel
         fQ1ulqAqo8G1MY1PJlSQJprVuo/CQ74lj0CMj8QjKzZyAOv4/xTDYI9uAsjM/VmtYS
         GWSH2NXe9Jjog==
Received: by mail-lj1-f175.google.com with SMTP id p5so26945273ljc.13
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 11:37:33 -0700 (PDT)
X-Gm-Message-State: ACrzQf2lO2MkuCUGsF0/ckGBUgDr9B4oGuV/OwUHs/kWiH7BOKaix6VP
        sTVkYt5SU5qGj3ynMv/AROrnWODbzVpjSlR8gvA=
X-Google-Smtp-Source: AMsMyM73lJrGRaV9MwfEV8KiASlsJLCDMD/HmPsY2EMfjfiRHVjwb6CLeGIbhljiKNTl/TU/z6WV5VghKt+zKriE3Lg=
X-Received: by 2002:a2e:2d0a:0:b0:26c:a1c:cdf with SMTP id t10-20020a2e2d0a000000b0026c0a1c0cdfmr1989814ljt.352.1663353451049;
 Fri, 16 Sep 2022 11:37:31 -0700 (PDT)
MIME-Version: 1.0
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 16 Sep 2022 20:37:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHk2o2g2t34-iMawUjfJd1uCZc1QaXH90TpS54Sg6PiCQ@mail.gmail.com>
Message-ID: <CAMj1kXHk2o2g2t34-iMawUjfJd1uCZc1QaXH90TpS54Sg6PiCQ@mail.gmail.com>
Subject: Removing DT dependency from LoongArch EFI stub
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>
Cc:     linux-efi <linux-efi@vger.kernel.org>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

One of the things I didn't quite like was that LoongArch now uses
libfdt only because our EFI stub code depends on it. I would like to
fix this.

I have pushed a branch here that implements this. Unfortunately, it
doesn't proceed beyond

and I need some help debugging the error.

EFI stub: Booting Linux Kernel...
EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
EFI stub: Exiting boot services ...

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=efi-cleanups-for-v6.1

The idea is to pass the EFI system table pointer and the command line
pointer directly. In previous patches, the initrd and memmap code is
updated so it exposes the information via configuration tables that
the generic code can parse.

Any help is greatly appreciated.

Thanks,
Ard.
