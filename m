Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC05F295941
	for <lists+linux-efi@lfdr.de>; Thu, 22 Oct 2020 09:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502403AbgJVHda (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Oct 2020 03:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441599AbgJVHda (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Oct 2020 03:33:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FC2C0613CE;
        Thu, 22 Oct 2020 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JbI0bflC8HQp7NYmkplX8khPFM4YNdFK0FBEU2KovRA=; b=lMsJhYJGc3BhDxJe68Hgu906om
        8Qon8SVUIOhCVFuRh77uHlceHn4dW4RO1HFDbxJpb/Sk9mzOY+XWXyTgrQqS2EoDdglvOg8WVe9MJ
        0N8c+ERqyETP4BuQ2qpnicSgJF4qro87FMpPt4G8VWiqvBj9nXYRhLIbKNNyxSVJRJBtcMoDTxKC1
        Uyu1v2J+K/vCxRtKmxxi6Hl4iirCl7pCaSOWmLIAezfrHRAS2pAtWZ9xKLDUgBZ9xclunQAUFM6bI
        PPWvYBw+4GGlfLjNCyByVldTQ/emii876kndho+qdxv0hvvZHqveaESL6Y3+55wsXV2XLq7zJn4Xb
        b/00Gw6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVV5w-00028b-Mt; Thu, 22 Oct 2020 07:33:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8B873011C6;
        Thu, 22 Oct 2020 09:33:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94AE72BB9BA76; Thu, 22 Oct 2020 09:33:07 +0200 (CEST)
Date:   Thu, 22 Oct 2020 09:33:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH -next] treewide: Remove stringification from __alias
 macro definition
Message-ID: <20201022073307.GP2628@hirez.programming.kicks-ass.net>
References: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 21, 2020 at 11:58:25AM -0700, Joe Perches wrote:
> Like the __section macro, the __alias macro uses
> macro # stringification to create quotes around
> the section name used in the __attribute__.
> 
> Remove the stringification and add quotes or a
> stringification to the uses instead.

There's a complete lack of rationale for this change.
