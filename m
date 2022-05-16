Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2E527FD6
	for <lists+linux-efi@lfdr.de>; Mon, 16 May 2022 10:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiEPIjX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 May 2022 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiEPIjU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 May 2022 04:39:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D5E0DD;
        Mon, 16 May 2022 01:39:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so24484799lfg.7;
        Mon, 16 May 2022 01:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=58VJTyS91eGqmdDXfaHsOWtLLXLnqdoRzKRAXC8kYBg=;
        b=YVTJUSj/06UfDPLrm20dENmoGpPw2RJnksjmdtiMqOazR5RCC88+ZWL6zRO18B/o/B
         9y/kX/HElg8zwwc6TZ5LZQET02cIH1M1OFTXBOSeyOgSS6KNwYbAuCjzIxCuLbxvjsDD
         8EyhjCSDPM1Plw3hWzHYzL/z5yoiDWwlNvpZSXmFpi0t3lhmU2Bv1J8zGdXMJKFZHjJF
         rUhIAPPwq+z+xJhJMOjJLVUwp60NbkpUQqNqPldCGMvk3ZrIKrm+GFvaurLQHmTVARhm
         hDlKB2gdpPNayypGBUyaAuvpNymHS80rgVgB42nObLLsRGHhih+TH6JYo91Vsw4A0Kg1
         yOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58VJTyS91eGqmdDXfaHsOWtLLXLnqdoRzKRAXC8kYBg=;
        b=QqML4grVSPGqaCJBbJEoRkRuhmFb7/On7F5IeWlt7omOHvVOb2GqZ20nafIdCI3Lvj
         JbJUKnx3rr/eIR0iJXFY4oPuIXfvJoHh+0BD1Yvc72L7yl5Pg66SFgf/jHlDZ5D/eO+j
         eeDl7L5qmVMUJ/v7EMYjigOT7Uto8EIQXGQg+nWWkQ16pRri4rwCbSO83Aq6DigEnL+M
         E9dz/MT8v0f269nYxlf71nW6HbYlVa9YwMqXeMtFNnFI+9X3mQjXd4LpLKP+8vCvwDrP
         o4iaf8tmNxiU6VheDGeYm9FPrt3Y5OpnSxfZQJMmdMOGhN9D0uS8MTy57eFnfivim8mu
         2xkg==
X-Gm-Message-State: AOAM533wzo95DEg9bSrm1LTpbaqvUFPJ7NrfJ72gnjWHj1jtV6bgc22h
        dOigWxiqiHMLXZIqZqH8ZXKMBcqhZDSz/xwR4b3FlUl3ZjI=
X-Google-Smtp-Source: ABdhPJxEEbo+EAFfwfotAw1nk3krfv5ObqZpSLA1blGFWBxMNNAv0SeoagqdByHHQifh2R6BT5Gjsga8Q/x372A24ZQ=
X-Received: by 2002:ac2:5456:0:b0:471:f9e6:7388 with SMTP id
 d22-20020ac25456000000b00471f9e67388mr11665162lfn.504.1652690357642; Mon, 16
 May 2022 01:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
 <YnKr+aMf4PspDpHZ@zn.tnic> <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic> <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
 <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
 <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de> <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
 <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de> <4bc56567-e2ce-40ec-19ab-349c8de8d969@intel.com>
 <CE52D65A-C9F4-408D-B18A-72D87495A433@alien8.de>
In-Reply-To: <CE52D65A-C9F4-408D-B18A-72D87495A433@alien8.de>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Mon, 16 May 2022 09:39:06 +0100
Message-ID: <CAD2FfiHe3hCSNHEA0mSWPbH4LEWhj+FgxkhO83U1GgYEJR6wrw@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do encryption
To:     Boris Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        "H. Peter Anvin" <hpa@zytor.com>, daniel.gutson@eclypsium.com,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, X86 ML <x86@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        alex.bazhaniuk@eclypsium.com, Greg KH <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
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

On Fri, 6 May 2022 at 20:02, Boris Petkov <bp@alien8.de> wrote:
> Remember - this all started with "i wanna say that mem enc is active" and now we're so far deep down the rabbit hole...

This is still something consumers need; at the moment users have no
idea if data is *actually* being encrypted. I think Martin has done an
admirable job going down the rabbit hole to add this functionality in
the proper manner -- so it's actually accurate and useful for other
use cases to that of fwupd.

At the moment my professional advice to people asking about Intel
memory encryption is to assume there is none, as there's no way of
verifying that it's actually enabled and working. This is certainly a
shame for something so promising, touted as an enterprise security
feature.

Richard
