Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD34B00EB
	for <lists+linux-efi@lfdr.de>; Thu, 10 Feb 2022 00:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbiBIXFC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 18:05:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiBIXFB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 18:05:01 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DFCE01976B;
        Wed,  9 Feb 2022 15:05:03 -0800 (PST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 219N4i1Z004353;
        Thu, 10 Feb 2022 08:04:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 219N4i1Z004353
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644447884;
        bh=a4CPTySbfz6tATOd3oisyCSdvLEgbXZVMlYkkDX676Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J+HdsNYfFFKEgIiacdUdp4ULvPnM/LbolxFvFZHp/DGpD5/6wl2As7pPXuzjGPpA9
         6SEM5s9qN8Iv9fdmusZA4JPcYVT6rqqI/FLXM+3j5Jeme32pQ8NKs7C3kkv73mlfbX
         lk2G149zFVXv24WacOyzDKiceLjR9QIRj/98h1f6uZ+k0tiUlHrIGblZ67kzS5nOzm
         rCaCIwpKOjzge2xE6IsoVf76HEHc8YpqyNDBhlK96AnWovLTY+thfNoOlruzJZzmb0
         N98XM3lWwTogUP060YeBUdsPH7aMpKU1h33a11Tn/prmS90FNfZHBiUa4h5ZceJ/Fg
         jKZgvJp6urIYw==
X-Nifty-SrcIP: [209.85.214.174]
Received: by mail-pl1-f174.google.com with SMTP id y17so252776plg.7;
        Wed, 09 Feb 2022 15:04:44 -0800 (PST)
X-Gm-Message-State: AOAM531KSWnQDkOfQZwBq3iyptZAtN85Dlx//5AhIUEDlIWYKxAvTIpB
        I4iIw74lA9KRhXXQOetlCCjGRXsZVqBeJ5xjOg0=
X-Google-Smtp-Source: ABdhPJwWB8ZNnsMSrugJLAaUoxmVXtYfCekIy7V3ZzXWPCjfVCdzOirMrkT+yVSMb4QpnAJTnSLfCYIdBvKSRlsafrw=
X-Received: by 2002:a17:903:22c5:: with SMTP id y5mr2455424plg.99.1644447883812;
 Wed, 09 Feb 2022 15:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20211218031122.4117631-1-willy@infradead.org> <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
 <YdSOV7LL0vWCMcWl@casper.infradead.org> <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
 <20220208110122.2z4cmbqexmnxuxld@jak-t480s> <YgJrypdQium7AcWV@casper.infradead.org>
 <3d76ff7aab8cdc134aebf16af66582849bd53156.camel@HansenPartnership.com>
In-Reply-To: <3d76ff7aab8cdc134aebf16af66582849bd53156.camel@HansenPartnership.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 10 Feb 2022 08:04:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNFnARmhJ0ik3uCiasuTDGgi9PtEgi7m+EPgHtK0-t5Q@mail.gmail.com>
Message-ID: <CAK7LNASNFnARmhJ0ik3uCiasuTDGgi9PtEgi7m+EPgHtK0-t5Q@mail.gmail.com>
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        efi@lists.einval.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        debian-kernel <debian-kernel@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 9, 2022 at 10:21 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2022-02-08 at 13:10 +0000, Matthew Wilcox wrote:
> > On Tue, Feb 08, 2022 at 12:01:22PM +0100, Julian Andres Klode wrote:
> > > It's worth pointing out that in Ubuntu, the generated MOK key
> > > is for module signing only (extended key usage
> > > 1.3.6.1.4.1.2312.16.1.2), kernels signed with it will NOT be
> > > bootable.
> >
> > Why should these be separate keys?  There's no meaningful security
> > boundary between a kernel module and the ernel itself; a kernel
> > modulecan, for example, write to CR3, and that's game over for
> > any pretence at separation.
>
> It's standard practice for any automated build private key to be
> destroyed immediately to preserve security.  Thus the modules get
> signed with a per kernel ephemeral build key but the MoK key is a long
> term key with a special signing infrastructure, usually burned into the
> distro version of shim.  The kernel signing key usually has to be long
> term because you want shim to boot multiple kernels otherwise upgrading
> becomes a nightmare.

Fully agreed.



-- 
Best Regards
Masahiro Yamada
