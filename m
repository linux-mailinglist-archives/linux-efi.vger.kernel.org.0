Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B74D70B27C
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 02:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjEVAXK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 21 May 2023 20:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEVAXK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 21 May 2023 20:23:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDA8D7;
        Sun, 21 May 2023 17:23:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso4912018a12.1;
        Sun, 21 May 2023 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684714988; x=1687306988;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAfoTJTuXzknmLlBI5ViwPZYI1PuWLrhmX2kfKQYWIE=;
        b=RYEEWS33yTgfPCb74moX5aEj6ndxqzoWnof3duGQMxZas6FXdPPoHGJBNswtPlAill
         RrScBJg7TYWXDserxwV6DuHPqABbz1P7zX/DphoImhGYMKbQns1EYLty/pbnbq3+Jq5X
         AqkYGosOKt6TlhBwq55WBXfnFHfED2MYWdg14gUnm1chdm3NbFHNr5HPx5CeurADeYrg
         fHtwj0WVci330egv06ExwIQHJWRJqe8GT9W6oQ+pKrXFc36giClGFiOrjA3Fge00Lxgq
         zGXgqOp5xBdzRFKQuePirqcFzhjyTcC3e53Y7/4/c0bghuoz0q3HEle6E+bhV9tAGbJ5
         Iyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684714988; x=1687306988;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RAfoTJTuXzknmLlBI5ViwPZYI1PuWLrhmX2kfKQYWIE=;
        b=SD5x3CrTbcyL2/UU5dFwSEK0XrwZcu90/KZljrICYr997IkRm8DKSOT1SX8wp9g8g0
         FlCNed/I803FUSdWv3urWeETt/nkYSuj5Ek/tCsVLloWP6KXvfP2nRruWETxCY8n+3ET
         +DN49QNEmioLxz/3wYAit4OYlbVuVxeQw3e/1SfzZ1/B1HRWc2Tg2um0WzQahi46wLGX
         tuKBUBPiuKcmWSterp/7P3JnQYPfOA5eN9Q+gPrWbgm3yETcHv6W/tzAukWNIGnkAlPs
         dRWp1RFoqywgr9Rhkfg9CAODO8TUfncZTWwfd5qqFzmKQ2ArpPJ6+qn+GlOG6GjQ6KjH
         g3IA==
X-Gm-Message-State: AC+VfDz0ofdvzq45ouOkOG7S7gD4IwtfbgOmEYrCK0iz2a+z4ytFx4jn
        7/8X0nKAng4jXKLALsxnG56nYTPRrOE=
X-Google-Smtp-Source: ACHHUZ6LM0I6jd4rJh2WZnhuiAVSEf7C4wytsXW2Ncj6jyUBMEeabOyNCk3EFFkm2JBYy4NGDrqMmg==
X-Received: by 2002:a17:902:e547:b0:1ac:815e:320b with SMTP id n7-20020a170902e54700b001ac815e320bmr11075276plf.17.1684714987934;
        Sun, 21 May 2023 17:23:07 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-10.three.co.id. [180.214.232.10])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090282c600b0019a773419a6sm3458854plz.170.2023.05.21.17.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 17:23:07 -0700 (PDT)
Message-ID: <8a79151b-ef75-08ad-ae3d-f6cdabfeaa47@gmail.com>
Date:   Mon, 22 May 2023 07:23:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux EFI <linux-efi@vger.kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Bartlett <ajb@elrepo.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Regression. -6.3.X Good. -6.4-rcY Bad.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

I notice a simple build-time regression on Bugzilla [1]. Quoting from it:

> This is a very simple to see regression.
> 
> On arm64 hardware, take any one of the -6.4-rcY tarballs created by Linus. Extract the contents of the tarball and cd to the linux-6.4-rcY directory. Issue a "make clean" or a "make mrproper" or a "make distclean" command. Look at the output (there should not be any). In every case, the output is --
> 
> nm: 'vmlinux': No such file
> 
> A bisection of Linus' full tree was performed specifying v6.4-rc1 as bad and v6.3 as good. Here is the result --
> 
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [ac9a78681b921877518763ba0e89202254349d1b] Linux 6.4-rc1
> git bisect bad ac9a78681b921877518763ba0e89202254349d1b
> # status: waiting for good commit(s), bad commit known
> # good: [457391b0380335d5e9a5babdec90ac53928b23b4] Linux 6.3
> git bisect good 457391b0380335d5e9a5babdec90ac53928b23b4
> # good: [6e98b09da931a00bf4e0477d0fa52748bf28fcce] Merge tag 'net-next-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect good 6e98b09da931a00bf4e0477d0fa52748bf28fcce
> # good: [70cc1b5307e8ee3076fdf2ecbeb89eb973aa0ff7] Merge tag 'powerpc-6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect good 70cc1b5307e8ee3076fdf2ecbeb89eb973aa0ff7
> # bad: [865fdb08197e657c59e74a35fa32362b12397f58] Merge tag 'input-for-v6.4-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
> git bisect bad 865fdb08197e657c59e74a35fa32362b12397f58
> # good: [e81507acdc19d91df4121f409871f3e4e055f6c2] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect good e81507acdc19d91df4121f409871f3e4e055f6c2
> # bad: [26c009dffca89b0f8fe7facc41d1ccf88a66825a] Merge tag '6.4-rc-smb3-client-fixes-part1' of git://git.samba.org/sfrench/cifs-2.6
> git bisect bad 26c009dffca89b0f8fe7facc41d1ccf88a66825a
> # bad: [10de638d8ea57ebab4231ea077bed01d9bade775] Merge tag 's390-6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> git bisect bad 10de638d8ea57ebab4231ea077bed01d9bade775
> # good: [680957b3b8b0b2e8697592fcb77369d4f643908a] s390/relocate_kernel: use SYM* macros instead of ENTRY(), etc.
> git bisect good 680957b3b8b0b2e8697592fcb77369d4f643908a
> # good: [ea76e08f4d901a450619831a255e9e0a4c0ed162] rust: ioctl: Add ioctl number manipulation functions
> git bisect good ea76e08f4d901a450619831a255e9e0a4c0ed162
> # bad: [825a0714d2b3883d4f8ff64f6933fb73ee3f1834] Merge tag 'efi-next-for-v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi
> git bisect bad 825a0714d2b3883d4f8ff64f6933fb73ee3f1834
> # good: [9489d1bdb763a3dd954e61522043190a9fd1cb4c] power: supply: generic-adc-battery: simplify read_channel logic
> git bisect good 9489d1bdb763a3dd954e61522043190a9fd1cb4c
> # good: [528bd42615f4bb564613cc76dead90d7fbae76ba] power: supply: rk817: Drop unneeded debugging code
> git bisect good 528bd42615f4bb564613cc76dead90d7fbae76ba
> # good: [538bc0f40b364f2c7b81f11aa163f723b138b40f] efi/zboot: Set forward edge CFI compat header flag if supported
> git bisect good 538bc0f40b364f2c7b81f11aa163f723b138b40f
> # bad: [026b85796ab4d52af56f8a1c60d2613983ecd845] efi/zboot: arm64: Grab code size from ELF symbol in payload
> git bisect bad 026b85796ab4d52af56f8a1c60d2613983ecd845
> # bad: [45dd403da851124412d32e3193c21de4a51d29da] efi/zboot: arm64: Inject kernel code size symbol into the zboot payload
> git bisect bad 45dd403da851124412d32e3193c21de4a51d29da
> # first bad commit: [45dd403da851124412d32e3193c21de4a51d29da] efi/zboot: arm64: Inject kernel code size symbol into the zboot payload
> 
> Reverting the commit 45dd403da851124412d32e3193c21de4a51d29da resolves the problem.

The regression looks like arm-specific, but the first bad commit
IMO isn't related to kbuild system.

Anyway, I'm adding it to regzbot:

#regzbot introduced: 45dd403da85112 https://bugzilla.kernel.org/show_bug.cgi?id=217468
#regzbot title: nm vmlinux ENOENT when "make mrproper" on arm64

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217468

-- 
An old man doll... just what I always wanted! - Clara
