Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41259134628
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 16:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgAHP1f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 10:27:35 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35056 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHP1e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 10:27:34 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so2990394qka.2
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2020 07:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rdb6+JfhY5qhsSKCWEoEtjzM1b9GuStE4sgdzifSqZA=;
        b=OIs4kaWbjlrZLUUgVbKlUcaXutsuNvx6MNcgbgofKQC5o18EFk0BUG0l3kcxlZFGtH
         tf1gz/KcodVrmYwun0M7guWWa3Qt9EgC3UhRIOwqIo77wj63CQhnJwA4NDcFK9jWzmul
         NAvXdxYyLah+nj+ukomotU/23xa3mSdSOrU/UJT6kJdwMcH4QIs8UI5OwExrTHN+PdMu
         UaQw5/X8Qr3SwZ+7wt0BtkioS3BP03kt8Co9iAHmtRaW3b9Rq5+36EVNBBvWa6u/rha8
         qH7DhOBfkZKLcK62sT0EAchWurnIkGHp9NwnoDL3RQClViJtISZTwEEp4TuV3g6pTrzA
         FM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rdb6+JfhY5qhsSKCWEoEtjzM1b9GuStE4sgdzifSqZA=;
        b=oUG9BFDwq3QLX/SAzHI5yViDBCcPI64jq9ysLTYPQDu0eH5YoLUmtd35yS60Q1A8vv
         n7u0NkyiTxTxdiQ6FV+TzFsHKvpndsvj+iWuJsoiuWBfElqagZnSdTbu7beGNk38UVp3
         cog3kfdGfUI19ZRzdMuCHACC6tiWPcvBohK2WOcQOpeLRuqgUqbPJUQZO9iqaVaC5EZE
         Py3rxSsCaeByur9awQvdsChoEE/wPQuPZKcKYGgRGm7uaiDJVkbJa9lAIcIvSEZJ3N0z
         m+tsREZU/sQrDXvap8LToW/9AsueWd4ncYmpdwrDQMLhCrDM7BVFxtV7K3+qriN9lJhH
         kgOA==
X-Gm-Message-State: APjAAAVU/hgjQx8CVfbYEmt42+pRSkSM9+D/iXngaPSbN/HADcQ052h1
        MJ+m29IqTzBBz0ERf7zMnIA=
X-Google-Smtp-Source: APXvYqwckYR7WQwjWviBHRDBpI7ZndNQ5dvCyMm465UxUnxbRcwrN4BT9gZXaWlNzB05MIwKZxxmtg==
X-Received: by 2002:ae9:ebca:: with SMTP id b193mr4806190qkg.53.1578497253915;
        Wed, 08 Jan 2020 07:27:33 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h28sm1523802qkk.48.2020.01.08.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 07:27:33 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 8 Jan 2020 10:27:32 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 1/2] efi/libstub/x86: use const attribute for
 efi_is_64bit()
Message-ID: <20200108152731.GB2499882@rani.riverdale.lan>
References: <20200108074502.10960-1-ardb@kernel.org>
 <20200108074502.10960-2-ardb@kernel.org>
 <20200108152325.GA2499882@rani.riverdale.lan>
 <CAKv+Gu80MujqKcyxAu9M_dR90cbcHo2_UDrHjuCLO_B0Adm7YQ@mail.gmail.com>
 <CAKv+Gu9bPdCB6=YhDNjPL-S3oWexeEf0wLDuvo-kr0HZ31Feeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9bPdCB6=YhDNjPL-S3oWexeEf0wLDuvo-kr0HZ31Feeg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 08, 2020 at 04:25:41PM +0100, Ard Biesheuvel wrote:
> On Wed, 8 Jan 2020 at 16:25, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Wed, 8 Jan 2020 at 16:23, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Wed, Jan 08, 2020 at 08:45:01AM +0100, Ard Biesheuvel wrote:
> > > > Reshuffle the x86 stub code a bit so that we can tag the efi_is_64bit()
> > > > function with the 'const' attribute, which permits the compiler to
> > > > optimize away any redundant calls. Since we have two different entry
> > > > points for 32 and 64 bit firmware in the startup code, this also
> > > > simplifies the C code since we'll enter it with the efi_is64 variable
> > > > already set.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  arch/x86/boot/compressed/eboot.c   | 14 ++++++--------
> > > >  arch/x86/boot/compressed/head_64.S |  7 +++----
> > > >  arch/x86/include/asm/efi.h         |  2 +-
> > > >  3 files changed, 10 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > > > index 4afd29eb5b34..ab3a40283db7 100644
> > > > --- a/arch/x86/boot/compressed/eboot.c
> > > > +++ b/arch/x86/boot/compressed/eboot.c
> > > > @@ -21,16 +21,18 @@
> > > >  #include "eboot.h"
> > > >
> > > >  static efi_system_table_t *sys_table;
> > > > -static bool efi_is64 = IS_ENABLED(CONFIG_X86_64);
> > > > +extern const bool efi_is64;
> > > >
> > >
> > > Didn't we need to declare this with hidden visibility? Or use the
> > > #pragma GCC visibility push(hidden)?
> >
> > Yes. So this patch depends on
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=next&id=c71339946177f235aa1f750b2dc556ede3288c23
> 
> which is part of the open PR to the TIP maintainers.

Ah sorry.
