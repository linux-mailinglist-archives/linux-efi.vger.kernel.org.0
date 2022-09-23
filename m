Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B931F5E81C7
	for <lists+linux-efi@lfdr.de>; Fri, 23 Sep 2022 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiIWSby (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiIWSbm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 14:31:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F391280C2
        for <linux-efi@vger.kernel.org>; Fri, 23 Sep 2022 11:31:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 9so899906pfz.12
        for <linux-efi@vger.kernel.org>; Fri, 23 Sep 2022 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=bP5mST62l3Dyplz/ju44QwmUlqSEvtJtbI9d63/+wa4=;
        b=LmxM4Lz58SHUvrkrIDVdepMVdSRQVWhb0IlR3f+Yovh2Cag0sjNwoC90rQKRLK9hC1
         AzYQmE4xAjwoNc4CI+gAqYwedw3+SSn/iDZaiATAx2X7dYUI/+nmQeNdJ4PwBSOomhFO
         do9ZF7l8HzIAkh+9dE2aIqst0P0cZu3xLfTPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bP5mST62l3Dyplz/ju44QwmUlqSEvtJtbI9d63/+wa4=;
        b=nzDUTu1VG4aMZ7yaeBucjjXTGJD68CJJjAKMR2NCe6MlChhI/DLxFdjoVC+IluExRp
         R9tUFhucpTw2DJ8mQiUXlLyZefltr46JqpLW9I2fcOioD/HHDkU4R+crKMXI9VtAJUCJ
         45+blmgz9xBm/e1Y38ROziIME/ci7XU6tK/ZAnzHKg/7O3t2VrzJt7UjrLJ7naCDzKju
         xAEsTXjZF5Rl3zrMfCak2MxKtL2RKaAkpXzkUNwHdNPEEOEDYRStyWTAhA40WAGCkHMi
         T2hU5nm5r/BiHBBt92yTGvMZa7hOWyMZ5WHjEBSZWLU+B+eTwTChuW0cnom78VL7fgPp
         wYtg==
X-Gm-Message-State: ACrzQf3lvU72+2d9qXa1KBG/P3RrtsgWnDcLfB02IYqA1ohfYg1bwfDK
        U2qpcMJX9MAI+C1f6SSIc152Zw==
X-Google-Smtp-Source: AMsMyM4LxG6s/WHMxivxyo0jIZYIGAIIFOx9grBhvtkzTKJXnR7Myuh6jLcm1g00SWqiKnYyJByFmQ==
X-Received: by 2002:a63:594c:0:b0:438:f2ce:8780 with SMTP id j12-20020a63594c000000b00438f2ce8780mr8739037pgm.285.1663957899033;
        Fri, 23 Sep 2022 11:31:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b0016c5306917fsm6403374plf.53.2022.09.23.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:31:38 -0700 (PDT)
Date:   Fri, 23 Sep 2022 11:31:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/mm+efi: Avoid creating W+X mappings
Message-ID: <202209231126.6855D54@keescook>
References: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
 <20220922193157.1673623-1-dave.hansen@linux.intel.com>
 <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
 <Yy1ZadE6Vnnc2dNf@hirez.programming.kicks-ass.net>
 <CAMj1kXEvt-TQzO5jO6srkC8jW5fbou95VKu=os3gt_y87ZPJWg@mail.gmail.com>
 <5f443915-b38a-c78d-cccd-876501434cef@roeck-us.net>
 <CAMj1kXEt1RwYbkBOFa=KsML0KvJ6Zuu9eJ_=jQA7BTW-N2BSeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEt1RwYbkBOFa=KsML0KvJ6Zuu9eJ_=jQA7BTW-N2BSeA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 23, 2022 at 04:26:58PM +0200, Ard Biesheuvel wrote:
> I was basically making the point that we still support i386 without
> PAE (which is a prerequisite for supporting non-executable mappings),
> and if we are going to be pedantic about security on this
> architecture, we should probably make PAE mandatory as well.

My expectation would be that if someone is running modern kernels on i386,
they're not using PAE. If they care about PAE, I'd expect them to have
long since moved to x86_64.

> If we are ok with the current state, enabling this permission check on
> i386 makes no sense.

I'd agree. If it's a choice between "spend a lot of time making sure
this works correctly on i386" and "don't do this at all on i386", I
would pick the latter. If someone steps up to do the former, then by
all means take the patches.

-- 
Kees Cook
