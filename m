Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A966D62280E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 11:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKIKJJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 05:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKIKJI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 05:09:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E888463B4;
        Wed,  9 Nov 2022 02:09:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EF7A1FB;
        Wed,  9 Nov 2022 02:09:13 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BED83F534;
        Wed,  9 Nov 2022 02:09:05 -0800 (PST)
Date:   Wed, 9 Nov 2022 10:08:54 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Possible BUG] arm64: efi: efi_runtime_fixup_exception() and
 efi_call_virt_check_flags() both taint the kernel
Message-ID: <Y2t8Njke376KjHpz@monolith.localdoman>
References: <Y2lAB508TrrjpDPi@monolith.localdoman>
 <CAMj1kXE1jXd_+UAgBvi2kKMMxQErH8EDAHU06mD85Es0OfsYsQ@mail.gmail.com>
 <Y2oq79NaCn6UKkLw@monolith.localdoman>
 <CAMj1kXGswMfSXYmr=LyAOusYjq6eLqC9oPRRCEaR-1u-kFu4Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGswMfSXYmr=LyAOusYjq6eLqC9oPRRCEaR-1u-kFu4Hw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Wed, Nov 09, 2022 at 10:07:00AM +0100, Ard Biesheuvel wrote:
> On Tue, 8 Nov 2022 at 11:10, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> >
> ...
> >
> > Speaking as an user, I think it would be nice to revert the commit, that's
> > how I am running v6.1-rcX kernels on the machine, as updating the firmware
> > is not feasible right now. But I realize that I'm not the one maintaining
> > the code, so I don't have a strong opinion about it :) And it's better now
> > than it was at rc3, when the kernel was panicing.
> >
> 
> I sent out a patch yesterday that tweaks the sync exception fixup
> handler to only disable the runtime service that triggered the
> exception. This means, of course, that you might hit it multiple times
> if several runtime service implementations are buggy, but there are
> only five or so that we actually use, so that shouldn't make a huge
> difference. But it also means a) we don't trigger other code paths
> that freak out when a runtime service that was available suddenly goes
> away and b) the diagnostics are more useful because we will find out
> which other runtime services are broken.
> 
> Could you please test that patch? And for good measure, could you try
> something like
> 
> efibootmgr -t 3
> 
> (as root) to exercise the SetVariable() path as well?

Tried booting with the patch applied yesterday, no regression as far as I
could tell (still hitting the two add_taint() statements, but that's not
what the patch does).

I was trying to figure out how I could test that the other runtime services
are still working correctly, your suggestion is exactly what I was looking
for, thanks. The machine is a shared machine, will test when I get access
to it (hopefully later today) and post my findings.

Thanks,
Alex
