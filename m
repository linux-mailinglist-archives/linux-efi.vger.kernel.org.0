Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367A96695F0
	for <lists+linux-efi@lfdr.de>; Fri, 13 Jan 2023 12:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbjAMLxe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Jan 2023 06:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbjAMLw2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Jan 2023 06:52:28 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F64633D43;
        Fri, 13 Jan 2023 03:50:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id cf18so45369957ejb.5;
        Fri, 13 Jan 2023 03:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eh75YM8Wx2vhFwI4QM9022rUL2tROqk3pc2ccwWrbOg=;
        b=TTxPBPbEbN4NRDQbM6q7Yhj4lLB/TbIlowtMioAV14gnrNCrGcdW19KUEBIA6z7oxQ
         yklMWTT1q8dPBjBRu+uEMMvDZ+rGGNhSSbS3NUR9IDSzXOpaNDfdFGYqpJzmDyiKoSPY
         9tDFSTU/q+8zmfinGoBRHaqmLabAa+ce6QPAhkIajBOlAtllOfHcfO2Cjb5erGMJuEBk
         zMVM/XHegsSBcMHTddwyqdHbQYOyJD5AxRAfTKn8eBDOKWj8ApePLkpovT8IoGSSE4uF
         F/Q/ZKxkmxd6WgdLH6H286cT2h3KNZ/B4R4cT37tpDzJXyQz/yMHodZVEJY6IUrgMmDh
         igQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eh75YM8Wx2vhFwI4QM9022rUL2tROqk3pc2ccwWrbOg=;
        b=lBhfb/AlZBbSMIQBQleb2e9YEl3bqNNZ53PyOdPE4m9vmGiKQY7ghDwS5uvEIVgesF
         POMc6UcBpcj185l0+1hCHq9cmBwm1BDjWQYhQCzg9tZYm1sXRmPHlVTB9gV/8qneAlNZ
         8wJoRkgmZy/cI/zpBIiXxp7p8VHyAiAGHBUfHuJjShD8M0c6c3adUjS9T19Jc07reKHJ
         tRu5xCwK/Flsodz+K8nbgmFXXjTbG5hMSnhLBqyQzjiMWk1nHZfW9/PYJYir5E5WMh4T
         zlBalySxsHzxDZQg92g0bfnBsNmIQsxRvXc6GrC1mDLXfvZnuJNphHPtvqoiZp7B0NkH
         DPSg==
X-Gm-Message-State: AFqh2koVEsh5aHTlF2x5uE7saO2zHoat3OHHpYlZ0mCZx7Fhm5yOgKID
        GJKfkSbRLzCMLBb7ADIv37dxtGnduBPIdvCNmm6qIpsNr5E=
X-Google-Smtp-Source: AMrXdXumAaAidXnRQ5QImabpR44eWRbTasirYGR4k1yl7DlfFNRO5iSIVq+aMzns2swXM50Wn0TK4g+lhqdPIsl1g1M=
X-Received: by 2002:a17:907:20fa:b0:7c1:6f86:ec4 with SMTP id
 rh26-20020a17090720fa00b007c16f860ec4mr9447298ejb.621.1673610616559; Fri, 13
 Jan 2023 03:50:16 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 13 Jan 2023 12:50:05 +0100
Message-ID: <CAKXUXMxNc4iObjL+8RyJN=Kcy5X1r21ez_05oAuy93J=gQ2gZw@mail.gmail.com>
Subject: linker problem with Ubuntu 18.04 tool chain: unknown architecture of
 input file `arch/arm64/boot/vmlinuz.o' is incompatible with aarch64 output
To:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dear Ard,

with my Ubuntu 18.04 arm gcc tool chain, I encounter this linker error
in my allyesconfig build:

 LD      arch/arm64/boot/vmlinuz.efi.elf
aarch64-linux-gnu-ld: unknown architecture of input file
`arch/arm64/boot/vmlinuz.o' is incompatible with aarch64 output
drivers/firmware/efi/libstub/Makefile.zboot:41: recipe for target
'arch/arm64/boot/vmlinuz.efi.elf' failed
make[1]: *** [arch/arm64/boot/vmlinuz.efi.elf] Error 1
arch/arm64/Makefile:173: recipe for target 'vmlinuz.efi' failed
make: *** [vmlinuz.efi] Error 2

I bisected it back to happen since commit c37b830fef13 ("arm64: efi:
enable generic EFI compressed boot"), and it still appears with the
latest next-20230113 (on linux-next, I have to remove DRM_MSM as it
currently comes with a build error).

The specific compiler and linker versions on my system are:

$ aarch64-linux-gnu-ld --version
GNU ld (GNU Binutils for Ubuntu) 2.30

$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0


IMHO, I run pretty standard commands:
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 mrproper
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 allyesconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 all

Let me know if you need more information.


Best regards,

Lukas
