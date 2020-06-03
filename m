Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299D11ECFCD
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jun 2020 14:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgFCMbp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jun 2020 08:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgFCMbn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Jun 2020 08:31:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8873CC08C5C1
        for <linux-efi@vger.kernel.org>; Wed,  3 Jun 2020 05:31:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id n24so2446965lji.10
        for <linux-efi@vger.kernel.org>; Wed, 03 Jun 2020 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P9MOihz2dNvs8KZnA010MIHpIN88q045MfnMNo8RW/o=;
        b=cKDJ0CH/AF02dBkES1fgqvnlScibwydiQmc/O6sYnvqocnJJn8D7Dt7BUqJbsXHFOq
         3Dh5EB5u05D+YUsYcdK2/dpz8P58l57wXAVWJcRb+qIKRfzhB1yUJK1hWXTcUY4lbCuG
         USjD327wh1diUNLSkiylOunzvvYK+8hVXWtRTK1+Ul1Zfo3EtpeJBZTM8Z4Oqp98gjBd
         DkWSSTa1qO5cNWMJDug4MRPvXkJ15iRqaEZ7DizskD2LQJKlcCVx4DV6nFhmgQDe10kX
         Xpy2RgMSqATYotfaUQk02ZT1fs/CLkW4WoouCR9LTIlwVpbLTgEVYlT3tpDHo7uZkbM5
         EI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P9MOihz2dNvs8KZnA010MIHpIN88q045MfnMNo8RW/o=;
        b=bYCIWVLS2+X/QBWR4xUVYI6iCzu08FC7I5Yn6IRJV+vyvU82S4YxYl82YPepr2h8Gc
         03jZUC4dj1179bhEinpE8cc33DrnhgMaZTHFZ0Omrqy4rnrzelarScr6NNHa6kM7b4/P
         t2f0W/+61Ey/fJp6GT2/w17cm5zdsfbcW3ql2+gBIfwZQH2ktzKe6JIc+2I6hhVc6/7c
         xEfYoDH27LwdEQ6V3E0ehsyUtL8TUPNEvySaUSWqvz5/9VUlCopycEBP2oTPvU6n42Oa
         DttX4A3DDlqYQ/GBlTlRxZ7GNFx00R2JC+wUYvw07FshvKl9g7yle/tOFRRM5v0x8U2M
         fA/Q==
X-Gm-Message-State: AOAM532aDNlbAX043fCI5rYl6dE3KzNak6o2PAhHQJvzvxGx1GVE0tQf
        eY6wORPhiZGmzCiyWb53Npn9OVxzx1RMNNw9zYsGXg==
X-Google-Smtp-Source: ABdhPJw8SSAJIyE84pdf0Z6PzkVQ0XCT1269nX2POe1eYPap+iF6PA0W87bqQfgKU2PzWMulWs5QUCll7p5vTFgMEVE=
X-Received: by 2002:a2e:911:: with SMTP id 17mr2041281ljj.411.1591187499787;
 Wed, 03 Jun 2020 05:31:39 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 3 Jun 2020 18:01:28 +0530
Message-ID: <CA+G9fYtCP3d805MpSMq0TGkz2uhHpFLaizP8uHxHzC5jnAc0hQ@mail.gmail.com>
Subject: linux-next: arm64 build failed - aarch64-linux-gnu-ld: cannot find
 ./drivers/firmware/efi/libstub/lib.abuilt-in.a: No such file or directory
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-efi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Cc:     ardb@kernel.org, Ingo Molnar <mingo@kernel.org>,
        nivedita@alum.mit.edu, jarkko.sakkinen@linux.intel.com,
        xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

arm64 build failed on Linux-next 20200603.

make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- HOSTCC=gcc CC="sccache
aarch64-linux-gnu-gcc" O=build Image
 #
aarch64-linux-gnu-ld: cannot find
./drivers/firmware/efi/libstub/lib.abuilt-in.a: No such file or
directory
 make[1]: *** [/linux/Makefile:1132: vmlinux] Error 1

-- 
Linaro LKFT
https://lkft.linaro.org
