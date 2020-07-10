Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F238C21B3E0
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jul 2020 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgGJLRe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jul 2020 07:17:34 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:35449 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgGJLR3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jul 2020 07:17:29 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1BA0E30002524;
        Fri, 10 Jul 2020 13:17:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E419388DDA8; Fri, 10 Jul 2020 13:17:24 +0200 (CEST)
Date:   Fri, 10 Jul 2020 13:17:24 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] EFI fixes
Message-ID: <20200710111724.m4jaci73pykalxys@wunner.de>
References: <20200628182601.GA84577@gmail.com>
 <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
 <20200708162053.GU4800@hirez.programming.kicks-ass.net>
 <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
 <CAK8P3a1GFjM5-ENf7XL6jjUvRdJhgjzYpSGD5R7TmW6oWEhYRA@mail.gmail.com>
 <20200709103459.wenqhbp52vesr7e5@box>
 <CAK8P3a3Cd30gthLj-Kw8dsNa2Cse3YfUs9q8c=nc7fHtQ-QLSg@mail.gmail.com>
 <20200710110034.zthb7lctf7xwj2yt@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710110034.zthb7lctf7xwj2yt@box>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 10, 2020 at 02:00:34PM +0300, Kirill A. Shutemov wrote:
> On Fri, Jul 10, 2020 at 12:09:36PM +0200, Arnd Bergmann wrote:
> > I forgot why we care though -- is there any behavior of gnu11
> > that we prefer over the gnu99 behavior, or is it just going with
> > the times because it's the right thing to do? All the interesting
> > features of c11 seem to also be available as extensions in
> > gcc-4.9's gnu89, though I could not find a definite list of the
> > differences.
> 
> Last time (llist_entry_safe() thread) it came up due to local variables in
> loops feature that is not available for gnu89. Both gnu99 and gnu11 is
> fine.

Same for anonymous structs/unions.  I used to have a use case for that
in struct efi_dev_path in include/linux/efi.h, but Ard refactored it
in a gnu89-compatible way for v5.7 with db8952e7094f.

(BTW, revisiting that commit I think it should have been broken into
smaller pieces, in particular the efi_get_device_by_path() argument
and #ifdef change should have gone into a separate commit.)

Thanks,

Lukas
