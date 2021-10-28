Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC6243E62F
	for <lists+linux-efi@lfdr.de>; Thu, 28 Oct 2021 18:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhJ1Qhf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Oct 2021 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1Qhf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Oct 2021 12:37:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7EAC061570;
        Thu, 28 Oct 2021 09:35:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13a70087f257aa50e887e8.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a700:87f2:57aa:50e8:87e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C672A1EC066C;
        Thu, 28 Oct 2021 18:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635438906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zh+2GNP02n/dF4/zNJ+FeGBfsbHiW2pUtoXXFtUgYqw=;
        b=Y7QXElCSiP3f5F2MygLvhg8uyJ3u/zL9/HdJ57Hu7Cm/OUTZNVgtdKS6tZWtNyEzE6WBPp
        QEiPgtn2mz1lnoDatHWqfAqLIT+lGq+I4TSTb3FG/WpgkAAA19rA3T7nCRZW/r2osYmO9a
        Wkee9fZnCgo4LXMmNwz0HHmvfYAmu/0=
Date:   Thu, 28 Oct 2021 18:35:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-efi@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Daniel Gutson <daniel.gutson@eclypsium.com>
Subject: Re: [PATCH v2 0/5] [RFC] x86: Export information about hardware
 memory encryption to sysfs
Message-ID: <YXrRN+pDr4Uv5p0t@zn.tnic>
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
 <8a8e0743-e54d-ec96-da4e-1d101b550274@intel.com>
 <CAKgze5Z3fT9F0S-mogfP6is9sL3=0imtCbfy6ZYrd3zgaBUqRg@mail.gmail.com>
 <YXq50yzJQqrJk13v@zn.tnic>
 <CAD2FfiFS++2-Sn5nCft8Eb-R41MM6abCjXyDn8bOVY-_miCpRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD2FfiFS++2-Sn5nCft8Eb-R41MM6abCjXyDn8bOVY-_miCpRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 28, 2021 at 05:03:20PM +0100, Richard Hughes wrote:
> We've got Red Hat customers right now that are completely confused if
> they have hardware capable of encrypted memory. We want to make it
> part of a specification that can be passed to the people actually
> purchasing the hardware.

Sorry, you need to expand on that: part of what specification? How is
this going to be run? How is the customer supposed to figure that out
when she has the hardware?

Why cannot this be a userspace program, script, tool, whatever?

My questions are still unanswered.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
