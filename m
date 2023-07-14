Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD2753638
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jul 2023 11:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjGNJPD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jul 2023 05:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjGNJPC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Jul 2023 05:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9FE65;
        Fri, 14 Jul 2023 02:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 954D861BE9;
        Fri, 14 Jul 2023 09:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F192BC4339A;
        Fri, 14 Jul 2023 09:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689326101;
        bh=UR2PQiTkOraF/bPw+g8tGmTxW93mOHT7lPZ28fwQOFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OwskA8MiBl+tCCRvL+2eVNppC5lcMnMXfX+lB/WshioJtkJEDn/tXihFYSuB8WZhI
         DFXZdIP49gZ0cQEiecuTdppuMzopbmRdIoM3AeFXFZ+hOUasMD2Kv7kWHevm8svmGi
         +y6dM7TaIfKf+81fwmwsm24p8bPWMJD6qFZ/JBcRBvlanNl1lTd84qd1reP0isH76R
         jBOHdyE1nQ4AJMgRZI4Zih0HAZwWAvIYeQdYpdFv4KclJ+djhf2ZkBodhSef2OTE4T
         mUPTER7KRWZMQmEPhC0V0lbNduWtqjrJ6bviP1DMOFYtJc1/cMJbbS6Lm6Xr8z0De7
         2Ds5ssnH52AHA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so2879288e87.1;
        Fri, 14 Jul 2023 02:15:00 -0700 (PDT)
X-Gm-Message-State: ABy/qLbJpJc2JQTHJRerFwf70yX7y0TMJRLUTF4ZO9VkHXVYt6sGqum0
        sXHiwx44XSl0WSuaTqTD5scjmtne5m63zlDaFR4=
X-Google-Smtp-Source: APBJJlGk74A4Y3faJunek748jUmeGt71UOaWdftQ8DOLfW1hWXbqHOLv+yCjr3LcOUkpygpM5k+UGai06QjHxDQoEYA=
X-Received: by 2002:ac2:43c4:0:b0:4f8:5f32:b1da with SMTP id
 u4-20020ac243c4000000b004f85f32b1damr2953923lfl.24.1689326098874; Fri, 14 Jul
 2023 02:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home> <CAMw=ZnSF_s-+74gURPpXCU+YSTeXDAYfVp_A9DOFoW7oL2T_Hw@mail.gmail.com>
 <CAMj1kXG1Sk1G=3PCRmiHZ24qPdUYiGRkSbq57u1-KUbyorX8Lg@mail.gmail.com> <20230714091310.GA21128@srcf.ucam.org>
In-Reply-To: <20230714091310.GA21128@srcf.ucam.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Jul 2023 11:14:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH+49YE6TQdRaEXGYF7OVY0dKY8KqvJ0N4dEHPOwhmjiA@mail.gmail.com>
Message-ID: <CAMj1kXH+49YE6TQdRaEXGYF7OVY0dKY8KqvJ0N4dEHPOwhmjiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Luca Boccassi <bluca@debian.org>, Peter Jones <pjones@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 14 Jul 2023 at 11:13, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Fri, Jul 14, 2023 at 10:52:20AM +0200, Ard Biesheuvel wrote:
>
> > Maybe the OEMs have gotten better at this over the years, but it is
> > definitely not possible for the distros to rely on being able to get
> > their own cert into KEK and sign their builds directly.
>
> Getting certs into local machine databases should[1] be possible on all
> Windows certified machines, but in the status-quo there's no
> cross-vendor solution to doing this. Relying on the Shim-provided
> mechanisms is much safer from a consistency perspective.
>
> [1] Every time someone has claimed it's impossible to me I've ended up
> demonstrating otherwise, but that's not a guarantee

Interesting. So by 'demonstrating', do you mean running some EFI app
that calls SetVariable() on PK/KEK/db directly, rather than going via
the UI?
