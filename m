Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503EE41E3AA
	for <lists+linux-efi@lfdr.de>; Fri,  1 Oct 2021 00:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbhI3WMb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Sep 2021 18:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhI3WMb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Sep 2021 18:12:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 965D361390;
        Thu, 30 Sep 2021 22:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633039847;
        bh=IwzBemW+hy1M1ewr7atFO0cSMjKx7nF1iOUj3EQWXE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMFkm4a+fgdg4zYaCkaWnSOTeOZ8uAbKkitUxM0+m4BBfXT2b5oLMM7rDTLawyLAE
         NhhBOznSRQz5yRbiTNsvbV6E0IU3T5qz407KpFRCdUtW5hyDqK4d2pDAOMg4JRadt6
         KWrjYIXEm0KrNBVtP+JPzhB2VrG3+5vrqbM5hiSfUBy+07gwCIoejO0uW/sH7DYI6V
         pgwC0QydyQR/hM9nqnvQyR6gIiVBVoszYMQd2xY8yoPecdNAhtt2AC8GtVh+C0O4VI
         bPLArmwwdAbQbiLreQFVTZM6xuVy7lVHSRkS66W+8O7Twsm9hTlzsCUC2ioP79rEse
         MlAOzYU2R7N3A==
Date:   Thu, 30 Sep 2021 15:10:46 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Juergen Gross <jgross@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        devicetree <devicetree@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KVM list <kvm@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-usb@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 0/6] memblock: cleanup memblock_free interface
Message-ID: <YVY15nd56j8x8udh@kernel.org>
References: <20210930185031.18648-1-rppt@kernel.org>
 <CAHk-=wjS76My8aJLWJAHd-5GnMEVC1D+kV7DgtV9GjcbtqZdig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjS76My8aJLWJAHd-5GnMEVC1D+kV7DgtV9GjcbtqZdig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 30, 2021 at 02:20:33PM -0700, Linus Torvalds wrote:
> On Thu, Sep 30, 2021 at 11:50 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > The first patch is a cleanup of numa_distance allocation in arch_numa I've
> > spotted during the conversion.
> > The second patch is a fix for Xen memory freeing on some of the error
> > paths.
> 
> Well, at least patch 2 looks like something that should go into 5.15
> and be marked for stable.
> 
> Patch 1 looks like a trivial local cleanup, and could go in
> immediately. Patch 4 might be in that same category.
> 
> The rest look like "next merge window" to me, since they are spread
> out and neither bugfixes nor tiny localized cleanups (iow renaming
> functions, global resulting search-and-replace things).
> 
> So my gut feel is that two (maybe three) of these patches should go in
> asap, with three (maybe four) be left for 5.16.
> 
> IOW, not trat this as a single series.
> 
> Hmm?

Yes, why not :)
I'd keep patch 4 for the next merge window, does not look urgent to me.

Andrew, can you please take care of this or you'd prefer me resending
everything separately?
 
>              Linus

-- 
Sincerely yours,
Mike.
