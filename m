Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CD351D817
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 14:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376601AbiEFMsW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 08:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349759AbiEFMsS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 08:48:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71046622A;
        Fri,  6 May 2022 05:44:34 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4FC151EC0535;
        Fri,  6 May 2022 14:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651841069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w5a6VyPh1Kscuhtqek949cERiqs3llXbkMpRPLQU5xk=;
        b=dpv0sfJ5xO11IrTCW6v14olvNOOwGrPsTwhjEfGvy52/IQq+4XMU7KoitZrS39tyViUorp
        OR+MmdaGZEgHm0e4Ni5J6+hp0htSwMKucCTk81kI0MzRsJk0513S9YBDSBJAFM08racC6c
        eEYzCqDeC8PmWbUkGHxbSx/eOo6xEks=
Date:   Fri, 6 May 2022 14:44:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do
 encryption
Message-ID: <YnUYLDjIThbIz/Uf@zn.tnic>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
 <YnKr+aMf4PspDpHZ@zn.tnic>
 <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 04, 2022 at 02:18:30PM -0300, Martin Fernandez wrote:
> The use case is to know if a user is using hardware encryption or
> not. This new sysfs file plus knowing if tme/sev is active you can be
> pretty sure about that.

Then please explain it in detail and in the text so that it is clear. As
it is now, the reader is left wondering what that file is supposed to
state.

> Dave Hansen pointed those out in a previuos patch serie, here is the
> quote:
> 
> > CXL devices will have normal RAM on them, be exposed as "System RAM" and
> > they won't have encryption capabilities.  I think these devices were
> > probably the main motivation for EFI_MEMORY_CPU_CRYPTO.

So this would mean that if a system doesn't have CXL devices and has
TME/SME/SEV-* enabled, then it is running with encrypted memory.

Which would then also mean, you don't need any of that code - you only
need to enumerate CXL devices which, it seems, do not support memory
encryption, and then state that memory encryption is enabled on the
whole system, except for the memory of those devices.

I.e.,

$ dmesg | grep -i SME
[    1.783650] AMD Memory Encryption Features active: SME

Done - memory is encrypted on the whole system.

We could export it into /proc/cpuinfo so that you don't have to grep
dmesg and problem solved.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
