Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB4484797
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jan 2022 19:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiADSNq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 13:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiADSNq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jan 2022 13:13:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926FC061761;
        Tue,  4 Jan 2022 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qCo/EEOuXkGQd3ORVen9TvUPi33M9r4hwOqzu/uF62I=; b=mcznDQresetsRf92LUuK6tJp/5
        TJzXRLBa39LwWGSHJEC8hQutFTEidjOdAoE9EcGp+wT/OUH47f2CdRSXbIIJNwcpf2SemholjxoIx
        Hp4pA9qI1VNzeq3OHtDW0jSdsF/hPWjooUOIv/1H3cHthrO+lllWXaKKJaEwtzFeo3ClWQ41HvvET
        t0An4YbGGIpg5ZOc0yBTb3udJ+nA67Bbvjk5LIP593BHG87JYBPIJ3/WR4bTWz9Rg9KBv5hkwP71r
        54gQawIjXFddkK2tjFiabLr4ws7CvM2u0uokGvEjg4bP9+u3u08SzpvreA2GuDo2gSelcT/h7PafG
        HiCDEmkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4oJb-00Dt2B-9M; Tue, 04 Jan 2022 18:13:43 +0000
Date:   Tue, 4 Jan 2022 18:13:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efi@lists.einval.com,
        debian-kernel <debian-kernel@lists.debian.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
Message-ID: <YdSOV7LL0vWCMcWl@casper.infradead.org>
References: <20211218031122.4117631-1-willy@infradead.org>
 <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 05, 2022 at 12:39:57AM +0900, Masahiro Yamada wrote:
> > +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> > +key=
> > +if is_enabled CONFIG_EFI_STUB && is_enabled CONFIG_MODULE_SIG; then
> > +       cert=$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> > +       if [ ! -f $cert ]; then
> > +               cert=$srctree/$cert
> > +       fi
> > +
> > +       key=${cert%pem}priv
> > +       if [ ! -f $key ]; then
> > +               key=$cert
> > +       fi
> 
> 
> I still do not understand this part.
> 
> It is true that the Debian document you referred to creates separate files
> for the key and the certificate:
>   # openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform
> DER -out MOK.der -days 36500 -subj "/CN=My Name/" -nodes
> 
> but, is such a use-case possible in Kbuild?

If someone has followed the Debian instructions for creating a MOK,
then they will have two separate files.  We should support both the case
where someone has created a Debian MOK and the case where someone has
used Kbuild to create this foolish blob with both private and public
key in one file.

> In the old days, yes, the key and the certificate were stored in separate files.
> (the key in *.priv and the certificate in *.x509)
> 
> 
> Please read this commit:

Yes, I did.

> The motivation for this change is still questionable to me;
> the commit description sounds like they merged *.priv and *.x509
> into *.pem just because they could not write a correct Makefile.
> (If requested, I can write a correct Makefile that works in parallel build)

I think that would be preferable.  Putting the private and public keys
in the same file cannot be good security practice!
