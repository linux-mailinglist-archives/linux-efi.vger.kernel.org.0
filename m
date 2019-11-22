Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9327F1079E3
	for <lists+linux-efi@lfdr.de>; Fri, 22 Nov 2019 22:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVVRp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Nov 2019 16:17:45 -0500
Received: from heinz.dinsnail.net ([81.169.187.250]:41016 "EHLO
        heinz.dinsnail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVVRp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Nov 2019 16:17:45 -0500
Received: from heinz.dinsnail.net ([IPv6:0:0:0:0:0:0:0:1])
        by heinz.dinsnail.net (8.15.2/8.15.2) with ESMTP id xAMLEhOU026814;
        Fri, 22 Nov 2019 22:14:43 +0100
Received: from eldalonde.UUCP (uucp@localhost)
        by heinz.dinsnail.net (8.15.2/8.15.2/Submit) with bsmtp id xAMLEhvV026813;
        Fri, 22 Nov 2019 22:14:43 +0100
Received: from eldalonde.weiser.dinsnail.net (localhost [IPv6:0:0:0:0:0:0:0:1])
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2) with ESMTP id xAML72hT000413;
        Fri, 22 Nov 2019 22:07:02 +0100
Received: (from michael@localhost)
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2/Submit) id xAML725G000412;
        Fri, 22 Nov 2019 22:07:02 +0100
Date:   Fri, 22 Nov 2019 22:07:02 +0100
From:   Michael Weiser <michael@weiser.dinsnail.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191122210702.GE32104@weiser.dinsnail.net>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blt3y949.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-dinsnail-net-MailScanner-Information: Please contact the ISP for more information
X-dinsnail-net-MailScanner-ID: xAMLEhOU026814
X-dinsnail-net-MailScanner: Found to be clean
X-dinsnail-net-MailScanner-From: michael@weiser.dinsnail.net
X-Spam-Status: No
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Eric,

On Fri, Nov 22, 2019 at 02:00:22PM -0600, Eric W. Biederman wrote:

> > esrt: Unsupported ESRT version 2904149718861218184.
> >
> > (The image is rather large at 18MiB as it has a built-in initrd.)
> When did x86_64 get support for ARCH_KEEP_MEMBLOCK?  I can't find it
> anywhere.

No, is hasn't. I temporarily hacked that in to see if it'd change
anything and it did. Sorry to not be more clear about that.

> Fundamentally when deciding where to place a new kernel kexec (either
> user space or the in kernel kexec_file implementation) needs to be able
> to ask the question which memory ares are reserved.
> What the buddy
> allocator does is unimportant as kexec copies memory from all over
> the place and places it in the destined memory addresses at the
> time of the kexec operation.

> So my question is why doesn't the ESRT reservation wind up in
> /proc/iomem?

My guess is that the focus was that some EFI structures need to be kept
around accross the life cycle of *one* running kernel and
memblock_reserve() was enough for that. Marking them so they survive
kexecing another kernel might just never have cropped up thus far. Ard
or Matt would know.

> Are you dealing with an embedded port that is being clever?

I'm not an expert but think it's rather the opposite: It's just a memory
area provided by EFI containing some potentially interesting information
about the EFI firmware structure itself. The aim is to aid firmware
upgrades. This information needs to survive kexec so the user would be
able to use that information (e.g. for upgrades) after a kexec.

So apart from leaving that memory untouched, I guess it could also be
copied over to a staging area by kexec explicitly to be preserved across
the kexec. Or it could be blanked out in such a way that the esrt driver
would not find it after kexec and just be unavailable, if it's decided
that you should only use data about a firmware for upgrades that you
really just used to boot. I guess a bigger question could be asked
whether it would actually be useful and safe for esrt to be available
after kexec.

> Or is there some subtle breakage now that x86 has memblock support that
> /proc/iomem is no longer being properly maintained?

Uuuh, let me backpaddle very hard here: x86 has not gained memblock
preserve support. That was just me mucking about. Sorry.
-- 
Thanks,
Michael
