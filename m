Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303B92C6A4A
	for <lists+linux-efi@lfdr.de>; Fri, 27 Nov 2020 17:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgK0Q7X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Nov 2020 11:59:23 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:59820 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730786AbgK0Q7W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Nov 2020 11:59:22 -0500
Received: from localhost (home.natalenko.name [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id B18CD8AFFEE;
        Fri, 27 Nov 2020 17:59:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1606496360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jicsug5dPakoEQZY49Hp26352m6/XQS82XZ2tDNeoI0=;
        b=a6QteInLg6H930OKsD+Edr58VisLNIJgeihw5boko9yQY0x6acdFY+N8weK4YfGBnuEkW9
        0cgzgLqQyGjRFUAvplIAotuWyZMs3ygeRMgqEzI09HJJSASmnAdPMRPx5hvvrLyIPXnPfT
        zJLsZ5Fp8mmVmVbHF2XXeNdc7GIClZk=
Date:   Fri, 27 Nov 2020 17:59:20 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Jonathon Fernyhough <jonathon@m2x.dev>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garrett <mjg59@google.com>,
        David Laight <David.Laight@aculab.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Subject: Re: [PATCH] efivarfs: revert "fix memory leak in efivarfs_create()"
Message-ID: <20201127165920.kaewzyz4ocx4lnrl@spock.localdomain>
References: <20201125075303.3963-1-ardb@kernel.org>
 <309bd3399d042ca94e5bab35980d661c@natalenko.name>
 <CAMj1kXHHW2MSUb1emSnDPqffBVFinAO2=w5Si3toEvqXZUBY2Q@mail.gmail.com>
 <a07e1520-f08b-2456-a954-707e0c3bcb4a@m2x.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07e1520-f08b-2456-a954-707e0c3bcb4a@m2x.dev>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi.

On Fri, Nov 27, 2020 at 04:50:34PM +0000, Jonathon Fernyhough wrote:
> On 25/11/2020 10:28, Ard Biesheuvel wrote:
> > On Wed, 25 Nov 2020 at 11:27, Oleksandr Natalenko
> > <oleksandr@natalenko.name> wrote:
> >>
> >> On 25.11.2020 08:53, Ard Biesheuvel wrote:
> --snip--
> >>
> >> Do we need to do this as well:
> >>
> >> #include <linux/kmemleak.h>
> >>
> >> ?
> >>
> >> Because otherwise for 5.9 I get:
> >>
> >> [  148s] fs/efivarfs/inode.c: In function 'efivarfs_create':
> >> [  148s] fs/efivarfs/inode.c:106:2: error: implicit declaration of
> >> function 'kmemleak_ignore' [-Werror=implicit-function-declaration]
> >> [  148s]   106 |  kmemleak_ignore(var);
> >> [  148s]       |  ^~~~~~~~~~~~~~~
> >>
> > 
> > Ah yes, thanks for the report. I will add the include to the patch.
> > 
> > 
> 
> Is this necessary if CONFIG_DEBUG_KMEMLEAK is not enabled in the kernel
> config? e.g. should there be an #ifdef CONFIG_DEBUG_KMEMLEAK somewhere
> in there?

kmemleak_ignore() is a noop if CONFIG_DEBUG_KMEMLEAK is not set. See
include/linux/kmemleak.h. Thus no extra condition is needed here.

-- 
  Oleksandr Natalenko (post-factum)
