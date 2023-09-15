Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD67A22D5
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 17:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjIOPpt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbjIOPpg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 11:45:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665E9E66;
        Fri, 15 Sep 2023 08:45:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so21909205e9.1;
        Fri, 15 Sep 2023 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694792730; x=1695397530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgPvXoM5Am6IVwtiAwFikLshyvCXFJLyhld0epzNIuE=;
        b=N++9plrQdmFKtSF+H/i6xrxGtwQH4k4icnJ67MnlZUeLFHLowPmW1+jjoMjf4PDn47
         DN8ifH5jG39I8uPK2zyTWr29mUtiBCXJ8gTn6/sRpq0k+aJG2WP+lM9WBx5106/KcUJT
         Pa+JJj8HP9bSfr54jxCJDfJBrSH+/En8h/zfjIXtMPrfIx1nMGouxaxWV7Mgol+ZjTb8
         gBGAj/4WbDMCjWfYVm4j+wh2vjvWpfNngeOIAo9oVKnAKQqfk7+17buyvoEJ2UsrLCkw
         GjQ75l/U0Uhz5kJMdaDJgGzQQkJsgCvmExjh/pBCJPZc03PxcJ6rweP9lo/HbI6hCGXK
         Apsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792730; x=1695397530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgPvXoM5Am6IVwtiAwFikLshyvCXFJLyhld0epzNIuE=;
        b=RqKykzfYxi5nEvc2wtAoYJUo6zaktTGxA9rtzMfl8pdzWna7ceQGHF7IJIab5tp7me
         kLDIliLNEEw1/vL7ZrRSxYogGDry5vMbE+9831Oei7XwIEhH29tYbAvuCrBC5LlI2mYm
         vdIchBIuDz1f3YPVShvjI+N96mjYMs02XHOgCje0/H+M8uY40DBtRi9K7ma7BDK4/6rH
         BhJF/n522zIfNjWiVYxzcyiClU9eKOf6F431o7x7vImWsv3RDqKwVZ7gjnFVi7UUeH5F
         PCDBKq0XT/+l3W1kPggCB/R2CINUZc2rNo0pWBZZdHohMfw1l3Q3+t6P2oiAvsCfM9Jd
         WixQ==
X-Gm-Message-State: AOJu0YyK/CnqyQgU/VObQPhXsp6U5XuHijuw1kSOXIHIgNUSb47awb0J
        5R5gfFHYe8PcbqDsvMYbUGg=
X-Google-Smtp-Source: AGHT+IEHurdXQrz+nqOZ9PZmVh3fyR5ZK+9AE8XXMnWDPsiLOHqgUXuUDY2qIWLy17KSJi8T5Qs9ag==
X-Received: by 2002:a05:600c:20d3:b0:3fe:1b5e:82 with SMTP id y19-20020a05600c20d300b003fe1b5e0082mr1468496wmm.20.1694792729689;
        Fri, 15 Sep 2023 08:45:29 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d65c1000000b00315af025098sm4757986wrw.46.2023.09.15.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:45:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 17:45:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
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
Message-ID: <ZQR8FptFJ+8Ht7Y3@gmail.com>
References: <20230912090051.4014114-17-ardb@google.com>
 <20230912090051.4014114-25-ardb@google.com>
 <ZQQgv7VWUa3VGqbb@gmail.com>
 <CAMj1kXGxv_Nt4__ETG-e0vXC7z8SyirCw5NO0p6gsWRbLfbNAQ@mail.gmail.com>
 <ZQR66uQOGCaVQlNu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQR66uQOGCaVQlNu@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Very weird - could it have gotten lost in the sending process, on your 
> side?

In any case I've dropped patch #8 from tip:x86/boot as well - the first 6 
patches arrived fine and are in the intended order.

Once the boot problem has been resolved, mind resending the rest?

There are no changes in -tip that should be interfering: tip:x86/boot has 
an upstream base.

Thanks,

	Ingo
