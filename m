Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB70E4AD916
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 14:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbiBHNQW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 08:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348284AbiBHNKm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 08:10:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22905C03FECE;
        Tue,  8 Feb 2022 05:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SLOtUPizIxEMzl9MHmssXbkKq3wV6EV1FfuM53oIxG8=; b=DBwru8G20qotyb5cEIMslVov3c
        TGTgULRVMePaSIfKHeCY43YdN05D97O7K37hs8fQc2ETyaYRHlaggWJ1i4R2+qPbs0tePzIB8dysR
        2Ut7zGGdYP0JPztkbpWaNoCPqIWSBT3GLimeBBpK4pQwhD2i6jFANoSdCZlP7fOzLX3kXhEr83GIu
        NY4Ki8Y78QebuMiWK+OzrqH0ycgDEaIRYHdOLFmmB42Wn8eu4CyIIsfJ4QO7/q/EQ5tiC1eORudQz
        +flOWaS1aWhUwXJX+MB+tt/HP4c9lGh9kkAfLl2DEuK1gDKKG2XvNwp2/OSOXymwi2x9kQYLkFXTR
        W4SeP7SA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHQGQ-004rIV-A0; Tue, 08 Feb 2022 13:10:34 +0000
Date:   Tue, 8 Feb 2022 13:10:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Julian Andres Klode <julian.klode@canonical.com>
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
Message-ID: <YgJrypdQium7AcWV@casper.infradead.org>
References: <20211218031122.4117631-1-willy@infradead.org>
 <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
 <YdSOV7LL0vWCMcWl@casper.infradead.org>
 <CAK7LNAQgixJSnDUMfjc+tg90oMdVoh+i5faEn-rqgmHR3Bk6dQ@mail.gmail.com>
 <20220208110122.2z4cmbqexmnxuxld@jak-t480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208110122.2z4cmbqexmnxuxld@jak-t480s>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 08, 2022 at 12:01:22PM +0100, Julian Andres Klode wrote:
> It's worth pointing out that in Ubuntu, the generated MOK key
> is for module signing only (extended key usage 1.3.6.1.4.1.2312.16.1.2),
> kernels signed with it will NOT be bootable.

Why should these be separate keys?  There's no meaningful security
boundary between a kernel module and the ernel itself; a kernel
modulecan, for example, write to CR3, and that's game over for
any pretence at separation.
