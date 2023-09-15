Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786C37A1A29
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 11:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjIOJQH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 05:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjIOJQG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 05:16:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8B72D42;
        Fri, 15 Sep 2023 02:15:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-402d499580dso20562345e9.1;
        Fri, 15 Sep 2023 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694769346; x=1695374146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVhExaS+jpAetFeQXoeolqqnZwsqI871bgvTQiw9kKI=;
        b=RfBckr6H6V+4TDJBGvjRrenGnuQ13Z/a6dmULQnXVIBgWyt/KtMDk1Elzd7KMWbdyz
         ve1bg92I34MEs46ude8uzZRcdWe0upYzFpS3rEN/eCCAb45adNAehjZ5hhMqsPRtJLrd
         Zw8pfiBZfhQ//kVMLWraV7D35mi9cFo53Lk+5ObsivX4O4k/ZUKTj2rAnu7Dhd4kjH1h
         KOMyh1p4rn3RhvP7OP8z9YtbFOKtfQXSuwk7YkPrV5sL7Cydi3tsRcrVzYNxExtRAz6A
         SxROv90SFo06iuNX5Ef/n/4n6aB4V774dvtL/N2fh4Xol+Z2OJff56n+3N8koflTzA8t
         CQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769346; x=1695374146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVhExaS+jpAetFeQXoeolqqnZwsqI871bgvTQiw9kKI=;
        b=kf6Kr4Vc/ySreuGkfTPHzL1SrsBf/vUPjOF5X3JKWv2CWXH2CKAT8LiCBEv8zh0OLf
         MdUs/YntjC9E4/g7lVNDJurr5uDeai5TqJNf4Zc0hQRHT07ubEKjIheLwyDTATTkWUWA
         9M4b2c+jONxcxWgC6F9W/RXl7RgUr5Q1O8v/cVLTwdvD5avhbC6ZOhkCvaP7wIj2mQRp
         uEjfOUsoN0Q0QsBhgUQ4kpMUl16L/SmF8FVH1SJ/luyVJnBOYi3GW3sai5Y6UhhultQa
         WhVbMX7rjLNOmCxk9jWJnuVOz1zR5lSU91zFQSWt01U0WQpdHG540M3JPUAAZMUtak2J
         qlhQ==
X-Gm-Message-State: AOJu0YyxXby0Wbtti0sNk0lJfCxFeLafWrLV7cq6gcC1Ns4fG6xeTbim
        gXbmU6qUtNEcAEo+ilRnuxA7LP/oqac=
X-Google-Smtp-Source: AGHT+IHPaYIK6SM5AuHrIlCULwEQfdK9rOb//q+sPL51OiOy+g7iBRx3Ev/Hlyp/yKq/7UWUlr3HCQ==
X-Received: by 2002:a5d:550b:0:b0:31f:d95d:20af with SMTP id b11-20020a5d550b000000b0031fd95d20afmr876814wrv.10.1694769346375;
        Fri, 15 Sep 2023 02:15:46 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d470f000000b0031981c500aasm3909605wrq.25.2023.09.15.02.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:15:45 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 11:15:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@google.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 08/15] x86/boot: Drop references to startup_64
Message-ID: <ZQQgv7VWUa3VGqbb@gmail.com>
References: <20230912090051.4014114-17-ardb@google.com>
 <20230912090051.4014114-25-ardb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912090051.4014114-25-ardb@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The x86 boot image generation tool assign a default value to startup_64
> and subsequently parses the actual value from zoffset.h but it never
> actually uses the value anywhere. So remove this code.
> 
> This change has no impact on the resulting bzImage binary.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/Makefile      | 2 +-
>  arch/x86/boot/tools/build.c | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)

Note that this patch conflicted with a recent upstream cleanup commit:

   e78d334a5470 ("x86/boot: Mark global variables as static")

It was trivial to resolve, but please double-check the result once I push 
out the new tip:x86/boot tree.

Thanks,

	Ingo
