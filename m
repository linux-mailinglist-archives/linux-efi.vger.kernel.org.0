Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A851A5AC
	for <lists+linux-efi@lfdr.de>; Wed,  4 May 2022 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353491AbiEDQl7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 May 2022 12:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiEDQl6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 May 2022 12:41:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866A2E9E3;
        Wed,  4 May 2022 09:38:21 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A3DC1EC03AD;
        Wed,  4 May 2022 18:38:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651682295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Yb7dl6ZzJv1QGvWe4IcQU8O7pEtknPbFBVDbx7B+FRU=;
        b=r5fP+b8UYDrbXbH70SX4sRkebHXzX0xBRKaP6aY7didGO9gEHGivQYnRrvv/G6QlGuaROq
        2YIc8Wkz6cGh55lEOXCW51ZElouMihMdBizWPgEi2AvZp6hRU6dR6lSeRp4eHoZUPpMWf/
        hOAji0mCmKofIgzSJ9DSnbqQHRP2ByE=
Date:   Wed, 4 May 2022 18:38:17 +0200
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
Message-ID: <YnKr+aMf4PspDpHZ@zn.tnic>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 29, 2022 at 05:17:09PM -0300, Martin Fernandez wrote:
> Show for each node if every memory descriptor in that node has the
> EFI_MEMORY_CPU_CRYPTO attribute.
> 
> fwupd project plans to use it as part of a check to see if the users
> have properly configured memory hardware encryption
> capabilities. fwupd's people have seen cases where it seems like there
> is memory encryption because all the hardware is capable of doing it,
> but on a closer look there is not, either because of system firmware
> or because some component requires updating to enable the feature.

Hm, so in the sysfs patch you have:

+               This value is 1 if all system memory in this node is
+               capable of being protected with the CPU's memory
+               cryptographic capabilities.

So this says the node is capable - so what is fwupd going to report -
that the memory is capable?

From your previous paragraph above it sounds to me like you wanna
say whether memory encryption is active or not, not that the node is
capable.

Or what is the use case?

> It's planned to make it part of a specification that can be passed to
> people purchasing hardware

So people are supposed to run that fwupd on that new hw to check whether
they can use memory encryption?

> These checks will run at every boot. The specification is called Host
> Security ID: https://fwupd.github.io/libfwupdplugin/hsi.html.
> 
> We choosed to do it a per-node basis because although an ABI that
> shows that the whole system memory is capable of encryption would be
> useful for the fwupd use case, doing it in a per-node basis gives also
> the capability to the user to target allocations from applications to
> NUMA nodes which have encryption capabilities.

That's another hmmm: what systems do not do full system memory
encryption and do only per-node?

From those I know, you encrypt the whole memory on the whole system and
that's it. Even if it is a hypervisor which runs a lot of guests, you
still want the hypervisor itself to run encrypted, i.e., what's called
SME in AMD's variant.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
