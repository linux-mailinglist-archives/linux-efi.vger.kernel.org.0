Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943CC58B723
	for <lists+linux-efi@lfdr.de>; Sat,  6 Aug 2022 18:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiHFQ5N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Aug 2022 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiHFQ5M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 6 Aug 2022 12:57:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB437DEDB;
        Sat,  6 Aug 2022 09:57:11 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id cr9so717490qtb.13;
        Sat, 06 Aug 2022 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wj6684H6Kpz2ZtSUodC0U0fU86f1YKlziRI4r3cW+HI=;
        b=BtpSlh2x5s/SOJglV0bbuGknHlFtC17/SdHTJmS3uZdZurl45R2Le81dNFTaKIU6Od
         NXfBR45JX5zUQEBNwnkmNwVGrnem8k97ff2spSUq73FY6s+kv8gM/Ru8ze2xYNcDLMWt
         NsPHERX877627zE1v4BgU9NYY4jNndt7MBzqQ3NF4LA5pe/aFNJhYrfB/2iSJN3dvZ2k
         T3Xo23bCjCQu8n82clu06hLqSSDFmUayNmcBvRq7fAN2NcRPJulq530HBdfcA9SdaNbJ
         Cy/0MQvzHjcYAQFuGtPP1miEIcsPS2jiffpfEm4jbpjIbITcbE9I9CO0LGfjyuVWFsBk
         ls7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wj6684H6Kpz2ZtSUodC0U0fU86f1YKlziRI4r3cW+HI=;
        b=VfX65Zu63iQ7E9F23P24qG523c+WtDDPbQnoW2SoGKpoBYaKJw4D2cOVPdj2cVYlt3
         lXNCjPFoDAZv9gFbXjJUJqSiq7N24oKWdZVtzHqKcpa750/l3H4e6hWfJvnI497O7O3y
         xkCA38F28LIth5eWNpp7Hr8T2Vc3PghzK8lCBMosCZ1REqb0U4HikcxsiqT2Tg9tsnXE
         /uwqm2qsiYOCnqnkg94ANEmKiUF+ET44u8VtvWN/VhIm81zV3QE8uEszt7CY5QSZ5aHL
         u2tNWIuJgDj4s5GBLTJh0V2SwS37FUkz3ExcMJa8ijRzIVzXYGDMMtpipJhzalQOArww
         nj/g==
X-Gm-Message-State: ACgBeo3Ao7pgaoosVqe4qHqZwc3WacBLDQIotTiXuvpMvfPzicp5ttfr
        h3BmfI8bTPjlN84eaxu0JUhC4aHgcDqsziWR+v4=
X-Google-Smtp-Source: AA6agR61xEI/w29pHlhpS9FZx9xdp0DX1Dk2bnjIJClh7I1yqul0PbHxwiEEgwD3NG9K2UtdJlDmFS2nsKEkKIZ0lIs=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr10304276qta.429.1659805030863; Sat, 06
 Aug 2022 09:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220806163255.10404-1-markuss.broks@gmail.com> <20220806163255.10404-2-markuss.broks@gmail.com>
In-Reply-To: <20220806163255.10404-2-markuss.broks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 18:56:34 +0200
Message-ID: <CAHp75VfizQY3kw3qk0des42uAwnYmv94aWQC+fVq_QQJGp-QYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drivers: serial: earlycon: Correct argument name
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Aug 6, 2022 at 6:37 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> The "node" argument is actually an offset, and it's also
> an "int", and not "unsigned long". Correct the of_setup_earlycon
> function.

Suggested-by: Greg KH?

> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
