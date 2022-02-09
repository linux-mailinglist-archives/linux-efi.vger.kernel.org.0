Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4E94AF28A
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 14:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiBINVK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 08:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiBINVJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 08:21:09 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35ECC0613C9;
        Wed,  9 Feb 2022 05:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1644412871;
        bh=IBIP7D6ePluxofErTJHBz8DUwJsVyK1rB4p2Vuaclgs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=isaITEAxFwx6i28OT7uW3+PnTYq2/xBzLsWPsZ0qEaDYDjst8Ycf7Qz3gSadFfmfx
         OpIUj64P50jD+FjuoaCsyWHbgvYb6tAFlWzNGofyBnHA5fsbTEing9k3B52BmHqrvF
         I5x8vHPfizGKO0blDoPsztrw2wKGsEG2Iu2XuACs=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 76CD71280B90;
        Wed,  9 Feb 2022 08:21:11 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4yZeh4o7Bs5x; Wed,  9 Feb 2022 08:21:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1644412871;
        bh=IBIP7D6ePluxofErTJHBz8DUwJsVyK1rB4p2Vuaclgs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=isaITEAxFwx6i28OT7uW3+PnTYq2/xBzLsWPsZ0qEaDYDjst8Ycf7Qz3gSadFfmfx
         OpIUj64P50jD+FjuoaCsyWHbgvYb6tAFlWzNGofyBnHA5fsbTEing9k3B52BmHqrvF
         I5x8vHPfizGKO0blDoPsztrw2wKGsEG2Iu2XuACs=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4B0171280B8A;
        Wed,  9 Feb 2022 08:21:10 -0500 (EST)
Message-ID: <3d76ff7aab8cdc134aebf16af66582849bd53156.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Julian Andres Klode <julian.klode@canonical.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        efi@lists.einval.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        debian-kernel <debian-kernel@lists.debian.org>
Date:   Wed, 09 Feb 2022 08:21:09 -0500
In-Reply-To: <YgJrypdQium7AcWV@casper.infradead.org>
References: <20211218031122.4117631-1-willy@infradead.org>
         <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
         <YdSOV7LL0vWCMcWl@casper.infradead.org>
         <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
         <20220208110122.2z4cmbqexmnxuxld@jak-t480s>
         <YgJrypdQium7AcWV@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2022-02-08 at 13:10 +0000, Matthew Wilcox wrote:
> On Tue, Feb 08, 2022 at 12:01:22PM +0100, Julian Andres Klode wrote:
> > It's worth pointing out that in Ubuntu, the generated MOK key
> > is for module signing only (extended key usage
> > 1.3.6.1.4.1.2312.16.1.2), kernels signed with it will NOT be
> > bootable.
> 
> Why should these be separate keys?  There's no meaningful security
> boundary between a kernel module and the ernel itself; a kernel
> modulecan, for example, write to CR3, and that's game over for
> any pretence at separation.

It's standard practice for any automated build private key to be
destroyed immediately to preserve security.  Thus the modules get
signed with a per kernel ephemeral build key but the MoK key is a long
term key with a special signing infrastructure, usually burned into the
distro version of shim.  The kernel signing key usually has to be long
term because you want shim to boot multiple kernels otherwise upgrading
becomes a nightmare.

James


