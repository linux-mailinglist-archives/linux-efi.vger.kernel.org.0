Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA221DE879
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgEVOEi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVOEh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 May 2020 10:04:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAB5C061A0E;
        Fri, 22 May 2020 07:04:37 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jc8He-0005Uc-Qj; Fri, 22 May 2020 16:04:22 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0C755100F17; Fri, 22 May 2020 16:04:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [GIT PULL 0/7] EFI fixes for v5.7
In-Reply-To: <CAMj1kXHogO=3wAyZPi9WtHP9++N5KH6OjNgY_CQ_o8nZJ5jjVA@mail.gmail.com>
References: <20200517125754.8934-1-ardb@kernel.org> <CAMj1kXGUxPuQCv9KPezqpLf1qLTbJh_j9JeVnnYZ=HbnL65=AQ@mail.gmail.com> <20200522134004.GF28750@zn.tnic> <CAMj1kXHogO=3wAyZPi9WtHP9++N5KH6OjNgY_CQ_o8nZJ5jjVA@mail.gmail.com>
Date:   Fri, 22 May 2020 16:04:21 +0200
Message-ID: <87mu60rrq2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ard,

Ard Biesheuvel <ardb@kernel.org> writes:
> On Fri, 22 May 2020 at 15:40, Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Fri, May 22, 2020 at 03:06:20PM +0200, Ard Biesheuvel wrote:
>> > Ping?
>>
>> Did you want to make your tags unique from the next pull request onwards
>> and I were supposed to pull this one as is?
>
> What usually happens is that Ingo applies the patches piecemeal,
> ignoring the tag altogether, so without any coordination between you
> as x86 maintainers or communication back to me, that is what i was
> expecting to happen this time as well.
>
> Note that I have another PR pending since two weeks ago [0].
>
> So if you want to start dealing with the EFI trees in a different way
> from now on, that is perfectly fine with me, but please align with
> Ingo and Thomas first.

/me dons managerial hat

Yes, please. Your pull request really do not need any special handling.

Please add a unique signed tag to each pull request and stick the
description, e.g.

 " EFI fixes for v5.7-rcX:
   - fix EFI framebuffer earlycon for wide fonts
   - avoid filling screen_info with garbage...."
   
into the tag which gives us the merge commit message automagically.

Thanks

        tglx

