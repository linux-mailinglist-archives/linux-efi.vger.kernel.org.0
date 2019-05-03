Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDBB12F12
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2019 15:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfECN1p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 May 2019 09:27:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfECN1p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 May 2019 09:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mkGg1i+EI0XU//yFAO+gJW+bQDnnQU83x/RNkUevVAw=; b=T9s51+W+nABH6PVAvlfgP+ohw
        RCDyHolxbxOczp+Cg0V5Q3SXBf36YHMOis1fkWWpWSE0zZx6A65FVoDithh+5zNBA/L+/pInK3O58
        PPdp9B6gb5Mj1aHlTOwgYd7feLRBi467iD6vPhfKK/abUZfZCHY1041K3TtWkrj1V0TUQ8aWIVhLI
        +/1YzsyjItpsKuqA6JsKXlZeS7WEi7325sCVTFrE7teQKa5lOodL28eu5Nt6D+miXBGjogCaXg8yc
        VVRuwIZrSBtfheGOujAaXemlnM9xeF/eEeaLHQrjpzSd4fVzD5UcaEhjqq1fDcHkpcop11b8UYehV
        hXvd6JaeQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMYDu-0006ZD-4h; Fri, 03 May 2019 13:27:34 +0000
Date:   Fri, 3 May 2019 06:27:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, jglisse@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] mm/pgtable: Drop pgtable_t variable from pte_fn_t
 functions
Message-ID: <20190503132733.GA5201@bombadil.infradead.org>
References: <1556803126-26596-1-git-send-email-anshuman.khandual@arm.com>
 <20190502134623.GA18948@bombadil.infradead.org>
 <20190502161457.1c9dbd94@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502161457.1c9dbd94@mschwideX1>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 02, 2019 at 04:14:57PM +0200, Martin Schwidefsky wrote:
> On Thu, 2 May 2019 06:46:23 -0700
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Thu, May 02, 2019 at 06:48:46PM +0530, Anshuman Khandual wrote:
> > > Drop the pgtable_t variable from all implementation for pte_fn_t as none of
> > > them use it. apply_to_pte_range() should stop computing it as well. Should
> > > help us save some cycles.  
> > 
> > You didn't add Martin Schwidefsky for some reason.  He introduced
> > it originally for s390 for sub-page page tables back in 2008 (commit
> > 2f569afd9c).  I think he should confirm that he no longer needs it.
> 
> With its 2K pte tables s390 can not deal with a (struct page *) as a reference
> to a page table. But if there are no user of the apply_to_page_range() API
> left which actually make use of the token argument we can safely drop it.

Interestingly, I don't think there ever was a user which used that
argument.  Looking at your 2f56 patch, you only converted one function
(presumably there was only one caller of apply_to_page_range() at the
time), and it didn't u se any of the arguments.  Xen was the initial user,
and the two other functions they added also didn't use that argument.

Looking at a quick sample of users added since, none of them appear to
have ever used that argument.  So removing it seems best.

Acked-by: Matthew Wilcox <willy@infradead.org>
