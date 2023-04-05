Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D626D836E
	for <lists+linux-efi@lfdr.de>; Wed,  5 Apr 2023 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDEQSK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Apr 2023 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDEQR4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Apr 2023 12:17:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2DC7A8D;
        Wed,  5 Apr 2023 09:17:22 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9AA41EC0104;
        Wed,  5 Apr 2023 18:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680711438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pkmewBtVUuj1GupUaGo/aeGQOsh5X5V6VVHDAZE0b9c=;
        b=YSOrnjytoNbMZ8AhY5Lq9ZDtp1RlA/CQoyBW4bieV8zO0OgoeH8KbIj1MhdO4rEs3qIBWB
        CHRm6aOs+txfnnZwubIDkF8SoyjQj/cJO8sjA3aFVHCphkkuDx6sqayIKLvwNIMhc2SECt
        t9M0/f4z1TKZRwNxv51xoNyEvNdMYRY=
Date:   Wed, 5 Apr 2023 18:17:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Jones <pjones@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <20230405161714.GCZC2fCg0SrV5v9LZg@fat_crate.local>
References: <cover.1678785672.git.baskov@ispras.ru>
 <d575db7f-bad3-477e-a501-19d2d84527cd@app.fastmail.com>
 <ea1b6e36-c434-49e9-bede-b4bd2b41868d@app.fastmail.com>
 <8493680a-0bad-43de-a7a0-caa48e430139@uncooperative.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8493680a-0bad-43de-a7a0-caa48e430139@uncooperative.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 15, 2023 at 01:57:33PM -0400, Peter Jones wrote:
> Currently I think the only shipping systems that implement
> NX-requirements are from Microsoft - the Surface product line and
> Windows Dev Kit - and they don't allow you to disable it at all.  Other
> vendors have produced firmware that isn't shipping yet (I *think*) that
> has it as a setting in the firmware menu, and they're looking to move to
> enabling it by default on some product lines.

I hope they realize that they must leave the off switch in the BIOS for
older kernels...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
