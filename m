Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5267596FF
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jul 2023 15:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGSNeu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jul 2023 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGSNet (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Jul 2023 09:34:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595EB11C
        for <linux-efi@vger.kernel.org>; Wed, 19 Jul 2023 06:34:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d20548adso6566251f8f.0
        for <linux-efi@vger.kernel.org>; Wed, 19 Jul 2023 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689773685; x=1692365685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iqyJ1tyt/zGintHwIRAOam+B9iGxWukjiMScggaplw=;
        b=tnwmFnoxmhunQP8kjZ6qRl/OGitVUDE3mJI4J0Bb9Bp8DUXPw7FUvoH4SJaponnIjO
         79/V5ps+CVomWPG8NqwqNbIO27SABfwVaVw3Mb6qZ7VdwIgmflhthWPDxDkyN+f84CyN
         Zq8sLp3Svrl/2foju6LSuOvdNyrJH3ic0TqeIW8z8qycFVYogIcRSsPJoWCvYQP1w8aL
         n/t1wnClJAh/vfLOvbGFPdk/C5OweTX/OB/xQHUXjfxicXFF43koJxJP4T8yqxoolLPE
         XjzgJzV1MbjftRFqHKBTG8TuBD/B+I1enQDU1ce3L3gmKkUdxXiX6YtiZQRcIeH2Vk5D
         97zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773685; x=1692365685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iqyJ1tyt/zGintHwIRAOam+B9iGxWukjiMScggaplw=;
        b=BEXfWmd8oB/aa47TSTwrxQLFc+t/8RtgzT3XFe7qXTUT9YDR7VOy0I3hAM4iHDDgVE
         Klla/eg4a2gOBC4TG0JC1EauVIdTzGLo7v/fjZH2aKwY2uIseuuTTlduboWPOitBNMgR
         09O6vCzejc0xkvurbtaAg2IRL8n0IrcHQ+q/tj0Yc39HVaB5jBmmhPAEZgdG+w/OH3uO
         H3tUDD6YXJcmDyHQKzjiZ/1ElyVT2TzzviMVFBGN46PV7EczLib/QsbDs0uHTxo+0PRU
         WozJPmeh+A3srmnZM5GW/RfyHFbb4+Mb6Bbe/TiC4nNOhlAn+/YUbych5qrx8s+cm3wY
         Y9ig==
X-Gm-Message-State: ABy/qLZ4X6KF5/SiV3u3ei4u5Xwlp7I840hohk4PH8hKMQFwEvUdIJjE
        nAw/WPYjLjGOjeEePxUdX/JTLA==
X-Google-Smtp-Source: APBJJlFyZliGO0KLF5ziGaA7+vZ36hbi8ZslxYYTzzyedsAOYH9vMG5lUGP70/h12j9uhl/y1hPRvg==
X-Received: by 2002:a5d:5906:0:b0:314:f1c:90bc with SMTP id v6-20020a5d5906000000b003140f1c90bcmr2067900wrd.69.1689773684758;
        Wed, 19 Jul 2023 06:34:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d5682000000b00314367cf43asm5360910wrv.106.2023.07.19.06.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:34:44 -0700 (PDT)
Message-ID: <f918a76f-324a-5c91-7dcc-5f5d43b247f6@linaro.org>
Date:   Wed, 19 Jul 2023 15:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/9] vgacon, arch/*: remove unused screen_info
 definitions
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>, Wei Liu <wei.liu@kernel.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Palmer Dabbelt <palmer@rivosinc.com>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-5-arnd@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230719123944.3438363-5-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 19/7/23 14:39, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A number of architectures either kept the screen_info definition for
> historical purposes as it used to be required by the generic VT code, or
> they copied it from another architecture in order to build the VGA console
> driver in an allmodconfig build. The mips definition is used by some
> platforms, but the initialization on jazz is not needed.
> 
> Now that vgacon no longer builds on these architectures, remove the
> stale definitions and initializations.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/csky/kernel/setup.c          | 12 ------------
>   arch/hexagon/kernel/Makefile      |  2 --
>   arch/hexagon/kernel/screen_info.c |  3 ---
>   arch/mips/jazz/setup.c            |  9 ---------
>   arch/nios2/kernel/setup.c         |  5 -----
>   arch/sh/kernel/setup.c            |  5 -----
>   arch/sparc/kernel/setup_32.c      | 13 -------------
>   arch/sparc/kernel/setup_64.c      | 13 -------------
>   arch/xtensa/kernel/setup.c        | 12 ------------
>   9 files changed, 74 deletions(-)
>   delete mode 100644 arch/hexagon/kernel/screen_info.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

