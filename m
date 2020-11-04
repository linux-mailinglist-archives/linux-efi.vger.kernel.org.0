Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985862A645F
	for <lists+linux-efi@lfdr.de>; Wed,  4 Nov 2020 13:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgKDMbR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 07:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729520AbgKDMbM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 07:31:12 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F31C061A4A
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 04:31:09 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id g12so21821229wrp.10
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 04:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CYMhdSYvqgb4/Tz4vfZIEw4zBJsmg4GIh5qwA7QnBAI=;
        b=DohQrVqieMXXX/3BeuGTHSEgSk8qJde0fn/LHffpFeOId3d66K/Mm1VKZcBKjnC80q
         yNQGgvmjL+1f7btxAPGVzwcfh00GLWTkGqsGzki/bpFsM6GWmS/KP4DH+UVayuI3/GRx
         qrrxft4d91xmXs1BlzJi5uRXw22+mpLu6W45/MPCxNCp5N/yQe9Y2jgLp/5R+Mn9Nnbj
         ZU/Q2XhxtsdJZeXyhZHmyhdjlXdDEZD1imY14xm2d5U9WbPTt3Urg8H6MjQpGNvF1J71
         c/B8VLOis4qLW5LqxYgVVbWOL1iabNPA3+uEmQMa4qcLkNvnGFL1VoR1soU4oXCem04C
         H6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CYMhdSYvqgb4/Tz4vfZIEw4zBJsmg4GIh5qwA7QnBAI=;
        b=TqpIzQ+1kWmcdsiKPd69rerw9EsV3fW8ezMUtEeKKrYsvAOtu8I2MdOnbLuG/TgEfw
         bRIjJc8NSdYlmoikc4yoLrz437wXJwKudG2klad7ba58Q7if9tDYhuslBeafvyWA6t60
         PQPI5a5lFyc+/Lpj3k2Ira9Z+Jm6aJIOnc3bBYpP9Sc6APBJ9UIRUarxHXBknVpGTzhl
         rF7ifyIIjgs/Y0JT2zYjxMRqEzGvewcsnY8B4xAFgWzuqeG9X0f+sMDR7RF+j4P4fBRY
         Ydyrtb7lwbbS2RJ2Q5OBqgRG1sSNmDVhv9x916ZKRbUxkAHV4afXnyUGos7gq5wgfQQo
         /+lg==
X-Gm-Message-State: AOAM53354JMny2ke1WLDc3d3sLHPL5VKTbKR53/VMmW5AXzcSaH0KYYe
        n3Sh1xlNHeqvzBkOVOQYdQBLAA==
X-Google-Smtp-Source: ABdhPJzoYvOvAcikkwClBWltryq6XICymRXfnLQwW8jF7VOc+OZUbDa4EZ0sHBEwmwGJG3qn+wlyiw==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr29707631wrm.285.1604493068199;
        Wed, 04 Nov 2020 04:31:08 -0800 (PST)
Received: from vanye (cpc92880-cmbg19-2-0-cust79.5-4.cable.virginm.net. [82.27.104.80])
        by smtp.gmail.com with ESMTPSA id t7sm2158264wrx.42.2020.11.04.04.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 04:31:07 -0800 (PST)
Date:   Wed, 4 Nov 2020 12:31:05 +0000
From:   Leif Lindholm <leif@nuviainc.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 1/8] linux/arm: fix ARM Linux header layout
Message-ID: <20201104123105.GU1664@vanye>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
 <20201025134941.4805-2-ard.biesheuvel@arm.com>
 <20201104121146.GT1664@vanye>
 <CAMj1kXHfqcDpkPekm7jjgxi5KGCWnBTygrTgBoK2A74MZ6MvkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHfqcDpkPekm7jjgxi5KGCWnBTygrTgBoK2A74MZ6MvkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 04, 2020 at 13:19:47 +0100, Ard Biesheuvel wrote:
> On Wed, 4 Nov 2020 at 13:11, Leif Lindholm <leif@nuviainc.com> wrote:
> >
> > On Sun, Oct 25, 2020 at 14:49:34 +0100, Ard Biesheuvel wrote:
> > > The hdr_offset member of the ARM Linux image header appears at
> > > offset 0x3c, matching the PE/COFF spec's placement of the COFF
> > > header offset in the MS-DOS header. We're currently off by four,
> > > so fix that.
> > >
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> > > ---
> > >  include/grub/arm/linux.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/grub/arm/linux.h b/include/grub/arm/linux.h
> > > index 2e98a6689696..bcd5a7eb186e 100644
> > > --- a/include/grub/arm/linux.h
> > > +++ b/include/grub/arm/linux.h
> > > @@ -30,7 +30,7 @@ struct linux_arm_kernel_header {
> > >    grub_uint32_t magic;
> > >    grub_uint32_t start; /* _start */
> > >    grub_uint32_t end;   /* _edata */
> > > -  grub_uint32_t reserved2[4];
> > > +  grub_uint32_t reserved2[3];
> > >    grub_uint32_t hdr_offset;
> >
> > How did this ever work?
> >
> 
> By ignoring the value of hdr_offset entirely everywhere else

Oh, right - we only bother checking magic, doh!

/
    Leif
