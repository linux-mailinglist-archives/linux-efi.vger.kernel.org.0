Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A2F4ADE09
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 17:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382804AbiBHQNG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 11:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbiBHQNF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 11:13:05 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E10C061579
        for <linux-efi@vger.kernel.org>; Tue,  8 Feb 2022 08:13:04 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2F66C3F1E9
        for <linux-efi@vger.kernel.org>; Tue,  8 Feb 2022 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644336783;
        bh=KanVwVycwVyhWEVvbA3CqdPulguy8dZ41O1L+1VqM/M=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=uEOugRExfbycM4AnDhk/zVkroQY8yWyxr1KeAXqLR2EcFHMa8Il3r0zPKpg2GQaAf
         1i2mxjXa7qI9LNEJhHtcaFgSPaTN5mjcWxFYZJr3HlprHrlLbM+yAmIAbiBQqSiT2X
         HSV+XgnRWYRezhk5fp9FJq736TFMqEZ209Un2/Uypsgy1+sAJYGnjTFYgHNv2YUhM6
         QlsWFpFObK1ijJeCum4JFh2AAEnPfZZDgSP4ax3TVIvuwzrGtwtKh9Hu6kk3blNfvN
         xYqczezkdQ2WZUttX1qIgXuXzTEqIwZ+8tM91vaxuxggxcwBzekmKoT78D59HwB28/
         1t67EPlz52UCw==
Received: by mail-ed1-f71.google.com with SMTP id w3-20020a50c443000000b0040696821132so9926725edf.22
        for <linux-efi@vger.kernel.org>; Tue, 08 Feb 2022 08:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :accept-language:references:mime-version:content-disposition
         :in-reply-to;
        bh=KanVwVycwVyhWEVvbA3CqdPulguy8dZ41O1L+1VqM/M=;
        b=65pWkhdMrGOGz+bHMc/WY6PIqeyX9YQ5R+NPRx2bkHrQUbcQUatjAvJ9hH8UoOFTu+
         FT3n7vTGEtYNMincGGyIBu/RdMsoNj44QTXoLWAKXvZIDiGbxtKxgJYWlKeFmavanmy8
         HnFTZ/wHgX/uEWaFmJku+xOrifZjn89/aL+F5SBktwNBdQYTnMprChe7uFIX0PtjF/69
         nZr0WfmJanZVGY67uaSai28ilSqw8unMTjyTKoJb6FukpAJ54AjNe5kO2oXK2mvmTIE+
         uSsl7x48DLywYQAREgqt2fpplbaJlX8ujRKb4LEW6bdJLZXG3khDYigHcXKnQpFyxROm
         MSSg==
X-Gm-Message-State: AOAM5322cG4YnFTboYpdg/NiydxLneR1kVHlUkaBr/yo3YuXm9EEL81E
        iNgf614cXU0hgHQbwRpvuO4QXxS00QO4bEABSnIITxpZboVYDt9fz5J5KFaoB1OktN9LSN6EeAl
        IWYA/O/gHg2qhILAWCZ8FzwAj/IIHYhODT5AfKA==
X-Received: by 2002:a17:906:149a:: with SMTP id x26mr4163273ejc.103.1644336782824;
        Tue, 08 Feb 2022 08:13:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIoXQ5FP2mUMkS1vwu5r7VNsMHe9wRfg35egcyMzltRFbVzxZ7vtguy695zr1PYIsyi+5vBg==
X-Received: by 2002:a17:906:149a:: with SMTP id x26mr4163255ejc.103.1644336782633;
        Tue, 08 Feb 2022 08:13:02 -0800 (PST)
Received: from jak-t480s ([2a02:908:2816:fb20:ab02:eec7:2fa9:ece7])
        by smtp.gmail.com with ESMTPSA id y5sm1721678ejf.142.2022.02.08.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 08:13:01 -0800 (PST)
Date:   Tue, 8 Feb 2022 17:12:59 +0100
From:   Julian Andres Klode <julian.klode@canonical.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        efi@lists.einval.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        debian-kernel <debian-kernel@lists.debian.org>
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
Message-ID: <20220208161259.inytmx6gm4w34gct@jak-t480s>
Accept-Language: de-DE, de, en-GB, en-US, en
References: <20211218031122.4117631-1-willy@infradead.org>
 <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
 <YdSOV7LL0vWCMcWl@casper.infradead.org>
 <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
 <20220208110122.2z4cmbqexmnxuxld@jak-t480s>
 <YgJrypdQium7AcWV@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgJrypdQium7AcWV@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 08, 2022 at 01:10:34PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 08, 2022 at 12:01:22PM +0100, Julian Andres Klode wrote:
> > It's worth pointing out that in Ubuntu, the generated MOK key
> > is for module signing only (extended key usage 1.3.6.1.4.1.2312.16.1.2),
> > kernels signed with it will NOT be bootable.
> 
> Why should these be separate keys?  There's no meaningful security
> boundary between a kernel module and the ernel itself; a kernel
> modulecan, for example, write to CR3, and that's game over for
> any pretence at separation.

I don't really _know_, but I believe the difference is that the
kernel binaries runs in boot services, and calls ExitBootServices,
whereas modules are loaded after ExitBootServices.

But I don't know the full rationale why (a) the feature exists in
the first place and (b) why the Ubuntu security team chose to require
that constraint.

My goal is just to make people aware of that so they can make
informed decisions :)

-- 
debian developer - deb.li/jak | jak-linux.org - free software dev
ubuntu core developer                              i speak de, en
