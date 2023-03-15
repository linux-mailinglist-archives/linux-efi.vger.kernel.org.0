Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82F16BBB8D
	for <lists+linux-efi@lfdr.de>; Wed, 15 Mar 2023 18:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjCOR6b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Mar 2023 13:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjCOR61 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Mar 2023 13:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B7F3E096
        for <linux-efi@vger.kernel.org>; Wed, 15 Mar 2023 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678903062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d+QEuJRmUpE8YOJGSMTzR0yeIC0gMbNde13EIE8mzH8=;
        b=E+X4PABNTccrqGhtAZWMirPdoGgWnzbWAt5zWHyOzUK8oGM4Ut9jWtuBIzZRuiX12kZFSB
        HChxdGShi7KR1SMKPxN6MFxIp3+zKVJkJALRWcUC/BWvcwtusrV4M5lpDe44n9ZSUKbzbr
        GCECIFt0Yh3SFvychxhaaKKVnRM9Q10=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-U3aX0hBBN_-pWEgVJFCBfQ-1; Wed, 15 Mar 2023 13:57:39 -0400
X-MC-Unique: U3aX0hBBN_-pWEgVJFCBfQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF1F328043D3;
        Wed, 15 Mar 2023 17:57:36 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55F54492B00;
        Wed, 15 Mar 2023 17:57:35 +0000 (UTC)
Date:   Wed, 15 Mar 2023 13:57:33 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 00/27] x86_64: Improvements at compressed kernel stage
Message-ID: <8493680a-0bad-43de-a7a0-caa48e430139@uncooperative.org>
References: <cover.1678785672.git.baskov@ispras.ru>
 <d575db7f-bad3-477e-a501-19d2d84527cd@app.fastmail.com>
 <ea1b6e36-c434-49e9-bede-b4bd2b41868d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea1b6e36-c434-49e9-bede-b4bd2b41868d@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 14, 2023 at 04:20:43PM -0700, Andy Lutomirski wrote:
> 
> 
> On Tue, Mar 14, 2023, at 2:23 PM, Andy Lutomirski wrote:
> > On Tue, Mar 14, 2023, at 3:13 AM, Evgeniy Baskov wrote:
> >>
> >> Kernel is made to be more compatible with PE image specification [3],
> >> allowing it to be successfully loaded by stricter PE loader
> >> implementations like the one from [2]. There is at least one
> >> known implementation that uses that loader in production [4].
> >> There are also ongoing efforts to upstream these changes.
> >
> > Can you clarify 
> 
> Sorry, lost part of a sentence.  Can you clarify in what respect the loader is stricter?
> 
> 
> Anyway, I did some research.  I found:
> 
> https://github.com/rhboot/shim/pull/459/commits/99a8d19326f69665e0b86bcfa6a59d554f662fba
> 
> which gives a somewhat incoherent-sounding description in which
> setting EFI_IMAGE_DLLCHARACTERISTICS_NX_COMPAT apparently enables
> allocating memory that isn't RWX.  But this seems odd
> EFI_IMAGE_DLLCHARACTERISTICS_NX_COMPAT is a property of the EFI
> *program*, not the boot services implementation.

Well, "is this binary compatible" is a property of the program, yes.
It's up to the loader to decide if it *cares*, and the compatibility
flag allows it to do that.

> And I'd be surprised if a flag on the application changes the behavior
> of boot services, but, OTOH, this is Microsoft.

There has been discussion of implementing a compatibility mode that
allows you to enable NX support by default, but only breaks the old
assumptions that the stack and memory allocations will be executable if
the flag is set, so that newer OSes get the mitigations we need, but
older OSes still work.  I don't think anyone has actually implemented
this *yet*, but some hardware vendors have made noises that sound like
they may intend to.  (I realize that sounds cagey as hell.  Sorry.)

Currently I think the only shipping systems that implement
NX-requirements are from Microsoft - the Surface product line and
Windows Dev Kit - and they don't allow you to disable it at all.  Other
vendors have produced firmware that isn't shipping yet (I *think*) that
has it as a setting in the firmware menu, and they're looking to move to
enabling it by default on some product lines.  We'd like to not be left
behind.

> And the PE 89 spec does say that
> EFI_IMAGE_DLLCHARACTERISTICS_NX_COMPAT means "Image is NX compatible"
> and that is the sole mention of NX in the document.

Yeah, the PE spec is not very good in a lot of ways unrelated to how
abominable the thing it's describing is.

> And *this* seems to be the actual issue:
> 
> https://github.com/rhboot/shim/pull/459/commits/825d99361b4aaa16144392dc6cea43e24c8472ae
> 
> I assume that MS required this change as a condition for signing, but
> what do I know?

Yes, they have, but it's not as if they did it in a vacuum.  I think the
idea was originally Kees Cook's actually, and there's been a significant
effort on the firmware and bootloader side to enable it.  And there's
good reason to do this, too - more and more of this surface is being
attacked, and recently we've seen the first "bootkit" that actually
includes a Secure Boot breakout in the wild: https://www.welivesecurity.com/2023/03/01/blacklotus-uefi-bootkit-myth-confirmed/

While that particular malware (somewhat ironically) only uses code
developed for linux systems *after* the exploit, it could easily have
gone the other way, and we're definitely a target here.  We need NX in
our boot path, and soon.

> Anyway, the rules appear to be that the PE sections
> must not be both W and X at the same size.  (For those who are
> familiar with the abomination known as ELF but not with the
> abomination known as PE, a "section" is a range in the file that gets
> mapped into memory.  Like a PT_LOAD segment in ELF.)
> 
> Now I don't know whether anything prevents us from doing something
> awful like mapping the EFI stuf RX and then immediately *re*mapping
> everything RWX.  (Not that I'm seriously suggesting that.)

Once we've taken over paging, nothing stops us at all.  Until then,
SetMemoryAttributes() (which is more or less mprotect()) might prevent
it.

> And it's not immediately clear to me how the rest of this series fits
> in, what this has to do with the identity map, etc.

I'll let Evgeniy address that and the rest of this.

-- 
        Peter

